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
    rocks = { enabled = false }, -- Add this to disable luarocks
    "goolord/alpha-nvim", -- dashboard
    {
        "nvim-treesitter/nvim-treesitter", -- treesitter
        branch = "main"
    },
    -- colorschemes
	"mountain-theme/vim", -- mountain
	"nanotech/jellybeans.vim", -- jellybeans
	"sainnhe/gruvbox-material", -- gruvbox material
	"morhetz/gruvbox", -- gruvbox
	"chriskempson/base16-vim", -- base16
	"habamax/vim-habamax", -- habamax
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        keys = {
            { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
            { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
            { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
            -- Add or adjust your specific Telescope keybinds here
        },
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    {
        "vimwiki/vimwiki",
        cmd = { "VimwikiIndex", "VimwikiDiaryIndex", "VimwikiMakeDiaryNote" },
        keys = {
            { "<leader>ww", "<cmd>VimwikiIndex<cr>", desc = "Open Vimwiki" },
            { "<leader>w<leader>w", "<cmd>VimwikiMakeDiaryNote<cr>", desc = "New Diary Note" },
        },
        init = function()
            -- Vimwiki expects global variables to be set BEFORE it loads.
            -- The 'init' function runs on startup, while 'config' runs after the plugin loads.
            vim.g.vimwiki_list = {
                {
                    path = '~/vimwiki/',
                    syntax = 'markdown',
                    ext = '.md'
                }
            }
            -- Optional but recommended: stops Vimwiki from hijacking all standard markdown files
            vim.g.vimwiki_global_ext = 0 
        end,
    },
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
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    -- This code only runs after the plugin is installed and loaded
    require("nvim-treesitter.configs").setup({
      -- your configuration options here
      highlight = { enable = true },
    })
  end,
}
--require "main.plugins.nvim-treesitter"

--require 'colorizer'.setup( mode = 'foreground' )
