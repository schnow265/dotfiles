local M = {}

M.packadd = function (package)
    vim.notify('Loading package "'..package..'"', 'debug')
    vim.cmd('packadd '.. package)
end

return M