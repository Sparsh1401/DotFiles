return {
  -- OpenCode AI integration
  {
    "NickvanDyke/opencode.nvim",
    lazy = false,
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Add any OpenCode configuration here
      }

      -- Required for opts.events.reload
      vim.o.autoread = true

      -- Apply transparency to OpenCode terminal
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "opencode_terminal",
        callback = function(event)
          local win = vim.fn.bufwinid(event.buf)
          if win ~= -1 then
            vim.api.nvim_set_option_value("winblend", 0, { win = win })
            vim.api.nvim_set_option_value(
              "winhighlight",
              "Normal:Normal,NormalFloat:Normal,FloatBorder:FloatBorder",
              { win = win }
            )
          end
        end,
      })
    end,
    keys = {
      { "<leader>oA", function() require("opencode").ask() end, desc = "Ask opencode" },
      { "<leader>oa", function() require("opencode").ask("@this: ") end, desc = "Ask opencode about this", mode = "n" },
      { "<leader>oa", function() require("opencode").ask("@this: ") end, desc = "Ask opencode about selection", mode = "v" },
      { "<leader>os", function() require("opencode").select() end, desc = "Select opencode prompt/command" },
      { "<leader>or", function() require("opencode").prompt("review") end, desc = "Review with opencode", mode = "n" },
      { "<leader>of", function() require("opencode").prompt("fix") end, desc = "Fix with opencode", mode = "n" },
      { "<leader>ox", function() require("opencode").operator("fix") end, desc = "Fix range with opencode", mode = "n" },
      { "<leader>ot", function() require("opencode").toggle() end, desc = "Toggle embedded opencode" },
      { "<leader>on", function() require("opencode").command("session_new") end, desc = "New session" },
      { "<leader>oy", function() require("opencode").command("messages_copy") end, desc = "Copy messages" },
    },
  },
}
