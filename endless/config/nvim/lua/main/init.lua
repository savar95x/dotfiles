local opt = vim.opt
opt.termguicolors = true

-- requiring stuff
require("main.plugins")
require("main.mappings")

-- Search
opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- switch to case sensitive search when there's a capital letter in search string

-- Number
opt.number = true -- absolute numbering
opt.relativenumber = true -- relative numbering
opt.numberwidth = 4 -- left padding between text and numbering

vim.cmd("set noshowmode") -- don't show active mode

opt.undofile = true -- persistent undos and redos


opt.cursorline = true -- highlight the current row
--opt.cursorcolumn = true -- highlight the current column

opt.scrolloff=1 -- top+bottom line padding while scrolling

opt.clipboard = "unnamedplus" -- global clipboard
--autocmd BufWritePre *.pl %s/\s\+$//e

-- Colorscheme
vim.g.gruvbox_material_transparent_background = true
vim.cmd("colorscheme gruvbox-material")
