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
	"goolord/alpha-nvim", -- dashboard
	"nvim-treesitter/nvim-treesitter", -- treesitter
	-- colorschemes
	"mountain-theme/vim", -- mountain
	"nanotech/jellybeans.vim", -- jellybeans
	"sainnhe/gruvbox-material", -- gruvbox material
	"morhetz/gruvbox", -- gruvbox
	"chriskempson/base16-vim", -- base16
	"habamax/vim-habamax", -- habamax
	"nvim-telescope/telescope.nvim",
	--{
		--"lukas-reineke/indent-blankline.nvim",
		--main = "ibl",
		-----@module "ibl"
		-----@type ibl.config
		--opts = {},
	--},
	{
		"chadcat7/prism",
		lazy = true,
		events = {"UIEnter"},
		config = function()
			require("prism"):setup({
				currentTheme = "onedarker",
				reset = false,
			})
		end
	},
	{
		"NvChad/nvim-colorizer.lua", -- highlight colors
	},
	"nvim-lualine/lualine.nvim", -- status line
	"elkowar/yuck.vim", -- yuck
})
require "main.plugins.misc"
require "main.plugins.lualine"
require "main.plugins.prism"
require "main.plugins.nvim-treesitter"
