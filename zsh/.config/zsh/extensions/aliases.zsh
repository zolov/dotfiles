#!/bin/bash


# ------------------------------------
#               ALIASES
# ------------------------------------
alias s="source $HOME/.zshrc"
alias o="open ."
alias zshrc="nvim $HOME/.zshrc"
alias tmuxrc="nvim $HOME/.tmux.conf"
alias aliases="nvim $HOME/.config/zsh/extensions/aliases.zsh "

alias g="git"
alias qq="yazi"
alias cr="clear"
alias nf="nvimGoToFiles"
alias ngl="nvimGoToLine"
alias cd="z"

alias ls="eza --tree --level 1 --icons --git"
alias lsa="eza --tree --level 1 --icons --all --git"
alias ll="eza --icons --long --no-user --git"
alias lla="eza --icons --long --no-user --git --all" 
alias tree="eza --icons --long --no-user --git --all --git-ignore --tree --level=4"

alias e="nvim"
alias vim="nvim"

alias upd="brew update && brew upgrade --greedy && brew cleanup && sdk update && sdk upgrade"
alias k="kubectl"
alias python="python3"
alias pip="pip3"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias obsi="open -a obsidian"
alias k8log="$HOME/bin/k8log.sh"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias cat="bat -p"
alias bathelp="bat --plain --language=help"
alias lg="lazygit"
alias ld="lazydocker"
alias yabaiupd="brew services stop yabai && brew upgrade yabai && brew services start yabai"
alias mvnd="mvn -gs "$HOME/Dropbox/Projects/settings.xml" -T 2C"

cx() {
    cd "$@" && l;
}
f() {
    cd "$(find . -type d -not -path '*/.*' | fzf)" && l;
}

# ------------------------------------
#            My IP function 
# ------------------------------------
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

function take {
    mkdir -p $1
    cd $1
}

note() {
    echo "date: $(date)" >> $HOME/drafts.md
    echo "- [ ] $@" >> $HOME/drafts.md
    echo "" >> $HOME/drafts.md
}

function copy {
  bat -p $1 | pbcopy
}

function displayFZFFiles {
    echo $(fzf --preview 'bat --paging=never --theme=base16 --color=always --style=header,grid --line-range :400 {}')
}

function nvimGoToFiles {
    nvimExists=$(which nvim)
    if [ -z "$nvimExists" ]; then
      return;
    fi;

    selection=$(displayFZFFiles);
    if [ -z "$selection" ]; then
        return;
    else
        nvim $selection;
    fi;
}

function displayRgPipedFzf {
    echo $(rg . -n --glob "!.git/" --glob "!vendor/" --glob "!node_modules/" | fzf);
}

function nvimGoToLine {
    nvimExists=$(which nvim)
    if [ -z "$nvimExists" ]; then
      return;
    fi
    selection=$(displayRgPipedFzf)
    if [ -z "$selection" ]; then
      return;
    else 
        filename=$(echo $selection | awk -F ':' '{print $1}')
        line=$(echo $selection | awk -F ':' '{print $2}')
        nvim $(printf "+%s %s" $line $filename) +"normal zz";
    fi
}

function nv() {
   if [[ -z "$@" ]]; then
     CWD=${PWD:t}
	 SESSION_PATH=$HOME/.local/share/nvim/sessions/${CWD}/
     SESSION_FILE="Session.vim"
     GIT_BRANCH=""
     if [[ -d ".git" ]]; then
         GIT_BRANCH=$(git branch --show-current)
         GIT_BRANCH=${GIT_BRANCH//\//-} # replace '/' with '-' in branch name for dir purposes
         mkdir -p ${SESSION_PATH} # make session path if not exists
         SESSION_FILE="${SESSION_PATH}Session-${GIT_BRANCH}.vim"
     fi
     if [[ -f "$SESSION_FILE" ]]; then
         nvim -S "$SESSION_FILE" -c "lua vim.g.savesession = true ; vim.g.sessionfile = \"${SESSION_FILE}\""
     else
         nvim -c "lua vim.g.savesession = true ; vim.g.sessionfile = \"${SESSION_FILE}\""
     fi
   else
     nvim "$@"
   fi
}
