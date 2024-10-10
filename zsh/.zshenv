. "$HOME/.cargo/env"

export PATH=$HOME/.local/bin:$PATH
export GOPATH="$(brew --prefix golang)"
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
