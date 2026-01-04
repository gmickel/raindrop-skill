#!/usr/bin/env bash
# Raindrop.io API helper
# Usage: raindrop.sh <METHOD> <ENDPOINT> [JSON_BODY]
#
# Examples:
#   raindrop.sh GET /collections
#   raindrop.sh GET '/raindrops/0?search=keyword'
#   raindrop.sh POST /raindrop '{"link":"https://example.com","pleaseParse":{}}'
#   raindrop.sh PUT /raindrop/123 '{"tags":["new"]}'
#   raindrop.sh DELETE /raindrop/123

set -euo pipefail

BASE_URL="https://api.raindrop.io/rest/v1"

if [[ -z "${RAINDROP_TOKEN:-}" ]]; then
    echo "Error: RAINDROP_TOKEN not set" >&2
    echo "Get token from: https://app.raindrop.io/settings/integrations" >&2
    echo "Then: export RAINDROP_TOKEN='your_token'" >&2
    exit 1
fi

if [[ $# -lt 2 ]]; then
    echo "Usage: raindrop.sh <METHOD> <ENDPOINT> [JSON_BODY]" >&2
    echo "Example: raindrop.sh GET /collections" >&2
    exit 1
fi

METHOD=$(echo "$1" | tr '[:lower:]' '[:upper:]')
ENDPOINT="$2"
BODY="${3:-}"

# Build curl args
CURL_ARGS=(
    -s
    -X "$METHOD"
    "${BASE_URL}${ENDPOINT}"
    -H "Authorization: Bearer $RAINDROP_TOKEN"
    -H "Content-Type: application/json"
)

if [[ -n "$BODY" ]]; then
    CURL_ARGS+=(-d "$BODY")
fi

# Execute and pretty-print if jq available
if command -v jq &>/dev/null; then
    curl "${CURL_ARGS[@]}" | jq .
else
    curl "${CURL_ARGS[@]}"
    echo  # newline
fi
