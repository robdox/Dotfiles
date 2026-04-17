-- ~/.config/nvim/init.lua
--
-- Kickstart-inspired config, trimmed and tuned for the Unify TS monorepo.
-- Structure:
--   lua/config/*  — options / keymaps / autocmds (loaded in order)
--   lua/plugins/* — one file per plugin concern; lazy.nvim auto-imports them
--
-- First launch will bootstrap lazy.nvim and install all plugins.

-- Leader must be set before lazy loads plugins that key off it.
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('config.options')
require('config.keymaps')
require('config.autocmds')

-- ── Bootstrap lazy.nvim plugin manager ──────────────────────────────────────
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local repo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system({ 'git', 'clone', '--filter=blob:none', '--branch=stable', repo, lazypath })
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = { border = 'rounded' },
  change_detection = { notify = false },
})
