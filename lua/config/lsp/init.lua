-- LSP Configuration Initialization
-- Main LSP setup and on_attach function
-- Icons are handled by lspkind.nvim in lua/plugins/completion.lua

-- ============================================================================
-- LSP Attach Handler
-- ============================================================================

local function on_attach(client, bufnr)
  -- Setup LSP keymaps
  require('config.lsp.keymaps').setup(bufnr)

  -- Setup diagnostic floating window on cursor hold
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })
end

-- ============================================================================
-- LspAttach Autocommands
-- ============================================================================

-- Lua Language Server
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'lua_ls' then
      on_attach(client, args.buf)
    end
  end,
})

-- TypeScript Language Server
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'ts_ls' then
      on_attach(client, args.buf)
    end
  end,
})

-- Flow Type Checker
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'flow' then
      on_attach(client, args.buf)
    end
  end,
})

-- PHP Language Server
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == 'phpactor' then
      on_attach(client, args.buf)
    end
  end,
})

-- ============================================================================
-- Initialize Servers
-- ============================================================================

-- Load server configurations and enable them
require('config.lsp.servers').setup()
