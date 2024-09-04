alias nvim-lazy="NVIM_APPNAME=LazyNvim nvim"
alias nvim-kick="NVIM_APPNAME=kickstart nvim"
alias nvim-chad="NVIM_APPNAME=NvChad nvim"
alias nvim-astro="NVIM_APPNAME=AstroNvim nvim"
alias nvim-dusk="NVIM_APPNAME=DuskNvim nvim"

function nvims() {
  items=(
    "default" 
    "kickstart" 
    "LazyVim" 
    "NvChad" 
    "DuskNvim"
    #"AstroNvim"
  )
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

if [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
   bindkey -s ^n "nvims\n"
elif [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
   bind -x '"\C-n": nvims'
else
   bindkey -s ^n "nvims\n"
fi
