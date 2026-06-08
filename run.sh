#!/bin/bash

LOG_DIR="$HOME/.update-cli"
LOG_FILE="$LOG_DIR/update-cli.log"

mkdir -p "$LOG_DIR"

{
  echo "=============================================="
  echo "      Update started at $(date)"
  echo "=============================================="
} >> "$LOG_FILE"

tools=(
  "npm:npm install -g npm@latest"
  "bun:bun upgrade || bash -c 'curl -fsSL https://bun.com/install | bash'"
  "composer:composer self-update || bash -c 'curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer'"
  "koda:npm i -g @kodadev/koda-cli@latest"
  "gemini:npm install -g @google/gemini-cli@latest"
  "qwen:npm install -g @qwen-code/qwen-code@latest"
  "copilot:npm install -g @github/copilot@latest"
  "codex:npm install -g @openai/codex@latest"
  "claude:npm install -g @anthropic-ai/claude-code@latest"
  "cursor-agent:cursor-agent update || bash -c 'curl -fsSL https://cursor.com/install | bash'"
  "goose:goose update || bash -c 'curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | bash'"
  "vibe:bash -c 'curl -fsSL https://mistral.ai/vibe/install.sh | bash'"
  "opencode:opencode upgrade || bash -c 'curl -fsSL https://opencode.ai/install | bash'"
)

update_tool() {
  local exe_name="$1" update_cmd="$2" index="$3" total="$4"

  if ! command -v "$exe_name" &>> "$LOG_FILE"; then
    echo "($index/$total) $exe_name: Pass"
    echo "  Install: $update_cmd"
    return
  fi

  echo -n "($index/$total) Updating $exe_name..."

  {
    echo "----------------------------------------------"
    echo "Updating $exe_name..."
    echo "----------------------------------------------"
  } >> "$LOG_FILE"

  local temp_log
  temp_log=$(mktemp)

  if bash -c "$update_cmd" &> "$temp_log"; then
    echo " Successful."
  else
    echo " Failed."
    cat "$temp_log"
  fi

  cat "$temp_log" >> "$LOG_FILE"
  rm "$temp_log"
}

total_tools=${#tools[@]}

for i in "${!tools[@]}"; do
  IFS=':' read -r exe_name update_cmd <<< "${tools[$i]}"
  update_tool "$exe_name" "$update_cmd" $((i + 1)) "$total_tools"
done

if command -v logrotate &>/dev/null; then
  logrotate -f -s "$LOG_DIR/logrotate.status" <(cat <<'EOF'
~/.update-cli/*.log {
  rotate 7
  daily
  compress
  missingok
  notifempty
  copytruncate
}
EOF
)
fi

echo "Logs are stored in the $LOG_DIR directory."
