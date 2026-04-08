return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      -- Load and select a random header before configuring
      local function get_random_header()
        local header_path = vim.fn.stdpath('config') .. '/header.txt'
        local f = io.open(header_path, "r")
        if not f then
          return "6E 65 6F 76 69 6D" -- Default if file doesn't exist
        end

        local lines = {}
        for line in f:lines() do
          if line and line:match("%S") and not line:match("^#") then  -- Skip empty lines and lines starting with '#'
            table.insert(lines, line)
          end
        end
        f:close()

        if #lines == 0 then
          return "6E 65 6F 76 69 6D" -- Default if file is empty
        end

        -- Get a random line from the file
        math.randomseed(os.time())
        local random_header = lines[math.random(#lines)]

        -- Process the header to remove quotes if needed
        if random_header:sub(1,1) == '"' then
          random_header = random_header:gsub('^"(.+)".*$', '%1')
        end

        -- Replace every '-' with a line break
        random_header = random_header:gsub("%s*-%s*", "\n")

        return random_header
      end

      -- Catch any errors during header generation
      local random_header = "6E 65 6F 76 69 6D"
      local ok, result = pcall(get_random_header)
      if ok then
        random_header = result
      else
        vim.notify("Error loading header: " .. tostring(result), vim.log.levels.WARN)
      end

      -- Ensure snacks is properly loaded
      local success, snacks = pcall(require, "snacks")
      if not success then
        vim.notify("Failed to load snacks plugin: " .. tostring(snacks), vim.log.levels.ERROR)
        return
      end

      snacks.setup({
        bigfile = { enabled = false },
        notifier = { enabled = false },
        quickfile = { enabled = false },
        statuscolumn = { enabled = false },
        zen = { enabled = false },
        words = { enabled = true },
        dashboard = {
          width = 60,
          row = nil,
          col = nil,
          pane_gap = 6, -- Increase gap between sections for better spacing
          autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
          preset = {
            keys = {
              { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
              { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
              { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
              {
                icon = " ",
                key = "c",
                desc = "Config",
                action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
              },
              { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
              { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
            header = random_header,
          },
          sections = {
            { section = "header", padding = 2},
            { section = "keys", gap = 1, padding = 1 },
            { section = "startup" },
          },
        },
      })
    end,
  },
}
