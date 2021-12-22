#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

URL="https://github.com/MIDORIBIN/offline-vscode-extensions/tarball/main"
wget --no-check-certificate -O - ${URL} | tar zxvf -
cd MIDORIBIN-offline-vscode-extensions-*
./vsix_install.sh
cd ../
rm -rf MIDORIBIN-offline-vscode-extensions-*
