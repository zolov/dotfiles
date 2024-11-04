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

export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="spaceship"

precmd() {
    source ~/.config/zsh/extensions/aliases.zsh
}

# PLUGINS
plugins=(
	asdf
	fzf-tab
	vi-mode
	# sudo
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
	vscode
	fzf
)

bindkey -M viins 'jj' vi-cmd-mode
ZVM_VI_INSERT_ESCAPE_BINDKEY=jj

ZSH_DISABLE_COMPFIX="true"

source $ZSH/oh-my-zsh.sh

# zsh-autosuggestions CONFIGURATION
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green,bold,underline"

# Key bindings
bindkey '^ ' autosuggest-accept
bindkey '^y' autosuggest-accept
bindkey '^e' autosuggest-clear

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
