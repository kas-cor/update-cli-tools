#!/bin/bash

tools=(
  "npm:npm install -g npm@latest"
  "composer:composer self-update"
  # LLM CLI Agents
  "gemini:npm install -g @google/gemini-cli"
  "qwen:npm install -g @qwen-code/qwen-code@latest"
  "cursor-agent:cursor-agent update"
  "goose:goose update"
)

for tool_info in "${tools[@]}"; do
  IFS=':' read -r exe_name update_cmd <<< "$tool_info"

  if command -v "$exe_name" &> /dev/null; then
    echo "Find $exe_name. try update..."
    $update_cmd
    if [ $? -eq 0 ]; then
      echo "The update of $exe_name was successful (or not required)."
    else
      echo "Error updating $exe_name or update command not implemented."
    fi
  fi
done
