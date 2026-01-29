return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Modern TypeScript LSP (2025 recommended)
        vtsls = {
          settings = {
            typescript = {
              preferences = {
                includePackageJsonAutoImports = "auto",
              },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
            },
            javascript = {
              preferences = {
                includePackageJsonAutoImports = "auto",
              },
              inlayHints = {
                parameterNames = { enabled = "all" },
                parameterTypes = { enabled = true },
                variableTypes = { enabled = true },
                propertyDeclarationTypes = { enabled = true },
                functionLikeReturnTypes = { enabled = true },
              },
            },
          },
        },
      },
    },
  },
}
