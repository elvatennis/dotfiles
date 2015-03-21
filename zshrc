# completion
autoload -U compinit
compinit

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

# set up boxen
[[ -f /opt/boxen/env.sh ]] && source /opt/boxen/env.sh
