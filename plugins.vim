" check whether vim-plug is installed and install it if necessary
let plugpath = expand('<sfile>:p:h'). '/autoload/plug.vim'
if !filereadable(plugpath)
    if executable('curl')
        let plugurl = 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        call system('curl -fLo ' . shellescape(plugpath) . ' --create-dirs ' . plugurl)
        if v:shell_error
            echom "Error downloading vim-plug. Please install it manually.\n"
            exit
        endif
    else
        echom "vm-plug not installed. Please install it manually or install curl.\n"
        exit
    endif
endif

call plug#begin('~/.config/nvim/plugged')
  Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'jose-elias-alvarez/null-ls.nvim'
  Plug 'MunifTanjim/prettier.nvim'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/nvim-cmp'
  Plug 'L3MON4D3/LuaSnip', {'tag': 'v1.*', 'do': 'make install_jsregexp'}
  Plug 'mattn/efm-langserver'
  Plug 'dgagn/diagflow.nvim'
  Plug 'weilbith/nvim-code-action-menu'

  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  Plug 'EdenEast/nightfox.nvim'
  Plug 'preservim/nerdcommenter'
  Plug 'vim-airline/vim-airline'
  Plug 'mhinz/vim-signify'
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'norcalli/nvim-colorizer.lua'
  Plug 'github/copilot.vim', {'branch': 'release'}
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'maxmellon/vim-jsx-pretty'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-tree/nvim-web-devicons'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.3' }
  Plug 'nvim-telescope/telescope-ui-select.nvim'
  " for laravel start "
  Plug 'tpope/vim-dispatch'             "| Optional
  Plug 'tpope/vim-projectionist'        "|
  Plug 'noahfrederick/vim-composer'     "|
  Plug 'noahfrederick/vim-laravel'
  Plug 'ajmwagar/vim-deus'
  Plug 'jwalton512/vim-blade'
  " for laravel end

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
