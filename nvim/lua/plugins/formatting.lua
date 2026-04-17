-- ~/.config/nvim/lua/plugins/formatting.lua — format + lint on save.
--
-- Prettier via prettierd for TS/JS to match `pnpm format` output exactly.

return {
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      { '<leader>cf', function() require('conform').format({ async = true, lsp_fallback = true }) end, desc = '[C]ode [F]ormat' },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Respect a per-buffer disable flag.
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 2000, lsp_fallback = true }
      end,
      formatters_by_ft = {
        lua        = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        javascriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        typescriptreact = { 'prettierd', 'prettier', stop_after_first = true },
        json       = { 'prettierd', 'prettier', stop_after_first = true },
        jsonc      = { 'prettierd', 'prettier', stop_after_first = true },
        yaml       = { 'prettierd', 'prettier', stop_after_first = true },
        markdown   = { 'prettierd', 'prettier', stop_after_first = true },
        css        = { 'prettierd', 'prettier', stop_after_first = true },
        html       = { 'prettierd', 'prettier', stop_after_first = true },
        graphql    = { 'prettierd', 'prettier', stop_after_first = true },
        go         = { 'goimports', 'gofmt' },
        python     = { 'ruff_format', 'black' },
        sh         = { 'shfmt' },
        zsh        = { 'shfmt' },
      },
    },
    init = function()
      vim.api.nvim_create_user_command('FormatToggle', function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print('Autoformat: ' .. (vim.g.disable_autoformat and 'OFF' or 'ON'))
      end, { desc = 'Toggle format-on-save globally' })
    end,
  },
}
