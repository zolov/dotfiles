export VISUAL=nvim
export EDITOR=nvim

# Added by Toolbox App
export PATH="$PATH:/Users/ivzolov/Library/Application Support/JetBrains/Toolbox/scripts"

export GPG_TTY=$(tty)

# bg+:#313244,bg:#1e1e2e,
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,spinner:#99e5a2,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#99e5a2 \
--color=selected-bg:#45475a \
--multi \
--layout=reverse \
--border
--prompt=' '
--height=95%
"
# FZF configurations
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="rg --hidden --sort-files --files --null 2> /dev/null | xargs -0 dirname | uniq"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/" --glob "!node_modules/" --glob "!vendor/" --glob "!undo/" --glob "!plugged/"'

export EZA_COLORS="$(vivid generate catppuccin-mocha)"

export BAT_THEME="Catppuccin Mocha"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PATH=$PATH:/Users/skaiur/.spicetify

export TODO="$HOME/Dropbox/Vaults/Zettelkasten/Notes/TODO.md"

if [[ $(uname) == "Darwin" ]]; then
    . "$HOME/.cargo/env"
    export PATH="$PATH:/Library/Developer/CommandLineTools/usr/bin/sourcekit-lsp"
    export PATH="$PATH:/opt/homebrew/bin"
    export PATH="$PATH:$HOME/.cargo/bin"
	export PATH="$PATH:$HOME/.local/bin"
else
    export PATH="$PATH:$HOME/.cargo/bin"
    export PATH="$PATH:$HOME/.local/bin"
fi

export GOPATH="$(asdf where golang)/packages"
export GOROOT="$(asdf where golang)/go"
export PATH="$PATH:$GOROOT/bin"

export HOMEBREW_AUTO_UPDATE_SECS=604800

export PATH="/usr/local/sbin:$PATH"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
