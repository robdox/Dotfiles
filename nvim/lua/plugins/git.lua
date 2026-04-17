-- ~/.config/nvim/lua/plugins/git.lua — gitsigns + fugitive.

return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      signs = {
        add          = { text = '▎' },
        change       = { text = '▎' },
        delete       = { text = '' },
        topdelete    = { text = '' },
        changedelete = { text = '▎' },
        untracked    = { text = '▎' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
        end

        map('n', ']c', function() gs.nav_hunk('next') end, 'Next git hunk')
        map('n', '[c', function() gs.nav_hunk('prev') end, 'Previous git hunk')

        map('n', '<leader>hs', gs.stage_hunk,       'git [H]unk [S]tage')
        map('n', '<leader>hr', gs.reset_hunk,       'git [H]unk [R]eset')
        map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Stage selection')
        map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end, 'Reset selection')
        map('n', '<leader>hS', gs.stage_buffer,     'git [H]unk stage [S] buffer')
        map('n', '<leader>hu', gs.undo_stage_hunk,  'git [H]unk [U]ndo stage')
        map('n', '<leader>hR', gs.reset_buffer,     'git [H]unk [R]eset buffer')
        map('n', '<leader>hp', gs.preview_hunk,     'git [H]unk [P]review')
        map('n', '<leader>hb', function() gs.blame_line { full = true } end, 'git [H]unk [B]lame line')
        map('n', '<leader>hd', gs.diffthis,         'git [H]unk [D]iff against index')
      end,
    },
  },

  -- Still the best tool for :Git blame, :Git rebase -i workflows.
  { 'tpope/vim-fugitive', cmd = { 'Git', 'G' } },
}
