-- ~/.config/nvim/lua/plugins/treesitter.lua — syntax + incremental selection.

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    config = function()
      require('nvim-treesitter.configs').setup({
        ensure_installed = {
          'lua', 'vim', 'vimdoc', 'bash',
          'typescript', 'tsx', 'javascript', 'jsdoc',
          'json', 'jsonc', 'yaml', 'toml',
          'html', 'css', 'scss', 'graphql',
          'markdown', 'markdown_inline',
          'python', 'go', 'rust',
          'prisma', 'sql',
          'dockerfile', 'gitcommit', 'gitignore', 'gitattributes',
          'regex', 'diff',
        },
        auto_install = true,
        highlight = { enable = true },
        indent    = { enable = true, disable = { 'python' } },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            node_decremental = '<BS>',
            scope_incremental = '<C-s>',
          },
        },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['aa'] = '@parameter.outer',
              ['ia'] = '@parameter.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start     = { [']f'] = '@function.outer', [']c'] = '@class.outer' },
            goto_previous_start = { ['[f'] = '@function.outer', ['[c'] = '@class.outer' },
          },
        },
      })
    end,
  },
}
