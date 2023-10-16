# .zshrc

setopt nosharehistory

# Neovim
alias n='nvim'
alias nd='nvim .'
alias vim='nvim'

# Git aliases
alias g='git'
alias gs='git status'
alias gd='git diff'
alias gc='git commit -m'
alias ga='git add'
alias gaa='git add --all'
alias gac='git add --all && git commit -m'
alias gpl='git pull'
alias gps='git push'


# cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Searching tmux session or create new if non exists
tmux-find-session() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}


tmux-sessionizer () {

    # This stores the output of the command in the variable
    selected=$(find ~/Documents/Programming ~/.config -mindepth 0 -maxdepth 2 -type d | fzf)

    # If the user exits fzf without selecting anything, exit the script
    if [[ -z $selected ]] && [[ -v TMUX ]]; then
        # This exits the tmux window
        exit 0
    elif [[ -z $selected ]]; then
        return 0
    fi

    # tr is used to replace the . with _ in the session name because tmux doesn't allow . in session names
    selected_name=$(basename "$selected" | tr . _)

    # Check if tmux is runnign
    tmux_running=$(pgrep tmux)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi

    # If the session is already running, just attach to it. tmux has-session throws an error if the session doesn't exist.
    # The 2> /dev/null is used to suppress the error message
    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi

    tmux switch-client -t $selected_name
}

launch-tmux-sessionizer () {
    # Check if tmux is runnign
    if [[ -v TMUX ]]; then
        tmux neww -n sessionizer tmux-sessionizer
    else
        tmux-sessionizer
    fi
}

source-config () {
    source ~/.zshrc
    tmux source-file ~/.config/tmux/tmux.conf
    tmux display-message "Configs reloaded"
}

# Killing selected tmux session
tmux-kill-session () {
    local sessions
    sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
    local i
    for i in "${(f@)sessions}"
    do
        [[ $i =~ '([^:]*):.*' ]] && {
            echo "Killing $match[1]"
            tmux kill-session -t "$match[1]"
        }
    done
}

# //TODO: Something overrides the keybingings c-f and c-n
# With `read -a` you can get the keycodes of the pressed keys
# Read `man zshzle` for more information about zle widgets
zle -N source-config
bindkey '^z' source-config

zle -N launch-tmux-sessionizer
bindkey  '^n' launch-tmux-sessionizer

zle -N tmux-find-session
bindkey '^z' tmux-find-session

zle -N tmux-kill-session
bindkey '^x' tmux-kill-session

