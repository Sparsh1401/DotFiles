-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- Your custom options
opt.relativenumber = true
opt.tabstop = 4
opt.shiftwidth = 4

-- Split settings
opt.splitright = true -- Vertical splits open to the right
opt.splitbelow = true -- Horizontal splits open below

-- Disable swap files (autosave is enabled)
opt.swapfile = false

-- Sign column settings
opt.signcolumn = "yes" -- Always show sign column
opt.number = true -- Show line numbers

-- Autosave settings
opt.autowrite = true -- Auto write when switching buffers
opt.autowriteall = true -- Auto write on more events

-- Enhanced autosave functionality
vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})

vim.api.nvim_create_autocmd({ "FocusLost", "WinLeave" }, {
  pattern = "*",
  callback = function()
    if vim.bo.modified and vim.bo.buftype == "" and vim.fn.expand("%") ~= "" then
      vim.cmd("silent! write")
    end
  end,
})


-- Transparency settings
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Make background transparent
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
    vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

    -- File explorer transparency (Neo-tree/LazyVim default)
    vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "NeoTreeEndOfBuffer", { bg = "none" })

    -- Additional transparency for various UI elements
    vim.api.nvim_set_hl(0, "NvimTreeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeVertSplit", { bg = "none" })
    vim.api.nvim_set_hl(0, "NvimTreeWinSeparator", { bg = "none" })

    -- Telescope transparency
    vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "none" })

    -- Which-key transparency
    vim.api.nvim_set_hl(0, "WhichKeyFloat", { bg = "none" })

    -- Status line transparency (optional)
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })
    vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "none" })
  end,
})


-- Auto-reload with delayed notification
local reload_timer = nil
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  pattern = "*",
  callback = function()
    if vim.fn.mode() ~= "c" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("FileChangedShellPost", {
  pattern = "*",
  callback = function()
    -- Cancel previous timer if exists
    if reload_timer then
      reload_timer:stop()
      reload_timer:close()
    end

    -- Set new timer with 2 second delay
    reload_timer = vim.loop.new_timer()
    reload_timer:start(2000, 0, vim.schedule_wrap(function()
      vim.notify("File reloaded from external changes", vim.log.levels.INFO)
      reload_timer:close()
      reload_timer = nil
    end))
  end,
})

-- File type specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "html" },
  callback = function()
    vim.opt_local.expandtab = true
  end,
})

-- Terminal specific settings (disable line numbers)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
    vim.opt_local.signcolumn = "no"
  end,
})
