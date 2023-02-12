return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  dependencies = {
    -- LSP Support
    {'neovim/nvim-lspconfig'},             -- Required
    {'williamboman/mason.nvim'},           -- Optional
    {'williamboman/mason-lspconfig.nvim'}, -- Optional

    -- Autocompletion
    {'hrsh7th/nvim-cmp'},         -- Required
    {'hrsh7th/cmp-nvim-lsp'},     -- Required
    {'hrsh7th/cmp-buffer'},       -- Optional
    {'hrsh7th/cmp-path'},         -- Optional
    {'saadparwaiz1/cmp_luasnip'}, -- Optional
    {'hrsh7th/cmp-nvim-lua'},     -- Optional

    -- Snippets
    {'L3MON4D3/LuaSnip'},             -- Required
    {'rafamadriz/friendly-snippets'}, -- Optional
  },
  config= function ()
    local cmp= require('cmp')
    cmp.setup{
      mapping={
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
      },
      sources ={
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" }
      }
    }
    local lsp = require('lsp-zero')
    lsp.preset('recommended')

    -- NOTE: Given that we want lspsaga to handle this, we omit those keymaps
    lsp.set_preferences({
      set_lsp_keymaps = {omit = {'gd', 'K'}}
    })
    lsp.ensure_installed({
      'gopls'
    })
    -- (Optional) Configure lua language server for neovim

    lsp.nvim_workspace()
    lsp.setup()
    vim.api.nvim_create_autocmd("BufWritePre",{
      callback =function ()
        vim.cmd [[LspZeroFormat]]
      end
    })
  end
}
