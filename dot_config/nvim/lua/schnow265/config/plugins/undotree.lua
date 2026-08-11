return {
    "XXiaoA/atone.nvim",
    cmd = "Atone",
    ---@module "atone"
    ---@type AtoneConfig
    opts = {
        layout = {
            direction = "right",
        },
        auto_attach = {
            enabled = true,
            excluded_ft = { "oil" },
        },
        keymaps = {
            tree = {
                quit = { "<C-c>", "q" },
                next_node = "j", -- support v:count
                pre_node = "k", -- support v:count
                jump_to_G = "G",
                jump_to_gg = "gg",
                undo_to = "<CR>",
                set_mark = "m",
                delete_mark = { "x", "X" },
                delete_all_marks = "dM",
                goto_mark = { "'", "`" },
                mark_picker = "s",
                help = { "?", "g?" },
            },
            auto_diff = {
                quit = { "<C-c>", "q" },
                help = { "?", "g?" },
            },
            help = {
                quit_help = { "<C-c>", "q" },
            },
        },
        ui = {
            border = "rounded",
            compact = false,
        },
    },
}