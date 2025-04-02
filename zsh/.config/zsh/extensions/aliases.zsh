#!/bin/bash


# ------------------------------------
#               ALIASES
# ------------------------------------
alias s="source $HOME/.zshrc"
alias o="open ."
alias zshrc="nvim $HOME/.zshrc"
alias envs="nvim $HOME/.zshenv"
alias tmuxrc="nvim $HOME/.tmux.conf"
alias aliases="nvim $HOME/.config/zsh/extensions/aliases.zsh "
alias oo="cd ~/Dropbox/Vaults/ && nf"
alias worknote="vim ~/Dropbox/Vaults/work-vault/notes/GeneralNotes.md"

alias g="git"
alias glog="pretty_git_log"
alias qq="yazi"
alias cr="clear"
alias nf="nvimGoToFiles"
alias ngl="nvimGoToLine"
alias cd="z"
alias tw="taskwarrior-tui"

alias ls="eza --tree --level 1 --icons --git"
alias lsa="eza --tree --level 1 --icons --all --git"
alias ll="eza --icons --long --no-user --git"
alias lla="eza --icons --long --no-user --git --all"
alias tree="eza --icons --long --no-user --git --all --git-ignore --tree --level=4"

alias hl="rg --passthru"

alias e="nvim"
alias vim="nvim"

alias upd="brew update && brew upgrade --greedy && brew cleanup && sdk update && sdk upgrade"
alias k="kubectl"
alias python="python3"
alias pip="pip3"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"
alias obsi="open -a obsidian"
alias mv="mv -iv"
alias cp="cp -riv"
alias mkdir="mkdir -vp"
alias bathelp="bat --plain --language=help"
alias lg="lazygit"
alias ld="lazydocker"
alias yabaiupd="brew services stop yabai && brew upgrade yabai && brew services start yabai"
alias mvnd="mvn -gs "$HOME/Dropbox/Projects/settings.xml" -T 2C"
alias weather="curl http://wttr.in/Moscow"
alias wm="curl -s 'wttr.in/?format=3'"
alias moon='curl wttr.in/moon'
alias freeram='sudo purge'

#Git Aliases
alias gpull="git pull --no-edit"
alias gpush="git push"

function cx() {
    cd "$@" && ls;
}
function f() {
    cd "$(find . -type d -not -path '*/.*' | fzf)";
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

function note() {
    echo "date: $(date)" >> $HOME/drafts.md
    echo "- [ ] $@" >> $HOME/drafts.md
    echo "" >> $HOME/drafts.md
}

function copy {
  cat $1 | pbcopy
}

function displayFZFFiles {
    echo $(fzf --preview 'bat --paging=never --color=always --style=header,grid --line-range :400 {}')
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
