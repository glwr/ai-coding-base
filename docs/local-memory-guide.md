# Local Memory Guide

> Personal, per-developer notes stored in `~/.claude/projects/`. NOT git-versioned.

## Shared Context vs Local Memory

| Type | Local (personal) | Shared (`context/`) |
|------|-------------------|---------------------|
| Personal preferences | Yes | No |
| Team decisions | No | Yes (`decisions.md`) |
| Individual debugging notes | Yes | No |
| Code patterns | No | Yes (`patterns.md`) |
| Personal workflow shortcuts | Yes | No |
| Learnings & gotchas | No | Yes (`learnings.md`) |
| Environment-specific notes | Yes (your machine) | No |
| Tech stack details | No | Yes (`stack.md`) |

## How to Update Local Memory

Claude Code automatically manages `~/.claude/projects/<project>/memory/MEMORY.md`.

To add personal notes:
1. Tell Claude: "Remember that I prefer [X]" — it saves to local memory automatically
2. Or edit `~/.claude/projects/<project>/memory/MEMORY.md` directly

## Suggested Local Memory Structure

```markdown
# Project Name — Personal Memory

## My Preferences
- Preferred editor settings
- Personal coding style notes
- Testing approach preferences

## My Environment
- Local database URL
- Dev server port
- OS-specific workarounds

## Session Notes
- Current work in progress
- Where I left off
- Things to revisit
```

## Promoting Local Notes to Shared Context

When a personal learning turns out to be generally useful, promote it to shared context:

```
/remember [your learning here]
```

This saves it to the `context/` directory where it benefits the whole team.
