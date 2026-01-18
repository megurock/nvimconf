#!/bin/bash
# Neovim LSP and tools installation script for macOS

set -e

echo "Installing Language Servers..."

# Check if volta is installed
if command -v volta &> /dev/null; then
    echo "Using Volta for npm packages..."

    ## TypeScript/JavaScript
    volta install typescript typescript-language-server

    ## CSS, HTML, JSON
    volta install vscode-langservers-extracted

    ## Biome (Formatter & Linter)
    volta install @biomejs/biome
else
    echo "Using npm for global packages..."

    ## TypeScript/JavaScript
    npm install -g typescript typescript-language-server

    ## CSS, HTML, JSON
    npm install -g vscode-langservers-extracted

    ## Biome (Formatter & Linter)
    npm install -g @biomejs/biome
fi

## Lua
brew install lua-language-server

echo "✅ Installation complete!"
echo ""
echo "Installed Language Servers:"
echo "  - ts_ls (TypeScript/JavaScript)"
echo "  - lua_ls (Lua)"
echo "  - cssls (CSS)"
echo "  - html (HTML)"
echo "  - jsonls (JSON)"
echo "  - biome (Biome - Formatter & Linter)"