#!/bin/bash
# Neovim LSP and tools installation script for macOS

set -e

echo "Installing Language Servers..."

## TypeScript/JavaScript
npm install -g typescript typescript-language-server

## Lua
brew install lua-language-server

## CSS, HTML, JSON
npm install -g vscode-langservers-extracted

## Biome (Formatter & Linter)
npm install -g @biomejs/biome

echo "✅ Installation complete!"
echo ""
echo "Installed Language Servers:"
echo "  - ts_ls (TypeScript/JavaScript)"
echo "  - lua_ls (Lua)"
echo "  - cssls (CSS)"
echo "  - html (HTML)"
echo "  - jsonls (JSON)"
echo "  - biome (Biome - Formatter & Linter)"
