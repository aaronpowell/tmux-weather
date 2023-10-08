#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/helpers.sh"

get_forecast() {
  local format=$(get_tmux_option @forecast-format "%C+%t+%w")
  local location=$(get_tmux_option @forecast-location "") # Let wttr.in figure out the location
  local language=$(get_tmux_option @forecast-language "en")
  curl "http://wttr.in/$location?format=$format&lang=$language"
}

get_cached_forecast() {
  local cache_duration=$(get_tmux_option @forecast-cache-duration 0) # in seconds, by default cache is disabled
  local cache_path=$(get_tmux_option @forecast-cache-path "/tmp/tmux-weather.cache") # where to store the cached data
  local cache_age=$(get_file_age "$cache_path")
  local forecast
  if [ $cache_duration -gt 0 ]; then # Cache enabled branch
    # if file does not exist or cache age is greater then configured duration
    if ! [ -f "$cache_path" ] || [ $cache_age -ge $cache_duration ]; then
      forecast=$(get_forecast)
      # store forecast in $cache_path
      mkdir -p "$(dirname "$cache_path")"
      echo "$forecast" > "$cache_path"
    else
      # otherwise try to get it from cache file
      forecast=$(cat "$cache_path" 2>/dev/null)
    fi
  else # Cache disabled branch
    forecast=$(get_forecast)
  fi
  echo "$forecast"
}

print_forecast() {
  local char_limit=$(get_tmux_option @forecast-char-limit 75)
  local forecast=$(get_cached_forecast)
  echo ${forecast:0:$char_limit}
}

main() {
  print_forecast
}

main
