return {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v1.x',
  dependencies = {
    -- LSP Support
    { 'neovim/nvim-lspconfig' },             -- Required
    { 'williamboman/mason.nvim' },           -- Optional
    { 'williamboman/mason-lspconfig.nvim' }, -- Optional

    -- Autocompletion
    { 'hrsh7th/nvim-cmp' },         -- Required
    { 'hrsh7th/cmp-nvim-lsp' },     -- Required
    { 'hrsh7th/cmp-buffer' },       -- Optional
    { 'hrsh7th/cmp-path' },         -- Optional
    { 'saadparwaiz1/cmp_luasnip' }, -- Optional
    { 'hrsh7th/cmp-nvim-lua' },     -- Optional

    -- Snippets
    { 'L3MON4D3/LuaSnip' },             -- Required
    { 'rafamadriz/friendly-snippets' }, -- Optional
  },
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    local cmp_setup = {
      mapping = require('lsp-zero.nvim-cmp-setup').default_mappings(),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "neorg" },
        { name = "path" },
        { name = "buffer" }
      }
    }

    cmp_setup.mapping["<C-k>"] = cmp.mapping.select_prev_item()
    cmp_setup.mapping["<C-j>"] = cmp.mapping.select_next_item()
    cmp_setup.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" })
    cmp_setup.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })

    local lsp = require('lsp-zero')
    lsp.preset('recommended')

    -- NOTE: Given that we want lspsaga to handle this, we omit those keymaps
    lsp.set_preferences({
      set_lsp_keymaps = { omit = { 'gd', 'K' } }
    })
    lsp.ensure_installed({
      'gopls',
    })
    -- (Optional) Configure lua language server for neovim

    lsp.setup_nvim_cmp({
      mapping = cmp_setup.mapping,
      sources = cmp_setup.sources
    })
    lsp.nvim_workspace()
    lsp.setup()

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        local client = vim.lsp.get_active_clients()[1]
        if not client then
          return
        end
        vim.cmd [[LspZeroFormat]]
      end
    })
  end
}
