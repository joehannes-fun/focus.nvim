local vim = vim --> Use locals

local M = {}
function M.split_resizer(config) --> Only resize normal buffers, set qf to 10 always
    local ft = vim.bo.ft
    -- if ft == 'NvimTree' or ft == 'NerdTree'  or ft == 'CHADTree' then FIX: This does not work
    if ft == 'qf' then
        vim.o.winwidth = 10
    else
        vim.o.winwidth = config.width --> lua print(vim.o.winwidth)
    end
    if config.height ~= 0 then vim.o.winheight = config.height --> Opt in to set height value, otherwise auto-size it
    end

end

return M
