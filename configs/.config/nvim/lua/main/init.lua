local opt = vim.opt
opt.termguicolors = true

require("main.plugins")
require("main.mappings")

opt.ignorecase = true -- case insensitive search
opt.smartcase = true -- switch to case sensitive search when there's a capital letter in search string

opt.number = true -- absolute numbering
opt.relativenumber = true -- relative numbering
opt.numberwidth = 5 -- left padding between text and numbering

--opt.list = true -- invisible chars

opt.showmode = false  -- don't show active mode

opt.undofile = true -- persistent undos and redos

-- lines
--opt.cursorline = true -- highlight the current row
--opt.cursorcolumn = true -- highlight the current column

opt.scrolloff = 1 -- top+bottom line padding while scrolling

--autocmd BufWritePre *.pl %s/\s\+$//e  -- remove trailing spaces
opt.clipboard = "unnamedplus" -- global clipboard

--vim.opt.clipboard:append("unnamedplus") -- use system clipboard as default register
--vim.g.clipboard = {
--name = "xclip-wsl",
--copy = {
--["+"] = { "xclip", "-quiet", "-i", "-selection", "clipboard" },
--["*"] = { "xclip", "-quiet", "-i", "-selection", "primary" },
--},
--paste = {
--["+"] = { "xclip", "-o", "-selection", "clipboard" },
--["*"] = { "xclip", "-o", "-selection", "primary" },
--},
--cache_enabled = 1, -- cache MUST be enabled, or else it hangs on dd/y/x and all other copy operations
--}

-- use 2 spaces instead of tabs for xml and yaml files
vim.cmd("autocmd FileType xml,yaml setlocal ts=2 sts=2 sw=2 expandtab")

-- treat rss as xml // tho not needed
--vim.cmd("autocmd BufNewFile,BufRead *.rss,*.atom setfiletype xml")

-- Colorscheme
vim.g.gruvbox_material_transparent_background = true
vim.cmd("colorscheme gruvbox-material")
