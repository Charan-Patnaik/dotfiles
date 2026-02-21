#!/usr/bin/env bash
set -euo pipefail

echo "=== Post-install checks ==="
echo "Shell: $SHELL"
echo "TERM: ${TERM:-<unset>}"

echo
echo "Versions:"
command -v zsh >/dev/null && zsh --version || echo "zsh missing"
command -v tmux >/dev/null && tmux -V || echo "tmux missing"
command -v node >/dev/null && node -v || echo "node missing"
command -v npm >/dev/null && npm -v || echo "npm missing"
command -v nvim >/dev/null && nvim --version | head -n 1 || echo "nvim missing"

echo
echo "Check tools:"
command -v rg >/dev/null && echo "rg ✅" || echo "rg ❌"
command -v fdfind >/dev/null && echo "fdfind ✅" || echo "fdfind ❌ (Ubuntu package name is fd-find)"
command -v xclip >/dev/null && echo "xclip ✅" || echo "xclip ❌"

echo
echo "Done. Open WezTerm and run: nvim + :checkhealth"