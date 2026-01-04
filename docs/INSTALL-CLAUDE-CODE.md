# Installing in Claude Code

## User-Level Installation

Applies to all your projects.

```bash
# Clone or copy to user skills directory
cp -r /path/to/raindrop-skill ~/.claude/skills/raindrop

# Or clone directly
git clone https://github.com/YOUR_USER/raindrop-skill ~/.claude/skills/raindrop
```

**Location**: `~/.claude/skills/raindrop/SKILL.md`

## Project-Level Installation

Applies only to a specific repository. Team members get the skill when they clone.

```bash
# In your project root
mkdir -p .claude/skills
cp -r /path/to/raindrop-skill .claude/skills/raindrop

# Commit to share with team
git add .claude/skills/raindrop
git commit -m "Add raindrop skill"
```

**Location**: `.claude/skills/raindrop/SKILL.md`

## Precedence

If same skill exists in multiple locations:

1. Enterprise (org-wide) - highest
2. Personal (`~/.claude/skills/`)
3. Project (`.claude/skills/`)
4. Plugin - lowest

## Verify Installation

Ask Claude Code:
```
What skills are available?
```

Or trigger the skill:
```
List my Raindrop collections
```

## How Skills Work

1. **Discovery**: At startup, Claude loads skill names + descriptions
2. **Activation**: When request matches description keywords, Claude asks to use skill
3. **Execution**: Full SKILL.md loads into context

Skills are **model-invoked** - Claude decides when to use them based on keywords in your request (raindrop, bookmarks, etc).

## Troubleshooting

**Skill not found:**
- Check path: `ls ~/.claude/skills/raindrop/SKILL.md`
- Verify YAML frontmatter syntax
- Restart Claude Code

**Script permission denied:**
```bash
chmod +x ~/.claude/skills/raindrop/scripts/raindrop.sh
```

**Token not set:**
```bash
# Check if set
echo $RAINDROP_TOKEN

# Add to shell config if missing
echo 'export RAINDROP_TOKEN="your_token"' >> ~/.zshrc.local
source ~/.zshrc
```

## Updating

```bash
# User-level
cd ~/.claude/skills/raindrop && git pull

# Project-level
cd .claude/skills/raindrop && git pull
```
