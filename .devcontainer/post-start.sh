#!/usr/bin/env bash
# Runs on every codespace start: bring up the Flyte devbox cluster if it isn't
# already running. Safe to re-run.
set -euo pipefail

FLYTE_URL="http://localhost:30080"

devbox_up() {
    curl -fs -o /dev/null --max-time 2 "$FLYTE_URL"
}

show_startup_diagnostics() {
    echo "==> Docker containers:" >&2
    docker ps -a >&2 || true
    if docker inspect flyte-devbox >/dev/null 2>&1; then
        echo "==> Recent Flyte devbox logs:" >&2
        docker logs --tail 100 flyte-devbox >&2 || true
    fi
    echo "==> Kubernetes pods:" >&2
    kubectl get pods -A >&2 || true
}

# Port visibility can't be set declaratively in devcontainer.json, so make the
# Flyte port public via the gh CLI when running inside a codespace.
if [ -n "${CODESPACE_NAME:-}" ] && command -v gh >/dev/null 2>&1; then
    echo "==> Making port 30080 public"
    timeout 15s gh codespace ports visibility 30080:public -c "$CODESPACE_NAME" \
        || echo "    (could not set port visibility automatically — set it in the PORTS tab)"
fi

if devbox_up; then
    echo "==> Flyte devbox is already running at $FLYTE_URL"
    exit 0
fi

echo "==> Starting the Flyte devbox (first boot pulls images — this can take a few minutes)"
if timeout --signal=TERM --kill-after=10s 900s flyte start devbox; then
    :
else
    startup_status=$?
    if [ "$startup_status" -eq 124 ]; then
        echo "==> Flyte devbox startup timed out after 15 minutes." >&2
    else
        echo "==> 'flyte start devbox' failed with exit status $startup_status." >&2
    fi
    show_startup_diagnostics
    exit "$startup_status"
fi

echo "==> Waiting for the devbox to become reachable at $FLYTE_URL"
for _ in $(seq 1 120); do
    if devbox_up; then
        echo ""
        echo "==> Flyte devbox is up! 🚀"
        echo "    UI:  open the forwarded port 30080 (PORTS tab in VS Code)"
        echo "    Try: flyte run examples/hello.py main"
        exit 0
    fi
    sleep 5
done

echo "==> Timed out waiting for the devbox. Check status with:" >&2
show_startup_diagnostics
exit 1
