# Installing in Codex CLI

OpenAI Codex CLI supports Agent Skills format.

## User-Level Installation

Applies to all your projects.

```bash
# Create skills directory if needed
mkdir -p ~/.codex/skills

# Copy skill
cp -r /path/to/raindrop-skill ~/.codex/skills/raindrop

# Or clone directly
git clone https://github.com/YOUR_USER/raindrop-skill ~/.codex/skills/raindrop
```

**Location**: `~/.codex/skills/raindrop/SKILL.md`

## Project-Level Installation

Applies only to a specific repository.

```bash
# In your project root
mkdir -p .codex/skills
cp -r /path/to/raindrop-skill .codex/skills/raindrop

# Commit to share with team
git add .codex/skills/raindrop
git commit -m "Add raindrop skill"
```

**Location**: `.codex/skills/raindrop/SKILL.md`

## Skill Search Order

Codex searches for skills in this order:

1. `$CWD/.codex/skills` - Current directory
2. `$REPO_ROOT/.codex/skills` - Repo-wide
3. `~/.codex/skills` - User personal
4. `/etc/codex/skills` - System admin
5. Bundled skills

## Alternative: Use Community Installer

If this skill is published to the skills catalog:

```bash
# Inside Codex CLI
$skill-installer raindrop
```

## Verify Installation

Trigger the skill by asking:
```
List my Raindrop bookmarks
```

Or check available skills in Codex.

## Configuration

Codex config lives at `~/.codex/config.toml`. No changes needed for skills - they're auto-discovered.

Optional MCP server config:
```toml
[mcp.raindrop]
command = "path/to/raindrop-mcp-server"
```

## Troubleshooting

**Skill not loading:**
- Check path exists: `ls ~/.codex/skills/raindrop/SKILL.md`
- Verify YAML frontmatter is valid
- Directory name must match skill `name` field

**Script errors:**
```bash
chmod +x ~/.codex/skills/raindrop/scripts/raindrop.sh
```

**Environment variable:**
```bash
# Ensure RAINDROP_TOKEN is set
export RAINDROP_TOKEN="your_token"
```

## Differences from Claude Code

| Feature | Claude Code | Codex |
|---------|-------------|-------|
| User skills | `~/.claude/skills/` | `~/.codex/skills/` |
| Project skills | `.claude/skills/` | `.codex/skills/` |
| Config file | `settings.json` | `config.toml` |
| Format | Same SKILL.md | Same SKILL.md |
