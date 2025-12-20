# Update CLI Tools

A simple and efficient bash script to update various command-line interface (CLI) tools, including package managers and LLM CLI agents.

## Features

- Automatically detects installed tools in your PATH
- Updates multiple tools in a single execution
- Comprehensive logging with optional log rotation
- Easy one-liner installation

## How it Works

The script iterates through a predefined list of tools. For each tool, it checks if the tool's executable is present in the system's PATH. If found, the script runs the corresponding update command.

## Supported Tools

### Package Managers
- `npm` - Node.js package manager
- `bun` - Fast JavaScript runtime and package manager
- `composer` - PHP dependency manager

### LLM CLI Agents
- `gemini` - Google's Gemini CLI
- `qwen` - Alibaba Cloud's Qwen Code CLI
- `copilot` - GitHub Copilot CLI
- `codex` - OpenAI Codex CLI
- `claude` - Anthropic Claude Code CLI
- `cursor-agent` - Cursor IDE agent
- `goose` - Goose development assistant
- `vibe` - Mistral AI Vibe CLI

## Prerequisites

- Bash shell
- Internet connection for downloading updates
- Appropriate permissions to update installed tools
- `curl` for remote script execution

## Usage

### Remote Execution (Recommended)
Execute directly from GitHub without cloning:
```bash
curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash
```

### Local Execution
Clone the repository and run the script locally:
```bash
git clone https://github.com/kas-cor/update-cli-tools.git
cd update-cli-tools
bash run.sh
```

## Setup Convenience Alias

For easy access, add an alias to your shell's configuration file (e.g., `~/.bashrc`, `~/.zshrc`):
```bash
alias update-tools='curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash'
```

After adding the alias and reloading your shell configuration (`source ~/.bashrc`), you can simply run `update-tools` to update your tools.

## Logging

The script logs its actions to `~/.update-cli/update-cli.log`. Log rotation is automatically handled by `logrotate` if it's available on your system, keeping up to 7 days of logs.

## Contributing

We welcome contributions to expand the list of supported tools!

### Adding a New Tool

To add a new tool to the update list:

1. Fork the repository
2. Add a new entry to the `tools` array in `run.sh`
3. Format: `"executable_name:update_command"`
4. Submit a pull request

#### Example Addition
```bash
"newtool:newtool update --latest"
```

### Guidelines for New Tools

- Ensure the tool is commonly used in development workflows
- Provide a reliable update command
- Test the update command works as expected
- Follow the same format as existing entries

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

If you encounter any issues or have suggestions for improvement, please open an issue on the GitHub repository.
