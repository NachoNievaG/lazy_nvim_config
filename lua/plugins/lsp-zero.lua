return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        build = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },     -- Required
      { 'hrsh7th/cmp-nvim-lsp' }, -- Required
      { 'L3MON4D3/LuaSnip' },     -- Required
      { 'simrat39/rust-tools.nvim' },
      { 'saadparwaiz1/cmp_luasnip' },
      { "rafamadriz/friendly-snippets" }
    },
    config = function()
      local lsp = require('lsp-zero').preset('minimal')

      lsp.on_attach(function(client, bufnr)
        lsp.default_keymaps({ buffer = bufnr })
      end)

      --
      -- (Optional) Configure lua language server for neovim
      require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
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


      local cmp = require('cmp')
      local luasnip = require('luasnip')
      local cmp_action = require('lsp-zero').cmp_action()
      require('luasnip.loaders.from_vscode').lazy_load()
      cmp.setup({
        mapping = {
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),

          -- Ctrl+Space to trigger completion menu
          ['<C-Space>'] = cmp.mapping.complete(),

          -- Navigate between snippet placeholder
          ['<C-f>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),
        },
        snippet = {
          expand = function(args)
            require 'luasnip'.lsp_expand(args.body)
          end
        },
        sources = {
          { name = 'luasnip', keyword_length = 2 },
          { name = 'path' },
          { name = 'nvim_lsp' },
          { name = 'buffer',  keyword_length = 3 },
        },
      })
    end
  }
}
