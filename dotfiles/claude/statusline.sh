#!/bin/bash

# Read JSON input
input=$(cat)

# Debug: save raw input to file
echo "$input" > /tmp/claude/statusline-debug.json

# Extract pre-calculated values directly from JSON
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
dir=$(echo "$input" | jq -r '.workspace.current_dir // "."')
context_size=$(echo "$input" | jq -r '.context_window.context_window_size // 200000')
used=$(echo "$input" | jq -r '.context_window.used_percentage // 0')
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')

# Total tokens = everything (input + output + cache reads + cache creation)
total_tokens=$(echo "$input" | jq -r '
  (.context_window.total_input_tokens // 0) +
  (.context_window.total_output_tokens // 0) +
  (.context_window.current_usage.cache_read_input_tokens // 0) +
  (.context_window.current_usage.cache_creation_input_tokens // 0) | floor
')

# Derive current context from percentage (ensures consistency)
current_context=$(awk "BEGIN {printf \"%.0f\", $used * $context_size / 100}")

# Defaults
context_size=${context_size:-200000}
used=${used:-0}
current_context=${current_context:-0}
total_tokens=${total_tokens:-0}
cost=${cost:-0}

# Get git branch
branch=$(cd "$dir" 2>/dev/null && git -c core.useBuiltinFSMonitor=false rev-parse --abbrev-ref HEAD 2>/dev/null)
project=$(basename "$dir")

# Generate colorful progress bar
bar_width=15
filled=$((used * bar_width / 100))
[ "$filled" -gt "$bar_width" ] && filled=$bar_width
[ "$filled" -lt 0 ] && filled=0
empty=$((bar_width - filled))

# Color codes
green="\033[32m"
yellow="\033[33m"
red="\033[31m"
dim="\033[2m"
reset="\033[0m"

# Build gradient bar using $'...' for proper escape interpretation
bar="["
for ((i=0; i<bar_width; i++)); do
    if [ $i -lt $filled ]; then
        # Filled portion - gradient from green to yellow to red
        if [ $i -lt 5 ]; then
            bar+=$'\033[32m█\033[0m'
        elif [ $i -lt 10 ]; then
            bar+=$'\033[33m█\033[0m'
        else
            bar+=$'\033[31m█\033[0m'
        fi
    else
        # Empty portion
        bar+=$'\033[2m░\033[0m'
    fi
done
bar+="]"

# Format numbers
current_k=$(awk "BEGIN {printf \"%.1f\", $current_context / 1000}" | sed 's/\.0$//')
context_k=$(awk "BEGIN {printf \"%.0f\", $context_size / 1000}")
total_k=$(awk "BEGIN {printf \"%.1f\", $total_tokens / 1000}" | sed 's/\.0$//')
cost_fmt=$(awk "BEGIN {printf \"%.2f\", $cost}")

token_display="${current_k}K/${context_k}K"

# Set color based on usage percentage
if [ "$used" -lt 50 ]; then
    color="\033[32m"  # Green
elif [ "$used" -lt 75 ]; then
    color="\033[33m"  # Yellow
else
    color="\033[31m"  # Red
fi

# Colors
cyan="\033[36m"
magenta="\033[35m"
yellow="\033[33m"
bold="\033[1m"
reset="\033[0m"

# Print status line with fancy colors (%b interprets escapes in bar)
printf "| ${cyan}%s${reset} | %b${color}%d%%${reset} - ${color}%s${reset} | ${magenta}⚡ %sK${reset} | ${bold}${yellow}💰 \$%s${reset} |" "$model" "$bar" "$used" "$token_display" "$total_k" "$cost_fmt"

# Print branch and project
if [ -n "$branch" ]; then
    printf " \033[36m%s (%s)\033[0m |" "$project" "$branch"
else
    printf " \033[36m%s\033[0m |" "$project"
fi
