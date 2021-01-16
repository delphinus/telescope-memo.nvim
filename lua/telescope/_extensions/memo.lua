local memo_builtin = require'telescope._extensions.memo_builtin'

return require'telescope'.register_extension{
  exports = {
    grep = memo_builtin.grep,
    list = memo_builtin.list,
  },
}
