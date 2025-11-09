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
-- LspAttach Autocommand - Modern Pattern (2025)
-- ============================================================================

-- Single autocommand that fires when any LSP server attaches to a buffer
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client then
      on_attach(client, args.buf)
    end
  end,
})

-- ============================================================================
-- Initialize Servers
-- ============================================================================

-- Load server configurations and enable them
require('config.lsp.servers').setup()
