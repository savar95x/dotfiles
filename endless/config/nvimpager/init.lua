-- colorscheme
vim.cmd([[set runtimepath+=~/.local/share/nvim/lazy/gruvbox-material]])
vim.cmd([[set runtimepath+=~/.local/share/nvim/lazy/gruvbox]])
vim.cmd([[set runtimepath+=~/.local/share/nvim/lazy/yuck.vim]])
vim.cmd([[set termguicolors]])
vim.g.gruvbox_material_transparent_background = true
vim.cmd([[colorscheme gruvbox-material]])

-- search
vim.cmd([[set ignorecase]]) -- case insensitive search
vim.cmd([[set smartcase]]) -- switch to case sensitive search when there's a capital letter in search string

-- number lines
vim.cmd([[set number]]) -- absolute numbering
vim.cmd([[set relativenumber]]) -- relative numbering
vim.cmd([[set nuw=4]]) -- left padding between text and numbering
-- don't show active mode
vim.cmd([[set noshowmode]])
-- highlight a line
vim.cmd([[set cursorline]])
--vim.cmd([[set cursorcolumn]])
-- top+bottom padding
vim.cmd([[set scrolloff=1]])
