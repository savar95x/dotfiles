-- bootstrapping lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
	-- dont know wtf this is
	"folke/which-key.nvim",
	{ "folke/neoconf.nvim", cmd = "Neoconf" },
	"folke/neodev.nvim",
	-- colorschemes
	"mountain-theme/vim",
	"nanotech/jellybeans.vim",
	"sainnhe/gruvbox-material",
	"morhetz/gruvbox",
	"chriskempson/base16-vim",
--	"habamax/vim-habamax",
	-- highlight colors
	"NvChad/nvim-colorizer.lua",
	-- status line
	"nvim-lualine/lualine.nvim",
	-- yuck
	"elkowar/yuck.vim",
})
require "main.plugins.misc"
require "main.plugins.lualine"
