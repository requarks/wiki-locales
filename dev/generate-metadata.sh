#!/usr/bin/env bash
#
# Writes an array of every *.json file in the current directory together with
# the SHA-256 of its contents to metadata.json.
#
# Usage: ./json-metadata.sh [output-file]   (default: metadata.json)
# Requires: jq, and sha256sum (Linux) or shasum (macOS)

set -euo pipefail

out="${1:-metadata.json}"
out_base="${out##*/}"

# Reading from stdin rather than passing the path keeps the output to a bare
# hash: no filename column, and no `\`-prefixed line that GNU sha256sum emits
# for names containing backslashes or newlines.
if command -v sha256sum >/dev/null 2>&1; then
    hash_of() { sha256sum < "$1" | cut -d' ' -f1; }
elif command -v shasum >/dev/null 2>&1; then
    hash_of() { shasum -a 256 < "$1" | cut -d' ' -f1; }
else
    echo "error: need sha256sum or shasum on PATH" >&2
    exit 1
fi

# Alternative: hash the *canonical* JSON instead of the raw bytes, so that
# reformatting or reordering keys doesn't change the hash. Swap in:
#   hash_of() { jq -S -c . -- "$1" | sha256sum | cut -d' ' -f1; }

shopt -s nullglob   # *.json expands to nothing when there are no matches

# Flat list of file, hash, file, hash, ... passed to jq as positional arguments,
# so no quoting or escaping concerns regardless of the filename.
args=()
for f in *.json; do
    [[ -f "$f" ]] || continue                 # skip directories named *.json
    [[ "$f" == "$out_base" ]] && continue      # don't hash the output file itself
    args+=("$f" "$(hash_of "$f")")
done

tmp="$(mktemp "${TMPDIR:-/tmp}/metadata.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

jq -n '[ range(0; $ARGS.positional | length; 2) as $i
         | { file: $ARGS.positional[$i], hash: $ARGS.positional[$i + 1] } ]' \
   --args "${args[@]}" > "$tmp"

mv "$tmp" "$out"
trap - EXIT

echo "Wrote $(( ${#args[@]} / 2 )) entries to $out" >&2