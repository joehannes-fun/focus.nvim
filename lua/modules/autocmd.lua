local api = vim.api
local cmd = api.nvim_command
local autocmd = {}

local function nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    cmd('augroup '..group_name)
    cmd('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{'autocmd', def}, ' ')
      cmd(command)
    end
    cmd('augroup END')
  end
end

function autocmd.setup(config) --> TODO: Replace with WinEnter once telescope bug figured out
  local autocmds = {
    { 'BufWinEnter', '*', 'lua require \'modules.resizer\'.split_resizer('..config.width..','..config.height..')'},
    { 'BufWinEnter', '*', 'setlocal signcolumn=no'},
  }

  if config.cursorline ~= false then
    -- Explicitly check against false, as it not being present should default to it being on
    table.insert(autocmds, { 'BufWinEnter', '*', 'setlocal cursorline' })
    table.insert(autocmds, { 'BufWinLeave', '*', 'setlocal nocursorline' })
  end

  nvim_create_augroups({autocmds})
end

return autocmd
