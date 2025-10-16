# Update CLI Tools

This script updates various command-line interface (CLI) tools, including package managers and LLM CLI agents.

## How it works

The script iterates through a predefined list of tools. For each tool, it checks if the tool's executable is present in the system's PATH. If it is, the script runs the corresponding update command.

## Supported Tools

The script currently supports updating the following tools:

*   **Package managers:**
    *   `npm`
    *   `bun`
    *   `composer`
*   **LLM CLI Agents:**
    *   `gemini`
    *   `qwen`
    *   `copilot`
    *   `codex`
    *   `claude`
    *   `cursor-agent`
    *   `goose`

## Usage

You can run the script in two ways:

1.  **Directly from GitHub:**
    ```bash
    curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash
    ```
2.  **Locally:**
    Clone the repository and run the script:
    ```bash
    git clone https://github.com/kas-cor/update-cli-tools.git
    cd update-cli-tools
    bash run.sh
    ```

## Alias

For convenient execution, you can add an alias to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`):

```bash
alias update-tools='curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash'
```

After adding the alias, you can simply run `update-tools` to update your tools.

## Logging

The script logs its actions to `~/.update-cli/update-cli.log`. Log rotation is handled by `logrotate` if it's available on the system.

## How to contribute

To add a new tool to the update list, you need to add a new entry to the `tools` array in `run.sh`. The format is:

```
"executable_name:update_command"
```
