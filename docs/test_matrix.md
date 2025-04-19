# Interface Mapping Test Matrix

This document tracks system compatibility, feature coverage, and edge case handling for `xcp-ng-nic-labeler`.

Contributors: Please submit your test results by opening a pull request and editing this table or adding a new section below.

---

## ✅ Test Matrix

| System / OS               | Type       | PCI NICs | Virtual NICs | Docker | Notes                              |
| ------------------------- | ---------- | -------- | ------------ | ------ | ---------------------------------- |
| XCP-ng 8.3 (host)         | Hypervisor | ✅       | N/A          | N/A    | Full PCI mapping with `lspci`      |
| XCP-ng 8.3 (VM: RHEL)     | VM         | ❌       | ✅           | ⬜️    | No PCI info exposed inside guest   |
| XCP-ng 8.3 (VM: Ubuntu)   | VM         | ❌       | ✅           | ✅     | `veth`, `docker0` labeled          |
| Ubuntu 22.04 (bare metal) | Host       | ✅       | ✅           | ✅     | Predictable interface names        |
| Proxmox VE                | Host/VM    | ✅/❌    | ✅           | ✅     | `pciutils` must be installed       |
| Rocky Linux 9.2 (VM)      | VM         | ❌       | ✅           | ✅     | Works with podman networks         |
| OPNsense 23.7             | FreeBSD    | ❌       | ❌           | ❌     | Not supported (FreeBSD)            |
| Protectli FW4B (Linux)    | Appliance  | ✅       | ✅           | ✅     | PCI and physical layout verified   |
| Qotom Q20352G9 (XCP-ng)   | Appliance  | ✅       | N/A          | N/A    | Works as passthrough planning tool |

**Legend:**

- ✅ Supported and tested
- ❌ Not available / not working
- ⬜️ Not tested yet

---

## Submission Format (for PRs)

```markdown
### [Your System Name or Model]

- OS: Ubuntu 20.04.6
- Environment: VM on Proxmox
- `eth_pci_mapper.sh` version: v1.0.1
- Results:
  - ✅ Interface names detected: ens18, docker0, veth1234
  - ✅ PCI address for `ens18`
  - ✅ Description from `lspci`
  - ✅ Log entries created
- Notes: Needed to `apt install pciutils`. Script ran without modification.
```

---

## Known Edge Cases

| Condition               | Status | Notes                                    |
| ----------------------- | ------ | ---------------------------------------- |
| Wi-Fi adapters (`wlp*`) | ⬜️    | Not currently labeled distinctly         |
| USB NICs                | ⬜️    | May show N/A PCI and generic description |
| Bonded NICs             | ⬜️    | Detected, not labeled specially          |
| Virtual tap interfaces  | ✅     | Detected and labeled as TAP              |
| Team interfaces         | ⬜️    | May appear, but not specially labeled    |

---

## Contributing Notes

- Please randomize MACs in shared output
- Mention if output was viewed via `eth_pci_mapping.md` or manually verified
- Attach logs if available (`eth_pci_mapper.log`)
