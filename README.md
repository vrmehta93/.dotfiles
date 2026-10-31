# Env setup

## Clone Repo

`git clone --recurse-submodules https://github.com/vrmehta93/.dotfiles.git`

## Install zsh (if necessary)

Docs - <https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH>

## Get Oh my Zsh

Docs - <https://github.com/ohmyzsh/ohmyzsh#basic-installation>
`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

### Get omz's extra plugins

- zsh-autosuggestions
`git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions`
- zsh-syntax-highlighting
`git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting`

### Get Powerlevel10k theme

Docs - <https://powerlevel10k.org/install-powerlevel10k-on-zsh-step-by-step-guide/>
`git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"`

## Create ~/.env file
