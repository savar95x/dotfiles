require("nvim-treesitter.configs").setup ({
  ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "latex" },
  auto_install = true,
  highlight = {
    enable = true,
  },
})
