-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
    -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
    'NMAC427/guess-indent.nvim', -- Detect tabstop and shiftwidth automatically

    -- NOTE: Plugins can also be added by using a table,
    -- with the first argument being the link and the following
    -- keys can be used to configure plugin behavior/loading/etc.
    --
    -- Use `opts = {}` to automatically pass options to a plugin's `setup()` function, forcing the plugin to be loaded.
    --

    -- modular approach: using `require 'path.name'` will
    -- include a plugin definition from file lua/path/name.lua

    require 'kickstart.plugins.gitsigns',

    require 'kickstart.plugins.which-key',

    require 'kickstart.plugins.telescope',

    require 'kickstart.plugins.lspconfig',

    require 'kickstart.plugins.conform',

    require 'kickstart.plugins.blink-cmp',

    require 'kickstart.plugins.tokyonight',

    require 'kickstart.plugins.todo-comments',

    require 'kickstart.plugins.mini',

    require 'kickstart.plugins.treesitter',

    -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
    -- init.lua. If you want these files, they are in the repository, so you can just download them and
    -- place them in the correct locations.

    -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
    --
    --  Here are some example plugins that I've included in the Kickstart repository.
    --  Uncomment any of the lines below to enable them (you will need to restart nvim).
    --
    require 'kickstart.plugins.debug',
    -- require 'kickstart.plugins.indent_line',
    -- require 'kickstart.plugins.lint',
    -- require 'kickstart.plugins.autopairs',
    require 'kickstart.plugins.neo-tree',

    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    This is the easiest way to modularize your config.
    --
    --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    -- { import = 'custom.plugins' },
    { import = 'schnow265_config.plugins' },
    --
    -- For additional information with loading, sourcing and examples see `:help lazy.nvim-🔌-plugin-spec`
    -- Or use telescope!
    -- In normal mode type `<space>sh` then write `lazy.nvim-plugin`
    -- you can continue same window with `<space>sr` which resumes last telescope search
}, {
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = '⌘',
            config = '🛠',
            event = '📅',
            ft = '📂',
            init = '⚙',
            keys = '🗝',
            plugin = '🔌',
            runtime = '💻',
            require = '🌙',
            source = '📄',
            start = '🚀',
            task = '📌',
            lazy = '💤 ',
        },
    },
    concurrency = jit.os:find("Windows") and 1 or nil,
    pkg = {
        enabled = true,
        cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua",
        -- the first package source that is found for a plugin will be used.
        sources = {
            "lazy",
            "rockspec", -- will only be used when rocks.enabled is true
            "packspec",
        },
    },
    rocks = {
        enabled = true,
        root = vim.fn.stdpath("data") .. "/lazy-rocks",
        server = "https://lumen-oss.github.io/rocks-binaries/",
        -- use hererocks to install luarocks?
        -- set to `nil` to use hererocks when luarocks is not found
        -- set to `true` to always use hererocks
        -- set to `false` to always use luarocks
        hererocks = nil,
    },
    headless = {
        -- show the output from process commands like git
        process = true,
        -- show log messages
        log = true,
        -- show task start/end
        task = true,
        -- use ansi colors
        colors = true,
    },
    readme = {
        enabled = true,
        root = vim.fn.stdpath("state") .. "/lazy/readme",
        files = { "README.md", "lua/**/README.md" },
        -- only generate markdown helptags for plugins that don't have docs
        skip_if_doc_exists = true,
    },
    performance = {
        cache = {
            enabled = true,
        },
    },
})

-- vim: ts=2 sts=2 sw=2 et
