vim.g.mapleader = " " -- Make sure to set `mapleader` before lazy so your mappings are correct

local map = vim.keymap.set
-- split screen navigation
map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- insert mode cursor navigation
map("i", "<C-e>", "<End>", { desc = "move end of line" })
map("i", "<C-h>", "<Left>", { desc = "move left" })
map("i", "<C-l>", "<Right>", { desc = "move right" })
map("i", "<C-j>", "<Down>", { desc = "move down" })
map("i", "<C-k>", "<Up>", { desc = "move up" })

-- vim casts tuts
map("n", "<leader>l", ":set list!<CR>", { desc = "show invisibles like tabs and trailing spaces" })

-- copy into system clipboard
map("v", "<leader>y", "\"+y", { desc = "copy to system keyboard" })
map("v", "<leader>p", "\"+p", { desc = "paste from system keyboard" })
