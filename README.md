# offline-vscode-extensions

## TODO

* 依存ライブラリの確認

## dependence

* wget

## ホスト向け

```sh
wget -O - https://raw.githubusercontent.com/MIDORIBIN/offline-vscode-extensions/main/host_install.sh | bash
```

## コンテナ向け

```sh
wget -O - https://raw.githubusercontent.com/MIDORIBIN/offline-vscode-extensions/main/container_install.sh | bash
```

## 更新用

```sh
docker run --rm -it -v ${PWD}:/work -w /work python:3.10.2 bash -c "update/update.sh"
```

## 動作確認用

```sh
docker run --rm -it -v ${PWD}:/work -w /work ubuntu:18.04 bash
```
