return {
  -- Enhanced file explorer with better search
  {
    "folke/snacks.nvim",
    opts = {
      explorer = {
        enabled = true,
        -- Enable search functionality
        search = true,
        -- Search keybindings
        keys = {
          search = "/",  -- Start search with /
          search_next = "n",  -- Next search result
          search_prev = "N",  -- Previous search result
          clear_search = "<ESC>",  -- Clear search
        },
        -- Show search bar
        ui = {
          search = {
            enabled = true,
            placeholder = "Search files...",
          },
        },
      },
    },
    keys = {
      { "<leader>e", function() Snacks.explorer() end, desc = "Toggle Explorer" },
      { "<leader>E", function() Snacks.explorer({ cwd = vim.fn.expand("%:p:h") }) end, desc = "Explorer (current file)" },
    },
  },
}
