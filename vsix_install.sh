#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"


OUT="${HOME}/.vscode-server/extensions"

mkdir -p "tmp"

for vsix in ./vsix/*.vsix; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}

    cp ${vsix} "tmp/${NAME}.zip"
    mkdir "tmp/${NAME}"
    unzip "tmp/${NAME}.zip" -d "tmp/${NAME}"

    mv "tmp/${NAME}/extension" ${OUT}/${NAME}
    rm -rf "tmp"
done

