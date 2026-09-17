return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  opts = {
    ensure_install = {
      "asm", "blade", "c", "cpp", "css", "html", "java", "javascript", "json",
      "jsonc", "lua", "luau", "markdown", "markdown_inline", "php", "php_only",
      "python", "tsx", "typescript", "vim", "xml",
    },
    allow_vim_regex = { "php" },
  },
  config = function(_, opts)
    local max_lines = vim.g.ts_max_lines or 1200

    ---@param lang string
    local function start(lang)
      local ok = pcall(vim.treesitter.start, 0, lang)
      if not ok then
        return false
      end

      if vim.tbl_contains(opts.allow_vim_regex, vim.bo.filetype) then
        vim.bo.syntax = "on"
      end

      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"

      return true
    end

    local function stop()
      pcall(vim.treesitter.stop, 0)
      vim.bo.syntax = "on"
      vim.wo[0][0].foldexpr = ""
    end

    vim.keymap.set("n", "<leader>ts", function()
      if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] then
        stop()
        vim.notify("treesitter off", vim.log.levels.INFO)
        return
      end

      if vim.api.nvim_buf_line_count(0) > max_lines then
        vim.notify(
          string.format("buffer > %d lines, treesitter would block; skipped", max_lines),
          vim.log.levels.WARN
        )
        return
      end

      local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
      if not lang then
        vim.notify("no treesitter lang for " .. vim.bo.filetype, vim.log.levels.WARN)
        return
      end

      vim.defer_fn(function()
        if start(lang) then
          vim.notify("treesitter on (" .. lang .. ")", vim.log.levels.INFO)
        else
          vim.notify("treesitter failed for " .. lang .. " (parser missing?)", vim.log.levels.ERROR)
        end
      end, 0)
    end, { desc = "Toggle treesitter highlighting (buffer)" })

    vim.api.nvim_create_user_command("TSInstallAll", function()
      require("nvim-treesitter").install(opts.ensure_install)
    end, {})
  end,
}