-- ~/.config/nvim/lua/config/keymaps.lua — non-plugin keymaps.
--
-- Plugin-specific keys live alongside their plugin specs in lua/plugins/*.
-- Leader is <Space>.

local map = vim.keymap.set

-- Clear search highlights on <Esc>
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Faster window movement (matches the muscle memory from the old .vimrc)
map('n', '<C-h>', '<C-w>h', { desc = 'Focus window left' })
map('n', '<C-j>', '<C-w>j', { desc = 'Focus window down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Focus window up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Focus window right' })

-- Resize splits with arrows (use sparingly — you're a wasd dog)
map('n', '<C-Up>',    '<cmd>resize +2<CR>')
map('n', '<C-Down>',  '<cmd>resize -2<CR>')
map('n', '<C-Left>',  '<cmd>vertical resize -2<CR>')
map('n', '<C-Right>', '<cmd>vertical resize +2<CR>')

-- Stay in visual after indent shift
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Move lines up/down with Alt-j/k (very handy; nvim-native)
map('n', '<A-j>', '<cmd>m .+1<CR>==')
map('n', '<A-k>', '<cmd>m .-2<CR>==')
map('v', '<A-j>', ":m '>+1<CR>gv=gv")
map('v', '<A-k>', ":m '<-2<CR>gv=gv")

-- Keep cursor centered on big jumps
map('n', '<C-d>', '<C-d>zz')
map('n', '<C-u>', '<C-u>zz')
map('n', 'n', 'nzzzv')
map('n', 'N', 'Nzzzv')

-- Save / quit without shift
map('n', '<leader>w', '<cmd>write<CR>', { desc = 'Save' })
map('n', '<leader>q', '<cmd>quit<CR>',  { desc = 'Quit' })
map('n', '<leader>Q', '<cmd>qa!<CR>',   { desc = 'Force quit all' })

-- Buffer nav
map('n', '<S-h>', '<cmd>bprevious<CR>', { desc = 'Previous buffer' })
map('n', '<S-l>', '<cmd>bnext<CR>',     { desc = 'Next buffer' })
map('n', '<leader>bd', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })

-- Yank/paste without clobbering the register when pasting over a selection
map('x', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to system clipboard' })
map('n', '<leader>Y', '"+Y', { desc = 'Yank line to system clipboard' })
map({ 'n', 'v' }, '<leader>d', '"_d', { desc = 'Delete without yanking' })

-- Keep the "switch to last file" shortcut from your old config.
map('n', '<leader><leader>', '<C-^>', { desc = 'Switch to last file' })
