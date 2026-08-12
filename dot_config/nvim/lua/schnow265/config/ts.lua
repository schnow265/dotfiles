local ts_requires = require("config.serverconfig").treesitter

vim.notify(string.format("Auto-Loading parsers: '%s'", table.concat(ts_requires.parsers, ", ")), "debug")

vim.api.nvim_create_autocmd("FileType", {
    pattern = ts_requires.parsers,
    callback = function()
        vim.notify("TreeSitter parser registered", "debug")
        -- syntax highlighting, provided by Neovim
        vim.treesitter.start()
        -- folds, provided by Neovim
        --vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
        --vim.wo.foldmethod = 'expr'
        -- indentation, provided by nvim-treesitter
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end,
})
