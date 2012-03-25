# Bash aliases
#
# Sean Voisen <http://sean.voisen.org>

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

# git
alias gst="git status"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s -%Creset %C(yellow)%d%Creset %Cgreen9%cr)%Creset' --abbrev-commit --date=relative"
alias gd="git diff"
alias gc="git commit"
alias gca="git commit -a"
alias gco="git checkout"
alias gb="git branch"
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gpom="git push origin master"

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
