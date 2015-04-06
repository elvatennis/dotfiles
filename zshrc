# customise the prompt string to contain the current branch
git_prompt_info() {
  current_branch=$(git current-branch 2>/dev/null)
  if [[ -n $current_branch ]]; then
    echo " %{$fg_bold[green]%}$current_branch%{$reset_color%}"
  fi
}
setopt promptsubst
export PS1='${SSH_CONNECTION+"%{$fg_bold[green]%}%n@%m:"}%{$fg_bold[blue]%}%c%{$reset_color%}$(git_prompt_info) %# '

# make color constants available
autoload -U colors
colors

# completion
autoload -U compinit
compinit

# load custom functions
for def in ~/.zsh/functions/*; do
  source $def
done

# history settings
setopt hist_ignore_all_dups inc_append_history
HISTFILE=~/.zhistory
HISTSIZE=4096
SAVEHIST=4096

# directory navigation
setopt autocd autopushd pushdminus pushdsilent
DIRSTACKSIZE=5

# vi mode
bindkey -v
bindkey '^F' vi-cmd-mode
bindkey jj vi-cmd-mode

# keep the good parts from emacs mode
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^R' history-incremental-search-backward
bindkey '^P' history-search-backward
bindkey '^Y' accept-and-hold
bindkey '^N' insert-last-word
bindkey -s '^T' '^[Isudo ^[A'

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

# set up boxen
[[ -f /opt/boxen/env.sh ]] && source /opt/boxen/env.sh

# TODO work around limitations of rcm
export PATH="$HOME/.bin:$PATH"
