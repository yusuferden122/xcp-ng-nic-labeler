<!--
Title: xcp-ng-nic-labeler
Description: Map and document physical and virtual network interfaces with PCI, MAC, and device info.
Tags: xcp-ng, networking, bash, pci, passthrough, markdown, docker, homelab, virtualization, sysadmin
-->

# xcp-ng-nic-labeler

[![GitHub release](https://img.shields.io/github/v/release/geekonamotorcycle/xcp-ng-nic-labeler)](https://github.com/geekonamotorcycle/xcp-ng-nic-labeler/releases)

A Bash utility for **XCP-ng 8.3** and Linux systems that maps detected network interfaces to:

- Interface name (e.g. `eth0`, `enp3s0`, `veth1234`, `docker0`)
- MAC address
- PCI bus address (or fallback label)
- Full device description (from `lspci` or classified virtual)

Outputs a clean Markdown table and logs all detections.

---

## Features

- ✅ Detects physical NICs and virtual interfaces (Docker, bridges, etc.)
- ✅ PCI address and `lspci` description for physical NICs
- ✅ Graceful fallback for VMs, containers, or abstract interfaces
- ✅ Markdown-friendly output for documentation or labeling
- ✅ Timestamped logging to `eth_pci_mapper.log`
- ✅ OS check to avoid running on unsupported systems (e.g., OPNsense/FreeBSD)

---

## Use Cases

- Port labeling on appliances (Qotom, Protectli)
- PCI passthrough planning on XCP-ng and Proxmox
- Debugging container bridges and virtual interfaces
- Generating interface mapping docs
- Creating physical labels for NICs

---

## Recommended Labeling Tools

See [`docs/labeling_tips.md`](docs/labeling_tips.md) for layout tips and examples.

We recommend:

- **Label printer:** [Nimbot B1 (Amazon)](https://amzn.to/3RpxfwQ)
- **Tape:** 6mm or 12mm waterproof thermal
- **Label Format:** Grid-style blocks to match device layout

---

## Compatibility

| OS / Platform       | Status           | Notes                                     |
| ------------------- | ---------------- | ----------------------------------------- |
| XCP-ng 8.3 (Host)   | ✅ Supported     | Full physical PCI mapping available       |
| Ubuntu 20.04+       | ✅ Supported     | PCI and virtual detection cleanly handled |
| RHEL / Rocky / Alma | ✅ Supported     | Works in VM and bare metal                |
| Proxmox VE          | ✅ Supported     | Ensure `pciutils` is installed            |
| Docker Hosts        | ✅ Supported     | Labels `docker0`, `veth*`, etc.           |
| OPNsense / FreeBSD  | ❌ Not Supported | OS detection blocks unsupported platforms |

---

## Output Example

```markdown
| Interface | MAC Address       | PCI Address  | Description                     |
| --------- | ----------------- | ------------ | ------------------------------- |
| eth0      | de:ad:be:ef:00:01 | 0000:04:00.0 | Intel Corporation I226-V        |
| veth1234  | ba:dd:c0:ff:ee:11 | N/A          | Docker/Podman virtual interface |
| docker0   | ba:dd:c0:ff:ee:01 | N/A          | Docker bridge interface         |
```

All activity is logged to `eth_pci_mapper.log` for troubleshooting or audit history.

---

## Getting Started

1. Ensure `bash` and `lspci` are available (`pciutils` package)
2. Clone this repo
3. Run the script:

    ```bash
    chmod +x eth_pci_mapper.sh
    ./eth_pci_mapper.sh
    ```

4. Open the output file:

    ```bash
    cat eth_pci_mapping.md
    ```

---

## Engineer Notes

- This script is **POSIX-compliant** and safe for minimal systems
- Interfaces are sourced from `/sys/class/net/*` for reliability
- PCI addresses are resolved from `/device/uevent → PCI_SLOT_NAME`
- If PCI info is missing, fallback logic classifies the interface:
  - `docker*`, `veth*`, `br*`, `tap*` — labeled clearly
  - Everything else marked as **"Non-PCI or virtual interface"**
- Extend support by:
  - Adding interface patterns to the `case` block
  - Updating description logic in the virtual interface section
  - Logging any new virtual types as needed

---

## Folder Structure

```text
xcp-ng-nic-labeler/
├── eth_pci_mapper.sh         # Main detection script
├── eth_pci_mapping.md        # Example output (regenerates each run)
├── eth_pci_mapper.log        # Detection logs with timestamps
├── LICENSE.txt               # Dual-use license
├── README.md                 # This file
├── CHANGELOG.md              # Version history and release notes
├── CONTRIBUTING.md           # Dev/contribution rules
├── docs/
│   ├── passthrough_guide.md  # How to identify NICs to passthrough
│   ├── labeling_tips.md      # Label layout, visual references
│   └── test_matrix.md        # OS compatibility and platform coverage
└── assets/
    ├── 1-Rack-Example-NIIMBOT.png
    ├── 2-Rack-Example-NIIMBOT.png
    └── 3-Rack-Example-NIIMBOT.png
```

---

## License

This project is **free for personal, non-commercial, and educational use** with attribution.

**Commercial use requires a separate license** from the project owner.

To license this tool for professional or consulting use:

**Joshua Porrata**  
**RP Digital Consulting LLC**  
[joshua@rpdigitalconsulting.com](mailto:joshua@rpdigitalconsulting.com)

---

## Contributions Welcome

See [`CONTRIBUTING.md`](CONTRIBUTING.md) for guidelines.

- Test on new platforms (submit `eth_pci_mapping.md`)
- Add new interface types (e.g., `wlan0`, USB NICs)
- Improve formatting or add optional output formats (CSV, JSON)

---

## Changelog

For a full history of additions and improvements, see [`CHANGELOG.md`](CHANGELOG.md).
