# Raindrop.io Agent Skill

> Manage your [Raindrop.io](https://raindrop.io) bookmarks with AI assistants.

Save links, organize collections, search bookmarks, add highlights—all through natural language.

## Features

- **Bookmarks** — Create, search, update, bulk edit, import/export
- **Collections** — Organize, nest, share with collaborators
- **Tags** — Add, rename, merge across bookmarks
- **Highlights** — Save annotated snippets with colors
- **Multi-client** — Works with Claude Code, Codex, Amp, OpenCode

---

## Quick Start

```bash
# 1. Get token from Raindrop
#    https://app.raindrop.io/settings/integrations
#    → Create app → Create test token

# 2. Add to shell
echo 'export RAINDROP_TOKEN="your_token"' >> ~/.zshrc.local
source ~/.zshrc

# 3. Install (Claude Code / Amp / OpenCode)
git clone https://github.com/gmickel/raindrop-skill ~/.claude/skills/raindrop

# 3. Install (Codex)
git clone https://github.com/gmickel/raindrop-skill ~/.codex/skills/raindrop

# 4. Use it
"Save this article to my Reading collection"
"Search my bookmarks for React hooks"
"List all tags in my Dev collection"
```

---

## Setup

### 1. Create Raindrop App

1. Go to [app.raindrop.io/settings/integrations](https://app.raindrop.io/settings/integrations)
2. Click **Create new app**
3. Fill in:
   - **Name**: `AI Assistant` (or anything)
   - **Redirect URI**: `http://localhost` (required, not used)
4. Click **Create**

### 2. Get Test Token

1. Open your app settings
2. Click **Create test token**
3. Copy the token

### 3. Configure Shell

```bash
# Add to ~/.zshrc.local or ~/.bashrc
export RAINDROP_TOKEN="your_test_token_here"
```

### 4. Verify

```bash
curl -s "https://api.raindrop.io/rest/v1/user" \
  -H "Authorization: Bearer $RAINDROP_TOKEN" | jq .fullName
```

### Why Test Tokens?

We use Raindrop's test token + environment variable approach because:

- **Standard pattern** — Same as `GH_TOKEN`, `ANTHROPIC_API_KEY`, etc.
- **No expiration** — Test tokens are permanent (OAuth tokens expire in 2 weeks)
- **No OAuth dance** — No redirect URI, no token refresh logic
- **Subprocess-friendly** — Env vars are inherited by agents and scripts

For personal/CLI use, this is the accepted approach. Store in `.zshrc.local` (not committed to dotfiles) and you're set.

> **Want more security?** Use 1Password CLI or macOS Keychain:
> ```bash
> export RAINDROP_TOKEN=$(op read "op://Private/Raindrop/token")
> ```

---

## Installation

### Claude Code

```bash
# User-level (all projects)
git clone https://github.com/gmickel/raindrop-skill ~/.claude/skills/raindrop

# Project-level (single repo)
git clone https://github.com/gmickel/raindrop-skill .claude/skills/raindrop
```

### Codex CLI

```bash
# User-level
git clone https://github.com/gmickel/raindrop-skill ~/.codex/skills/raindrop

# Project-level
git clone https://github.com/gmickel/raindrop-skill .codex/skills/raindrop
```

### Amp / OpenCode

Both fall back to `.claude/skills/`:

```bash
git clone https://github.com/gmickel/raindrop-skill ~/.claude/skills/raindrop
```

See [docs/](docs/) for detailed installation guides.

---

## Usage Examples

Once installed, just ask:

| Task | Example |
|------|---------|
| Save link | "Save https://example.com to my Dev collection" |
| Search | "Find bookmarks about TypeScript" |
| List | "Show my collections" |
| Tag | "Add #reading tag to my last 5 bookmarks" |
| Highlight | "Show highlights from my Research collection" |
| Export | "Export my bookmarks as CSV" |

---

## Files

```
raindrop-skill/
├── SKILL.md              # Main skill instructions
├── scripts/
│   └── raindrop.sh       # API helper
├── references/
│   └── API-REFERENCE.md  # Complete API docs
└── docs/
    ├── INSTALL-CLAUDE-CODE.md
    ├── INSTALL-CODEX.md
    └── INSTALL-OTHER-CLIENTS.md
```

---

## API Coverage

| Resource | Operations |
|----------|------------|
| Raindrops | CRUD, search, bulk ops, file upload |
| Collections | CRUD, nesting, sharing, covers |
| Highlights | Create, update, delete with 12 colors |
| Tags | List, rename, merge, delete |
| Import/Export | HTML, CSV, ZIP, URL parsing |
| Backups | List, download, generate |

Full reference: [API-REFERENCE.md](references/API-REFERENCE.md)

---

## License

MIT
