# Raindrop.io API Reference

Complete endpoint documentation for Raindrop.io REST API v1.

## Authentication

### OAuth2 Flow

1. **Authorize**: `GET https://raindrop.io/oauth/authorize?client_id=...&redirect_uri=...`
2. **Token Exchange**: `POST https://raindrop.io/oauth/access_token`
   ```json
   {
     "grant_type": "authorization_code",
     "code": "<code>",
     "client_id": "<client_id>",
     "client_secret": "<client_secret>",
     "redirect_uri": "<redirect_uri>"
   }
   ```
3. **Response**:
   ```json
   {
     "access_token": "...",
     "refresh_token": "...",
     "expires_in": 1209599,
     "token_type": "Bearer"
   }
   ```

### Token Refresh

```json
{
  "grant_type": "refresh_token",
  "client_id": "<client_id>",
  "client_secret": "<client_secret>",
  "refresh_token": "<refresh_token>"
}
```

Tokens expire after 2 weeks. Test tokens don't expire.

---

## Collections

### Object Fields

| Field | Type | Description |
|-------|------|-------------|
| `_id` | Integer | Collection ID |
| `title` | String | Name |
| `count` | Integer | Raindrop count |
| `cover` | Array | Cover URL(s) |
| `color` | String | HEX color |
| `public` | Boolean | Public visibility |
| `expanded` | Boolean | Sub-collections expanded |
| `view` | String | `list`, `simple`, `grid`, `masonry` |
| `sort` | Integer | Sort order (descending) |
| `parent.$id` | Integer | Parent collection ID |
| `access.level` | Integer | 1=read, 2=read collab, 3=write collab, 4=owner |
| `created` | String | ISO 8601 timestamp |
| `lastUpdate` | String | ISO 8601 timestamp |

### Endpoints

#### GET /collections
Get root collections.

#### GET /collections/childrens
Get nested collections.

#### GET /collection/{id}
Get single collection.

#### POST /collection
Create collection.

```json
{
  "title": "Name",
  "public": false,
  "parent": {"$id": 123},
  "view": "list",
  "cover": ["url"]
}
```

#### PUT /collection/{id}
Update collection.

#### DELETE /collection/{id}
Remove collection (moves raindrops to trash).

#### PUT /collection/{id}/cover
Upload cover image (multipart/form-data).

#### PUT /collections
Reorder all collections.

```json
{"sort": "title"}
```
Options: `title`, `-title`, `-count`

#### DELETE /collections
Remove multiple collections.

```json
{"ids": [1, 2, 3]}
```

#### PUT /collections/merge
Merge collections.

```json
{"to": 123, "ids": [456, 789]}
```

#### PUT /collections/clean
Remove all empty collections.

### Sharing

#### POST /collection/{id}/sharing
Share collection.

```json
{"role": "member", "emails": ["user@example.com"]}
```
Roles: `member` (write), `viewer` (read-only). Max 10 emails.

#### GET /collection/{id}/sharing
Get collaborators.

#### DELETE /collection/{id}/sharing
Unshare/leave collection.

#### PUT /collection/{id}/sharing/{userId}
Change collaborator role.

#### DELETE /collection/{id}/sharing/{userId}
Remove collaborator.

#### POST /collection/{id}/join
Accept invitation.

```json
{"token": "<invitation_token>"}
```

### Covers/Icons

#### GET /collections/covers/{text}
Search icons by keyword.

#### GET /collections/covers
Get featured covers.

---

## Raindrops

### Object Fields

| Field | Type | Description |
|-------|------|-------------|
| `_id` | Integer | Raindrop ID |
| `link` | String | URL |
| `title` | String | Title (max 1000 chars) |
| `excerpt` | String | Description (max 10000 chars) |
| `note` | String | Notes (max 10000 chars) |
| `type` | String | `link`, `article`, `image`, `video`, `document`, `audio` |
| `tags` | Array | Tag strings |
| `cover` | String | Cover URL |
| `media` | Array | `[{"link": "url"}]` |
| `collection.$id` | Integer | Collection ID |
| `domain` | String | Link hostname |
| `created` | String | ISO 8601 |
| `lastUpdate` | String | ISO 8601 |
| `important` | Boolean | Favorite |
| `broken` | Boolean | Link unreachable |
| `highlights` | Array | Highlight objects |
| `cache.status` | String | `ready`, `retry`, `failed`, etc. |
| `file.name` | String | Uploaded file name |
| `file.size` | Integer | File size bytes |
| `reminder.data` | Date | Reminder datetime |

### Single Raindrop Endpoints

#### GET /raindrop/{id}
Get single raindrop.

#### POST /raindrop
Create raindrop.

```json
{
  "link": "https://example.com",
  "title": "Title",
  "excerpt": "Description",
  "tags": ["tag1", "tag2"],
  "collection": {"$id": 123},
  "pleaseParse": {},
  "important": true
}
```

Use `pleaseParse: {}` to auto-extract metadata.

#### PUT /raindrop/{id}
Update raindrop.

#### DELETE /raindrop/{id}
Remove raindrop (to trash, or permanent if already in trash).

#### PUT /raindrop/file
Upload file as raindrop (multipart/form-data).

Fields:
- `file` - file object
- `collectionId` - target collection

#### PUT /raindrop/{id}/cover
Upload cover (multipart/form-data, PNG/GIF/JPEG).

#### GET /raindrop/{id}/cache
Get permanent copy (PRO only, returns 307 redirect).

#### POST /raindrop/suggest
Suggest collections/tags for new URL.

```json
{"link": "https://example.com"}
```

#### GET /raindrop/{id}/suggest
Suggest for existing raindrop.

### Multiple Raindrops Endpoints

#### GET /raindrops/{collectionId}
List raindrops.

**Query params:**
- `sort`: `-created` (default), `created`, `score`, `-sort`, `title`, `-title`, `domain`, `-domain`
- `perpage`: max 50
- `page`: 0, 1, 2...
- `search`: search query
- `nested`: include nested collections

**Search operators:**
- `#tag` - by tag
- `type:article` - by type
- `domain:example.com` - by domain
- `created:>2024-01-01` - by date
- `important:true` - favorites only

#### POST /raindrops
Create many (max 100).

```json
{"items": [{...}, {...}]}
```

#### PUT /raindrops/{collectionId}
Update many.

```json
{
  "ids": [1, 2, 3],
  "important": true,
  "tags": ["newtag"],
  "collection": {"$id": 456},
  "cover": "<screenshot>"
}
```

#### DELETE /raindrops/{collectionId}
Remove many.

```json
{"ids": [1, 2, 3]}
```

---

## Highlights

### Object Fields

| Field | Type | Description |
|-------|------|-------------|
| `_id` | String | Highlight ID |
| `text` | String | Highlighted text |
| `color` | String | Color name |
| `note` | String | Annotation |
| `created` | String | ISO 8601 |

Colors: `blue`, `brown`, `cyan`, `gray`, `green`, `indigo`, `orange`, `pink`, `purple`, `red`, `teal`, `yellow`

### Endpoints

#### GET /highlights
Get all highlights.

**Query:** `page`, `perpage` (max 50, default 25)

#### GET /highlights/{collectionId}
Get highlights in collection.

#### Add/Update/Remove Highlights

Use `PUT /raindrop/{id}` with highlights array:

**Add:**
```json
{"highlights": [{"text": "...", "color": "yellow", "note": "..."}]}
```

**Update:**
```json
{"highlights": [{"_id": "existingId", "color": "green"}]}
```

**Remove:**
```json
{"highlights": [{"_id": "existingId", "text": ""}]}
```

---

## Tags

### Endpoints

#### GET /tags
Get all tags.

#### GET /tags/{collectionId}
Get tags in collection.

**Response:**
```json
{"result": true, "items": [{"_id": "tagname", "count": 5}]}
```

#### PUT /tags/{collectionId}
Rename or merge tags.

**Rename:**
```json
{"tags": ["oldname"], "replace": "newname"}
```

**Merge:**
```json
{"tags": ["tag1", "tag2"], "replace": "merged"}
```

#### DELETE /tags/{collectionId}
Remove tags.

```json
{"tags": ["tag1", "tag2"]}
```

---

## Filters

#### GET /filters/{collectionId}
Get filter counts.

**Query:**
- `tagsSort`: `-count` or `_id` (alphabetical)
- `search`: filter query

**Response:**
```json
{
  "broken": {"count": 5},
  "duplicates": {"count": 2},
  "important": {"count": 10},
  "notag": {"count": 3},
  "tags": [{"_id": "tag", "count": 5}],
  "types": [{"_id": "article", "count": 10}]
}
```

---

## User

### Object Fields

| Field | Type | Description |
|-------|------|-------------|
| `_id` | Integer | User ID |
| `email` | String | Email (private) |
| `email_MD5` | String | MD5 hash (for Gravatar) |
| `fullName` | String | Display name |
| `pro` | Boolean | PRO subscription |
| `proExpire` | String | PRO expiry date |
| `registered` | String | Registration date |
| `groups` | Array | Collection groups |
| `files.used` | Integer | Space used this month |
| `files.size` | Integer | Total file space |
| `config` | Object | User settings |

### Endpoints

#### GET /user
Get authenticated user.

#### GET /user/{name}
Get public user info.

#### PUT /user
Update user.

```json
{
  "fullName": "New Name",
  "email": "new@email.com",
  "oldpassword": "...",
  "newpassword": "...",
  "config": {...},
  "groups": [...]
}
```

#### GET /user/connect/{provider}
Connect social account (facebook, google, twitter, vkontakte, dropbox, gdrive).

#### GET /user/connect/{provider}/revoke
Disconnect social account.

#### GET /user/stats
Get collection statistics (counts for 0, -1, -99).

---

## Import/Export

### Import

#### GET /import/url/parse?url=...
Parse URL metadata.

#### POST /import/url/exists
Check if URLs exist.

```json
{"urls": ["https://...", "https://..."]}
```

#### POST /import/file
Import HTML bookmarks (multipart/form-data).

Supports Netscape, Pocket, Instapaper formats.

### Export

#### GET /raindrops/{collectionId}/export.{format}
Export raindrops.

Formats: `csv`, `html`, `zip`

**Query:** `sort`, `search`

---

## Backups

#### GET /backups
List all backups (sorted newest first).

```json
{"items": [{"_id": "...", "created": "..."}]}
```

#### GET /backup/{id}.{format}
Download backup (html or csv).

#### GET /backup
Generate new backup (async, email notification when ready).

---

## Rate Limits

- 120 requests/minute per user
- Headers: `X-RateLimit-Limit`, `RateLimit-Remaining`, `X-RateLimit-Reset`
- 429 response when exceeded
