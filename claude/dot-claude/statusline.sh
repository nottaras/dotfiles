#!/bin/bash
# Status line for a Claude subscription plan.
# It shows plan limits, not dollars. On a fixed-price plan the
# only budget that matters is the 5-hour window and the weekly window.

input=$(cat)

eval "$(printf '%s' "$input" | jq -r '
  @sh "MODEL=\(.model.display_name // "?")",
  @sh "DIR=\(.workspace.current_dir // "")",
  @sh "CTX=\(.context_window.used_percentage // 0 | floor)",
  @sh "CTX_TOK=\(.context_window.total_input_tokens // 0)",
  @sh "H5=\(.rate_limits.five_hour.used_percentage // -1 | floor)",
  @sh "H5_AT=\(.rate_limits.five_hour.resets_at // 0)",
  @sh "D7=\(.rate_limits.seven_day.used_percentage // -1 | floor)",
  @sh "D7_AT=\(.rate_limits.seven_day.resets_at // 0)",
  @sh "OPUS=\(.rate_limits.seven_day_opus.used_percentage // -1 | floor)",
  @sh "FAST=\(.fast_mode // false)",
  @sh "EFFORT=\(.effort.level // "")",
  @sh "ADDED=\(.cost.total_lines_added // 0)",
  @sh "REMOVED=\(.cost.total_lines_removed // 0)"
')"

R=$'\033[0m'; DIM=$'\033[2m'
GREEN=$'\033[32m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; BLUE=$'\033[34m'; CYAN=$'\033[36m'

# Green below 60%, yellow below 85%, red above.
pct_color() {
  if [ "$1" -ge 85 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 60 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

# Time left until a unix timestamp, as 2d3h / 4h12m / 37m.
until_reset() {
  local left=$(( $1 - $(date +%s) ))
  [ "$left" -lt 0 ] && left=0
  if [ "$left" -ge 86400 ]; then printf '%dd%dh' $((left / 86400)) $(((left % 86400) / 3600))
  elif [ "$left" -ge 3600 ]; then printf '%dh%02dm' $((left / 3600)) $(((left % 3600) / 60))
  else printf '%dm' $((left / 60)); fi
}

# Token count as 31k / 1.2M.
human() {
  local n=$1
  if [ "$n" -ge 1000000 ]; then printf '%d.%dM' $((n / 1000000)) $(((n % 1000000) / 100000))
  elif [ "$n" -ge 1000 ]; then printf '%dk' $((n / 1000))
  else printf '%d' "$n"; fi
}

SEP="${DIM} · ${R}"

NAME="${DIR##*/}"
[ -z "$NAME" ] && NAME="?"
OUT="${CYAN}${MODEL}${R}"
[ -n "$EFFORT" ] && OUT="${OUT} ${DIM}${EFFORT}${R}"
OUT="${OUT}${SEP}${NAME}"

if [ -d "$DIR" ] && branch=$(git -C "$DIR" branch --show-current 2>/dev/null); then
  [ -z "$branch" ] && branch=$(git -C "$DIR" rev-parse --short HEAD 2>/dev/null)
  dirty=""
  git -C "$DIR" diff --quiet --ignore-submodules HEAD 2>/dev/null || dirty="*"
  OUT="${OUT}${SEP}${BLUE}${branch}${dirty}${R}"
fi

[ "$FAST" = "true" ] && OUT="${OUT}${SEP}${YELLOW}fast${R}"

OUT="${OUT}${SEP}${DIM}ctx${R} $(pct_color "$CTX")${CTX}%${R} ${DIM}$(human "$CTX_TOK")${R}"

if [ "$H5" -ge 0 ]; then
  OUT="${OUT}${SEP}${DIM}5h${R} $(pct_color "$H5")${H5}%${R} ${DIM}$(until_reset "$H5_AT")${R}"
fi

if [ "$D7" -ge 0 ]; then
  OUT="${OUT}${SEP}${DIM}wk${R} $(pct_color "$D7")${D7}%${R} ${DIM}$(until_reset "$D7_AT")${R}"
fi

if [ "$OPUS" -ge 0 ]; then
  OUT="${OUT}${SEP}${DIM}wk-opus${R} $(pct_color "$OPUS")${OPUS}%${R}"
fi

if [ "$ADDED" -gt 0 ] || [ "$REMOVED" -gt 0 ]; then
  OUT="${OUT}${SEP}${GREEN}+${ADDED}${R}${DIM}/${R}${RED}-${REMOVED}${R}"
fi

printf '%s\n' "$OUT"
