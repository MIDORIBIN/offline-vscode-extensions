# offline-vscode-extensions

## TODO

## dependence

* wget

## インストール

```sh
wget -O - https://raw.githubusercontent.com/MIDORIBIN/offline-vscode-extensions/main/install.sh | bash
```

## 更新用

```sh
docker run --rm -it -v ${PWD}:/work -w /work python:3.10.2 bash -c "update/update.sh"
```

## 動作確認用

```sh
docker run --rm -it -v ${PWD}:/work:ro -w /work ubuntu:18.04 bash
```

```
sed -i 's@archive.ubuntu.com@ftp.jaist.ac.jp/pub/Linux@g' /etc/apt/sources.list
apt update && apt install -y wget python3
./install.sh
```
