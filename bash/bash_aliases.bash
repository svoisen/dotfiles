# nav and ls aliases
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -al"
alias ..="cd .."
alias ...="cd .. && cd .."

# grep
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# history
alias h="history | tail -20"

# find
alias fn="find . -name"

# clear
alias c="clear"

# processes
alias pu="ps u"
alias paux="ps aux | less"

# slapd
alias slapd="sudo /usr/libexec/slapd -d 255"
