local link_opener = require('utils.link_opener')

vim.keymap.set('n', '<CR>', link_opener.open_link_under_cursor, {
  buffer = true,
  silent = true,
  desc = 'Open link under cursor',
})
