#
# ~/.bashrc
#

[[ $- != *i* ]] && return

RESET="\[\033[0m\]"
BOLD="\[\033[1m\]"
ITALIC="\[\033[3m\]"

NORD_FG="\[\033[38;2;236;239;244m\]"
NORD_GREEN="\[\033[38;2;163;190;140m\]"
NORD_CYAN="\[\033[38;2;136;192;208m\]"
NORD_BLUE="\[\033[38;2;129;161;193m\]"
NORD_PURPLE="\[\033[38;2;180;142;173m\]"
NORD_RED="\[\033[38;2;191;97;106m\]"

git_prompt() {
  branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  [ -n "$branch" ] && echo " (${branch})"
}

exit_prompt() {
  [ ${LAST_EXIT:-0} -ne 0 ] && echo " ✗${LAST_EXIT}"
}

first_prompt=true
precmd() {
  if [ "$first_prompt" = true ]; then
    first_prompt=false
  else
    echo ""
  fi
}
PROMPT_COMMAND='LAST_EXIT=$?; precmd'

export PS1="╭╴${NORD_GREEN}\u${RESET}@${NORD_CYAN}\h ${RESET}${NORD_FG}\w ${RESET}${NORD_BLUE}\t${RESET}${NORD_PURPLE}\$(git_prompt)${RESET}${NORD_RED}\$(exit_prompt)${RESET}\n╰─> "
