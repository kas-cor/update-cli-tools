#!/bin/bash

[ ! -d ~/.update-cli ] && mkdir -p ~/.update-cli

echo "==============================================" >> ~/.update-cli/update-cli.log
echo "      Update started at $(date)" >> ~/.update-cli/update-cli.log
echo "==============================================" >> ~/.update-cli/update-cli.log

tools=(
  # Package managers
  "npm:npm install -g npm@latest"
  "bun:bun upgrade || bash -c 'curl -fsSL https://bun.com/install | bash'"
  "composer:composer self-update || bash -c 'curl -fsSL https://getcomposer.org/installer | php && sudo mv composer.phar /usr/local/bin/composer'"
  # LLM CLI Agents
  "koda:npm i -g @kodadev/koda-cli@latest"
  "gemini:npm install -g @google/gemini-cli@latest"
  "qwen:npm install -g @qwen-code/qwen-code@latest"
  "copilot:npm install -g @github/copilot@latest"
  "codex:npm install -g @openai/codex@latest"
  "claude:npm install -g @anthropic-ai/claude-code@latest"
  "cursor-agent:cursor-agent update || bash -c 'curl -fsSL https://cursor.com/install | bash'"
  "goose:goose update || bash -c 'curl -fsSL https://github.com/block/goose/releases/download/stable/download_cli.sh | bash'"
  "vibe:bash -c 'curl -fsSL https://mistral.ai/vibe/install.sh | bash'"
)

total_tools=${#tools[@]}
current_tool=0

for tool_info in "${tools[@]}"; do
  current_tool=$((current_tool + 1))
  IFS=':' read -r exe_name update_cmd <<< "$tool_info"
  if command -v "$exe_name" &>> ~/.update-cli/update-cli.log; then
    echo -n "($current_tool/$total_tools) Updating $exe_name..."
    echo "----------------------------------------------" >> ~/.update-cli/update-cli.log
    echo "Updating $exe_name..." >> ~/.update-cli/update-cli.log
    echo "----------------------------------------------" >> ~/.update-cli/update-cli.log

    temp_log=$(mktemp)

    if bash -c "$update_cmd" &> "$temp_log"; then
      echo " Successful."
    else
      echo " Failed."
      cat "$temp_log"
    fi

    cat "$temp_log" >> ~/.update-cli/update-cli.log
    rm "$temp_log"
  else
    echo "($current_tool/$total_tools) $exe_name: Pass"
    echo "  Install: $update_cmd"
  fi
done

if command -v "logrotate" >/dev/null 2>&1; then
logrotate -f -s ~/.update-cli/logrotate.status <(cat <<'EOF'
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

echo "Logs are stored in the ~/.update-cli directory."
