# Privacy (this repository)

Maintained by Murtesa Developer. Last updated: 12 November 2026.

- **The files added here** (`scripts/start-monitored.sh`, `doc/MONITOR_APP.md`, these notices) collect,
  store and send no data. The start script only reads environment variables you set and passes them to XMRig.
- **XMRig itself** connects to the mining pool you configure and sends the wallet address, worker name and
  shares your configuration tells it to. By default XMRig also mines for its developers a small share of the
  time (`donate-level`, `1` in `src/config.json`). See the upstream project for details. This repository does
  not add any analytics or telemetry.
- **The HTTP API** is off unless you enable it. When enabled it serves your miner’s status (and, with
  `--http-no-restricted`, its configuration) to anyone who can reach the port and has the access token. Keep it
  on a trusted network and never expose it to the internet.
- **Your secrets** (wallet address, pool password, access token) live in your own config or environment.
  Do not commit them to a repository.
- Murtesa Developer is not responsible for data exposed through a compromised device, an unsafe network or a
  misconfigured miner (see `TERMS.md`).
