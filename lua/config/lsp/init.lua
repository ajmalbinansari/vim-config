-- LSP Configuration Initialization
-- Main LSP setup and on_attach function
-- Icons are handled by lspkind.nvim in lua/plugins/completion.lua

-- ============================================================================
-- Diagnostic Configuration
-- ============================================================================

vim.diagnostic.config({
  -- Show diagnostics in virtual text (inline)
  virtual_text = {
    prefix = '●',
    source = 'if_many',
  },
  -- Show diagnostics in sign column (gutter)
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.HINT] = " ",
      [vim.diagnostic.severity.INFO] = " ",
    },
  },
  -- Underline diagnostics
  underline = true,
  -- Update diagnostics while typing in insert mode
  update_in_insert = false,
  -- Sort diagnostics by severity
  severity_sort = true,
  -- Float window configuration
  float = {
    border = 'rounded',
    source = 'always',
    header = '',
    prefix = '',
  },
})

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
    if not client then return end

    -- Common on_attach for all servers
    on_attach(client, args.buf)

    -- TypeScript-specific: Disable formatting (Prettier handles it)
    if client.name == 'ts_ls' or client.name == 'tsserver' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false
    end

    -- ESLint-specific: Disable formatting + auto-fix on save
    if client.name == 'eslint' then
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      -- Auto-fix ESLint violations on save (before Prettier formats)
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        callback = function()
          -- Use pcall to avoid errors if EslintFixAll is not available
          pcall(vim.cmd, "EslintFixAll")
        end,
      })
    end
  end,
})

-- ============================================================================
-- Initialize Servers
-- ============================================================================

-- Load server configurations and enable them
require('config.lsp.servers').setup()
