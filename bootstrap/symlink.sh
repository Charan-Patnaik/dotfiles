#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.config/zsh"

ln -sf "$REPO_DIR/wsl/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$REPO_DIR/wsl/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -sf "$REPO_DIR/wsl/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"
ln -sf "$REPO_DIR/wsl/tmux/.tmux.conf" "$HOME/.tmux.conf"
ln -sf "$REPO_DIR/wsl/git/.gitconfig" "$HOME/.gitconfig"

echo "Symlinks created."