
autoload -Uz compinit && compinit

autoload -U promptinit; promptinit
prompt spaceship

# Kuberbetes CLI
source <(kubectl completion zsh)

# Path to your oh-my-zsh installation.
export ZSH="/Users/zolov/.oh-my-zsh"

# THEMES
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
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

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Add wisely, as too many plugins slow down shell startup.
plugins=(
sudo
git
git-flow
gitignore
kubectl
docker
docker-compose
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
)

ZSH_DISABLE_COMPFIX="true"

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
# ALIASES
alias zshrc"code ~/.zshrc"
alias g="git"
alias rr=". ranger"
alias qq=". ranger"
alias clr="clear"
alias ls="exa --icons"
alias lsa="exa --icons --all"
alias ll="exa --icons --long --no-user --git --git-ignore"
alias lla="exa --icons --long --no-user --git --all" 
alias tree="exa --icons --long --no-user --git --all --git-ignore --tree"
alias vim="nvim"
alias upd="brew update && brew upgrade && brew cleanup" 
alias k="kubectl"
alias python="python3"
alias pip="pip3"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias typora="open -a typora"
alias k8log="$HOME/bin/k8log.sh"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"

function acp() {
git add .
git commit -m "$1"
git push
}

extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)  tar xjf $1    ;;
      *.tar.gz) tar xzf $1    ;;
      *.bz2)    bunzip2 $1    ;;
      *.rar)    rar x $1    ;;
      *.gz)   gunzip $1   ;;
      *.tar)    tar xf $1   ;;
      *.tbz2)   tar xjf $1    ;;
      *.tgz)    tar xzf $1    ;;
      *.zip)    unzip $1    ;;
      *.Z)    uncompress $1 ;;
      *)      echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

complete -F __start_kubect

# ------------------------------------
# Kubernetes alias and function
# ------------------------------------

# Get versions of deployment services
alias deplver="kubectl get deployments -o custom-columns=NAME:.metadata.name,version:.metadata.labels.version"

# ------------------------------------
# Docker alias and function
# ------------------------------------

# Get latest container ID
alias dl="docker ps -l -q"
# Get container process
alias dps="docker ps"
# Get process included stop container
alias dpa="docker ps -a"
# Get images
alias di="docker images"
# Get container IP
alias dip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
# Run deamonized container, e.g., $dkd base /bin/echo hello
alias dkd="docker run -d -P"
# Run interactive container, e.g., $dki base /bin/bash
alias dki="docker run -i -t -P"
# Execute interactive container, e.g., $dex base /bin/bash
alias dex="docker exec -i -t"
# Execute zip db data
alias dzip="docker exec -t -u postgres $(docker ps --no-trunc --filter name=dev_postgres_1 | awk '$2 ~ /postgres/ {print $1}') pg_dumpall -c | gzip > postgres.sql.gz"
alias dunzip="gunzip -c postgres.sql.gz | docker exec -i $(docker ps --no-trunc --filter name=dev_postgres_1 | awk '$2 ~ /postgres/ {print $1}') psql -Upostgres"
# Stop all containers
dstop() { docker stop $(docker ps -a -q); }
# Remove all containers
drm() { docker rm $(docker ps -a -q); }
# Stop and Remove all containers
alias drmf='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q)'
# Remove all images
dri() { docker rmi $(docker images -q); }
# Dockerfile build, e.g., $dbu tcnksm/test 
dbu() { docker build -t=$1 .; }
# Show all alias related docker
dalias() { alias | grep 'docker' | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
allalias() { alias | sed "s/^\([^=]*\)=\(.*\)/\1 => \2/"| sed "s/['|\']//g" | sort; }
# Bash into running container
dbash() { docker exec -it $(docker ps -aqf "name=$1") bash; }

function k9logs() {
    GREP=(`k9s info | grep Logs`)
    logPath=`echo ${GREP[2]} | sed -e $'s#\033\[[;0-9]*m##g' | tr -d '[:cntrl:]' | cat`

    # cp $logPath ~/Downloads/k9s-log.log
    cp $logPath .
}

function myip()
{
    extIp=$(dig +short myip.opendns.com @resolver1.opendns.com)

    printf "Wireless IP: "
    MY_IP=$(/sbin/ifconfig wlp4s0 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}


    printf "Wired IP: "
    MY_IP=$(/sbin/ifconfig enp0s25 | awk '/inet/ { print $2 } ' |
      sed -e s/addr://)
    echo ${MY_IP:-"Not connected"}

    echo ""
    echo "WAN IP: $extIp"

}

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
  #battery       # Battery level and status
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  #package       # Package version
  kubectl       # Kubectl context section
  exec_time     # Execution time
  line_sep      # Line break
  #gradle        # Gradle section
  #maven         # Maven section
  #node          # Node.js section
  #ruby          # Ruby section
  #elixir        # Elixir section
  #xcode         # Xcode section
  #swift         # Swift section
  #golang        # Go section
  #php           # PHP section
  #rust          # Rust section
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

# tat: tmux attach
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# Key bindings
bindkey '^ ' autosuggest-accept
bindkey '^x' autosuggest-clear

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/zolov/.sdkman"
[[ -s "/Users/zolov/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/zolov/.sdkman/bin/sdkman-init.sh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e /Users/zolov/.iterm2_shell_integration.zsh && source /Users/zolov/.iterm2_shell_integration.zsh || true

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
