#!/usr/bin/env zsh

# Source zplug
export ZPLUG_HOME=$HOME/.zplug
if [[ ! -f $ZPLUG_HOME/init.zsh ]]; then
  rm -rf "$ZPLUG_HOME"
  echo "Updating zplug"
  git clone https://github.com/zplug/zplug $ZPLUG_HOME
fi

source $ZPLUG_HOME/init.zsh

zplug "zplug/zplug"
zplug "mafredri/zsh-async", from:github
zplug "larkery/zsh-histdb", from:github, at:d831a3a222e138ecdd65c225779f49bca52813f8
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
zplug "zsh-users/zsh-completions", from:github


# Install packages that have not been installed yet
if ! zplug check --verbose; then
  echo; zplug install
fi

zplug load
