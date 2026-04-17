-- ~/.config/nvim/lua/plugins/editor.lua — editing ergonomics.

return {
  -- Auto-detect tab/space settings per file (honors .editorconfig too).
  { 'tpope/vim-sleuth', event = 'VeryLazy' },

  -- Comment toggling: `gcc` line, `gc` in visual, `gbc` block.
  { 'numToStr/Comment.nvim', event = 'VeryLazy', opts = {} },

  -- Surround: `ysiw"` wrap word in quotes; `cs"'` change " to ', etc.
  {
    'echasnovski/mini.surround',
    event = 'VeryLazy',
    opts = {
      mappings = {
        add    = 'ys',
        delete = 'ds',
        find   = '',
        find_left = '',
        highlight = '',
        replace = 'cs',
        update_n_lines = '',
      },
    },
  },

  -- Auto-pair brackets/quotes.
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = { check_ts = true, fast_wrap = {} },
  },

  -- Surface TODO / FIXME / HACK / NOTE / PERF in a searchable panel.
  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
    keys = {
      { '<leader>st', '<cmd>TodoTelescope<CR>', desc = '[S]earch [T]ODOs' },
    },
  },

  -- File explorer: :Oil — opens the current directory as a buffer you can edit.
  -- Lighter than neo-tree, fits the "terminal dog" vibe better.
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = false,   -- required because it hooks into filetype detection
    opts = {
      default_file_explorer = true,
      view_options = { show_hidden = true },
    },
    keys = {
      { '-', '<cmd>Oil<CR>', desc = 'Open parent directory (oil)' },
    },
  },

  -- Keep vim-test bindings from the old config alive.
  {
    'vim-test/vim-test',
    cmd = { 'TestFile', 'TestNearest', 'TestLast', 'TestSuite', 'TestVisit' },
    keys = {
      { '<leader>tt', '<cmd>TestFile<CR>',    desc = 'Test file' },
      { '<leader>tn', '<cmd>TestNearest<CR>', desc = 'Test nearest' },
      { '<leader>tl', '<cmd>TestLast<CR>',    desc = 'Test last' },
      { '<leader>ta', '<cmd>TestSuite<CR>',   desc = 'Test suite' },
      { '<leader>tg', '<cmd>TestVisit<CR>',   desc = 'Test visit' },
    },
  },
}
