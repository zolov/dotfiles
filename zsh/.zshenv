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

export GOPATH="$(brew --prefix golang)"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export HOMEBREW_AUTO_UPDATE_SECS=604800
