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
vim.api.nvim_set_keymap('n', '<leader>x', ':Neotree filesystem toggle left<CR>', { noremap = true, silent = true })

-- UsageTracker
vim.api.nvim_set_keymap('n', '<leader>ul', ':UsageTrackerShowFilesLifetime<CR>', {noremap = true, silent = true})

-- NeoGit
vim.api.nvim_set_keymap('n', '<leader>gg', ':Neogit<CR>', {noremap = true, silent = true})    
vim.api.nvim_set_keymap('n', '<leader>gf', ':Neogit cwd=%:p:h<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gc', ':Neogit commit<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gm', ':Neogit merge<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gr', ':Neogit rebase<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gd', ':Neogit diff<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>gs', ':Neogit stash<CR>', {noremap = true, silent = true})

-- whichkey additions
local wk = require("which-key")
wk.add({
  { "<leader>f", group = "Telescope" }, -- telescope group
  { "<leader>ff", desc = "Find Files" },
  { "<leader>fg", desc = "Live grep" },
  { "<leader>fb", desc = "Search Buffers" },
  { "<leader>fh", desc = "Help Tags" },

  { "<leader>x", desc = "Toggle NeoTree" },

  { "<leader>u", group = "Usage Tracker" }, -- Usage Tracker

  { "<leader>g", group = "Git" }, -- neogit group
  { "<leader>gg", desc = "NeoGit" },
  { "<leader>gf", desc = "Repo of current file" }, 
  { "<leader>gm", desc = "Merge" },
  { "<leader>gr", desc = "Rebase" },
  { "<leader>gd", desc = "Diff" },
  { "<leader>gs", desc = "Stash" },
})
