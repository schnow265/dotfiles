local M = {}

local function canRequire(moduleName)
    local success, _ = pcall(require, moduleName)
    return success
end

local function isInstalled(executable)
    if vim.fn.executable(executable) == 1 then
        vim.health.ok(string.format("'%s' is installed", executable))
    else
        vim.health.error(string.format("'%s' is not installed", executable))
    end
end

local function checkVersion(executable)
    -- First verify installation
    if vim.fn.executable(executable) ~= 1 then
        return
    end

    -- Run "<executable> --version"
    local result = vim.system({ executable, "--version" }, { text = true }):wait()

    if result.code == 0 then
        local output = (result.stdout or ""):gsub("%s+$", "")
        if output == "" then
            vim.health.info(string.format("'%s --version' returned no output", executable))
        else
            vim.health.info(output)
        end
    else
        vim.health.warn(string.format(
            "'%s' is installed, but '%s --version' failed (exit code %d).",
            executable,
            executable,
            result.code
        ), "The '--version' argument may be unsupported or incorrect.")
    end
end

local cli_tools = {
    elixir = {
        'iex',
        'mix',
        'elixir'
    },
    dotnet = {
        'dotnet',
        'csharp-ls'
    },
    python = {
        'uv',
        'ruff',
        'ty'
    },
    rust = {
        'rustup',
        'cargo',
        'rustc',
    },
    ["Version Control"] = {
        'git'
    },
    ["C/C++"] = {
        'clang',
        'clang++',
        'lldb',
        'clangd'
    },
    ["General Tools"] = {
        'trivy',
        'ast-grep'
    },
    lua = {
        'lua',
        'lua-language-server',
        'stylua'
    }
}

local lua_libs = {
    'schnow265.lib'
}

M.check = function()
    vim.health.start '===== Local files ====='

    local headerFile = vim.fn.stdpath 'config' .. '/header.txt'
    local f = io.open(headerFile, 'r')

    if not f then
        vim.health.error "The file 'header.txt' does not exist in the config root, or neovim failed to open it."
    else
        vim.health.ok "'header.txt' is avaliable and readable."
    end

    vim.health.start '===== require-able config options ====='

    if canRequire 'config.serverconfig' then
        vim.health.ok 'serverconfig could be required'

        local lsp_configs = require('config.serverconfig').lspconfig

        local count = 0
        for _, _ in pairs(lsp_configs) do
            count = count + 1
        end

        if count == 0 then
            vim.health.warn("Either config.serverconfig.lspconfig is empty or something is wrong.",
                "Check if the file exists and looks fine.")
        else
            vim.health.info(string.format('Configured %d LSP servers.', count))
        end
    else
        vim.health.error "could not require 'config.serverconfig'!"
    end

    vim.health.start "===== CLI Tools ====="

    for language, commands in pairs(cli_tools) do
        vim.health.start(string.format("Group '%s'", language))

        for _, command in ipairs(commands) do
            isInstalled(command)
            checkVersion(command)
        end
    end

    vim.health.start "===== Library functions ====="

    for _, config in pairs(lua_libs) do
        if canRequire(config) then
            local lib = require(config)

            local count = 0
            for _, _ in pairs(lib) do
                count = count + 1
            end

            if count == 0 then
                vim.health.warn("No functions/exports found in library.", "Library may be in development. Ignore this.")
            else
                vim.health.ok(string.format('Found %d exports in library %s', count, config))
            end
        else
            vim.health.error(
                string.format("Could not require '%s'. Please make sure it is actually there.", config))
        end
    end
end

return M
