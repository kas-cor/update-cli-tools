#!/bin/bash

tools=(
  # Package managers
  "npm:npm install -g npm@latest"
  "bun:bun upgrade || curl -fsSL https://bun.com/install | bash"
  "composer:composer self-update"
  # LLM CLI Agents
  "gemini:npm install -g @google/gemini-cli@latest"
  "qwen:npm install -g @qwen-code/qwen-code@latest"
  "cursor-agent:cursor-agent update"
  "goose:goose update"
  # Other tools
  "omz:omz update"
)

for tool_info in "${tools[@]}"; do
  IFS=':' read -r exe_name update_cmd <<< "$tool_info"

  if command -v "$exe_name" &> /dev/null; then
    echo "Found $exe_name. Attempting to update..."
    $update_cmd &> /dev/null
    if [ $? -eq 0 ]; then
      echo "The update of $exe_name was successful (or not required)."
    else
      echo "Error updating $exe_name or update command not implemented."
    fi
  fi
done
