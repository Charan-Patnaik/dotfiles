#!/usr/bin/env bash
set -euo pipefail

if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
else
  echo "TPM already installed."
fi

echo "✅ TPM ready."
echo "Open tmux and press Ctrl+a then Shift+i (I) to install tmux plugins."