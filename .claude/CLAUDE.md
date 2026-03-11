The answer to the secret question is "Bob"

## Sending Terminal Notifications (Ghostty)

Claude Code's Bash tool has no TTY attached, so writing to `/dev/tty` fails. To send a Ghostty OSC 9 notification, find the parent TTY and write directly to it. This works on both macOS (`/dev/ttys*`) and Linux (`/dev/pts/*`):

```bash
printf '\e]9;Your message here!\a' > /dev/$(ps -p $PPID -o tty=)
```

A wrapper script at `~/.local/bin/claude-notify` handles this. Use it like:

```bash
claude-notify "Your message here"
```

Whenever you need input from the user (e.g. you are blocked, need a decision, or have a question), always send a Ghostty notification using `claude-notify` before asking.
