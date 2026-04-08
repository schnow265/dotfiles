return {
    "bassamsdata/namu.nvim",
    config = function()
    require("namu").setup({
        -- Enable the modules you want
        namu_symbols = {
            enable = true,
            options = {}, -- here you can configure namu
        },
        -- Optional: Enable other modules if needed
        ui_select = { enable = false }, -- vim.ui.select() wrapper
        colorscheme = {
            enable = false,
            options = {
                persist = true,      -- very efficient mechanism to Remember selected colorscheme
                write_shada = false, -- If you open multiple nvim instances, then probably you need to enable this
            },
        },
    })
    end,
    keys = {
        { "<leader>ss", "<cmd>Namu symbols<cr>", desc = "Jump to LSP symbol", silent = true },
        { "<leader>sw", "<cmd>Namu workspace<cr>", desc = "LSP Symbols - Workspace", silent = true }
    }
}
