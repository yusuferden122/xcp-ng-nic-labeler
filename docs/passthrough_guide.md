# PCI Passthrough Guide (XCP-ng 8.3)

PCI passthrough allows you to assign a physical device (like a NIC, GPU, or storage controller) directly to a virtual machine. This is commonly used to provide near-native performance or hardware-level network separation.

This guide is specific to **XCP-ng 8.3**, which supports PCI passthrough using the Xen hypervisor with the appropriate BIOS and system configuration.

## Official Documentation

Refer to the official XCP-ng PCI Passthrough documentation for full setup instructions:

- [XCP-ng PCI Passthrough Documentation (8.3)](https://xcp-ng.org/docs/virtualization/pci-passthrough.html)

This covers:

- Verifying IOMMU support
- Enabling VT-d / AMD-Vi in BIOS
- Checking IOMMU groups
- Configuring GRUB and Xen parameters
- Assigning passthrough devices using `xl pci-assignable-add` or via Xen Orchestra

## Using `xcp-ng-nic-labeler` for Passthrough Mapping

Before assigning NICs to a VM, you must:

- Identify the **PCI address** (e.g., `0000:04:00.0`)
- Confirm the **MAC address**
- Avoid assigning the NIC currently used for host management

You can generate a NIC map using:

```bash
./eth_pci_mapper.sh
cat eth_pci_mapping.md
```

### Sample Output

```markdown
| Interface | MAC Address       | PCI Address    | Description                                                |
|-----------|-------------------|----------------|------------------------------------------------------------|
| eth1      | de:ad:be:ef:02:01 | 0000:0b:00.1   | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth2      | de:ad:be:ef:02:02 | 0000:0d:00.0   | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth3      | de:ad:be:ef:02:03 | 0000:0d:00.1   | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth4      | de:ad:be:ef:02:04 | 0000:04:00.0   | Intel Corporation Ethernet Controller I226-V (rev 04)      |
| eth5      | de:ad:be:ef:02:05 | 0000:05:00.0   | Intel Corporation Ethernet Controller I226-V (rev 04)      |
| eth6      | de:ad:be:ef:02:06 | 0000:06:00.0   | Intel Corporation Ethernet Controller I226-V (rev 04)      |
| eth7      | de:ad:be:ef:02:07 | 0000:07:00.0   | Intel Corporation Ethernet Controller I226-V (rev 04)      |
| eth8      | de:ad:be:ef:02:08 | 0000:08:00.0   | Intel Corporation Ethernet Controller I226-V (rev 04)      |
| eth9      | de:ad:be:ef:02:09 | 0000:0b:00.0   | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
```

To generate this table on your system:

```bash
./eth_pci_mapper.sh
cat eth_pci_mapping.md
```

You can then use the table to plan passthrough, build labels, or document your rack.

*Note: The MAC addresses shown here are randomized example values and do not reflect real hardware.*

## Best Practices

- Always leave at least one NIC for the XCP-ng host management interface.
- Group your passthrough NICs by function (e.g., all SFP+, or all LAN ports).
- Confirm isolation of passthrough devices using IOMMU group checks:

  ```bash
  find /sys/kernel/iommu_groups/ -type l
  ```

- Document passthrough assignments in your inventory and/or Markdown outputs.

## Known Limitations

- Not all NICs or chipsets support passthrough equally.
- Some integrated or multifunction chipsets may share IOMMU groups.
- Misconfiguration of passthrough can cause your host to lose network access.

## Troubleshooting Resources

- [XCP-ng Forum - PCI Passthrough](https://xcp-ng.org/forum/search?term=pci+passthrough)
- [Xen Wiki - PCI Passthrough](https://wiki.xenproject.org/wiki/Xen_PCI_Passthrough)

If passthrough fails or the VM fails to boot, check:

- BIOS settings for virtualization and IOMMU
- Xen and GRUB config (usually under `/etc/default/grub`)
- That the device was properly detached from dom0

---

This guide is meant as a companion to official documentation and real-world tools like `xcp-ng-nic-labeler`. For full implementation details, always consult the [XCP-ng docs](https://xcp-ng.org/docs/).

