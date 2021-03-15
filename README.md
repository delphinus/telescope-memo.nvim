# telescope-memo.nvim

`telescope-memo` is an extension for [telescope.nvim][] that provides its users with operating [mattn/memo][].

[telescope.nvim]: https://github.com/nvim-telescope/telescope.nvim
[mattn/memo]: https://github.com/mattn/memo

## Installation

```lua
use{
  'nvim-telescope/telescope.nvim',
  requires = {
    'delphinus/telescope-memo.nvim',
  },
  config = function()
    require'telescope'.load_extension'memo'
  end,
}
```

## Usage

### list

`:Telescope memo list`

Running `memo list` and list notes.

### live\_grep

`:Telescope memo live_grep`

Running `telescope.builtin.live_grep` on memo_dir.

### grep\_string

`:Telescope memo grep_string`

Running `telescope.builtin.grep_string` on memo_dir.

### grep

***DEPELECATED***

`:Telescope memo grep`

Running `telescope.builtin.live_grep` on memo_dir.

## TODO

* [x] `memo grep`
* [ ] `memo new` and others
* [x] enable to set path for `memo` executable
