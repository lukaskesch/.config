# MacOS Dev Setup

## Inspiration
- [zsh setup](https://www.josean.com/posts/terminal-setup)
- [yabai setup](https://www.josean.com/posts/yabai-setup)

## Keyboard remaps with Karabiner

## Package Manager
[brew](https://brew.sh/)

- `brew install git`

## Terminal
### iTerm2
[iterm2](https://iterm2.com/)

- `brew install --cask iterm2`
- Settings > Profiles > General > Command > Send text at start: source ~/.zshrc

### fzf

### Oh My ZSH
[install link](https://ohmyz.sh/#install)

Plugins:
- Theme [Powerline10k](https://github.com/romkatv/powerlevel10k#installation)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [zsh-vi-mode](https://github.com/jeffreytse/zsh-vi-mode#-usage)

Own config file:
Add the following line to the ~/.zshrc config file `source ~/.config/zsh/.zshrc`
The `.zshrc` file contains custom aliases, functions, and keymaps

### TMUX

### NVIM
Plugins:
- Treesitter (Syntax parser & highlither)
- Telescope (Search UI)
- Darkplus (Theme from VS Code)
- LuaLine (Startusbar)
- Copilot


## Window Manager
Installing:
- `brew install koekeishiya/formulae/yabai`
- `brew install koekeishiya/formulae/skhd`

Starting:
- `brew services start yabai`
- `brew services start skhd`

## Applications
- Arc (Broswer)
- Obsidian
- Goodnotes
- Google Drive
- 1Password
- NordVPN
- Spotify

### Dev
- RapidAPI or Postman
- VS Code
- IntelliJ
- DataGrip

### Utils
- Cleanshot X 
- Textsniper
- Alfred or Raycast
- Rectange
- flux
- AIDente
- Bartender (Menu Bar Management)

