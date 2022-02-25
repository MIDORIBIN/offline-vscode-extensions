#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"


OUT="${HOME}/.vscode-server/extensions"
VSIX_DIR="${1}"

mkdir -p ${OUT}

for vsix in ${VSIX_DIR}/*.tar.gz; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}
    tar xvzf ${vsix} -C ${OUT}
done

