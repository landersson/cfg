
command -v exa >/dev/null && alias ls=exa
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l="less"
alias dbm='printf "\e[?2004l"'

# git aliases
alias gst='git status'
alias gco='git commit'
alias gch='git checkout'
alias gad='git add'
alias glg='git log'
alias gps='git push'
alias gpl='git pull'
alias gdf='git diff'
alias gbr='git branch'

alias tmux='tmux -2'
alias v=view


alias mvim=/Applications/MacVim.app/Contents/bin/mvim

# ROS2 Related
alias iron='source /opt/ros/iron/setup.bash'
