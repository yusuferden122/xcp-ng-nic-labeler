# Example Output: XCP-ng 8.3 on Qotom Q20352G9

This is a sample output from running `eth_pci_mapper.sh` on a Qotom Q20352G9 appliance running XCP-ng 8.3. The output is
saved to `eth_pci_mapping.md` by default.

```markdown
| Interface | MAC Address       | PCI Address  | Description                                                     |
| --------- | ----------------- | ------------ | --------------------------------------------------------------- |
| eth1      | de:ad:be:ef:01:01 | 0000:0b:00.1 | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth2      | de:ad:be:ef:01:02 | 0000:0d:00.0 | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth3      | de:ad:be:ef:01:03 | 0000:0d:00.1 | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
| eth4      | de:ad:be:ef:01:04 | 0000:04:00.0 | Intel Corporation Ethernet Controller I226-V (rev 04)           |
| eth5      | de:ad:be:ef:01:05 | 0000:05:00.0 | Intel Corporation Ethernet Controller I226-V (rev 04)           |
| eth6      | de:ad:be:ef:01:06 | 0000:06:00.0 | Intel Corporation Ethernet Controller I226-V (rev 04)           |
| eth7      | de:ad:be:ef:01:07 | 0000:07:00.0 | Intel Corporation Ethernet Controller I226-V (rev 04)           |
| eth8      | de:ad:be:ef:01:08 | 0000:08:00.0 | Intel Corporation Ethernet Controller I226-V (rev 04)           |
| eth9      | de:ad:be:ef:01:09 | 0000:0b:00.0 | Intel Corporation Ethernet Connection X553 10 GbE SFP+ (rev 11) |
```

To generate this table on your system:

```bash
./eth_pci_mapper.sh
cat eth_pci_mapping.md
```

You can then use the table to plan passthrough, build labels, or document your rack.

_Note: The MAC addresses shown here are randomized example values and do not reflect real hardware._
