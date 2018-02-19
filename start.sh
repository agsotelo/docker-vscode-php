#!/bin/bash
set -e
set -o pipefail

# Git credentials
git config --global user.email "$GITUSERMAIL"
git config --global user.name "$GITUSERNAME"

su user -p -c "/usr/share/code/code . --extensions-dir /var/vscode-ext"
