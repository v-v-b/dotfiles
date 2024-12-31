alias ls='ls -G'
alias gst='git status'
alias ll='ls -lah'
alias la='ls -A'
alias v=nvim

parse_git_branch() {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* (*\([^)]*\))*/\1/'
}

markup_git_branch() {
  if [[ -n $@ ]]; then
    if [[ -z $(git status --porcelain 2> /dev/null) ]]; then
      echo -e " \001\033[32m\002[$@]\001\033[0m\002"
    else
      echo -e " \001\033[31m\002[$@ *]\001\033[0m\002"
    fi
  fi
}

export PS1=" \[\033[01;32m\]\u@\h\[\033[00m\] \w\$(markup_git_branch \$(parse_git_branch)) $ "

# asdf
. /opt/asdf-vm/asdf.sh
# JAVA_HOME
. ~/.asdf/plugins/java/set-java-home.bash

