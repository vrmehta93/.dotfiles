
# Aliases
#alias ll="pwd && ls -al" #
alias nv="nvim"
alias vi="nvim"
alias vim="nvim"

## Git aliases
alias gst="git status"
alias gas="git add --all && git status"
alias gcm="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gb="git branch"
alias gsw="git switch"
alias gswc="git switch -c"

acp() {
  git add -A # equivalent to --all
  git status
  git commit -m "$1"
  git push
}
# For "pip" - allow installations in user directory
export PATH="$PATH:/Users/vishal/.local/bin"

# Load env vars
source "$HOME/.env"

# Keyboard Mappings
# Map `caps lock` key to ctrl key
# For MacOS - System Settings > Keyboard > Keyboard Shortcuts... > Modifier keys

# List of commands to ensure are installed
# rg = ripgrep
# nvim = neovim
REQUIRED_TOOLS=(nvim pyenv pipenv rg stow
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
