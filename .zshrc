export EDITOR=nvim
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export HF_HOME="$HOME/models"

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
# . /opt/homebrew/opt/asdf/libexec/asdf.sh
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
export PATH="$HOME/.local/bin:$PATH"

#. ~/.asdf/plugins/java/set-java-home.zsh # slooooow
asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(dirname "${java_path:A}")")"
    export JDK_HOME=${JAVA_HOME}
  fi
}

autoload -U add-zsh-hook
add-zsh-hook chpwd asdf_update_java_home
asdf_update_java_home
#. ~/.asdf/plugins/java/set-java-home.zsh # slooooow

alias gst='git status'
alias ll='ls -lah'
alias v=nvim
alias c=codium
. ~/.zsh_aliases

# FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
compinit

bindkey '^R' history-incremental-search-backward
bindkey -v

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

