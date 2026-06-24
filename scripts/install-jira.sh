#!/bin/sh
set -e

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "${script_dir}/lib.sh"

VERSION="${VERSION:-1.7.0}"

if command -v jira >/dev/null 2>&1 && \
	jira version 2>/dev/null | grep -q "\"${VERSION}\""
then
	exit 0
fi

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

os=$(uname | tr '[:upper:]' '[:lower:]')
arch="$(uname -m | sed 's/aarch64/arm64/')"
pkg="jira_${VERSION}_${os}_${arch}.tar.gz"
url="https://github.com/ankitpokhrel/jira-cli/releases/download/v${VERSION}/${pkg}"

curl -fsSL "$url" -o "$tmp/jira.tar.gz"
tar -xzf "$tmp/jira.tar.gz" -C "$tmp"
cp "$tmp"/jira_*/bin/jira "$XDG_BIN_HOME/jira"
chmod 755 "$XDG_BIN_HOME/jira"

"$XDG_BIN_HOME/jira" completion bash > "${tmp}/jira.bash"
sudo mv "${tmp}/jira.bash" /etc/bash_completion.d/jira

copy_file "${script_dir}/../src/.config/.jira/jira.sh" ${XDG_CONFIG_HOME}/.jira/jira.sh
