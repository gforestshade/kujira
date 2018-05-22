+++
date = "2017-07-03"
lastmod = "2018-01-28"
draft = false
title = "はじめてのPythonMOD 1"
banner = "photo_yellow"
categories = ["Python"]
tags = ["はじめてのPythonMOD", "講座"]
+++

# はじめに
## これは何か
これは、
「PythonによるModding、やってみたいけどどこから手を付けたら...」
という声にお応えして、CvEventManager.pyを編集して
XMLだけではできないちょっと面白いことをやってみようという企画です。
XMLで文明やユニットをいじったことがあればよりすんなり入り込めます。

## これは何でないか
これは、技術的な解説、PythonによるModdingに親しむ、
という視点での説明に偏重しています。
あなたが作りたいMODへの直接的なヒントやコピペですぐ動くコードは
あまりないかもしれません。

<!--more-->

# CivilizationIV.ini
早速その`CvEventManager.py`がどこにあるのか...を見ていく前に、
PythonのModdingをしていくにあたって`CivilizationIV.ini`を編集しましょう。[^1]

[^1]: Windows10,パッケージ版の場合,{{<inpath>}}ドキュメント\My Games\Beyond the Sword(J){{</inpath>}}<br>Steam版の場合,{{<inpath>}}ドキュメント\My Games\Beyond the Sword{{</inpath>}}にあります

``` ini
<<<<<<<<
; Enable the logging system
; Documents\My Games\Beyond the Sword(J)\Logs
LoggingEnabled = 1

; Enable synchronization logging
SynchLog = 1

; Overwrite old network and message logs
OverwriteLogs = 1
>>>>>>>>
```

とりあえずこの３つを`0`から`1`に変えておきましょう。

# CvEventInterface.py
さて、`CvEventManager.py`...といいたいところなのですが、後々のことまで考えると、
もうちょっと準備が必要です。
そこで、`CvEventManagerInterface.py`を編集します。

さっそくBtSの元ファイル

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\Python\EntryPoints\CvEventManagerInterface.py{{</path>}}

…はなかったので

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Assets\Python\EntryPoints\CvEventInterface.py{{</path>}}

[^2]をみると、こうなっていました。

[^2]: パッケージ版の場合。Steam版の場合は{{<inpath>}}C:\\Program Files (x86)\\Steam\\SteamApps\\common\\Sid Meier's Civilization IV Beyond the Sword\\Beyond the Sword\\Assets\\Python\\EntryPoints\\CvEventInterface.py{{</inpath>}}


``` python
# Sid Meier's Civilization 4
# Copyright Firaxis Games 2005
#
# CvEventInterface.py
#
# These functions are App Entry Points from C++
# WARNING: These function names should not be changed
# WARNING: These functions can not be placed into a class
#
# No other modules should import this
#
import CvUtil
import CvEventManager
from CvPythonExtensions import *

normalEventManager = CvEventManager.CvEventManager()

def getEventManager():
	return normalEventManager

def onEvent(argsList):
	'Called when a game event happens - return 1 if the event was consumed'
	return getEventManager().handleEvent(argsList)

def applyEvent(argsList):
	context, playerID, netUserData, popupReturn = argsList
	return getEventManager().applyEvent(argsList)

def beginEvent(context, argsList=-1):
	return getEventManager().beginEvent(context, argsList)

```

これを**どのフォルダに入っているかも含めて**コピーしてきて編集すると、該当ファイルが差し変わるのでした。
**MODフォルダ**に新しく{{<inpath>}}kujira\Assets\Python\EntryPoints\{{</inpath>}}フォルダを作って、そこにコピーします。

MOD開発中に使用するMODフォルダはユーザーの"Documents"にある方をおすすめします。

パッケージ版の場合

{{<path>}}ドキュメント\My Games\Beyond the Sword (J)\Mods{{</path>}}

Steam版の場合

{{<path>}}ドキュメント\My Games\Beyond the Sword\Mods{{</path>}}

です。

``` txt
└─kujira
    └─Assets
        └─Python
            └─Entrypoints
                 └─CvEventInterface.py
```
コピーした`CvEventInterface.py`の中身をすこし編集します...

``` python
# Sid Meier's Civilization 4
# Copyright Firaxis Games 2005
#
# CvEventInterface.py
#
# These functions are App Entry Points from C++
# WARNING: These function names should not be changed
# WARNING: These functions can not be placed into a class
#
# No other modules should import this
#
import CvUtil
# ここと
# import CvEventManager
import KujiraEventManager
from CvPythonExtensions import *

# ここ
# normalEventManager = CvEventManager.CvEventManager()
myEventManager = KujiraEventManager.MyEventManager()

def getEventManager():
	# ここも
	return myEventManager

def onEvent(argsList):
	'Called when a game event happens - return 1 if the event was consumed'
	return getEventManager().handleEvent(argsList)

def applyEvent(argsList):
	context, playerID, netUserData, popupReturn = argsList
	return getEventManager().applyEvent(argsList)

def beginEvent(context, argsList=-1):
	return getEventManager().beginEvent(context, argsList)
```
<!-- `KujiraEventManager`というモジュール(あるいは`KujiraEventManager.py`というファイル)にある`MyEventManager`クラスを指定しています。 -->
`CvEventManager.py`というファイルから
`KujiraEventManager.py`というファイルに指定を変えています。

## 本命をつくる
まだ指定した先である`KujiraEventManager.py`というファイルがないので、自分でつくります。
``` plain
└─kujira
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

`KujiraEventManager.py`の中身はこのようにします...

``` python
import CvEventManager
import CvUtil

class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
        # ログファイルに出力する
        CvUtil.pyPrint("Hello, Python!")
```

<!-- 難し過ぎたのでコメントアウト
こうしてみました。元のCvEventManagerを継承して、
onGameStartメソッドをオーバーライドします。
気持ち的には、ゲーム開始時に割って入って、独自の処理をするイメージです。

Civ4のプログラムはゲームの処理中のとある時点でグローバル関数のonEvent()を呼び出します。
onEvent()はそのままCvEventManager.hundleEvent()を呼び出し、hundleEvent()はargsListに渡ってきた
「どんなイベントか」の情報を解釈してon\*\*\*\*\*\*()にさらに振り分けます。
ここでhundleEvent()を呼び出すレシーバのCvEventManagerのインスタンスをすり替えておくと、
かわりにそちらが呼ばれることになります。そのインスタンスを派生クラスのものにしておけば、
hundleEvent()から振り分けられた各イベントハンドラをオーバーライドすることによって、
各タイミングでの処理ができるようになります。
-->

## ためす
MODをロードして起動してみましょう。
............シド星に降り立ってみても、とくにバニラとなにも変わっていません。
それもそのはず、ログファイルに文字列を出力する処理しかまだ書いていません。
それを確認するには、(ゲームをいちど始めたうえで、)
Documents\My Games\Beyond the Sword(J)\Logs
にある`PythonDbg.log`を開いてみます。
(ファイルがありませんか？見るフォルダが間違っているか、冒頭のini編集ができていない可能性があります。確認してみましょう。)

下に下にスクロールしていくと...
{{<img src="/img/pyprint.png" width="572">}}
ありました。ちゃんと動いているようです！

# 結局、何ができるのか？
ともかく、特定のタイミングに割って入って、処理を書くことができるわけですが、
そうなってくると気になるのが

+ どういうタイミングに割って入れるのか？
+ 何ができるのか？

ということですね。
まずどういうタイミングがあるかですが、[たくさんあります。][a]
どういうことができるかについては、[さらにたくさんあります。][b]
すべてを覚える必要はもちろんありません。わかりやすいような処理から始めて、
自分の手で書いていくことを通して、少しずつ理解していくのがよいです。

[a]: http://modiki.civfanatics.com/index.php?title=CvEventManager
[b]: http://civ4bug.sourceforge.net/PythonAPI/index.html

# 結局こつこつとやっていくしかない
というわけで、`KujiraEventManager.py`をこのように変えてみます...

``` python
import CvEventManager
import CvUtil

class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityBuilt(self, argsList):
        'Called when a player builds a city'
        super(self.__class__, self).onCityBuilt(argsList)
        ##########
        pCity = argsList[0]
        pCity.setPopulation(4)

```

## くわしく
捕まえるイベントを、onCityBuiltにしています。
``` python
>>>>>>
    def onCityBuilt(self, argsList): #ここと
        'Called when a player builds a city' #これは特に意味のない飾り
        super(self.__class__, self).onCityBuilt(argsList) #ここをonCityBuiltにする
<<<<<<
```

独自処理部分では、まず`pCity = argsList[0]`として
イベントに付随してくる情報を取得しています。
[イベント一覧][b]からdef onCityBuiltをさがしてみると、

+ Function: def onCityBuilt()
+ Parameters: self, argsList(city)
+ Description: Called when a player builds a city

とあります。「都市を建てたとき」というイベントのようですね。
つまり都市を建てたときに割り込んで何らかのプログラム的処理をしますよ、
という意味になります。

{{<img src="/img/onCityBuilt.svg">}}

ParametersのargsListのカッコ内にあるのがイベントについてくる情報です。
「ターン開始時」なら、誰のターン開始時で、いま何ターン目なのか、
「プロジェクトが完成したとき」なら、どの都市で、何のプロジェクトが完成したのか、
「ユニットが倒されたとき」なら、それはどのユニットで、またどのユニットに倒されたのか、
等等、そのイベントに関する情報が一緒に送られてくるので、
Pythonではそれらを利用することができます。

`pCity = argsList[0]`に戻ると、`argsList`の中身に`city`が入っているはずなので、
それをpCityに取り出しています。
この`pCity`はイメージとしてはいま立ったばかりの都市そのものが
ぎゅっと詰まっているイメージです。
`.`(ピリオド)をつけて命令を記述することで
都市の情報を取得したり、都市に操作を加えたりできます。
そこで、`pCity.setPopulation(4)`として、都市の人口を4にセットしています。

つまりぜんぶまとめて、《都市が建設されたとき、その都市の人口を4にするMOD》ができたことになるはずです。

## ためす
フォルダ構成がこうなっていることを確認して...
``` txt
└─kujira
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

起動してみると、
{{<img src="/img/civss_kujira_population_4.png">}}
うまくいきました！

# もう少し進める
もう一歩進んで、《都市が建設されたとき、その都市に図書館を建設するMOD》を目指してみましょう。

## 図書館を建設する、とは
さて、「図書館を建設する」という「操作」をPythonコードに落とし込みたいです。
探し方はいろいろあります。他人のMODを参考にさせてもらってもよいでしょうし、
civfanaticsで漁るのもよいでしょう。英語でよろしければ、[一覧][b]を載せてくれているWebページもあります。

今回は[リファレンス][b]から探してみましょう。
都市に対する操作なので、最初に`CyCity`をぽちっと押して、
都市に建物を与えるのですからgetというよりsetでしょうか、
その中からsetで始まっていてBuildingも含んでいるものを探していくと...
ありました。

{{<img src="/img/pythonapi_setNumRealBuilding.svg">}}


>
``` nohighlight
400. VOID setNumRealBuilding (BuildingType iIndex, INT iNewValue)
(BuildingID, iNum) - Sets number of buildings in this city of BuildingID type
```

建物の種類と、数値を指定して、その建物の数を設定する操作のようです。
数は1でよいのでしょうが、肝心の建物の種類を
どうやって指定するか学ばないといけないようです。

そこで、`BuildingType iIndex`とあるところに注目します。
iはXMLの編集でおなじみのように数値を表します。
ですから、ここには図書館を表す数値を指定しなければなりません。
が、そんな数値はもちろん知りません。そこで調べて...くるのではなく、
そこはPython自身に計算してもらえばよいのです。

まず、図書館を表す「キー」を用意しましょう。
(これはどうにかして調べてください。
XML編集をしていた方なら、さほど難しくないと思います)
調べたところ、`BUILDING_LIBRARY`でした。
そこで`gc.getInfoTypeForString('BUILDING_LIBRARY')`とすると、
図書館を表す数値を取得できます。
`gc`を使うのには少し準備がいるので、
それも含めた`KujiraEventManager.py`のリストはこうなります...

``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityBuilt(self, argsList):
        'Called when a player builds a city'
        super(self.__class__, self).onCityBuilt(argsList)
        ##########
        pCity = argsList[0]
        iLib = gc.getInfoTypeString('BUILDING_LIBRARY')
        pCity.setNumRealBuilding(iLib, 1)

# Something is wrong!
```

## まちがえた？
さてこれで起動してみます。

.........しかし都市を覗いてみても、図書館は建っていないようです。

どこかでミスっているのでしょうか。エラーを起こしたなら起こしたで
どの行で起こしたかの場所を知りたいものです。
このようなときDocuments\My Games\Beyond the Sword(J)\Logsにある
`PythonErr.log`が助けになってくれます。開いてみてみましょう...

>
``` txt
Traceback (most recent call last):

  File "CvEventInterface", line 25, in onEvent

  File "CvEventManager", line 187, in handleEvent

  File "KujiraEventManager", line 14, in onCityBuilt

AttributeError: 'CyGlobalContext' object has no attribute 'getInfoTypeString'
ERR: Python function onEvent failed, module CvEventInterface
```

エラーが起こっていました。
ファイル名と行番号が並んでいるうちの一番下、この例では
`File "KujiraEventManager", line 14, in onCityBuilt`が
エラーを起こした場所を示してくれています。

``` python
>>>>>>>>
        iLib = gc.getInfoTypeString('BUILDING_LIBRARY')
<<<<<<<<
```

この行ですね。お使いのテキストエディタで行番号の表示ができるのであれば、
すぐ見つかると思います。
エラー内容はこうです。
`AttributeError: 'CyGlobalContext' object has no attribute 'getInfoTypeString'`
「CyGlobalContextのオブジェクトにgetInfoTypeStringなんて属性ないやで」

objectやattributeという単語の意味がいまの時点でわからなくとも、
getInfoTypeStringっていう名前のものがない(探すのに失敗している)
ということはなんとなく感じ取れます。
そして、よくよく見直すと、たしかにgetInfoTypeStringって名前は間違いで、
getInfoTypeForStringが正しいことが分かりました。直しましょう...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityBuilt(self, argsList):
        'Called when a player builds a city'
        super(self.__class__, self).onCityBuilt(argsList)
        ##########
        pCity = argsList[0]
        iLib = gc.getInfoTypeForString('BUILDING_LIBRARY') #typo!
        pCity.setNumRealBuilding(iLib, 1)

```

## ためす
起動してみて...
{{<img src="/img/civss_library.png">}}
動きました！

