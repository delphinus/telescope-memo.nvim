local memo_builtin = require'telescope._extensions.memo_builtin'

return require'telescope'.register_extension{
  exports = {
    grep = memo_builtin.grep, -- DEPELECATED
    live_grep = memo_builtin.live_grep,
    grep_string = memo_builtin.grep_string,
    list = memo_builtin.list,
  },
}
