return {
  "echasnovski/mini.surround",
  version = false,
  event = "VeryLazy",
  opts = {
    mappings = {
      add = "sa",            -- Add surrounding in Normal and Visual modes
      delete = "sd",         -- Delete surrounding
      find = "sf",           -- Find surrounding (to the right)
      find_left = "sF",      -- Find surrounding (to the left)
      highlight = "sh",      -- Highlight surrounding
      replace = "sr",        -- Replace surrounding
      update_n_lines = "sn", -- Update `n_lines`
    },
  },
}
-- Usage examples:
-- sa + motion + char  : Add surrounding (e.g., saiw" adds " around word)
-- sd + char           : Delete surrounding (e.g., sd" deletes surrounding ")
-- sr + old + new      : Replace surrounding (e.g., sr"' changes " to ')
--
-- Common patterns:
-- saiw"  → surround inner word with "
-- sai("  → surround inside ( with "
-- sd'    → delete surrounding '
-- sr"'   → replace " with '
-- sa$)   → surround to end of line with ()
