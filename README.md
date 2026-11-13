# XMRig fork with monitoring scripts

> **Unofficial fork of [xmrig/xmrig](https://github.com/xmrig/xmrig).** The miner source code is unchanged.
> Not affiliated with or endorsed by the XMRig authors. Licensed under **GPL-3.0** (see [`LICENSE`](LICENSE)).

XMRig is an open-source, cross-platform CPU/GPU miner that supports the RandomX, KawPow, CryptoNight and
GhostRider algorithms, and includes a RandomX benchmark. This repository is a copy of it, plus a few
ready-made files that make it easy to watch and manage your miners from the
**[XMRig Monitor](https://github.com/YOUR-USERNAME/xmrig-monitor)** app (Android, iOS, web, Windows, macOS, Linux).

## What this fork adds

| File | Purpose |
|---|---|
| [`scripts/start-monitored.sh`](scripts/start-monitored.sh) | Starts XMRig with the HTTP API enabled, using environment variables (no secrets in files). |
| [`doc/MONITOR_APP.md`](doc/MONITOR_APP.md) | How to connect XMRig to the monitor app, flags, troubleshooting. |
| [`FORK_NOTICE.md`](FORK_NOTICE.md) | Exactly what differs from upstream. |
| [`TERMS.md`](TERMS.md), [`PRIVACY.md`](PRIVACY.md) | Terms of use and privacy notes for this repository. |
| [`README.upstream.md`](README.upstream.md) | The original XMRig README, kept for attribution. |

Everything else is upstream XMRig. For miner bugs and features, use the
[upstream project](https://github.com/xmrig/xmrig).

## Quick start (Linux)

**1. Build**

```bash
sudo apt install -y build-essential cmake libuv1-dev libssl-dev libhwloc-dev
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j"$(nproc)"
cd ..
```

Other systems and options: the [upstream build guide](https://xmrig.com/docs/miner/build).

**2. Run with the monitoring API on**

```bash
XMRIG_POOL=<POOL_HOST>:<POOL_PORT> \
XMRIG_USER=<YOUR_WALLET_ADDRESS> \
XMRIG_TOKEN="$(openssl rand -hex 16)" \
  ./scripts/start-monitored.sh
```

Optional settings (all environment variables):

| Variable | Effect |
|---|---|
| `XMRIG_HTTP_HOST` | API address. Default `127.0.0.1`; use your LAN IP to monitor from a phone. |
| `XMRIG_HTTP_PORT` | API port, default `44444`. |
| `XMRIG_ALLOW_CONFIG=1` | Lets the app change the config (`--http-no-restricted`). |
| `XMRIG_LOW_RESOURCE=1` | 1 thread, idle priority, light RandomX mode, pauses while you use the computer. |
| `XMRIG_ALGO` | Force an algorithm, e.g. `rx/0`. |
| `XMRIG_BIN` | Path to the xmrig binary (default `./build/xmrig`). |

**3. Connect the app** — add a node with your machine's IP, port `44444` and the token you generated.
Details: [`doc/MONITOR_APP.md`](doc/MONITOR_APP.md).

## Mining backends (from upstream)

- **CPU** — x86/x64, ARMv7/ARMv8, RISC-V
- **OpenCL** — AMD GPUs
- **CUDA** — NVIDIA GPUs through the external [CUDA plugin](https://github.com/xmrig/xmrig-cuda)

Configuration reference: [JSON config](https://xmrig.com/docs/miner/config),
[command-line options](https://xmrig.com/docs/miner/command-line-options),
[HTTP API](https://xmrig.com/docs/miner/api).

## Security

- Never expose the HTTP API port to the internet. Use a trusted LAN, a VPN, or a TLS reverse proxy.
- Always set `--http-access-token` to a long random value.
- Only use `--http-no-restricted` if you want to change the config remotely.
- Mine only on hardware and networks you own or have permission to use.

## Donations to upstream

Like upstream, XMRig mines for its developers a small share of the time by default
(`donate-level`, `1` in `src/config.json`). This fork keeps that default. See the
[upstream README](README.upstream.md) for details.

## Credits

XMRig is developed by [xmrig](https://github.com/xmrig) and [sech1](https://github.com/SChernykh).
All credit for the miner goes to them. This fork is maintained by **Murtesa Developer**.

## License and disclaimer

[GPL-3.0](LICENSE). The original license text and copyright notices are unchanged. If you distribute
binaries built from this repository, the GPL requires you to also make the corresponding source code
available. Provided "as is", without warranty — **Murtesa Developer is not responsible for anything that
happens from using this software** (see [`TERMS.md`](TERMS.md)).
