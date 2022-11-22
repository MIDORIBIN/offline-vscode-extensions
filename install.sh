#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

if [ ${#} != 1 ]; then
    echo "invalid args length: ${#}"
    exit 1
fi

if [ ${1} != "host" ] && [ ${1} != "container" ]; then
    echo "invalid args: ${1}"
    exit 1
fi

URL="https://github.com/MIDORIBIN/offline-vscode-extensions/tarball/main"
wget --no-check-certificate -O - ${URL} | tar zxvf -
cd MIDORIBIN-offline-vscode-extensions-*

OUT="${HOME}/.vscode-server/extensions"
COMMON_VSIX_DIR="vsix/common"
SPECIFIC_VSIX_DIR="vsix/${1}"

rm -rf ${OUT}
mkdir -p ${OUT}

VISXS=(${COMMON_VSIX_DIR}/* ${SPECIFIC_VSIX_DIR}/*)


function untar() {
    local out=${1}
    local vsix=${2}
    tar xvzf ${vsix} -C ${OUT} 
}

for vsix in "${VISXS[@]}"; do
    untar ${OUT} ${vsix}
done

cd ../
rm -r MIDORIBIN-offline-vscode-extensions-*
