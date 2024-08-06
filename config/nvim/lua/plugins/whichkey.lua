return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
  opts = {
    preset = "helix", 
    spec = {
	{ "<leader>f", group = "Telescope" }, -- telescope group
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fg", desc = "Live grep" },
        { "<leader>fb", desc = "Search Buffers" },
        { "<leader>fh", desc = "Help Tags" },

        { "<leader>x", group = "NeoTree" },
        { "<leader>xt", desc = "Toggle NeoTree" },
        { "<leader>xf", desc = "Focus NeoTree" },

        { "<leader>u", group = "Usage Tracker" }, -- Usage Tracker

        { "<leader>l", group = "Git" },
        { "<leader>lg", desc = "LazyGit" },

        { "<leader>t", group = "Testing" }, -- vim-test
        { "<leader>tt", desc = "Test nearest" },
        { "<leader>tl", desc = "Test last" },
        { "<leader>tf", desc = "Test file" },
        { "<leader>ts", desc = "Test suite" }
    },
  },
  keys = {
    {
      "<leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },  
}
