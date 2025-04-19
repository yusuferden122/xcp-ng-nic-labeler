# Contributing to xcp-ng-nic-labeler

Thank you for your interest in contributing! This project welcomes improvements, bug fixes, platform-specific
 enhancements, and community documentation contributions.

## Ways to Contribute

- Submit fixes for detection issues or edge cases
- Add support for non-`ethX` naming conventions (e.g. `ensX`, `enpXsX`)
- Improve or expand the documentation in `docs/`
- Test on new hardware or distributions and report findings
- Add alternate output formats (CSV, JSON, HTML, etc.)

## Getting Started

1. Fork the repository
2. Create a new branch:

   ```bash
   git checkout -b feature/my-new-feature
   ```

3. Make your changes using clean, POSIX-compliant Bash
4. Format output consistently (Markdown tables preferred)
5. Commit your changes and push:

   ```bash
   git commit -am "Add new feature"
   git push origin feature/my-new-feature
   ```

6. Submit a pull request

## Code Style

- Shell: POSIX-compliant Bash (avoid advanced `bashisms` unless necessary)
- Output: Human-readable and Markdown-friendly
- Indentation: Use 4 spaces or tabs consistently (match existing files)
- Documentation: Use correct Markdown formatting with blank lines before and after headings, lists, and code blocks

## Attribution & License

This project uses a dual-license model:

- **Free for non-commercial/personal/educational use with attribution**
- **Commercial use requires a separate license**

By contributing, you agree to the project’s licensing terms.

To request a commercial license, please contact:

Joshua Porrata  
RP Digital Consulting LLC  
[joshua@rpdigitalconsulting.com](mailto:joshua@rpdigitalconsulting.com)

By submitting a pull request, you affirm that your contribution is your own work and you have the right to license it
 under the terms of this project.
