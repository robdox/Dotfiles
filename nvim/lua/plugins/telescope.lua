-- ~/.config/nvim/lua/plugins/telescope.lua — fuzzy finder.
--
-- Bread-and-butter picker. Replaces CtrlP + Ag from the old .vimrc.

return {
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'nvim-telescope/telescope-ui-select.nvim',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')

      telescope.setup({
        defaults = {
          prompt_prefix = '   ',
          selection_caret = ' ',
          path_display = { 'truncate' },
          sorting_strategy = 'ascending',
          layout_config = { prompt_position = 'top' },
          mappings = {
            i = {
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<Esc>'] = actions.close,
            },
          },
        },
        pickers = {
          find_files = { hidden = true, file_ignore_patterns = { '.git/', 'node_modules/', '.turbo/', 'dist/', 'build/', '.next/' } },
          live_grep  = { additional_args = function() return { '--hidden' } end },
        },
        extensions = {
          ['ui-select'] = { require('telescope.themes').get_dropdown({}) },
        },
      })

      telescope.load_extension('fzf')
      telescope.load_extension('ui-select')

      local builtin = require('telescope.builtin')
      local map = vim.keymap.set
      map('n', '<leader>sf', builtin.find_files,        { desc = '[S]earch [F]iles' })
      map('n', '<leader>sg', builtin.live_grep,         { desc = '[S]earch by [G]rep' })
      map('n', '<leader>sw', builtin.grep_string,       { desc = '[S]earch current [W]ord' })
      map('n', '<leader>sb', builtin.buffers,           { desc = '[S]earch [B]uffers' })
      map('n', '<leader>sh', builtin.help_tags,         { desc = '[S]earch [H]elp' })
      map('n', '<leader>sd', builtin.diagnostics,       { desc = '[S]earch [D]iagnostics' })
      map('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch document [S]ymbols' })
      map('n', '<leader>sS', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch workspace [S]ymbols' })
      map('n', '<leader>sk', builtin.keymaps,           { desc = '[S]earch [K]eymaps' })
      map('n', '<leader>sr', builtin.resume,            { desc = '[S]earch [R]esume' })
      map('n', '<leader>s.', builtin.oldfiles,          { desc = '[S]earch recent files' })
      map('n', '<leader>/',  builtin.current_buffer_fuzzy_find, { desc = 'Fuzzy-find in current buffer' })
      map('n', '<leader>gb', builtin.git_branches,      { desc = '[G]it [B]ranches' })
      map('n', '<leader>gc', builtin.git_commits,       { desc = '[G]it [C]ommits' })
    end,
  },
}
