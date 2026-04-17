-- ~/.config/nvim/lua/config/autocmds.lua — auto-commands.

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Highlight on yank.
autocmd('TextYankPost', {
  group = augroup('highlight-yank', { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

-- Restore cursor to last known position on file open (from old .vimrc).
autocmd('BufReadPost', {
  group = augroup('restore-cursor', { clear = true }),
  callback = function()
    local ft = vim.bo.filetype
    if ft == 'gitcommit' or ft == 'gitrebase' then return end
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Strip trailing whitespace on save for common code filetypes.
autocmd('BufWritePre', {
  group = augroup('strip-trailing-ws', { clear = true }),
  pattern = { '*.ts', '*.tsx', '*.js', '*.jsx', '*.lua', '*.py', '*.go', '*.md', '*.yaml', '*.yml', '*.json', '*.sh', '*.zsh' },
  callback = function()
    local view = vim.fn.winsaveview()
    vim.cmd([[silent! %s/\s\+$//e]])
    vim.fn.winrestview(view)
  end,
})

-- Auto-resize splits when the terminal window changes.
autocmd('VimResized', {
  group = augroup('auto-resize', { clear = true }),
  command = 'tabdo wincmd =',
})
