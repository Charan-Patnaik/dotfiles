# Dotfiles — Windows + WSL2 + WezTerm + zsh + tmux + Neovim

A reproducible development setup for:

- **Windows** (host): WezTerm
- **WSL2 Ubuntu** (dev environment): zsh + Oh My Zsh + Powerlevel10k + tmux
- **Neovim**: kickstart.nvim (installed separately, with notes in this repo)

This repo is designed so a **fresh Windows install** can be set up quickly with guardrails and validation steps.

---

## What this repo manages

### Windows side
- WezTerm config (`windows/wezterm/.wezterm.lua`)
- PowerShell helper to symlink WezTerm config (`windows/wezterm-link.ps1`)

### WSL (Ubuntu) side
- zsh config (`wsl/zsh/.zshrc`)
- Powerlevel10k prompt config (`wsl/zsh/.p10k.zsh`)
- zsh aliases (`wsl/zsh/aliases.zsh`)
- tmux config (`wsl/tmux/.tmux.conf`)
- git config (`wsl/git/.gitconfig`)
- nvim notes (`wsl/nvim/README.md`)

### Setup automation
- Bootstrap installers (`bootstrap/*.sh`)
- Tool installers (`scripts/*.sh`)
- Symlink script (`bootstrap/symlink.sh`)
- Post-install health checks (`bootstrap/post-install-checks.sh`)

---

## Philosophy (check & balances)

This setup is intentionally built with **checks and balances**:

- **Backups before overwrite** (Windows WezTerm config is backed up by the PowerShell link script)
- **Idempotent scripts** (running installers again is safe; they skip already-installed tools)
- **Symlink-based config management** (single source of truth = this repo)
- **Post-install validation** (health checks confirm shell, TERM, tools, and versions)
- **Manual verification points** after major steps (fonts, shell, tmux, nvim, clipboard)

The goal is: **No silent failures.**

---

## Repo structure

```text
dotfiles/
├── README.md
├── .gitignore
├── bootstrap/
│   ├── wsl-ubuntu.sh
│   ├── symlink.sh
│   └── post-install-checks.sh
├── windows/
│   ├── wezterm/
│   │   └── .wezterm.lua
│   └── wezterm-link.ps1
├── wsl/
│   ├── zsh/
│   │   ├── .zshrc
│   │   ├── .p10k.zsh
│   │   └── aliases.zsh
│   ├── tmux/
│   │   └── .tmux.conf
│   ├── git/
│   │   └── .gitconfig
│   └── nvim/
│       └── README.md
└── scripts/
    ├── install-ohmyzsh.sh
    ├── install-p10k.sh
    ├── install-zsh-plugins.sh
    └── install-tmux-tpm.sh
```

---

## Prerequisites (Fresh Machine)

### Windows
Install these first:

1. **WSL2** enabled
2. **Ubuntu** installed and set as default distro
3. **WezTerm** installed
4. **Git** (Windows optional, WSL Git is sufficient)

### WSL Ubuntu
You only need:
- Ubuntu booting correctly in WSL
- Internet access

---

## Important: Font requirement (Windows)

Powerlevel10k and Nerd Font icons render through **WezTerm on Windows**, so the font must be installed on **Windows** (not just WSL).

### Required font
- **MesloLGS Nerd Font Mono** (recommended for p10k)

If icons look broken in the prompt (`□`, `?`, or weird glyphs), this is usually a font issue.

---

## Quick Start (Fresh Setup)

## Step 1 — Clone this repo inside WSL

Open Ubuntu (WSL) and clone:

```bash
git clone <YOUR_REPO_URL> ~/dotfiles
cd ~/dotfiles
```

### Check
```bash
pwd
ls
```

You should see folders like `bootstrap`, `windows`, `wsl`, `scripts`.

---

## Step 2 — Run WSL bootstrap + installers

Make scripts executable:

```bash
chmod +x bootstrap/*.sh scripts/*.sh
```

Run setup in order:

```bash
bash bootstrap/wsl-ubuntu.sh
bash scripts/install-ohmyzsh.sh
bash scripts/install-p10k.sh
bash scripts/install-zsh-plugins.sh
bash scripts/install-tmux-tpm.sh
bash bootstrap/symlink.sh
```

### What these do
- Installs base packages (zsh, tmux, build tools, rg, fd, clipboard tools, Node.js, etc.)
- Installs Oh My Zsh
- Installs Powerlevel10k
- Installs zsh plugins (autosuggestions + syntax highlighting)
- Installs TPM (tmux plugin manager)
- Creates symlinks from this repo to your home directory (`~/.zshrc`, `~/.tmux.conf`, etc.)

### Check
You should see success messages like:
- `✅ Base WSL packages installed`
- `✅ Oh My Zsh ready`
- `✅ p10k ready`
- `✅ zsh plugins ready`
- `✅ TPM ready`
- `✅ Symlinks created`

---

## Step 3 — Make zsh default shell

```bash
chsh -s $(which zsh)
```

### Check
```bash
echo $SHELL
```

If it still shows `/bin/bash`, that’s normal until WSL restarts.

---

## Step 4 — Restart WSL (from Windows)

Open **PowerShell** (Windows) and run:

```powershell
wsl --shutdown
```

Reopen **WezTerm**.

### Check
Inside WezTerm / WSL:
```bash
echo $SHELL
echo $TERM
```

Expected:
- `zsh` path (for example `/usr/bin/zsh`)
- `xterm-256color`

---

## Step 5 — Link WezTerm config (Windows)

From **PowerShell** (preferably run as Admin if symlink permissions fail):

```powershell
cd <path-to-your-dotfiles-repo>
.\windows\wezterm-link.ps1
```

> If your repo is only inside WSL, either:
> - clone the same repo on Windows too, **or**
> - manually copy `windows/wezterm/.wezterm.lua` to `C:\Users\<YourUser>\.wezterm.lua`

### Check
- Open WezTerm
- Press `Ctrl+Shift+R` to reload config
- Confirm visible config changes apply (font, theme, keybinds)

---

## Step 6 — Run post-install checks

Inside WSL:

```bash
bash bootstrap/post-install-checks.sh
```

### What it validates
- shell + TERM
- zsh / tmux / node / npm / nvim versions
- `rg`, `fdfind`, `xclip`

---

## Step 7 — Neovim setup (kickstart.nvim)

This repo does **not** bundle kickstart.nvim by default.

Install kickstart:

```bash
git clone https://github.com/nvim-lua/kickstart.nvim ~/.config/nvim
```

Open Neovim:

```bash
nvim
```

On first launch, kickstart will bootstrap plugins.

### Run health checks in Neovim
Inside Neovim:

```vim
:checkhealth
:Mason
:TSUpdate
```

### Common Mason packages to install
- `lua_ls`
- `pyright`
- `tsserver`
- `bashls`

---

## Validation checklist (end-to-end)

Use this after full setup.

### Terminal + shell
- [ ] WezTerm launches into **WSL Ubuntu**
- [ ] Prompt is **zsh**
- [ ] p10k prompt renders correctly (icons visible)
- [ ] `echo $TERM` = `xterm-256color`

### Tools
- [ ] `tmux -V` works
- [ ] `node -v` and `npm -v` work
- [ ] `rg --version` works
- [ ] `fdfind --version` works
- [ ] `nvim --version` works

### Neovim
- [ ] `nvim` launches
- [ ] `:checkhealth` has no major red issues
- [ ] `:Mason` opens
- [ ] Treesitter installs/parses (`:TSUpdate` runs)

### Clipboard (WSL + nvim)
- [ ] `xclip` installed
- [ ] Copy/paste in WezTerm works (`Ctrl+Shift+C` / `Ctrl+Shift+V`)
- [ ] Neovim clipboard works (if configured via kickstart + system clipboard)

---

## Check & balance rules (recommended habits)

### 1) Always edit configs in the repo, not in `~`
Because your home files are symlinked, edit the repo files:

- ✅ `~/dotfiles/wsl/zsh/.zshrc`
- ❌ `~/.zshrc` directly (it works, but easier to forget what’s tracked)

### 2) Test before pushing
After changing configs:

```bash
bash bootstrap/post-install-checks.sh
```

And manually test:
- `tmux`
- `nvim`
- `Ctrl+Shift+R` in WezTerm

### 3) Keep scripts idempotent
If you add scripts later, make them safe to re-run:
- check if tool exists before installing
- avoid overwriting files without backup

### 4) Back up before risky edits
The WezTerm PowerShell script already backs up `.wezterm.lua` to `.bak`.  
Use the same pattern if you add more Windows config linkers.

### 5) Commit small, logical changes
Example commit messages:
- `feat(zsh): add zoxide init and aliases`
- `chore(wezterm): tune opacity and keybinds`
- `fix(tmux): preserve current pane path on split`

---

## Common issues + fixes

## 1) WezTerm opens but not in Ubuntu WSL
### Check
In WezTerm, run:
```bash
uname -a
```

If you don’t see Linux/WSL, WezTerm didn’t launch WSL.

### Fix
Verify `windows/wezterm/.wezterm.lua` contains:
```lua
config.default_prog = { "wsl.exe", "-d", "Ubuntu" }
```

Also confirm your distro name:
```powershell
wsl -l -v
```

If your distro isn’t exactly `Ubuntu`, update the config name.

---

## 2) p10k icons look broken
### Cause
Nerd Font not installed on Windows, or wrong font name in WezTerm config.

### Fix
- Install **MesloLGS Nerd Font Mono** on Windows
- Ensure WezTerm uses the exact font name:
```lua
config.font = wezterm.font("MesloLGS Nerd Font Mono")
```

Then restart WezTerm.

---

## 3) `fd` command not found (Ubuntu)
Ubuntu package installs `fdfind`, not `fd`.

### Fix
This repo aliases `fd='fdfind'` in `.zshrc`.

### Check
```bash
which fdfind
fd --version
```

---

## 4) Neovim `:checkhealth` shows clipboard issue
### Fix
Ensure clipboard tools are installed:
```bash
sudo apt install -y xclip wl-clipboard
```

If still flaky in WSL, consider `win32yank.exe` integration later.

---

## 5) WezTerm transparency not working on Windows
This varies by Windows build / GPU / WezTerm version.

### Fix options
- Standard opacity:
```lua
config.window_background_opacity = 0.90
```

- Windows backdrop (if supported):
```lua
config.window_background_opacity = 0
config.win32_system_backdrop = "Mica"
```

If backdrop is flaky, use opacity-only mode.

---

## 6) Symlink script works but config changes don’t apply
### Check
Verify symlinks:

```bash
ls -l ~/.zshrc ~/.p10k.zsh ~/.tmux.conf
```

You should see links pointing to `~/dotfiles/...`.

For WezTerm, reload config with:
- `Ctrl+Shift+R`

---

## 7) `chsh` doesn’t persist zsh
Sometimes WSL needs a full restart.

### Fix
Run from Windows:
```powershell
wsl --shutdown
```

Then reopen WezTerm.

---

## Repo maintenance workflow (recommended)

## Make changes
Edit files under this repo:
- `wsl/...`
- `windows/...`

## Validate
```bash
bash bootstrap/post-install-checks.sh
```

## Commit + push
```bash
git add .
git commit -m "Describe change"
git push origin main
```

---

## Recovery / fresh install procedure (summary)

If you reinstall Windows later:

1. Install WSL2 + Ubuntu
2. Install WezTerm
3. Install MesloLGS Nerd Font on Windows
4. Clone this repo in WSL
5. Run setup scripts
6. Set zsh as default shell
7. `wsl --shutdown`
8. Link WezTerm config on Windows
9. Run post-install checks
10. Install kickstart.nvim and run `:checkhealth`

---

## Security notes

This repo should **not** contain:
- `.zsh_history`
- SSH keys (`~/.ssh`)
- API keys / tokens
- `.env` files
- credentials

Always review `git status` before every commit.

---

## Optional future improvements

- Add a root `setup.sh` to run all setup scripts in one command
- Add GNU Stow for cleaner symlink management
- Add your customized kickstart.nvim config into this repo
- Add more tmux plugins (beyond TPM + sensible)
- Add a package manifest script for WSL tooling

---

## Personal notes (edit this section)

Use this section to track your preferences so future-you doesn’t have to remember.

### Current preferences
- Font: `MesloLGS Nerd Font Mono`
- Theme: `Catppuccin Mocha`
- WezTerm opacity: `0.90` (or your current value)
- tmux prefix: `Ctrl+a`
- Neovim distro: `kickstart.nvim`

### Must-have Mason packages
- `lua_ls`
- `pyright`
- `tsserver`
- `bashls`

---

## Commands cheat sheet

### WSL restart (from Windows)
```powershell
wsl --shutdown
```

### Reload WezTerm config
- `Ctrl+Shift+R`

### Run repo health check
```bash
bash bootstrap/post-install-checks.sh
```

### Recreate symlinks
```bash
bash bootstrap/symlink.sh
```

### tmux plugin install
Inside tmux:
- `Ctrl+a` then `Shift+i` (`I`)

### p10k prompt wizard
```bash
p10k configure
```

---

## License
Not needed at the moment