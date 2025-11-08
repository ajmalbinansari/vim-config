-- Test file to verify Neovim LSP setup
-- Open this file in Neovim to test Lua LSP
local function greet(name)
  print('Hello, ' .. name)
end

-- Test autocomplete: type vim. and you should see completions
vim.notify('Testing Lua LSP!')

-- Test hover: place cursor on 'greet' below and press 'K'
greet('Neovim')

-- Test go to definition: place cursor on 'greet' and press 'gd'
greet('World')

-- Intentional error to test diagnostics:
-- Uncomment the line below to see error highlighting
-- this_variable_does_not_exist()

return {
  status = 'LSP test file',
  -- Test formatting: save this file and it should auto-format with stylua
}
