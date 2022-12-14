import requests
import re
import os


def main():
    download_all_vsix()


def download_all_vsix():
    type_urls = {
        'common': [
            'https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory',
            'https://marketplace.visualstudio.com/items?itemName=streetsidesoftware.code-spell-checker',
            'https://marketplace.visualstudio.com/items?itemName=ionutvmi.path-autocomplete',
            'https://marketplace.visualstudio.com/items?itemName=IBM.output-colorizer',
        ],
        'container': [
            'https://marketplace.visualstudio.com/items?itemName=ms-python.python',
            'https://marketplace.visualstudio.com/items?itemName=ms-python.vscode-pylance',
            'https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools',
            'https://marketplace.visualstudio.com/items?itemName=mesonbuild.mesonbuild',
        ],
        'host': [
            'https://marketplace.visualstudio.com/items?itemName=alefragnani.project-manager',
            'https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker',
        ],
    }
    for t, urls in type_urls.items():
        output_dir = '/tmp/' + t
        os.makedirs(output_dir, exist_ok=True)
        for url in urls:
            download_vsix(url, output_dir)


def download_vsix(url: str, dir_path: str):
    version = get_version(url)
    publishers, extension = url.split('=')[1].split('.', maxsplit=1)
    download_url = f'https://marketplace.visualstudio.com/_apis/public/gallery/publishers/{publishers}/vsextensions/{extension}/{version}/vspackage'
    filename = dir_path + '/' + url.split('=')[1] + '-' + version + '.zip'
    download_file(download_url, filename)


def get_version(url: str):
    response = requests.get(url).text
    pattern = r'"VersionValue":"([^"]*)"'
    result = re.search(pattern, response, re.S)
    return result.group(1)


def download_file(url: str, filename: str):
    headers = {
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36',
        'cookie': 'Gallery-Service-UserIdentifier=65d94e85-3a89-4fb3-8e89-bc75ff2eaed1',
    }
    r = requests.get(url, stream=True, headers=headers)
    if r.status_code != requests.codes.ok:
        print(r.status_code)
        print(r.text)
        return
    with open(filename, 'wb') as f:
        for chunk in r.iter_content(chunk_size=1024):
            if chunk:
                f.write(chunk)
                f.flush()


if __name__ == '__main__':
    main()
