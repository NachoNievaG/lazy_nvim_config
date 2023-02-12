return {
  -- the colorscheme should be available when starting Neovim
  {
    "rebelot/kanagawa.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the colorscheme here
      vim.cmd([[colorscheme kanagawa]])
    end,
  },

  -- I have a separate config.mappings file where I require which-key.
  -- With lazy the plugin will be automatically loaded when it is required somewhere


  {
    "nvim-neorg/neorg",
    -- lazy-load on filetype
    ft = "norg",
    -- custom config that will be executed when loading the plugin
    config = function()
      require("neorg").setup()
    end,
  },

  {
    "dstein64/vim-startuptime",
    -- lazy-load on a command
    cmd = "StartupTime",
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    config = function ()
      require("neo-tree").setup({
        close_if_last_window = true,
      })
    end
  },
  "nvim-lua/plenary.nvim",
  "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  "MunifTanjim/nui.nvim",

  {
    "folke/noice.nvim",
    config= function ()
      require("noice").setup({
        lsp = {
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
         messages = {
            enabled = false, 
        }
      })
    end,
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
    }
  },
  {"moll/vim-bbye"},
  {
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      require("indent_blankline").setup {
        show_current_context = true,
        show_current_context_start = true,
        char = '┊',
        show_trailing_blankline_indent = false,
      }
    end
  },
 { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap" },
    init = function()
      require("dapui").setup()
    end
  },
   { 'leoluz/nvim-dap-go',
    init = function()
      require("dap-go").setup()
    end
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" },
  },
  { -- Additional text objects via treesitter
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = 'nvim-treesitter',
  },
  {
    "xiyaowong/nvim-transparent",
    config = function()
      require("transparent").setup({
        enable = true, -- boolean: enable transparent
        extra_groups = { -- table/string: additional groups that should be cleared
          "all",
        },
        exclude = {}, -- table: groups you don't want to clear
      })
    end
  },
  "tpope/vim-surround",
  "p00f/nvim-ts-rainbow",
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup {}
    end
  },
  {
    "glepnir/lspsaga.nvim",
    config = function()
        require("lspsaga").setup({})
    end,
    dependencies = { {"nvim-tree/nvim-web-devicons"} }
  },
  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    config = function() require("todo-comments").setup {} end
  }
}
