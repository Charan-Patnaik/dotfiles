#!/usr/bin/env bash
set -euo pipefail

echo "[1/4] Updating apt..."
sudo apt update

echo "[2/4] Installing base packages..."
sudo apt install -y \
  zsh \
  git \
  curl \
  unzip \
  ripgrep \
  fd-find \
  xclip \
  wl-clipboard \
  tmux \
  build-essential \
  gcc \
  g++ \
  make \
  cmake \
  python3-pip \
  python3-venv \
  luarocks

echo "[3/4] Installing Node.js (NodeSource 20.x)..."
if ! command -v node >/dev/null 2>&1; then
  curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
  sudo apt install -y nodejs
fi

echo "[4/4] Installing zoxide (optional but recommended)..."
if ! command -v zoxide >/dev/null 2>&1; then
  curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
fi

echo "Base WSL packages installed."
echo "Next: run scripts/install-ohmyzsh.sh etc."