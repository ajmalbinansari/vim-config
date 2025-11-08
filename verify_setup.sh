#!/bin/bash
# Verification script for Neovim setup

echo "═══════════════════════════════════════════════════════════"
echo "  Neovim Configuration Verification"
echo "═══════════════════════════════════════════════════════════"
echo ""

# Check Mason packages
echo "1. Checking Mason installed packages..."
echo "───────────────────────────────────────────────────────────"
if [ -d ~/.local/share/nvim/mason/packages ]; then
    echo "✓ Mason directory exists"
    echo ""
    echo "Installed packages:"
    ls -1 ~/.local/share/nvim/mason/packages/ | while read pkg; do
        echo "  ✓ $pkg"
    done
    echo ""
else
    echo "✗ Mason directory not found"
    echo ""
fi

# Check Mason binaries
echo "2. Checking Mason binaries..."
echo "───────────────────────────────────────────────────────────"
if [ -d ~/.local/share/nvim/mason/bin ]; then
    echo "Available in PATH:"
    ls -1 ~/.local/share/nvim/mason/bin/ | while read bin; do
        echo "  ✓ $bin"
    done
    echo ""
else
    echo "✗ Mason bin directory not found"
    echo ""
fi

# Check for LSP servers
echo "3. Checking LSP servers specifically..."
echo "───────────────────────────────────────────────────────────"
for lsp in lua-language-server typescript-language-server phpactor; do
    if [ -f ~/.local/share/nvim/mason/bin/$lsp ] || [ -L ~/.local/share/nvim/mason/bin/$lsp ]; then
        echo "  ✓ $lsp (installed via Mason)"
    else
        # Check global installation
        if command -v $lsp &> /dev/null; then
            echo "  ⚠ $lsp (global installation: $(which $lsp))"
        else
            echo "  ✗ $lsp (NOT FOUND)"
        fi
    fi
done
echo ""

# Check formatters
echo "4. Checking formatters..."
echo "───────────────────────────────────────────────────────────"
for fmt in prettier stylua; do
    if [ -f ~/.local/share/nvim/mason/bin/$fmt ] || [ -L ~/.local/share/nvim/mason/bin/$fmt ]; then
        echo "  ✓ $fmt (Mason)"
    else
        if command -v $fmt &> /dev/null; then
            echo "  ⚠ $fmt (global: $(which $fmt))"
        else
            echo "  ✗ $fmt (NOT FOUND)"
        fi
    fi
done
echo ""

# Check config files
echo "5. Checking config files..."
echo "───────────────────────────────────────────────────────────"
for config in init.lua lua/plugins.lua lua/lsp-config.lua lua/conform-config.lua; do
    if [ -f ~/.config/nvim/$config ]; then
        echo "  ✓ $config"
    else
        echo "  ✗ $config (MISSING)"
    fi
done
echo ""

# Check for old null-ls
echo "6. Checking for old null-ls remnants..."
echo "───────────────────────────────────────────────────────────"
if [ -f ~/.config/nvim/lua/null-ls-config.lua ]; then
    echo "  ⚠ null-ls-config.lua still exists (should be removed)"
else
    echo "  ✓ null-ls-config.lua removed"
fi
echo ""

echo "═══════════════════════════════════════════════════════════"
echo "  Next Steps:"
echo "═══════════════════════════════════════════════════════════"
echo ""
echo "1. Open test file:"
echo "   nvim ~/.config/nvim/test_setup.lua"
echo ""
echo "2. Inside Neovim, run these commands:"
echo "   :checkhealth mason"
echo "   :checkhealth lsp"
echo "   :Mason          (check UI for installed packages)"
echo "   :LspInfo        (while in test_setup.lua)"
echo ""
echo "3. Test keybindings in test_setup.lua:"
echo "   K           - Hover documentation (on 'greet')"
echo "   gd          - Go to definition"
echo "   <leader>f   - Format file"
echo "   [d / ]d     - Navigate diagnostics"
echo ""
echo "═══════════════════════════════════════════════════════════"
