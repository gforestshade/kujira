+++
date = "2018-05-29T16:22:20+09:00"
title = "CvGameCoreDll.dllの作り方(2018-05)"
banner = "green"
categories = ["C++"]
comment = true
+++

# 筆者の環境
- Windows 10 64bit
- Civ4 BtS 3.19 パッケージ版

# 必要なもの

Dawn of Civilizationの作者さんが全部入りパッケージを公開されています。
<https://sourceforge.net/projects/beyond-the-sword-sdk/>
ここから
/VS2010Express1.iso と
/Install Civ4 Microsoft Windows SDK Visual C Toolkit.exe を
両方ダウンロードします。

Install Civ4 Microsoft Windows SDK Visual C Toolkit.exeは
実行して指示に従いインストールします。

VS2010Express1.isoはマウントしてVC++2010 Express Editionをインストールします。
(それ以外のプログラミング言語は不要です。)
Setup.htaからVC++2010を選ぶか、{{<inpath>}}\VCExpress\setup.exe{{</inpath>}}を直接実行します。

# やってみる

<!--more-->

## zipから
ソースファイルとMakefileもセットになって提供されています。
<https://github.com/dguenms/beyond-the-sword-sdk/archive/develop.zip>

beyond-the-sword-sdk-develop を展開しMODフォルダに入れて、
お好きなフォルダ名にリネームしておきます。

あらかじめAssetsという名前のフォルダを作っておきます。
``` txt
└─(MOD名)
    │─Assets
    │
    └─CvGameCoreDLL
        └─いろいろ
        └─たくさん
```

## gitから
Githubで公開されているので、`git clone`してきてもよいです。
Git Bashやcmdから、
``` shell
$ git clone https://github.com/dguenms/beyond-the-sword-sdk.git mytestmod
```
とします。

Assetsという名前のディレクトリを作っておきます。
``` shell
$ cd mytestmod
$ mkdir Assets
```

## ビルド
そのままでビルドできるようになっています。
{{<inpath>}}CvgameCoreDLL\CvGameCoreDLL.sln{{</inpath>}}をダブルクリックして開きます。[^othervc]

[^othervc]: ほかのバージョンのVC++もインストールしている方は、VC++2010でソリューションファイルを開いてください。

ビルド構成がDebugになっている場合はRelaseに変更します。
![](/img/vcproject_release.png)

`F7`を押します。
ビルドが始まります。
しばらく待ちます。
Assetsの中にCvGameCoreDll.dllができているはずです。

Enjoy!


# もうソースファイル持ってる場合
コンパイルしたいソースファイル群をすでにお持ちの方は、
***CvTextScreens.cpp以外の*** \*.cppと\*.hファイルをすべてこのプロジェクトフォルダに上書きコピーしてリビルドします。
SolutionExplorerのSolutionまたはProjectのコンテクストメニューからRebuild、
または`Ctrl+Alt+F7`でリビルドができます。

MODによっては追加の#defineが必要になるかもしれません。
ProjectのPropatiesから...
![](/img/vcproject_propaties.png)

Configuration Propaties -> NMake -> Additional Optionsに追加してください。
![](/img/vcproject_preprocessor_define.png)

<div style="padding:5em"></div>
