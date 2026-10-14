#!/usr/bin/env bash
# Install, check and update the third-party libraries listed in libraries.txt.
#
#   ./update_libraries.sh install        clone any missing library and check
#                                        out its pinned commit
#   ./update_libraries.sh check          (default) report each library's state
#                                        and how far it is behind upstream
#   ./update_libraries.sh update [name]  move a library (or all) to the latest
#                                        upstream commit and re-pin it
#
# Each library is a git checkout in library/<name>, pinned to a commit so the
# models render the same until you choose to update. After an update, re-run
# the verification workflow in AGENTS.md: a library change can alter geometry.

set -euo pipefail

dir=$(cd "$(dirname "$0")" && pwd)
manifest="$dir/libraries.txt"
cmd=${1:-check}
only=${2:-}

entries() { grep -vE '^\s*(#|$)' "$manifest"; }

pin() {  # pin <name> <commit>: rewrite that library's pinned commit
    awk -v n="$1" -v c="$2" \
        '$1 == n { printf "%-6s %s  %s  %s\n", $1, $2, $3, c; next } { print }' \
        "$manifest" > "$manifest.tmp" && mv "$manifest.tmp" "$manifest"
}

install() {  # install <name> <url> <commit>
    local path="$dir/$1"
    if [[ ! -d $path/.git ]]; then
        echo "$1: cloning $2"
        git clone --quiet "$2" "$path"
    fi
    git -C "$path" checkout --quiet "$3" 2>/dev/null || {
        git -C "$path" fetch --quiet origin
        git -C "$path" checkout --quiet "$3"
    }
    echo "$1: at ${3:0:12}"
}

check() {  # check <name> <branch> <commit>
    local path="$dir/$1"
    if [[ ! -d $path/.git ]]; then
        echo "$1: MISSING (run: $0 install)"
        return 1
    fi
    local head; head=$(git -C "$path" rev-parse HEAD)
    local state="ok"
    [[ $head == "$3" ]] || state="NOT AT PIN (at ${head:0:12})"
    [[ -z $(git -C "$path" status --porcelain) ]] || state="$state, LOCAL CHANGES"
    if git -C "$path" fetch --quiet origin "$2" 2>/dev/null; then
        local behind; behind=$(git -C "$path" rev-list --count "$3..FETCH_HEAD")
        echo "$1: pinned ${3:0:12}, $state, $behind commits behind origin/$2"
    else
        echo "$1: pinned ${3:0:12}, $state (couldn't reach upstream)"
    fi
    [[ $state == ok ]]
}

update() {  # update <name> <branch> <commit>
    local path="$dir/$1"
    [[ -d $path/.git ]] || { echo "$1: MISSING (run: $0 install)"; return 1; }
    git -C "$path" fetch --quiet origin "$2"
    local new; new=$(git -C "$path" rev-parse FETCH_HEAD)
    if [[ $new == "$3" ]]; then
        echo "$1: already up to date at ${3:0:12}"
        return
    fi
    echo "$1: ${3:0:12} -> ${new:0:12}"
    git -C "$path" log --oneline "$3..$new" | head -20
    git -C "$path" checkout --quiet "$new"
    pin "$1" "$new"
    echo "$1: re-pinned. Re-run the AGENTS.md verification workflow."
}

status=0
while read -r name url branch commit; do
    [[ -z $only || $only == "$name" ]] || continue
    case $cmd in
        install) install "$name" "$url" "$commit" || status=1 ;;
        check)   check "$name" "$branch" "$commit" || status=1 ;;
        update)  update "$name" "$branch" "$commit" || status=1 ;;
        *) echo "usage: $0 [install|check|update [name]]" >&2; exit 2 ;;
    esac
done < <(entries)
exit $status
