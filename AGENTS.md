# update-cli-tools

Single bash script (`run.sh`) that updates CLI tools (package managers + AI agent CLIs).

## Tools format

Entries in the `tools` array in `run.sh` follow:

```
"executable_name:update_command"
```

When adding a tool: test that `command -v executable_name` works and that `update_command` is reliable (idempotent,
non-interactive).

## Structure

- `run.sh` — the entire program. No dependencies beyond bash, curl, and standard POSIX utils.
- `README.md` / `README_RU.md` — usage docs. Remote curl-to-bash is the recommended install method.
- No build, test, lint, CI, or package manager config. No dependencies file (no `package.json`, `go.mod`, etc.).

## Execution flow

1. Creates `~/.update-cli/` log directory
2. Iterates `tools` array; skips tools not in `PATH` (prints install hint)
3. For found tools: runs the update command, captures stdout+stderr to a temp file — on success prints "Successful.", on
   failure prints "Failed." + full output to console
4. Appends all output to `~/.update-cli/update-cli.log`
5. Attempts `logrotate` with inline config (7 daily logs, compressed) — silently skipped if `logrotate` not available

## Key behaviors

- **Skip, don't fail**: missing tools are silently passed, not errored
- **Logging always**: everything is also appended to `~/.update-cli/update-cli.log`
- **One-liner install**:
  `curl -fsSL https://raw.githubusercontent.com/kas-cor/update-cli-tools/refs/heads/main/run.sh | bash`
- **Non-PATH installs**: some fallback install commands (bun, composer, cursor-agent, goose, vibe, opencode) pipe
  `curl ... | bash` inside the update command — intentional, not a bug

## Adding a tool

1. Add entry to `tools` array: `"name:command"`
2. Verify `command -v name` matches the installed binary name
3. Ensure the command works non-interactively and won't prompt for confirmation
