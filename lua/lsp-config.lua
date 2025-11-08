local nvim_lsp = require('lspconfig')
-- require('completions-config')

local protocol = require('vim.lsp.protocol')

-- Create autocommand group (must be defined before use)
local augroup_format = vim.api.nvim_create_augroup("PHPformat", { clear = false })

-- Set up completion using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

protocol.CompletionItemKind = {
	'', -- Text
	'', -- Method
	'', -- Function
	'', -- Constructor
	'', -- Field
	'', -- Variable
	'', -- Class
	'ﰮ', -- Interface
	'', -- Module
	'', -- Property
	'', -- Unit
	'', -- Value
	'', -- Enum
	'', -- Keyword
	'﬌', -- Snippet
	'', -- Color
	'', -- File
	'', -- Reference
	'', -- Folder
	'', -- EnumMember
	'', -- Constant
	'', -- Struct
	'', -- Event
	'ﬦ', -- Operator
	'', -- TypeParameter
}

local enable_format_on_save = function(_, bufnr)
	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup_format,
		buffer = bufnr,
		callback = function()
			vim.lsp.buf.format({ bufnr = bufnr })
		end,
	})
end


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end


	--Enable completion triggered by <c-x><c-o>
	--local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	--buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	-- buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
	buf_set_keymap('n', 'gd', '<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>', opts)
	buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
	buf_set_keymap('n', 'gr', '<Cmd>lua require("telescope.builtin").lsp_references()<CR>', opts)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts_ = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = 'rounded',
				source = 'always',
				prefix = ' ',
				scope = 'cursor',
			}
			vim.diagnostic.open_float(nil, opts_)
		end
	})
end

nvim_lsp.lua_ls.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		enable_format_on_save(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { 'vim' },
			},

			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false
			},
		},
	},
}
--

nvim_lsp.ts_ls.setup {
	on_attach = function(client, bufnr)
		on_attach(client, bufnr)
		-- enable_format_on_save(client, bufnr)
	end,
	filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "jsx" },
	cmd = { "typescript-language-server", "--stdio" },
	capabilities = capabilities
}

nvim_lsp.flow.setup {
	on_attach = on_attach,
	capabilities = capabilities
}



-- Specify the path to the PHP-CS-Fixer executable

-- Function to run PHP-CS-Fixer on "BufWritePre" event
local enable_format_on_save_php = function(_, bufnr)
	-- Clear existing autocommands in the group for the current buffer
	local php_cs_fixer = "/usr/local/bin/php-cs-fixer"

	vim.api.nvim_clear_autocmds({ group = augroup_format, buffer = bufnr })

	vim.api.nvim_create_autocmd({ "BufWritePre" }, {
		group = augroup_format,
		pattern = { "*.php" },
		-- command = "echo 'Entering a C or C++ file'",
		-- command = string.format('%s fix %s', php_cs_fixer, vim.fn.expand('%')),
		-- command = "w !php-cs-fixer fix --allow-risky yes -"
		command = "FormatAndSaveBuffer"

	})
end

-- Example configuration for your PHPactor LSP
require('lspconfig').phpactor.setup {
	capabilities = capabilities,
	on_attach = function(client, bufnr)
		-- Attach PHPactor to the buffer
		-- You can add other configuration options as needed
		on_attach(client, bufnr)
		capabilities = capabilities

		-- Enable auto-formatting with PHP-CS-Fixer on save
		-- enabe_format_on_save_php(client, bufnr)
	end,
	-- Other settings...
}
