#/bin/bash
set -euox pipefail
# cd "$(dirname "$0")"
cd /tmp

URL="https://github.com/MIDORIBIN/offline-vscode-extensions/tarball/main"
wget --no-check-certificate -O - ${URL} | tar zxvf -
cd MIDORIBIN-offline-vscode-extensions-*


COMMON_VSIX_DIR="vsix/common"
HOST_VSIX_DIR="vsix/host"
CONTAINER_VSIX_DIR="vsix/container"

# host
OUT="${HOME}/.vscode-server/extensions"
rm -rf ${OUT}
mkdir -p ${OUT}

for vsix in ${COMMON_VSIX_DIR}/*.tar.gz; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}
    tar xvzf ${vsix} -C ${OUT}
done

for vsix in ${HOST_VSIX_DIR}/*.tar.gz; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}
    tar xvzf ${vsix} -C ${OUT}
done


# container
OUT="${HOME}/.vscode-server/container-extensions"
rm -rf ${OUT}
mkdir -p ${OUT}

for vsix in ${COMMON_VSIX_DIR}/*.tar.gz; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}
    tar xvzf ${vsix} -C ${OUT}
done

for vsix in ${CONTAINER_VSIX_DIR}/*.tar.gz; do
    NAME=${vsix##*/}
    NAME=${NAME%.*}
    tar xvzf ${vsix} -C ${OUT}
done

