local map = vim.api.nvim_set_keymap

-- move window
map('n', '<Leader>j', '<C-w>j', { noremap = true, silent = true })
map('n', '<Leader>k', '<C-w>k', { noremap = true, silent = true })
map('n', '<Leader>l', '<C-w>l', { noremap = true, silent = true })
map('n', '<Leader>h', '<C-w>h', { noremap = true, silent = true })

-- split window
map('n', '<Leader>s', ':sp<CR>', { noremap = true })
map('n', '<Leader>v', ':vs<CR>', { noremap = true })

-- close window
map('n', '<Leader>w', ':w<CR>', { noremap = true })
map('n', '<Leader>q', ':q<CR>', { noremap = true })
map('n', '<Leader>x', ':wq<CR>', { noremap = true })

