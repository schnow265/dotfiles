return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require('lualine').setup {
                options = { theme = 'nord' }
            }
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
        'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
        'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
        -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
        -- animation = true,
        -- insert_at_start = true,
        -- …etc.
        },
    },
    { 'shaunsingh/nord.nvim' },
    {
        'goolord/alpha-nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'nvim-lua/plenary.nvim'
        },
        config = function ()
            require'alpha'.setup(require'alpha.themes.theta'.config)
        end
    },
    {
      'VonHeikemen/fine-cmdline.nvim',
      dependencies = {
        'MunifTanjim/nui.nvim'
      },
      init = function() vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true}) end,
    },
}
