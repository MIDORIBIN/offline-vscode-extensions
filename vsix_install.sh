#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"

TMP="./tmp"
OUT="${HOME}/.vscode-server/extensions"
VSIX_DIR="${1}"

mkdir -p ${OUT}
mkdir -p ${TMP}

for vsix in ${VSIX_DIR}/*.vsix; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}

    cp ${vsix} "${TMP}/${NAME}.zip"
    mkdir "${TMP}/${NAME}"
    unzip "${TMP}/${NAME}.zip" -d "${TMP}/${NAME}"

    mv "${TMP}/${NAME}/extension" ${OUT}/${NAME}
done

rm -rf ${TMP}
