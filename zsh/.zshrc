source_if_exists () {
    if test -r "$1"; then
        source "$1"
    fi
}

source_if_exists $HOME/.env.sh
source_if_exists ~/.fzf.zsh
source_if_exists ~/.config/zsh/extensions/aliases.zsh
source_if_exists ~/.config/zsh/extensions/history.sh
source_if_exists ~/.config/zsh/extensions/git.sh
source_if_exists ~/.config/zsh/extensions/.secenv.zsh
source_if_exists ~/.config/zsh/extensions/nvimswitcher.zsh
source_if_exists ~/.config/zsh/extensions/docker-aliases.sh

autoload -Uz compinit && compinit

# prompt spaceship
autoload -U promptinit; promptinit

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="spaceship"

precmd() {
    source ~/.config/zsh/extensions/aliases.zsh
}

# PLUGINS
plugins=(
fzf-tab
vi-mode
sudo
git
git-flow
gitignore
# kubectl
# docker
# docker-compose
zsh-autosuggestions
zsh-syntax-highlighting
fast-syntax-highlighting
fasd
brew
macos
common-aliases
postgres
spring
vscode
oc
rust
fzf
)

bindkey -M viins 'jj' vi-cmd-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

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
  golang        # Go section
  #php           # PHP section
  rust          # Rust section
  #haskell       # Haskell Stack section
  #julia         # Julia section
  #docker        # Docker section
  #aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  #venv          # virtualenv section
  #conda         # conda virtualenv section
  #dotnet        # .NET section
  #ember         # Ember.js section
  #terraform     # Terraform workspace section
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  vi_mode       # Vi-mode indicator
  char          # Prompt character
)

export VISUAL=nvim
export EDITOR=nvim

# Key bindings
bindkey '^ ' autosuggest-accept
bindkey '^x' autosuggest-clear

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

fpath+=${ZDOTDIR:-~}/.zsh_functions
export PATH="/usr/local/sbin:$PATH"

# Fig post block. Keep at the bottom of this file.
#[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"

source ~/.bash_profile
export GPG_TTY=$(tty)

export FZF_DEFAULT_OPTS='--prompt="🔭 " --height 80% --layout=reverse --border'

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/" --glob "!node_modules/" --glob "!vendor/" --glob "!undo/" --glob "!plugged/"'

export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

[[ -s "/Users/ivzolov/.gvm/scripts/gvm" ]] && source "/Users/ivzolov/.gvm/scripts/gvm"

export PATH=$PATH:/Users/skaiur/.spicetify
