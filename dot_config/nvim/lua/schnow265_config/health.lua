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
        vim.health.warning(string.format(
            "'%s' is installed, but '%s --version' failed (exit code %d). The '--version' argument may be unsupported or incorrect.",
            executable,
            executable,
            result.code
        ))
    end
end

local executables = {
    'git',
    'cargo',
    'npm',
    'dotnet',
    'uv'
}

local programming_languages = {
    elixir = {
        'iex',
        'mix',
        'elixir',
    },
    dotnet = {
        'dotnet'
    },
    python = {
        'python',
        'uv'
    },
    rust = {
        'rustup',
        'cargo',
        'rustc',
    },
    ["Version Control"] = {
        'git'
    }
}

M.check = function()
    vim.health.start 'Required Executables'

    for _, executable in ipairs(executables) do
        isInstalled(executable)
    end

    vim.health.start 'Local files'

    local headerFile = vim.fn.stdpath 'config' .. '/header.txt'
    local f = io.open(headerFile, 'r')

    if not f then
        vim.health.error "The file 'header.txt' does not exist in the config root, or neovim failed to open it."
    else
        vim.health.ok "'header.txt' is avaliable and readable."
    end

    vim.health.start 'require-able config options'

    if canRequire 'config.serverconfig' then
        vim.health.ok 'serverconfig could be required'

        local lsp_configs = require('config.serverconfig').lspconfig

        local count = 0
        for _, _ in pairs(lsp_configs) do
            count = count + 1
        end

        if count == 0 then
            vim.health.warning("Either config.serverconfig.lspconfig is empty or something is wrong.")
        else
            vim.health.info(string.format('Configured %d LSP servers.', count))
        end
    else
        vim.health.error "could not require 'config.serverconfig'!"
    end

    vim.health.start "===== Programming language checks ====="

    for language, commands in pairs(programming_languages) do
        vim.health.start(string.format("\nGroup '%s'", language))

        for _, command in ipairs(commands) do
            isInstalled(command)
            checkVersion(command)
        end
    end
end

return M
