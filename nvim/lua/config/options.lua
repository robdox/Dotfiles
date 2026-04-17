-- ~/.config/nvim/lua/config/options.lua — editor behaviour.

local o = vim.opt

-- UI
o.number = true
o.relativenumber = true
o.numberwidth = 5
o.signcolumn = 'yes'
o.cursorline = true
o.showmode = false        -- lualine shows it
o.termguicolors = true
o.scrolloff = 8
o.sidescrolloff = 8
o.wrap = false
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '·' }
o.fillchars = { eob = ' ' }

-- Editing
o.expandtab = true
o.shiftwidth = 2
o.tabstop = 2
o.shiftround = true
o.smartindent = true
o.breakindent = true
o.textwidth = 80
o.colorcolumn = '80,120'

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

-- Splits feel natural
o.splitbelow = true
o.splitright = true

-- Performance / UX
o.updatetime = 250
o.timeoutlen = 400
o.undofile = true
o.swapfile = false
o.backup = false
o.confirm = true
o.mouse = 'a'
o.clipboard = 'unnamedplus'  -- share with macOS clipboard

-- Completion menu
o.completeopt = { 'menuone', 'noselect', 'noinsert' }

-- Ag-style grep if rg is present
if vim.fn.executable('rg') == 1 then
  o.grepprg = 'rg --vimgrep --smart-case --hidden'
  o.grepformat = '%f:%l:%c:%m'
end

-- Match our spell file location from the old .vimrc.
o.spellfile = vim.fn.expand('$HOME/.vim-spell-en.utf-8.add')
