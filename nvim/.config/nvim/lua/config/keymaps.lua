-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- General mappings
map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>", { desc = "TMUX window left" })
map("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>", { desc = "TMUX window right" })
map("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>", { desc = "TMUX window down" })
map("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>", { desc = "TMUX window up" })

-- Window resizing
map("n", "<M-h>", "<cmd>vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<M-l>", "<cmd>vertical resize +2<CR>", { desc = "Resize window right" })
map("n", "<M-k>", "<cmd>resize +2<CR>", { desc = "Resize window up" })
map("n", "<M-j>", "<cmd>resize -2<CR>", { desc = "Resize window down" })

-- Use j and k as gj and gk
map("n", "j", "gj", { desc = "Move down by visual line" })
map("n", "k", "gk", { desc = "Move up by visual line" })
map("v", "j", "gj", { desc = "Move down by visual line" })
map("v", "k", "gk", { desc = "Move up by visual line" })

-- ThePrimeagen-style keybindings
-- Paste without affecting register
map("x", "<leader>P", [["_dP]], { desc = "Paste without yanking" })

-- Move selected lines up and down
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })

-- Keep search terms in the middle
map("n", "n", "nzzzv", { desc = "Next search result centered" })
map("n", "N", "Nzzzv", { desc = "Previous search result centered" })

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to black hole register
map({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete to black hole register" })

-- Replace word under cursor
map("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "Replace word under cursor" })

-- Quick fix navigation
map("n", "<C-q>", "<cmd>copen<CR>", { desc = "Open quickfix list" })
map("n", "]q", "<cmd>cnext<CR>zz", { desc = "Next quickfix item" })
map("n", "[q", "<cmd>cprev<CR>zz", { desc = "Previous quickfix item" })

-- Insert mode mappings
map("i", "<C-h>", "<C-w>", { desc = "Delete the whole word in insert mode" })

-- DAP mappings
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP Add breakpoint at line" })
map("n", "<leader>dus", function()
  local widgets = require("dap.ui.widgets")
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "DAP Open debugging sidebar" })

-- DAP Go mappings
map("n", "<leader>dgt", function()
  require("dap-go").debug_test()
end, { desc = "DAP Debug go test" })
map("n", "<leader>dgl", function()
  require("dap-go").debug_last()
end, { desc = "DAP Debug last go test" })

-- Gopher mappings
map("n", "<leader>gsj", "<cmd>GoTagAdd json<CR>", { desc = "Gopher Add json struct tags" })
map("n", "<leader>gsy", "<cmd>GoTagAdd yaml<CR>", { desc = "Gopher Add yaml struct tags" })

-- Persistence mappings
map("n", "<leader>qs", function()
  require("persistence").load()
end, { desc = "Persistence Restore Session" })
map("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end, { desc = "Persistence Restore Last Session" })
map("n", "<leader>qd", function()
  require("persistence").stop()
end, { desc = "Persistence Don't Save Current Session" })

-- LSP mappings
map("n", "<leader>lf", function()
  vim.diagnostic.open_float({ border = "rounded" })
end, { desc = "LSP Floating diagnostic" })

-- Gitsigns mappings
map("n", "<leader>ph", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Gitsigns Preview hunk" })
map("n", "<leader>bl", "<cmd>Gitsigns blame_line<CR>", { desc = "Gitsigns Blame line" })
map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Gitsigns Toggle line blame" })
map("n", "<leader>gd", "<cmd>Gitsigns diffthis<CR>", { desc = "Gitsigns Diff this" })
map("n", "]h", "<cmd>Gitsigns next_hunk<CR>", { desc = "Gitsigns Next hunk" })
map("n", "[h", "<cmd>Gitsigns prev_hunk<CR>", { desc = "Gitsigns Previous hunk" })


-- LeetCode mappings
map("n", "<leader>lr", "<cmd>Leet run<CR>", { desc = "LeetCode Run tests" })
map("n", "<leader>ls", "<cmd>Leet submit<CR>", { desc = "LeetCode Submit solution" })

-- Menu mappings
map("n", "<C-t>", function()
  require("menu").open("default")
end, { desc = "Open menu" })

-- Mouse menu
map("n", "<RightMouse>", function()
  vim.cmd.exec('"normal! \\<RightMouse>"')
  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, { desc = "Open context menu" })

-- File operations
map("n", "<leader>w", ":w<CR>", { desc = "Save file" })
map("n", "<leader>fw", ":w<CR>", { desc = "Save file" })



-- Formatting
map("n", "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format buffer" })

-- Terminal management - Using toggleterm.nvim
-- See lua/plugins/toggleterm.lua for terminal configuration
--
-- Terminal keybindings:
-- <leader>ft or <C-\> - Toggle terminal (opens at bottom)
-- <leader>th - New terminal horizontal split
-- <leader>tv - New terminal vertical split
-- <leader>tf - Float terminal
-- <leader>ts - Select terminal (shows picker)
-- <leader>tm - Terminal manager (shows all terminals)
-- <leader>t1/t2/t3/t4 - Jump to specific terminal by number
-- <leader>ta - Toggle all terminals

-- OpenCode Integration (from jnsahaj/dotfiles)
-- See lua/config/opencode-integration.lua
--
-- OpenCode keybindings:
-- <leader>op - Run OpenCode task on current file/line
--              (prompts for task, runs: opencode run <file:line> <task>)
-- <leader>cs - Copy file path with line number to clipboard
--              (e.g., "src/main.rs:42" or "src/main.rs:10-20" in visual mode)
