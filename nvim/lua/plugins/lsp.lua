-- ~/.config/nvim/lua/plugins/lsp.lua — LSP + Mason-managed servers.
--
-- Mason installs language servers into ~/.local/share/nvim/mason, so no
-- manual `npm install -g typescript-language-server` ceremony.

return {
  -- Package manager for LSP servers / formatters / linters.
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = { ui = { border = 'rounded' } },
  },
  { 'williamboman/mason-lspconfig.nvim' },
  { 'WhoIsSethDaniel/mason-tool-installer.nvim' },

  -- Faster TS integration than stock lspconfig's tsserver handling.
  { 'pmizio/typescript-tools.nvim', dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' }, opts = {} },

  -- Core LSP.
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'hrsh7th/cmp-nvim-lsp',
      { 'j-hui/fidget.nvim', opts = {} },  -- LSP progress UI
    },
    config = function()
      -- ── Keymaps applied on LspAttach ─────────────────────────────────────
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('rob-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          local builtin = require('telescope.builtin')
          map('gd', builtin.lsp_definitions,       '[G]oto [D]efinition')
          map('gr', builtin.lsp_references,        '[G]oto [R]eferences')
          map('gI', builtin.lsp_implementations,   '[G]oto [I]mplementation')
          map('gy', builtin.lsp_type_definitions,  'Goto t[y]pe definition')
          map('K',  vim.lsp.buf.hover,             'Hover documentation')
          map('<leader>rn', vim.lsp.buf.rename,    '[R]e[n]ame symbol')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('[d', function() vim.diagnostic.jump({ count = -1, float = true }) end, 'Previous diagnostic')
          map(']d', function() vim.diagnostic.jump({ count =  1, float = true }) end, 'Next diagnostic')
          map('<leader>cd', vim.diagnostic.open_float, '[C]ode [D]iagnostic on this line')
        end,
      })

      -- Diagnostic UI
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = 'rounded', source = 'if_many' },
        underline = { severity = vim.diagnostic.severity.ERROR },
        virtual_text = { source = 'if_many', spacing = 2 },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = '',
            [vim.diagnostic.severity.WARN]  = '',
            [vim.diagnostic.severity.INFO]  = '',
            [vim.diagnostic.severity.HINT]  = '',
          },
        },
      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      -- ── Servers ──────────────────────────────────────────────────────────
      -- typescript-tools handles tsserver; everything else via vim.lsp.config.
      local servers = {
        eslint            = {},
        prismals          = {},
        yamlls            = {
          settings = {
            yaml = {
              schemaStore = { enable = true, url = '' },
              keyOrdering = false,
            },
          },
        },
        jsonls            = {},
        lua_ls            = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { globals = { 'vim' } },
            },
          },
        },
        bashls            = {},
        tailwindcss       = {},
        cssls             = {},
        html              = {},
        marksman          = {},  -- markdown
        pyright           = {},
        gopls             = {},
      }

      -- Register per-server overrides with the new vim.lsp.config API.
      -- mason-lspconfig v2 calls vim.lsp.enable() for each installed server,
      -- which merges these overrides with the base config shipped by lspconfig.
      for server, opts in pairs(servers) do
        opts.capabilities = vim.tbl_deep_extend('force', {}, capabilities, opts.capabilities or {})
        vim.lsp.config(server, opts)
      end

      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, {
        'stylua',          -- lua formatter
        'prettierd',       -- prettier daemon (matches pnpm format)
        'eslint_d',        -- eslint daemon
        'shfmt',           -- bash formatter
        'goimports',       -- go formatter
      })
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

      require('mason-lspconfig').setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_enable = true,
      })
    end,
  },
}
