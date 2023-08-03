local setup = {
  plugins = {
    marks = true,       -- shows a list of your marks on ' and `
    registers = true,   -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true,   -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false,    -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = false,      -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true,       -- default bindings on <c-w>
      nav = true,           -- misc bindings to work with windows
      z = true,             -- bindings for folds, spelling and others prefixed with z
      g = true,             -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+",      -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = "<c-d>", -- binding to scroll down inside the popup
    scroll_up = "<c-u>",   -- binding to scroll up inside the popup
  },
  window = {
    border = "rounded",       -- none, single, double, shadow
    position = "bottom",      -- bottom, top
    margin = { 1, 0, 1, 0 },  -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 0,
  },
  layout = {
    height = { min = 4, max = 25 },                                             -- min and max height of the columns
    width = { min = 20, max = 50 },                                             -- min and max width of the columns
    spacing = 3,                                                                -- spacing between columns
    align = "left",                                                             -- align columns left, center or right
  },
  ignore_missing = true,                                                        -- enable this to hide mappings for which you didn't specify a label
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true,                                                             -- show help message on the command line when the popup is visible
  triggers = "auto",                                                            -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { "j", "k" },
    v = { "j", "k" },
  },
}

local opts = {
  mode = "n",     -- NORMAL mode
  prefix = "<leader>",
  buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true,  -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true,  -- use `nowait` when creating keymaps
}

local mappings = {
  ["e"] = { "<cmd>Neotree toggle reveal<cr>", "Explorer" },
  ["r"] = { "<cmd>Neotree reveal<cr>", "Explorer" },
  ["w"] = { "<cmd>w!<CR>", "Save" },
  ["q"] = { "<cmd>q<CR>", "Quit" },
  ["W"] = { "<cmd>wq!<CR>", "Save & quit" },
  ["Q"] = { "<cmd>q!<CR>", "Quit" },
  ["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
  ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
  ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
  ["N"] = { "<cmd>tabnew<cr>", "New Buffer" },
  f = {
    name = "Telescope",
    f = {
      "<cmd>Telescope find_files <cr>", "Find files"
    },
    w = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
    h = { "<cmd>Telescope help_tags theme=ivy<cr>", "Find Help" },
    d = { "<cmd>Telescope diagnostics <cr>", "Find Diagnostics" },
    p = { "<cmd>TodoTelescope keywords=TODO,FIX <cr>", "Find Pendings" },
    n = { "<cmd>TodoTelescope keywords=NOTE,INFO <cr>", "Find Annotations" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    s = { "<cmd>Telescope git_status<cr>", "Git Status" },
    S = { "<cmd>Telescope git_stash<cr>", "Git Stash" },
    c = { "<cmd>Telescope git_commits<cr>", "Git Commits" },
    C = { "<cmd>Telescope git_bcommits<cr>", "Git Commits" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
  },
  g = {
    name = "Git",
    g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
    P = { "<cmd>lua _LAZYDOCKER_TOGGLE()<CR>", "Lazydocker" },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Diff",
    },
  },
  l = {
    name = "LSP",
    a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code Action" },
    d = {
      "<cmd>Telescope lsp_document_diagnostics<cr>",
      "Document Diagnostics",
    },
    w = {
      "<cmd>Telescope lsp_workspace_diagnostics<cr>",
      "Workspace Diagnostics",
    },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.diagnostic.goto_next()<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.diagnostic.goto_prev()<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
    q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  },
  t = {
    name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  x = {
    name = "Debugger",
    b = { function() require("dap").toggle_breakpoint() end, "Toggle Breakpoint" },
    B = { function() require("dap").clear_breakpoints() end, "Clear Breakpoints" },
    c = { function() require("dap").continue() end, "Continue" },
    i = { function() require("dap").step_into() end, "Step Into" },
    g = { function()
      require("dap-go").debug_test()
      require("dapui").toggle()
    end, "Debug Go Test" },
    l = { function() require("dapui").float_element "breakpoints" end, "List Breakpoints" },
    o = { function() require("dap").step_over() end, "Step Over" },
    q = { function() require("dap").close() end, "Close Session" },
    Q = { function() require("dap").terminate() end, "Terminate" },
    r = { function() require("dap").repl.toggle() end, "REPL" },
    s = { function() require("dapui").float_element "scopes" end, "Scopes" },
    t = { function() require("dapui").float_element "stacks" end, "Threads" },
    u = { function() require("dapui").toggle() end, "Toggle Debugger UI" },
    w = { function() require("dapui").float_element "watches" end, "Watches" },
    x = { function() require("dap.ui.widgets").hover() end, "Inspect" },
  },
  y = {
    name = "Yanking",
    f = { "<cmd>YankFileRelativePath <cr>", "Yank current file relative path"}
  },
  n = {
    name = "Neorg",
    t = { "<cmd>Neorg journal today<cr>", "Today journal" },
    r = { "<cmd>Neorg journal tomorrow<cr>", "Tomorrow journal" },
    y = { "<cmd>Neorg journal yesterday<cr>", "Yesterday journal" },
    i = { "<cmd>Neorg index<cr>", "Index" },
  },
  m = {
    name = "Harpoon",
    a = { function() require("harpoon.mark").add_file() end, "Add File" },
    o = { function() require("harpoon.ui").toggle_quick_menu() end, "Menu" },
  },
}


return {
  "folke/which-key.nvim",
  config = function()
    require('which-key').setup(setup)
    require('which-key').register(mappings, opts)
  end
}
