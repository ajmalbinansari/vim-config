-- ============================================================================
-- Neovim Configuration Entry Point
-- ============================================================================
--
-- This is the main entry point for Neovim configuration.
-- All actual configuration is modularized in lua/config/ and lua/plugins/
--
-- Structure:
--   lua/config/        - Core configuration (options, keymaps, autocmds, lsp)
--   lua/plugins/       - Plugin specifications organized by category
--
-- ============================================================================

-- Set leader keys FIRST (before loading any plugins)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Bootstrap lazy.nvim and load plugin specifications
require('config.lazy')

-- Load core configuration
require('config.options')   -- Vim options and settings
require('config.keymaps')   -- General keymaps
require('config.autocmds')  -- Autocommands
