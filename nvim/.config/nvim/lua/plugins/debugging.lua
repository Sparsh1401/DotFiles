return {
  -- Debug Adapter Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "mason-org/mason.nvim",
    },
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Debug: Run to Cursor" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<leader>dO", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Debug: Terminate" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Debug: Toggle REPL" },
      { "<leader>du", function() require("dapui").toggle() end, desc = "Debug: Toggle UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Debug: Evaluate Expression" },
      { "<leader>de", function() require("dapui").eval() end, mode = "v", desc = "Debug: Evaluate Selection" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Debug: Run Last" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Go setup
      require("dap-go").setup()

      -- DAP UI setup
      dapui.setup()

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- JS/TS debug adapter (via Mason's js-debug-adapter)
      local js_debug_path = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

      for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = "node",
            args = { js_debug_path, "${port}" },
          },
        }
      end

      -- Next.js / TypeScript configurations (from .vscode/launch.json)
      local js_ts_configs = {
        {
          name = "Next.js: debug server-side",
          type = "pwa-node",
          request = "launch",
          cwd = vim.fn.getcwd(),
          runtimeExecutable = "npm",
          runtimeArgs = { "run", "dev" },
          console = "integratedTerminal",
        },
        {
          name = "Next.js: debug full stack",
          type = "pwa-node",
          request = "launch",
          program = "${workspaceFolder}/node_modules/.bin/next",
          args = { "dev" },
          runtimeArgs = { "--inspect" },
          skipFiles = { "<node_internals>/**" },
          cwd = vim.fn.getcwd(),
        },
        {
          name = "Next.js: debug client-side (Chrome)",
          type = "pwa-chrome",
          request = "launch",
          url = "http://localhost:3000",
          webRoot = vim.fn.getcwd(),
        },
        {
          name = "Attach to Node process",
          type = "pwa-node",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = vim.fn.getcwd(),
          skipFiles = { "<node_internals>/**", "node_modules/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
      }

      for _, lang in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[lang] = js_ts_configs
      end
    end,
  },

  -- Mason: ensure debug adapters are installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "js-debug-adapter",
      },
    },
  },
}
