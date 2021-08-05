# My dotfiles

I hope someone will find my configuration files useful.

Except for the case where I accidentally shared any personal data.

## Aliases

```bash
alias zshconfig="vim ~/.zshrc"
alias g="git"
alias rr=". ranger"
alias qq=". ranger"
alias clr="clear"
alias ls="exa --icons"
alias ll="exa --icons --long --no-user --git"
alias lla="exa --icons --long --no-user --git --all --git-ignore"
alias tree="exa --icons --long --no-user --git --all --git-ignore --tree"
alias vim="nvim"
alias upd="brew update && brew upgrade"
alias k="kubectl"
alias python="python3"
alias pip="pip3"
alias config="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME
```

## Zsh plugins



### oh-my-zsh

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### zsh-autosuggestions

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

```

### zsh-syntax-highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

```

### Powerlevel10k prompt
[p10k](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k) or only [font](https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k)

### Spaceship Prompt
```bash
git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
```
