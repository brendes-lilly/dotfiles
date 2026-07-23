#!/bin/sh
input=$(cat)

cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd')
home=$HOME
case "$cwd" in
    "$home") short="~" ;;
    "$home"/*) short="~${cwd#"$home"}" ;;
    *) short="$cwd" ;;
esac

branch=$(git -C "$cwd" --git-dir="$(git -C "$cwd" rev-parse --git-dir 2>/dev/null)" \
    rev-parse --abbrev-ref HEAD 2>/dev/null)

model=$(echo "$input" | jq -r '.model.display_name // empty')

if [ -n "$branch" ]; then
    loc="${short}[${branch}]"
else
    loc="$short"
fi

if [ -n "$model" ]; then
    printf '%s  %s' "$loc" "$model"
else
    printf '%s' "$loc"
fi
