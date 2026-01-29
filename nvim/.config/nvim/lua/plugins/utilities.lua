return {
  -- Emmet for HTML/CSS
  {
    "mattn/emmet-vim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  },

  -- Color picker
  {
    "nvzone/minty",
    dependencies = { "nvzone/volt" },
  },

  -- Text wrapping improvements
  {
    "andrewferrier/wrapping.nvim",
    config = function()
      require("wrapping").setup({
        auto_set_mode_filetype_allowlist = {
          "asciidoc",
          "gitcommit",
          "latex",
          "mail",
          "markdown",
          "rst",
          "tex",
          "text",
        },
      })
    end,
  },
}
