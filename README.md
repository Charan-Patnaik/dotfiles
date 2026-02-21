# Dotfiles (Windows + WSL2 + WezTerm + zsh + tmux + nvim)

Personal dotfiles for a Windows + WSL2 Ubuntu development setup.

## Stack covered

- **Windows**: WezTerm
- **WSL Ubuntu**: zsh, Oh My Zsh, Powerlevel10k, tmux
- **Neovim**: kickstart.nvim (managed separately, with notes here)

---

## Fresh setup checklist

## 1) Windows side (manual once)

### Install WezTerm
Install WezTerm on Windows (winget or installer).

### Install Nerd Font
Install **MesloLGS Nerd Font Mono** on Windows (required for p10k icons in WezTerm).

### Link WezTerm config
Run PowerShell (preferably as Admin) and execute:

```powershell
.\windows\wezterm-link.ps1
