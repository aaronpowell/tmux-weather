#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

print_forecast() {
  local format=$(get_tmux_option @forecast-format "%C+%t+%w")
  local location=$(get_tmux_option @forecast-location "") # Let wttr.in figure out the location
  local char_limit=$(get_tmux_option @forecast-char-limit 75)
  local forecast=$(curl http://wttr.in/$location?format=$format)
  echo ${forecast:0:$char_limit}
}

main() {
  print_forecast
}

main
