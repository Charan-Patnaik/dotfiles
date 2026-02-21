#!/usr/bin/env bash
set -euo pipefail

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
TARGET="$ZSH_CUSTOM/themes/powerlevel10k"

if [ ! -d "$TARGET" ]; then
  echo "Installing Powerlevel10k..."
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$TARGET"
else
  echo "Powerlevel10k already installed."
fi

echo "✅ p10k ready."
echo "Tip: run 'p10k configure' after reloading zsh if you want to regenerate prompt config."