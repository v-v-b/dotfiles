alias ls='ls -G'
alias gst='git status'
alias ll='ls -lah'
alias la='ls -A'
alias v=nvim

# FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
compinit

git_branch() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    if [ -n "$(git status --porcelain)" ]; then
      echo "%F{red} [$ref]"
    else
      echo "%F{green} [$ref]"
    fi
  fi
}

setopt PROMPT_SUBST
PROMPT='%9c$(git_branch)%F{none} $ '

export EDITOR=nvim
bindkey -e

. /opt/homebrew/opt/asdf/libexec/asdf.sh
. ~/.asdf/plugins/java/set-java-home.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

