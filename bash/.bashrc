# .bashrc


# Git aliases
alias g='git'
alias gc='git commit'
alias gac='git add --all && git commit'


# Search history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# Searching tmux session or create new if non exists
tfs() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# Creating new tmux session for selected directory
tns() {
    if [[ $# -eq 1 ]]; then
        selected=$1
    else
        selected=$(find ~/Documents/Programming -mindepth 1 -maxdepth 2 -type d | fzf)
    fi

    selected_name=$(basename "$selected" | tr . _)
    tmux_running=$(pgrep tmux)

    if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
        tmux new-session -s $selected_name -c $selected
        exit 0
    fi

    if ! tmux has-session -t=$selected_name 2> /dev/null; then
        tmux new-session -ds $selected_name -c $selected
    fi

    tmux switch-client -t $selected_name

    if [[ -z $TMUX ]]; then
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi
}

# Killing selected tmux session
# tk () {
#     local sessions
#     sessions="$(tmux ls|fzf --exit-0 --multi)"  || return $?
#     local i
#     for i in "${(f@)sessions}"
#     do
#         [[ $i =~ '([^:]*):.*' ]] && {
#             echo "Killing $match[1]"
#             tmux kill-session -t "$match[1]"
#         }
#     done
# }
#
