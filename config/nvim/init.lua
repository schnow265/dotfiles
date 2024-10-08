-- set keybinds and nvim options
vim.g.mapleader = ';'
vim.o.number = true

-- Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.cmd 'colorscheme nord'

-- Telescope Keybinds
local telescopeFuncts = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', telescopeFuncts.find_files, {})
vim.keymap.set('n', '<leader>fg', telescopeFuncts.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescopeFuncts.buffers, {})
vim.keymap.set('n', '<leader>fh', telescopeFuncts.help_tags, {})

-- NeoTree
vim.api.nvim_set_keymap('n', '<leader>xt', ':Neotree filesystem toggle left<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>xf', ':Neotree focus<CR>', { noremap = true, silent = true })

-- UsageTracker
vim.api.nvim_set_keymap('n', '<leader>ul', ':UsageTrackerShowFilesLifetime<CR>', {noremap = true, silent = true})

vim.g['test#neovim#start_normal'] = 1

-- autoclose
vim.g['closetag_filenames'] = '*.html,*.erb'

-- vim-test strategy
vim.g['test#strategy'] = 'vimux'

-- vim-test keybinds
vim.cmd("let test#strategy = 'vimux'")
vim.keymap.set('n', '<leader>tt', '<cmd>TestNearest<CR>', { desc = "Test nearest" })
vim.keymap.set('n', '<leader>tl', '<cmd>TestLast<CR>', { desc = "Test last" })
vim.keymap.set('n', '<leader>tf', '<cmd>TestFile<CR>', { desc = "Test file" })
vim.keymap.set('n', '<leader>ts', '<cmd>TestSuite<CR>', {desc = "Test suite" })
