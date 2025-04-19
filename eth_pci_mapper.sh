#!/bin/bash

# -----------------------------------------------------------------------------
# eth_pci_mapper.sh
#
# Description:
#   Maps all detected network interfaces (physical or virtual) into a Markdown
#   table, including:
#     - Interface name (eth0, enp1s0, docker0, vethX, etc.)
#     - MAC address
#     - PCI address (or "N/A" for virtual interfaces)
#     - Description (from lspci or classified fallback)
#
# Outputs:
#   - eth_pci_mapping.md : Markdown table of results
#   - eth_pci_mapper.log : Timestamped log of detections and warnings
#
# Environment Support:
#    Linux (XCP-ng, Ubuntu, RHEL, Proxmox, etc.)
#    Not supported on FreeBSD/OPNsense — this is detected and logged
#
# Contributor Notes:
#   - Use POSIX-safe Bash only
#   - Interface names and types are parsed using /sys/class/net and name patterns
#   - PCI info is retrieved from uevent and passed to lspci
#   - Unknown/virtual NICs are labeled and logged
#   - Extend via the 'case' block for more interface types (e.g. wlan*, usb*)
#
# License: See LICENSE.txt (dual-use: free with attribution for personal use)
# Author: Joshua Porrata — RP Digital Consulting LLC
# -----------------------------------------------------------------------------

OUTPUT_FILE="eth_pci_mapping.md"
LOG_FILE="eth_pci_mapper.log"

# Check OS type and exit if not Linux (e.g., FreeBSD/OPNsense)
OS_TYPE=$(uname -s)
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
if [[ "$OS_TYPE" != "Linux" ]]; then
    echo "[$timestamp] ERROR: Unsupported OS ($OS_TYPE). Only Linux is supported." >> "$LOG_FILE"
    echo "This script only runs on Linux systems (detected: $OS_TYPE). Exiting."
    exit 1
fi

# Begin Markdown table output
echo "| Interface | MAC Address       | PCI Address    | Description |" > "$OUTPUT_FILE"
echo "|-----------|-------------------|----------------|-------------|" >> "$OUTPUT_FILE"
echo "[$timestamp] --- Starting interface scan ---" >> "$LOG_FILE"

# Loop through all network interfaces detected by the kernel
for iface_path in /sys/class/net/*; do
    iface_name=$(basename "$iface_path")

    # Skip loopback interface (lo) — it has no physical relevance
    [[ "$iface_name" == "lo" ]] && continue

    # Get MAC address from system file
    MAC_ADDR=$(cat "$iface_path/address" 2>/dev/null)
    PCI_ADDR=""
    DEVICE_DESC="Unknown device"

    # Try to extract PCI slot name (only present on real PCI devices)
    if [[ -f "$iface_path/device/uevent" ]]; then
        PCI_ADDR=$(grep PCI_SLOT_NAME "$iface_path/device/uevent" 2>/dev/null | cut -d'=' -f2)
    fi

    # Handle PCI-backed interfaces with lspci lookup
    if [[ -n "$PCI_ADDR" ]]; then
        DEVICE_DESC=$(lspci -s "$PCI_ADDR" 2>/dev/null | cut -d':' -f3- | sed 's/^ //' )
        if [[ -z "$DEVICE_DESC" ]]; then
            DEVICE_DESC="Unknown PCI device"
            echo "[$timestamp] WARN: lspci returned no result for $iface_name ($PCI_ADDR)" >> "$LOG_FILE"
        fi

    else
        # Virtual or abstracted interface — no PCI address
        PCI_ADDR="N/A"

        # Classify based on known naming conventions
        case "$iface_name" in
            docker*)  DEVICE_DESC="Docker bridge interface" ;;
            veth*)    DEVICE_DESC="Docker/Podman virtual interface" ;;
            br*)      DEVICE_DESC="Linux bridge interface" ;;
            tap*)     DEVICE_DESC="TAP interface (VM/KVM)" ;;
            *)        DEVICE_DESC="Non-PCI or virtual interface" ;;
        esac

        echo "[$timestamp] INFO: Detected $iface_name as $DEVICE_DESC" >> "$LOG_FILE"
    fi

    # Append to Markdown output table
    echo "| $iface_name | $MAC_ADDR | $PCI_ADDR | $DEVICE_DESC |" >> "$OUTPUT_FILE"
done

timestamp=$(date '+%Y-%m-%d %H:%M:%S')
echo "[$timestamp] --- Scan complete. Output written to $OUTPUT_FILE ---" >> "$LOG_FILE"
echo "Mapping completed. Results saved in $OUTPUT_FILE"
