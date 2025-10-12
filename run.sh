#!/bin/bash

tools=(
  # Package managers
  "npm:npm install -g npm@latest"
  "bun:bun upgrade || {curl -fsSL https://bun.com/install | bash}"
  "composer:composer self-update"
  # LLM CLI Agents
  "gemini:npm install -g @google/gemini-cli@latest"
  "qwen:npm install -g @qwen-code/qwen-code@latest"
  "copilot:npm install -g @github/copilot@latest"
  "codex:npm install -g @openai/codex@latest"
  "claude:npm install -g @anthropic-ai/claude-code@latest"
  "cursor-agent:cursor-agent update"
  "goose:goose update"
  # Other tools
  "omz:omz update"
)

for tool_info in "${tools[@]}"; do
  IFS=':' read -r exe_name update_cmd <<< "$tool_info"
  if command -v "$exe_name" &> /dev/null; then
    echo -n "Update $exe_name..."
    $update_cmd &> /dev/null
    if [ $? -eq 0 ]; then
      echo "Successful (or not required)."
    else
      echo "Error (or update command not implemented)."
    fi
  fi
done
