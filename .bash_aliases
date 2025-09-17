command -v exa >/dev/null && alias ls=exa
# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l="less"

alias nv='nvim'

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

# yadm git shortcuts
alias yst='yadm status'
alias yco='yadm commit'
alias yad='yadm add'
alias ylg='yadm log'
alias yps='yadm push'
alias ypl='yadm pull'
alias ydf='yadm diff'

alias tmux='tmux -2'
alias v=view

alias mvim=/Applications/MacVim.app/Contents/bin/mvim

alias ryz='ssh -4 ryzen.rcv.csiro.au'
alias rok='ssh -4 rocky.rcv.csiro.au'
alias lbu='ssh -4 lightingbug-bm.nexus.csiro.au'

# ROS2 Related
alias jazzy='source /opt/ros/jazzy/setup.bash'
