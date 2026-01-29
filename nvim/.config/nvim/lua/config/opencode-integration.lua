--- Get file path with line number(s) based on current mode.
--- In visual mode, returns "filepath:start-end", otherwise "filepath:line".
---@return string file_ref The formatted file reference
local function get_file_ref()
  local filepath = vim.fn.expand("%")
  local start_line = vim.fn.line(".")
  local end_line = vim.fn.line("v")

  if vim.fn.mode() == "v" or vim.fn.mode() == "V" or vim.fn.mode() == "\22" then
    -- Visual mode: use current visual selection
    start_line = vim.fn.line("v")
    end_line = vim.fn.line(".")
    -- Ensure start_line <= end_line
    if start_line > end_line then
      start_line, end_line = end_line, start_line
    end
    return string.format("%s:%d-%d", filepath, start_line, end_line)
  else
    -- Normal mode: single line
    return string.format("%s:%d", filepath, start_line)
  end
end

-- Copy file reference with line number to clipboard
vim.keymap.set({ "n", "v" }, "<leader>cs", function()
  local file_ref = get_file_ref()
  vim.fn.setreg("+", file_ref) -- copy to system clipboard
  vim.notify("Copied: " .. file_ref, vim.log.levels.INFO)
end, { desc = "Copy file path with line number/range" })

-- Run OpenCode task on current file/line
vim.keymap.set({ "n", "v" }, "<leader>op", function()
  -- Get current working directory
  local cwd = vim.fn.getcwd()

  -- Get file path with line numbers
  local file_ref = get_file_ref()

  -- Prompt for user input
  vim.ui.input({
    prompt = "OpenCode task: ",
    default = "",
  }, function(input)
    -- Check if input was provided
    if not input or input == "" then
      vim.notify("No input provided", vim.log.levels.WARN)
      return
    end

    -- Build the command with file reference prepended to input
    local cmd = {
      "opencode",
      "run",
      "--model",
      "anthropic/claude-haiku-4-5",
      file_ref .. " " .. input,
    }

    vim.notify("Running: " .. input, vim.log.levels.INFO)

    -- Use vim.system to run the command asynchronously
    vim.system(cmd, {
      cwd = cwd,
      text = true,
    }, function(result)
      vim.schedule(function()
        if result.code == 0 then
          -- Reload the buffer to reflect any changes
          vim.cmd("edit!")

          -- Show output if available
          if result.stdout and result.stdout ~= "" then
            -- Split output into lines for better display
            local lines = vim.split(result.stdout, "\n", { trimempty = true })
            vim.notify("Task Completed\n" .. table.concat(lines, "\n"), vim.log.levels.INFO)
          end
        else
          -- Error
          local error_msg = "OpenCode task failed with code " .. result.code
          if result.stderr and result.stderr ~= "" then
            error_msg = error_msg .. "\n" .. result.stderr
          end
          vim.notify(error_msg, vim.log.levels.ERROR)
        end
      end)
    end)
  end)
end, {
  desc = "Run OpenCode with user input and file reference",
  noremap = true,
  silent = true,
})
