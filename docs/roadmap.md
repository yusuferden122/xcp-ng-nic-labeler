# Project Roadmap

This document outlines the near-term goals and long-term vision for **xcp-ng-nic-labeler**.

The project is stable for personal use and production documentation as of v1.0.1. Future enhancements focus on improved
output formats, advanced interface detection, and deeper support across edge platforms.

---

## ✅ Completed (v1.0.0 – v1.0.1)

- [x] Output in clean Markdown format
- [x] Detect PCI NICs and retrieve `lspci` description
- [x] Graceful fallback for virtual-only NICs (VMs, containers)
- [x] Label `docker*`, `veth*`, `br*`, `tap*` interfaces
- [x] Log detection with timestamps (`eth_pci_mapper.log`)
- [x] Documented contribution flow and interface classification
- [x] OS guard to block unsupported platforms (e.g., OPNsense)

---

## 🛠️ Planned for v1.1.0

- [ ] Add optional CSV output (`--csv`)
- [ ] Add optional JSON output (`--json`)
- [ ] Include NIC **state** (up/down)
- [ ] Include **driver** name (`ethtool -i $iface`)
- [ ] Flag NICs in **bonded** or **teamed** configurations
- [ ] Label `wlan*` as Wi-Fi interfaces with appropriate notes
- [ ] Label `usb*` or USB Ethernet devices (fallback when PCI missing)
- [ ] Add CLI option for **virtual-only** export (`--virtual-only`)
- [ ] Add CLI option for **physical-only** export (`--pci-only`)

---

## 🔭 Future Considerations

- [ ] BSD/OPNsense-specific rewrite using `ifconfig -v` and `pciconf`
- [ ] Optional `udevadm` integration for better hardware metadata (Linux only)
- [ ] Output Markdown to a filename based on hostname + date
- [ ] Generate pre-formatted Nimbot label text for each NIC
- [ ] Package as a container for network asset scanning
- [ ] Auto-sync to remote GitHub Gist or private repo for documentation tracking

---

## 📬 Feature Suggestions

Please open a GitHub Issue to propose new features, report platform results, or suggest format improvements. Include:

- The OS/platform you're using
- A short description of the feature
- Example output, if possible

We're actively accepting PRs for:

- Output format improvements
- Interface type detection
- Platform-specific workarounds
- Label generation ideas

---
