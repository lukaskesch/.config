
-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.o.relativenumber = true

-- Enable mouse mode
-- vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

-- Fold / Folding options
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 2
