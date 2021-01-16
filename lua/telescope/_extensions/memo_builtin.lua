local conf = require'telescope.config'.values
local entry_display = require'telescope.pickers.entry_display'
local finders = require'telescope.finders'
local from_entry = require'telescope.from_entry'
local path = require'telescope.path'
local pickers = require'telescope.pickers'
local previewers = require'telescope.previewers'
local utils = require'telescope.utils'

local M = {}

local sep = string.char(9)

local function gen_from_memo(opts)
  local displayer = entry_display.create{
    separator = ' : ',
    items = {
      {}, -- File
      {}, -- Title
    },
  }

  local function make_display(entry)
    return displayer{
      {entry.value, 'TelescopeResultsIdentifier'},
      entry.title,
    }
  end

  return function(line)
    local fields = vim.split(line, sep, true)
    return {
      display = make_display,
      filename = fields[1],
      ordinal = fields[1],
      path = opts.memo_dir..path.separator..fields[1],
      title = fields[2],
      value = fields[1],
    }
  end
end

local function detect_memo_dir(memo_bin)
  return function()
    local lines = utils.get_os_command_output{memo_bin, 'config', '--cat'}
    for _, line in ipairs(lines) do
      local dir = line:match'memodir%s*=%s*"(.*)"'
      if dir then
        return dir
      end
    end
    error'cannot detect memodir'
  end
end

M.list = function(opts)
  opts.entry_maker = utils.get_default(opts.entry_maker, gen_from_memo(opts))
  opts.memo_bin = utils.get_default(opts.memo_bin, 'memo')
  opts.memo_dir = utils.get_lazy_default(opts.memo_dir, detect_memo_dir(opts.memo_bin))

  pickers.new(opts, {
    prompt_title = 'Notes from mattn/memo',
    finder = finders.new_oneshot_job({'memo', 'list', '--format', '{{.File}}'..sep..'{{.Title}}'}, opts),
    sorter = conf.file_sorter(opts),
    previewer = previewers.new_termopen_previewer{
      get_command = function(entry)
        local path = from_entry.path(entry)
        if vim.fn.executable'glow' == 1 then
          return {'glow', path}
        elseif vim.fn.executable'bat' == 1 then
          return {'bat', '--style', 'header,grid', path}
        else
          return {'cat', path}
        end
      end,
    },
  }):find()
end

return M
