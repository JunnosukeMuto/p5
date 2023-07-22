# p5

## 環境構築

### Arch系Linuxユーザー

```
cp .vscode/linux-tasks.json .vscode/tasks.json
```
pacmanでprocessingをインストールしたら、`usr/share/processing/processing-java`ができると思います。\
クローンしたディレクトリをvscodeで開いて中のpdeファイルを`ctrl+shift+b`で実行できます。

### Windowsユーザー

`processing-java.exe`を環境変数に登録してください。
`.vscode/windows-tasks.json`を、`tasks.json`にリネームしましょう。

## 新しくファイルを追加する場合

まず作成したいpdeファイルと同名のディレクトリを作成し、その中に新しいプログラムを作ってください。
