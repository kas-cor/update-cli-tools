# Project Overview

This project is a shell script designed to update a list of command-line interface (CLI) tools. It checks if a tool is installed and then runs the corresponding update command. The script updates package managers like `npm`, `bun`, and `composer`, as well as several LLM CLI agents such as `gemini`, `qwen`, `copilot`, `codex`, `claude`, `cursor-agent`, and `goose`. It also includes log rotation for the update logs.

# Building and Running

The script can be executed directly from the command line.

*   To run the script, you can use the `curl` command as described in the `README.md`:
    ```bash
    curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash
    ```
*   Alternatively, you can run the `run.sh` script directly:
    ```bash
    bash run.sh
    ```

# Development Conventions

*   The script is written in `bash`.
*   To add a new tool to the update list, you need to add a new entry to the `tools` array in `run.sh`. The format is `"executable_name:update_command"`.
*   Logs are stored in the `~/.update-cli` directory.
