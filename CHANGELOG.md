# Changelog

All notable changes to **xcp-ng-nic-labeler** will be documented in this file.

This project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). New features, breaking changes, or
 enhancements should increment versions accordingly.

---

## [v1.0.1] – 2025-04-19

### Added

- OS detection and guard: script now exits cleanly on unsupported systems (e.g., FreeBSD/OPNsense)
- Classification for virtual NICs:
  - `docker*` → **Docker bridge interface**
  - `veth*` → **Docker/Podman virtual interface**
  - `br*` → **Linux bridge interface**
  - `tap*` → **TAP interface (used in VM/KVM setups)**
  - All others fallback to **Non-PCI or virtual interface**
- Timestamped log file: `eth_pci_mapper.log` records every scan with detection notes
- Inline documentation for contributors and maintainers
- Engineer-facing instructions embedded in `README.md`, `test_matrix.md`, and `eth_pci_mapper.sh`

### Fixed

- Prevented `lspci` from dumping entire PCI tree when PCI address is missing
- Removed silent failures in guest VMs by logging instead of skipping

---

## [v1.0.0] – 2025-04-18

### Initial Release

- Script detects `eth[0-9]+` NICs and maps:
  - Interface name
  - MAC address
  - PCI address
  - `lspci` device description
- Output is saved to `eth_pci_mapping.md` (Markdown format)
- Designed for:
  - XCP-ng 8.3 (host)
  - Qotom / Protectli / physical homelab appliances
- POSIX-compliant, ShellCheck-safe, and suitable for use in minimal Linux environments

---

## Upcoming

Planned for `v1.1.0` and beyond:

- Optional CSV/JSON output (`--csv`, `--json`)
- Interface state detection (`up/down`)
- Support for Wi-Fi interfaces (`wlp*`)
- USB NIC detection and description
- CLI flag for virtual-only output
- BSD-style rewrite or helper for OPNsense/FreeBSD systems
