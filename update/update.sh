#/bin/bash
set -euox pipefail
cd "$(dirname "$0")"


ZIP_DIR="/tmp"
OUTPUT_DIR="../vsix"

function remove_old_file () {
    rm -f ${OUTPUT_DIR}/*/*
}

function download_zip () {
    pip3 install requests
    python3 ./download.py
}

function all_zip_to_tar () {
    CURRENT_DIR=$(pwd)
    for zip in ${ZIP_DIR}/*/*.zip; do
        zip_to_tar ${zip}
    done
    cd ${CURRENT_DIR}
}

function zip_to_tar () {
    cd `dirname ${1}`

    # unzip
    ZIP_FILE=${1##*/}
    UNZIP_DIR=${ZIP_FILE%.*}
    unzip ${ZIP_FILE} -d ${UNZIP_DIR}

    # tar
    cd ${UNZIP_DIR}
    mv "extension" ${UNZIP_DIR}
    tar -zcvf "${UNZIP_DIR}.tar.gz" ${UNZIP_DIR}
}

function move_tar () {
    CURRENT_DIR=$(pwd)
    OUTPUT_DIR=$(cd "${OUTPUT_DIR}"; pwd)
    cd ${ZIP_DIR}
    for tar in */*/*.tar.gz; do
        mv ${tar} ${OUTPUT_DIR}/${tar%%/*}/
    done
    cd ${CURRENT_DIR}
}

remove_old_file
download_zip
all_zip_to_tar
move_tar
