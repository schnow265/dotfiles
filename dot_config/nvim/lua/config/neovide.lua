-- Config for Neovide

vim.o.guifont = "SauceCodePro Nerd Font:h12"
-- vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_animation_length = 0.13
vim.g.neovide_cursor_trail_size = 0.8

-- Keymaps for saving, copy, and paste with both Cmd (Mac) and Ctrl (Windows/Linux)
if vim.loop.os_uname().sysname == "Darwin" then
    vim.keymap.set("n", "<D-s>", ":w<CR>")      -- Save with Cmd+S
    vim.keymap.set("v", "<D-c>", '"+y')         -- Copy with Cmd+C
    vim.keymap.set("n", "<D-v>", '"+P')         -- Paste in normal mode with Cmd+V
    vim.keymap.set("v", "<D-v>", '"+P')         -- Paste in visual mode with Cmd+V
    vim.keymap.set("c", "<D-v>", "<C-R>+")      -- Paste in command mode with Cmd+V
    vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste in insert mode with Cmd+V

    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
else
    vim.keymap.set("n", "<C-s>", ":w<CR>")          -- Save with Ctrl+S
    vim.keymap.set("v", "<C-c>", '"+y')             -- Copy with Ctrl+C
    vim.keymap.set("n", "<C-v>", '"+P')             -- Paste in normal mode with Ctrl+V
    vim.keymap.set("v", "<C-v>", '"+P')             -- Paste in visual mode with Ctrl+V
    vim.keymap.set("c", "<C-v>", "<C-R>+")          -- Paste in command mode with Ctrl+V
    vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli')     -- Paste in insert mode with Ctrl+V

    vim.api.nvim_set_keymap("", "<C-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<C-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<C-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<C-v>", "<C-R>+", { noremap = true, silent = true })
end

-- Nuclear option: disable all animations.
-- Gosh do I hate them.

vim.g.neovide_position_animation_length = 0
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
