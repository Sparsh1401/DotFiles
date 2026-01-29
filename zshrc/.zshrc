# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

POWERLEVEL9K_MODE='nerdfont-complete'

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias saber-1="gcloud compute ssh --zone "us-east4-c" "vwo-testapp-saber-1"  --project "wingify-k8s-test" --tunnel-through-iap"
alias clickhouse="gcloud compute ssh --zone "us-east4-c" "vwo-testapp-clickhouse" --project "wingify-k8s-test" --tunnel-through-iap"
alias gpom="git pull --ff-only origin master"
alias gpoh="git push origin HEAD"
export M2_HOME="/Users/sparshagarwal/Downloads/apache-maven-3.9.6"
PATH="${M2_HOME}/bin:${PATH}"
export PATH

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# warpify subshell
printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh" }}\x9c'

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/sparshagarwal/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# Added by Antigravity
export PATH="/Users/sparshagarwal/.antigravity/antigravity/bin:$PATH"

# bun completions
[ -s "/Users/sparshagarwal/.bun/_bun" ] && source "/Users/sparshagarwal/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/node@22/bin:$PATH"


export PATH="$HOME/.local/bin:$PATH"

# fzf shell integration
source <(fzf --zsh)

# Create a new clone and branch for parallel development.
# Usage: ga <branch-name> [base-branch]
unalias ga 2>/dev/null
ga() {
  if [[ -z "$1" ]]; then
    echo "Usage: ga <branch-name> [base-branch]"
    return 1
  fi
  local branch="$1"
  local repo_name="$(basename "$PWD")"
  local repo_url="$(git remote get-url origin)"
  local clone_path="../${repo_name}-${branch}"

  # Use fzf to select base branch, defaulting to main
  local base_branch="$(git branch -r --format='%(refname:short)' | sed 's|origin/||' | fzf --height=20 --prompt='Select base branch: ' --query="main")"

  # If fzf was cancelled, fall back to main
  if [[ -z "$base_branch" ]]; then
    base_branch="main"
  fi

  echo "Creating clone at $clone_path from $base_branch..."

  # Clone with reference to current repo for speed/space savings
  git clone --reference "$PWD" "$repo_url" "$clone_path"

  # Enter clone and set up branch
  cd "$clone_path"
  git checkout "$base_branch"
  git checkout -b "sa/$branch"

  echo "Created clone at $clone_path on branch sa/$branch (based on $base_branch)"
}

# Remove a cloned repo directory. Warns if there are uncommitted changes.
# Run from within the clone you want to delete.
unalias gd 2>/dev/null
gd() {
  local cwd="$(pwd)"
  local clone_name="$(basename "$cwd")"

  # Check for uncommitted changes
  if [[ -n "$(git status --porcelain 2>/dev/null)" ]]; then
    echo "Warning: You have uncommitted changes:"
    git status --short
    echo ""
    if ! gum confirm "Delete anyway?"; then
      echo "Aborted"
      return 1
    fi
  fi

  # Check for unpushed commits
  local unpushed="$(git log --oneline @{upstream}..HEAD 2>/dev/null)"
  if [[ -n "$unpushed" ]]; then
    echo "Warning: You have unpushed commits:"
    echo "$unpushed"
    echo ""
    if ! gum confirm "Delete anyway?"; then
      echo "Aborted"
      return 1
    fi
  fi

  if gum confirm "Remove clone '$clone_name'?"; then
    cd ..
    rm -rf "$clone_name"
    echo "Removed $clone_name"
  fi
}
