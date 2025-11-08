return {
  -- Colorscheme (load immediately for fast UI)
  {
    "ajmwagar/vim-deus",
    lazy = false,
    priority = 1000,
  },

  -- LSP & Mason
  {
    "williamboman/mason.nvim",
    lazy = false,
    priority = 900,
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    priority = 850,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ts_ls", "phpactor" },
        automatic_installation = true,
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    priority = 800,
  },

  -- Treesitter (lazy load on file open)
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    config = function()
      require("treesitter-config")
    end,
  },

  -- Completion (load on insert mode)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      require("completions-config")
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true,
  },
  {
    "hrsh7th/cmp-buffer",
    lazy = true,
  },
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    version = "v1.*",
    build = "make install_jsregexp",
  },

  -- Conform.nvim (formatting)
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform-config")
    end,
  },
  {
    "nvim-lua/plenary.nvim",
    lazy = true,
  },

  -- Diagflow (diagnostic display)
  {
    "dgagn/diagflow.nvim",
    event = "LspAttach",
    config = function()
      require("diagflow-config")
    end,
  },

  -- Code action menu
  {
    "weilbith/nvim-code-action-menu",
    cmd = "CodeActionMenu",
  },
	 {
      "greggh/claude-code.nvim",
      cmd = "ClaudeCode",
      keys = {
        { "<C-,>", "<cmd>ClaudeCode<CR>", desc = "Toggle Claude Code", silent = true },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
      },
      config = function()
        require("claude-code").setup({
          split_ratio = 0.3,
          position = "botright",
          enter_insert = true,
          file_refresh = {
            enable = true,
            show_notifications = false,
          },
          hide_numbers = false,
          hide_signcolumn = false,
        })
      end,
    },

  -- Telescope (lazy load on command/keymap)
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<leader>t", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>g", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
      { "<leader>o", "<cmd>Telescope current_buffer<CR>", desc = "Current buffer" },
      { ";", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
      require("telescope-config")
    end,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    lazy = true,
  },

  -- NERDTree (lazy load on command)
  {
    "preservim/nerdtree",
    cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
    keys = {
      { "<leader>n", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree", silent = true },
      { "<leader>F", ":NERDTreeFind<CR>", desc = "Find in NERDTree", silent = true },
    },
  },

  -- NERDCommenter (lazy load on command)
  {
    "preservim/nerdcommenter",
    keys = {
      { "<leader>c<space>", mode = { "n", "v" }, desc = "Toggle comment" },
    },
  },

  -- Icons
  {
    "ryanoasis/vim-devicons",
    lazy = true,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },

  -- Airline (statusline - load immediately)
  {
    "vim-airline/vim-airline",
    lazy = false,
  },

  -- Git plugins (lazy load on git events)
  {
    "airblade/vim-gitgutter",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G", "Gdiff", "Gblame", "Glog" },
  },

  -- Copilot (lazy load on insert)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    init = function()
      -- Use latest Node v22.x from nvm
      local node_path = vim.fn.glob("~/.nvm/versions/node/v22*/bin/node")
      if node_path ~= "" then
        vim.g.copilot_node_command = vim.fn.expand(node_path)
      end
    end,
  },

  -- Colorizer (lazy load on file open)
  {
    "norcalli/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("colorizer").setup()
    end,
  },

  -- Syntax plugins (lazy load on filetype)
  {
    "HerringtonDarkholme/yats.vim",
    ft = { "typescript", "typescriptreact" },
  },
  {
    "maxmellon/vim-jsx-pretty",
    ft = { "javascript", "javascriptreact", "jsx" },
  },

  -- Laravel plugins (lazy load on PHP/Blade files)
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  {
    "tpope/vim-projectionist",
    ft = "php",
  },
  {
    "noahfrederick/vim-composer",
    ft = "php",
  },
  {
    "noahfrederick/vim-laravel",
    ft = "php",
  },
  {
    "jwalton512/vim-blade",
    ft = "blade",
  },

  -- Nightfox (alternative colorscheme, load on demand)
  {
    "EdenEast/nightfox.nvim",
    lazy = true,
  },
}
