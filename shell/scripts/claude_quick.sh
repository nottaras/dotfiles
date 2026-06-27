source "$HOME/.dotfiles/shell/scripts/claude_quick.conf"

ask_claude() {
  local answer
  [[ ! -f "$CLAUDE_LOG" ]] && touch "$CLAUDE_LOG"
  answer=$(claude -p "$*" \
    --model "$CLAUDE_MODEL" \
    --output-format text \
    --system-prompt "$(cat $CLAUDE_SYSTEM_PROMPT)" \
    2>/dev/null)
  printf "## %s — %s\n%s\n---\n" "$*" "$(date '+%Y-%m-%d %H:%M')" "$answer" >> "$CLAUDE_LOG"
  echo "$answer"
}

alias '?'='ask_claude'