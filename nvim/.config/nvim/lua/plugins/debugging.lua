return {
  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
    },
    config = function()
      require("dap-go").setup()
    end,
  },
}
