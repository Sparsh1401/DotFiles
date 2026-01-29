return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    -- Size of terminal windows (VSCode-like proportions)
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.3 -- 30% of screen height
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4 -- 40% of screen width
      end
    end,
    -- Open terminal in insert mode
    open_mapping = [[<c-\>]],
    -- Show terminal numbers in buffer list for easy identification
    hide_numbers = false,
    -- Shade background of terminals
    shade_terminals = true,
    shading_factor = 2,
    -- Start terminals in insert mode
    start_in_insert = true,
    -- Persist terminal size
    persist_size = true,
    -- Terminal direction: 'horizontal' opens at bottom like VSCode
    direction = "horizontal",
    -- Close terminal on process exit
    close_on_exit = true,
    -- Shell to use
    shell = vim.o.shell,
    -- Auto scroll to bottom on terminal output
    auto_scroll = true,
    -- Floating terminal configuration
    float_opts = {
      border = "curved",
      winblend = 0,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    -- Winbar configuration - Disabled (no terminal tabs UI)
    winbar = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Custom terminal instances
    local Terminal = require("toggleterm.terminal").Terminal

    -- Lazygit terminal
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "double",
      },
      -- function to run on opening the terminal
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      end,
    })

    function _lazygit_toggle()
      lazygit:toggle()
    end

    -- Python REPL terminal
    local python = Terminal:new({
      cmd = "python3",
      direction = "float",
      close_on_exit = false,
    })

    function _python_toggle()
      python:toggle()
    end

    -- Node REPL terminal
    local node = Terminal:new({
      cmd = "node",
      direction = "float",
      close_on_exit = false,
    })

    function _node_toggle()
      node:toggle()
    end

    -- Htop terminal
    local htop = Terminal:new({
      cmd = "htop",
      direction = "float",
      close_on_exit = true,
    })

    function _htop_toggle()
      htop:toggle()
    end
  end,
  keys = {
    -- Toggle terminal (opens at bottom like VSCode)
    { "<C-\\>", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal", mode = { "n", "t" } },
    { "<leader>ft", "<cmd>ToggleTerm<CR>", desc = "Toggle terminal (horizontal)" },

    -- Open terminal in different directions (creates numbered terminals)
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Terminal Float" },
    {
      "<leader>th",
      function()
        -- Get next available terminal number
        local terms = require("toggleterm.terminal").get_all()
        local next_id = #terms + 1
        vim.cmd(next_id .. "ToggleTerm direction=horizontal")
      end,
      desc = "New Terminal Horizontal"
    },
    {
      "<leader>tv",
      function()
        -- Get next available terminal number
        local terms = require("toggleterm.terminal").get_all()
        local next_id = #terms + 1
        vim.cmd(next_id .. "ToggleTerm direction=vertical")
      end,
      desc = "New Terminal Vertical"
    },
    { "<leader>tt", "<cmd>ToggleTerm direction=tab<CR>", desc = "Terminal Tab" },

    -- Open numbered terminals (like VSCode Terminal 1, 2, 3...)
    { "<leader>t1", "<cmd>1ToggleTerm<CR>", desc = "Terminal 1" },
    { "<leader>t2", "<cmd>2ToggleTerm<CR>", desc = "Terminal 2" },
    { "<leader>t3", "<cmd>3ToggleTerm<CR>", desc = "Terminal 3" },
    { "<leader>t4", "<cmd>4ToggleTerm<CR>", desc = "Terminal 4" },

    -- Select from active terminals (shows list)
    { "<leader>ts", "<cmd>TermSelect<CR>", desc = "Terminal Select (quick)" },
    { "<leader>tm", "<cmd>Telescope toggleterm_manager<CR>", desc = "Terminal Manager (VSCode-like)" },

    -- Toggle all terminals
    { "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", desc = "Terminal Toggle All" },

    -- Custom terminal instances
    { "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", desc = "Terminal Lazygit" },
    { "<leader>tp", "<cmd>lua _python_toggle()<CR>", desc = "Terminal Python" },
    { "<leader>tn", "<cmd>lua _node_toggle()<CR>", desc = "Terminal Node" },
    { "<leader>tH", "<cmd>lua _htop_toggle()<CR>", desc = "Terminal Htop" },

    -- Send commands to terminal
    { "<leader>tc", "<cmd>TermExec cmd='clear'<CR>", desc = "Terminal Clear" },

    -- Easy terminal exit
    { "<C-x>", [[<C-\><C-n>]], desc = "Exit terminal mode", mode = "t" },
    { "<Esc><Esc>", [[<C-\><C-n>]], desc = "Exit terminal mode", mode = "t" },

    -- Navigate between terminals and windows in terminal mode
    { "<C-h>", [[<Cmd>wincmd h<CR>]], desc = "Go to left window", mode = "t" },
    { "<C-j>", [[<Cmd>wincmd j<CR>]], desc = "Go to lower window", mode = "t" },
    { "<C-k>", [[<Cmd>wincmd k<CR>]], desc = "Go to upper window", mode = "t" },
    { "<C-l>", [[<Cmd>wincmd l<CR>]], desc = "Go to right window", mode = "t" },
  },
}
