vim.cmd("color vim")
vim.o.termguicolors = false

vim.o.clipboard = 'unnamedplus'

vim.o.number = true
vim.o.relativenumber = true

-- disable expanding comment onto new line
vim.cmd([[autocmd FileType * set formatoptions-=ro]])
