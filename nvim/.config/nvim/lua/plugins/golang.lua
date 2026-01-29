return {
  -- Go development tools
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    config = function()
      require("gopher").setup()
    end,
  },
}
