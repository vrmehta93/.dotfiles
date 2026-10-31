# ---------------------------------------------------------------------------
# OS detection
# ---------------------------------------------------------------------------
case "$(uname -s)" in
Darwin)
  IS_MAC=1
  IS_LINUX=0
  ;;
Linux)
  IS_MAC=0
  IS_LINUX=1
  ;;
esac

# ---------------------------------------------------------------------------
# Env vars
# ---------------------------------------------------------------------------
# Load secrets/env vars (auto-export everything defined in the file)
if [[ -f "$HOME/.env" ]]; then
  set -a
  source "$HOME/.env"
  set +a
fi

# XDG base directories
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"

# Remove clutter from $HOME (these tools won't create parent dirs themselves)
mkdir -p "$XDG_STATE_HOME/less" "$XDG_STATE_HOME/python"
export LESSHISTFILE="$XDG_STATE_HOME/less/history"
export PYTHON_HISTORY="$XDG_STATE_HOME/python/history"

export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"

# Manually installed binaries (prepended, de-duplicated)
case ":$PATH:" in
*":$HOME/.local/bin:"*) ;;
*) export PATH="$HOME/.local/bin:$PATH" ;;
esac

# ---------------------------------------------------------------------------
# Aliases & functions
# ---------------------------------------------------------------------------
alias nv="nvim"
alias nvr="nvim -R" # Read only mode

# NOTE: don't name this `tr`, it shadows /usr/bin/tr
alias tre="tree -a -I '.git|.github|.DS_Store'"
alias rgh="rg --hidden"

rgl() { # NOTE - This is used in git config
  rg --hidden --glob "!**/.git/*" --pretty "$@" | less -R
}

alias lsf="ls -a | fzf"

cdf() {
  local dir
  dir="$(find . -mindepth 1 -maxdepth 1 -type d | fzf)" && [[ -n "$dir" ]] && cd "$dir"
}

mkcd() { mkdir -p -- "$1" && cd -- "$1"; }

# Function (not alias) so $VIM_GOLF_KEY is read at call time
vimgolf() {
  docker run --rm -it -e "key=$VIM_GOLF_KEY" ghcr.io/filbranden/vimgolf "$@"
}

# ---------------------------------------------------------------------------
# Required tools
# ---------------------------------------------------------------------------
# Format: "command:package". Package name differs from command in places
# (rg -> ripgrep, nvim -> neovim), and between brew and pacman.
#   fzf keybindings (via omz plugin): https://github.com/junegunn/fzf?tab=readme-ov-file#key-bindings-for-command-line
#     <C-t> fuzzy search files/dirs | <C-r> fuzzy search history | <M-c> cd into dir
if ((IS_MAC)); then
  REQUIRED_TOOLS=(
    nvim:neovim pyenv:pyenv pipenv:pipenv rg:ripgrep stow:stow tree:tree
    lazygit:lazygit hunk:hunk
    fzf:fzf zoxide:zoxide tmux:tmux # omz plugins
    fd:fd                           # neovim (lazyvim)
  )
else
  REQUIRED_TOOLS=(
    nvim:neovim pyenv:pyenv pipenv:python-pipenv rg:ripgrep stow:stow tree:tree
    lazygit:lazygit hunk:hunk # verify hunk's package name / AUR
    fzf:fzf zoxide:zoxide tmux:tmux
    fd:fd
  )
fi

# Install anything missing. Run manually: `ensure_tools`
ensure_tools() {
  local item cmd pkg
  local -a missing=()

  for item in "${REQUIRED_TOOLS[@]}"; do
    cmd="${item%%:*}"
    pkg="${item#*:}"
    command -v "$cmd" &>/dev/null || missing+=("$pkg")
  done

  ((${#missing[@]})) || {
    echo "All required tools installed."
    return 0
  }

  echo "Installing: ${missing[*]}"
  if ((IS_MAC)); then
    command -v brew &>/dev/null || {
      echo "Install Homebrew first: https://brew.sh/"
      return 1
    }
    brew install "${missing[@]}"
  elif command -v pacman &>/dev/null; then
    sudo pacman -S --needed "${missing[@]}"
  else
    echo "Unsupported package manager."
    return 1
  fi
}

# Cheap check on shell start: warn only, never install automatically
_missing=()
for _item in "${REQUIRED_TOOLS[@]}"; do
  command -v "${_item%%:*}" &>/dev/null || _missing+=("${_item%%:*}")
done
((${#_missing[@]})) && echo "Missing tools: ${_missing[*]} (run: ensure_tools)"
unset _missing _item

# ---------------------------------------------------------------------------
# pyenv
# ---------------------------------------------------------------------------
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
