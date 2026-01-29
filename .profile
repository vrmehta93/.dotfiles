
# Aliases
#alias ll="pwd && ls -al" # Use alias l
alias nv="nvim"
# alias vi="nvim"
# alias vim="nvim"
alias nvr="nvim -R" # Read only mode

alias g=git

alias tr="tree -a -I '.git|.github|.DS_Store'"
alias rgh="rg --hidden"
rgl() { # NOTE - This is used in .gitconfig
	rg --hidden --glob "!**/.git/*" --pretty "$1" | less
}
alias lsf="ls -a | fzf"
alias cdf='cd "$(find . -maxdepth 1 -type d | fzf)"'
mkcd () { mkdir "$@" && cd "$@"; }

alias vimgolf="docker run --rm -it -e 'key=$VIM_GOLF_KEY' ghcr.io/filbranden/vimgolf"

# For manual installation of binaries
export PATH="$PATH:/Users/vishal/.local/bin"

# Load env vars
source "$HOME/.env"

# List of commands to ensure are installed
# rg = ripgrep
# nvim = neovim
# fzf = fuzzy finder
#   Keybindings: https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
#     <C-t> - fuzzy search files and directories
#     <C-r> - fuzzy search CLI history
#     <M-c> - cd into a directory
REQUIRED_TOOLS=(nvim pyenv pipenv rg stow tree
	# For omz plugins
	fzf zoxide tmux
)

# Check for Homebrew
if ! command -v brew &>/dev/null; then
  echo "Homebrew not found. Please install Homebrew first: https://brew.sh/"
else
  for cmd in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "Installing missing tool: $cmd"
      brew install "$cmd"
    fi
  done
fi

# pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
