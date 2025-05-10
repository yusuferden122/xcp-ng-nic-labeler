# 🖥️ XCP-ng NIC Labeler

![GitHub Repo stars](https://img.shields.io/github/stars/yusuferden122/xcp-ng-nic-labeler?style=social)
![GitHub Release](https://img.shields.io/github/v/release/yusuferden122/xcp-ng-nic-labeler)
![GitHub Issues](https://img.shields.io/github/issues/yusuferden122/xcp-ng-nic-labeler)

A utility for mapping NICs on XCP-ng systems by interface, MAC, PCI address, and device description. This tool is ideal for passthrough, labeling, and organizing homelab hardware.

## Table of Contents

- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Contact](#contact)

## Features

- **Easy Mapping**: Quickly identify NICs by interface, MAC, and PCI address.
- **Device Descriptions**: Get clear descriptions for each device.
- **Passthrough Support**: Streamline passthrough configurations.
- **Homelab Organization**: Keep your hardware neatly organized.
- **Cross-Platform Compatibility**: Works on any system running XCP-ng.

## Installation

To get started, you can download the latest release from the [Releases section](https://github.com/yusuferden122/xcp-ng-nic-labeler/releases). Download the appropriate file for your system, then execute it as follows:

```bash
chmod +x xcp-ng-nic-labeler
./xcp-ng-nic-labeler
```

## Usage

After installation, you can run the utility to start mapping your NICs. Here’s a basic command to get you started:

```bash
./xcp-ng-nic-labeler --help
```

This command will show you all available options. For instance, you can specify the output format or filter by device type.

### Example Commands

1. **List All NICs**:
   ```bash
   ./xcp-ng-nic-labeler list
   ```

2. **Filter by MAC Address**:
   ```bash
   ./xcp-ng-nic-labeler --mac 00:1A:2B:3C:4D:5E
   ```

3. **Generate a Report**:
   ```bash
   ./xcp-ng-nic-labeler --report
   ```

## Contributing

We welcome contributions! If you want to help improve this project, please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contact

For questions or feedback, feel free to reach out. You can also check the [Releases section](https://github.com/yusuferden122/xcp-ng-nic-labeler/releases) for updates and new features.

---

Thank you for using XCP-ng NIC Labeler! We hope it helps you manage your networking hardware efficiently. Happy labeling! 🎉