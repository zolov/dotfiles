# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.env.sh
source_if_exists $DOTFILES/zsh/aliases.zsh
source_if_exists ~/.fzf.zsh
source_if_exists $DOTFILES/zsh/history.zsh
source_if_exists $DOTFILES/zsh/git.zsh
source_if_exists $DOTFILES/zsh/.secenv.zsh

autoload -Uz compinit && compinit

# prompt spaceship
autoload -U promptinit; promptinit

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

precmd() {
    source $DOTFILES/zsh/aliases.zsh
}

# PLUGINS
plugins=(
sudo
git
git-flow
gitignore
# kubectl
# docker
# docker-compose
zsh-autosuggestions
zsh-syntax-highlighting
fasd
brew
macos
zsh-z
common-aliases
postgres
spring
vscode
oc
rust
)

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# complete -F __start_kubect

# zsh-autosuggestions CONFIGURATION
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green,bold,underline"

# SPACESHIP CONFIGURATION
# Colors
SPACESHIP_DIR_COLOR=blue
SPACESHIP_USER_COLOR_ROOT=blue
SPACESHIP_EXEC_TIME_COLOR=34
SPACESHIP_GIT_BRANCH_COLOR=green
# Settings
SPACESHIP_USER_SHOW="true"
SPACESHIP_USER_COLOR=34
SPACESHIP_USER_PREFIX="["
SPACESHIP_USER_SUFFIX="] "

SPACESHIP_DIR_PREFIX=" "
SPACESHIP_DIR_SUFFIX=" "
SPACESHIP_PROMPT_FIRST_PREFIX_SHOW="true"
SPACESHIP_PROMPT_ORDER=(
  battery      # Battery level and status
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  #package       # Package version
  # kubectl       # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
  #gradle        # Gradle section
  # maven         # Maven section
  #node          # Node.js section
  #ruby          # Ruby section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  rust          # Rust section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #terraform     # Terraform workspace section
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  vi_mode       # Vi-mode indicator
  char          # Prompt character
)

# Key bindings
bindkey '^ ' autosuggest-accept
bindkey '^x' autosuggest-clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/zolov/.sdkman"
[[ -s "/Users/zolov/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/zolov/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e /Users/zolov/.iterm2_shell_integration.zsh && source /Users/zolov/.iterm2_shell_integration.zsh || true

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Add JBang to environment
alias j!=jbang
export PATH="$HOME/.jbang/bin:$PATH"
fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="/usr/local/sbin:$PATH"

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
