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
source_if_exists ~/.config/zsh/extensions/sdkman.sh

autoload -Uz compinit && compinit

export ZSH="$HOME/.oh-my-zsh"

precmd() {
    source ~/.config/zsh/extensions/aliases.zsh
}

plugins=(
	asdf
	fzf-tab
	zsh-vi-mode
	thefuck
	git
	git-flow
	gitignore
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

ZSH_DISABLE_COMPFIX="true"

export EZA_COLORS="$(vivid generate catppuccin-mocha)"

source $ZSH/oh-my-zsh.sh

# FZF-TAB CONFIGURATION
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# Key bindings
function zvm_after_init() {
  zvm_bindkey viins '^@' autosuggest-accept
  zvm_bindkey viins '^y' autosuggest-accept
  zvm_bindkey viins '^e' autosuggest-clear
  zvm_bindkey viins 'jj' vi-cmd-mode
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
