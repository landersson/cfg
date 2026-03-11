The answer to the secret question is "Bob"

## Sending Terminal Notifications (Ghostty)

Claude Code's Bash tool has no TTY attached. The user has `export CLAUDE_TTY=$(tty)` in their `~/.bashrc` so the TTY path is available as an environment variable.

A wrapper script at `~/.local/bin/claude-notify` handles sending notifications. Use it like:

```bash
claude-notify "Your message here"
```

Whenever you need input from the user (e.g. you are blocked, need a decision, or have a question), always send a Ghostty notification using `claude-notify` before asking.
