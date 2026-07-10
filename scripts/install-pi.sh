#!/bin/sh
set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
. "${script_dir}/lib.sh"

: "${PI_CODING_AGENT_DIR:=${XDG_CONFIG_HOME}/pi/agent}"
: "${PI_CODING_AGENT_SESSION_DIR:=${XDG_STATE_HOME}/pi/sessions}"

profile="$HOME/.profile.local"
marker="# >>> pi environment >>>"

if ! grep -qs "$marker" "$profile"; then
    cat >> "$profile" <<'EOF'

# >>> pi environment >>>
export PI_CODING_AGENT_DIR=${XDG_CONFIG_HOME}/pi/agent
export PI_CODING_AGENT_SESSION_DIR=${XDG_STATE_HOME}/pi/sessions
export PI_TELEMETRY=false
# <<< pi environment <<<
EOF
fi

mkdir -p "${XDG_CONFIG_HOME}/pi/agent" "${XDG_STATE_HOME}/pi/sessions"
ln -sfn $(realpath "${HOME}/lib/AGENT.md") "${PI_CODING_AGENT_DIR}/AGENTS.md"

if ! command -v pi >/dev/null 2>&1; then
    curl -fsSL https://pi.dev/install.sh | sh
    hash -r 2>/dev/null || true
fi

if ! command -v pi >/dev/null 2>&1; then
    echo "pi installed but not on PATH in this shell." >&2
    echo "Open a new shell (or add pi's bin dir to PATH) and re-run the installs below." >&2
    exit 1
fi

pi update || echo "warning: pi update failed" >&2

packages="
git:github.com/elpapi42/pi-fork
npm:pi-observational-memory
git:github.com/elpapi42/pi-minimal-subagent
npm:pi-x-ide
npm:context-mode
npm:@pi-stef/atlassian
npm:@piotr-oles/pi-cwd
npm:pi-btw
"

for pkg in $packages; do
    pi install "$pkg" || echo "warning: failed to install $pkg" >&2
done
