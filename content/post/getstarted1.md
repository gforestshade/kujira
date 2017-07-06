+++
date = "2017-07-03"
draft = false
title = "はじめてのCvEventManager.py 1"
banner = "/green1024x200.png"
tags = ["はじめてのCvEventManager.py", "せつめい"]
+++

CvEventManager.py を直接編集するのではなく、それを呼び出しているファイルにさかのぼって、
独自のEventManagerに変えてしまった方が後々よいです。

さっそくBtSの元ファイル
`C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\Python\EntryPoints\CvEventManagerInterface.py`
…はなかったので
`C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Assets\Python\EntryPoints\CvEventInterface.py`
をみると、こうなっていました。

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

これを**ディレクトリ配列ごと**コピーしてきて編集すると、該当ファイルが差し変わるのでした。
MODのほうにもEntryPoint\ ディレクトリを作って、そこにコピーします。

``` c
EntryPoint\CvEventInterface.py
```

こうしてみました。`KujiraEventManager`というモジュール(あるいは`KujiraEventManager.py`というファイル)にある`MyEventManager`クラスを指定しています。

まだ指定した先である`KujiraEventManager.py`というファイルがないので、自分でつくります。中身は…

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

こうしてみました。元のCvEventManagerを継承して、onGameStartメソッドをオーバーライドします。
気持ち的には、ゲーム開始時に割って入って、独自の処理をするイメージです。

>
Civ4のプログラムはゲームの処理中のとある時点でグローバル関数のonEvent()を呼び出します。
onEvent()はそのままCvEventManager.hundleEvent()を呼び出し、hundleEvent()はargsListに渡ってきた
「どんなイベントか」の情報を解釈してon\*\*\*\*\*\*()にさらに振り分けます。
ここでhundleEvent()を呼び出すレシーバのCvEventManagerのインスタンスをすり替えておくと、
かわりにそちらが呼ばれることになります。そのインスタンスを派生クラスのものにしておけば、
hundleEvent()から振り分けられた各イベントハンドラをオーバーライドすることによって、
各タイミングでの処理ができるようになります。

ともかく、特定のタイミングに割って入って、処理を書くことができるわけですが、
そうなってくると気になるのが

+ どういうタイミングに割って入れるのか？
+ 何ができるのか？

ということですね。
まずどういうタイミングがあるかですが、[たくさんあります。][1]
どういうことができるかについては、[さらにたくさんあります。][2]
すべてを覚える必要はもちろんありません。わかりやすいような処理から始めて、
自分の手で書いていくことを通して、少しずつ理解していくのがよいです。

[1]: http://modiki.civfanatics.com/index.php?title=CvEventManager
[2]: http://civ4bug.sourceforge.net/PythonAPI/index.html

というわけで、`KujiraEventManager.py`を...

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

こうしてみました。

捕まえるイベントを、onCityBuiltにしています。
``` python
>>>>>>
    def onCityBuilt(self, argsList): #ここと
        'Called when a player builds a city' #これは特に意味のない飾り
        super(self.__class__, self).onCityBuilt(argsList) #ここをonCityBuiltにする
<<<<<<
```

独自処理部分では、まず`pCity = argsList[0]`としてイベントに付随してくる情報を取得しています。
[イベント一覧][1]からdef onCityBuiltをさがしてみると、

+ Function: def onCityBuilt()
+ Parameters: self, argsList(city)
+ Description: Called when a player builds a city

とあります。ParametersのargsListのカッコ内にあるのがイベントについてくる情報です。
ターン開始時なら、誰のターン開始時で、いま何ターン目なのか、
プロジェクトが完成したなら、どの都市で、何のプロジェクトが完成したのか、
ユニットが倒されたなら、それはどのユニットで、またどのユニットに倒されたのか、
等等、そのイベントに関する情報が一緒に送られてくるので、Pythonではそれらを利用することができます。

`pCity = argsList[0]`に戻ると、argsListの0番目(プログラミング言語では、順番を0番目・1番目・2番目...と数えます)にcityが入っているはずなので、それをpCityに取り出しています。
この`pCity`はイメージとしてはいま立ったばかりの都市そのものがぎゅっと詰まっているイメージで、
`pCity.操作()`とすることで都市に操作を加えることもできます。
そこで、`pCity.setPopulation(4)`として、都市の人口を4にセットしています。

つまりぜんぶまとめて、『都市が建設されたとき、その都市の人口を4にするMOD』ができたことになるはずです。

フォルダ構成がこうなっていることを確認して...
``` plain
└─kujira
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

起動してみると、
{{<img src="/img/kujira_population_4.png" width="800" height="460">}}
うまくいきました！

もう一歩進んで、『都市が建設されたとき、その都市に図書館を建設するMOD』を目指してみましょう。
さて、「図書館を建設する」という「操作」をPythonコードに落とし込みたいです。
探し方はいろいろあります。他人のMODを参考にさせてもらってもよいでしょうし、
civfanaticsで漁るのもよいでしょう。英語でよろしければ、[一覧][2]を載せてくれているWebページもあります。

都市に建物を与えるのですからgetというよりsetですね...
setで始まるCyCityのメソッドの中からBuildingも含んでいるものを探していくと...
ありました。

>
VOID setNumRealBuilding (BuildingType iIndex, INT iNewValue)
(BuildingID, iNum) - Sets number of buildings in this city of BuildingID type

建物の種類と、数値を指定して、その建物の数をその数値にするメソッドのようです。
数は1でよいのでしょうが、肝心の建物の種類をどうやって指定するか学ばないといけないようです。
`BuildingType iIndex`とあります。
iはXMLの編集でおなじみのように数値を表します。
ですから、ここには図書館を表す数値を指定しなければなりません。
が、そんな数値はもちろん知りません。そこで調べて...くるのではなく、
そこはPython自身に計算してもらえばよいのです。

まず、図書館を表すキーを用意しましょう。(これはどうにかして調べてください。XML編集をしていた方なら、さほど難しくないと思います)
調べたところ、`BUILDING_LIBRARY`でした。そして`gc.getInfoTypeForString('BUILDING_LIBRARY')`とすると、数値を取得できます。
`gc`を使うのには少し準備がいるので、それも含めた`KujiraEventManager.py`のリストは

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

こうなります。

さてこれで起動してみて都市を覗いてみても、図書館は建っていないようです。
どこかでミスっているのでしょうか。エラーを起こしたなら起こしたでどの行で起こしたかの場所を知りたいものです。
このようなとき`Documents\My Games\Beyond the Sword(J)\Logs`にある`PythonErr.log`が助けになってくれます。
``` c
Traceback (most recent call last):

  File "CvEventInterface", line 25, in onEvent

  File "CvEventManager", line 187, in handleEvent

  File "KujiraEventManager", line 14, in onCityBuilt

AttributeError: 'CyGlobalContext' object has no attribute 'getInfoTypeString'
ERR: Python function onEvent failed, module CvEventInterface
```

エラーが起こっていました。
ファイル名と行番号が並んでいるうちの一番下、この例では
`File "KujiraEventManager", line 14, in onCityBuilt`がエラーを起こした場所を示します。

``` python
>>>>>>>>
        iLib = gc.getInfoTypeString('BUILDING_LIBRARY')
<<<<<<<<
```

この行ですね。お使いのテキストエディタで行番号の表示ができるのであれば、すぐ見つかると思います。
エラー内容はこうです。
`AttributeError: 'CyGlobalContext' object has no attribute 'getInfoTypeString'`
『CyGlobalContextのオブジェクトにgetInfoTypeStringなんて属性ないやで』
objectやattributeという単語の意味がいまの時点でわからなくとも、
getInfoTypeStringっていう名前のものがない(探すのに失敗している)ということはなんとなく感じ取れます。
そして、よくよく見直すと、たしかにgetInfoTypeStringって名前は間違いで、
getInfoTypeForStringが正しいことが分かりました。直しましょう。

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

起動してみて...
{{<img src="/img/library.png" width="800" height="460">}}
動きました！
