
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

export GOPATH=$(asdf where golang)/packages
export GOROOT=$(asdf where golang)/go
# export GOPATH="$(brew --prefix golang)"
# export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$(go env GOPATH)/bin

export HOMEBREW_AUTO_UPDATE_SECS=604800


