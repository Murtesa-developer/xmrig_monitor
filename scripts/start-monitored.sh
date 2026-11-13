#!/usr/bin/env bash
# Start XMRig with the HTTP API enabled so the XMRig Monitor app can connect.
#
#   XMRIG_POOL=pool.example.com:3333 XMRIG_USER=<wallet> XMRIG_TOKEN=$(openssl rand -hex 16) \
#     ./scripts/start-monitored.sh
#
# Optional environment variables:
#   XMRIG_BIN            path to the xmrig binary          (default ./build/xmrig)
#   XMRIG_PASS           pool password                      (default x)
#   XMRIG_ALGO           algorithm, e.g. rx/0               (default: XMRig decides)
#   XMRIG_HTTP_HOST      API bind address                   (default 127.0.0.1; use LAN IP or 0.0.0.0 for a phone)
#   XMRIG_HTTP_PORT      API port                           (default 44444)
#   XMRIG_ALLOW_CONFIG   1 = let the app change the config  (adds --http-no-restricted)
#   XMRIG_LOW_RESOURCE   1 = 1 thread, idle priority, light RandomX mode, pause while you use the PC
# Any extra arguments are passed to xmrig unchanged.
set -euo pipefail

XMRIG_BIN="${XMRIG_BIN:-./build/xmrig}"
: "${XMRIG_POOL:?Set XMRIG_POOL, e.g. pool.example.com:3333}"
: "${XMRIG_USER:?Set XMRIG_USER to your wallet address}"
: "${XMRIG_TOKEN:?Set XMRIG_TOKEN to a long random secret (openssl rand -hex 16)}"

args=(
  --url="$XMRIG_POOL"
  --user="$XMRIG_USER"
  --pass="${XMRIG_PASS:-x}"
  --http-host="${XMRIG_HTTP_HOST:-127.0.0.1}"
  --http-port="${XMRIG_HTTP_PORT:-44444}"
  --http-access-token="$XMRIG_TOKEN"
)
[[ -n "${XMRIG_ALGO:-}" ]] && args+=(--algo="$XMRIG_ALGO")
[[ "${XMRIG_ALLOW_CONFIG:-0}" == "1" ]] && args+=(--http-no-restricted)
if [[ "${XMRIG_LOW_RESOURCE:-0}" == "1" ]]; then
  args+=(--threads=1 --cpu-priority=0 --randomx-mode=light --pause-on-active=60)
fi

exec "$XMRIG_BIN" "${args[@]}" "$@"
