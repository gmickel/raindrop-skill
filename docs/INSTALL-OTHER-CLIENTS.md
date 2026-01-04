# Installing in Other AI Clients

Several AI coding assistants support Agent Skills format or have fallback compatibility with Claude Code's `.claude/skills/` directory.

## Amp (Sourcegraph)

Amp has native support for Claude Code skills.

### Installation

Amp checks these locations for skills:

1. `.agents/skills/` (preferred)
2. `.claude/skills/` (fallback - works automatically!)

**Option 1: Use Claude Code location (recommended)**
```bash
cp -r /path/to/raindrop-skill ~/.claude/skills/raindrop
```

This works for both Claude Code AND Amp.

**Option 2: Amp-specific location**
```bash
mkdir -p ~/.config/amp/skills
cp -r /path/to/raindrop-skill ~/.config/amp/skills/raindrop
```

### Project-Level
```bash
# Works for both Claude Code and Amp
cp -r /path/to/raindrop-skill .claude/skills/raindrop
```

### Amp Settings

Config location: `~/.config/amp/settings.json`

No changes needed for skills - auto-discovered.

---

## OpenCode

OpenCode has Claude Code compatibility mode enabled by default.

### Installation

OpenCode checks these locations:

1. `~/.config/opencode/skill/` (native)
2. `.opencode/skill/` (project)
3. `~/.claude/skills/` (fallback via `claude_code` compat)
4. `.claude/skills/` (project fallback)

**Recommended: Use Claude Code location**
```bash
cp -r /path/to/raindrop-skill ~/.claude/skills/raindrop
```

Works for Claude Code, Amp, AND OpenCode.

### OpenCode-Specific Location

```bash
mkdir -p ~/.config/opencode/skill
cp -r /path/to/raindrop-skill ~/.config/opencode/skill/raindrop
```

### Configuration

Config location: `~/.config/opencode/opencode.json`

Claude Code compatibility is enabled by default. To verify:
```json
{
  "claude_code": {
    "enabled": true
  }
}
```

---

## Universal Installation

For maximum compatibility across all clients:

```bash
# Install to Claude Code location
cp -r /path/to/raindrop-skill ~/.claude/skills/raindrop
```

This single installation works for:
- Claude Code (native)
- Amp (fallback)
- OpenCode (fallback)

---

## Compatibility Matrix

| Client | Native Path | Claude Fallback | Notes |
|--------|-------------|-----------------|-------|
| Claude Code | `~/.claude/skills/` | - | Native |
| Codex | `~/.codex/skills/` | No | Separate install needed |
| Amp | `~/.config/amp/skills/` | Yes | `.claude/skills/` works |
| OpenCode | `~/.config/opencode/skill/` | Yes | `.claude/skills/` works |

## Environment Variable

All clients need access to `RAINDROP_TOKEN`. Add to shell config:

```bash
# ~/.zshrc.local or ~/.bashrc
export RAINDROP_TOKEN="your_token_here"
```

This is inherited by all terminal-based AI assistants.

---

## Troubleshooting

### Skill Not Found

1. Check the path exists:
   ```bash
   ls ~/.claude/skills/raindrop/SKILL.md
   ```

2. Verify YAML frontmatter:
   ```yaml
   ---
   name: raindrop
   description: ...
   ---
   ```

3. Directory name must match `name` field in frontmatter

### Script Permission Denied

```bash
chmod +x ~/.claude/skills/raindrop/scripts/raindrop.sh
```

### OpenCode Not Finding Claude Skills

Check compatibility is enabled in `~/.config/opencode/opencode.json`:
```json
{
  "claude_code": {
    "enabled": true
  }
}
```

### Amp Not Finding Skills

Amp looks for `AGENTS.md` first, then falls back to `CLAUDE.md`. Skills should work regardless. If issues persist, check `~/.config/amp/settings.json`.
