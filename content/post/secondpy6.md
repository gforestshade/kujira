+++
date = "2017-11-17"
lastmod = "2018-01-30"
draft = false
title = "それからのPython 6"
banner = "photo_pink1"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その５]({{<ref "secondpy5.md">}})のつづき
- もっともっとクラスをつかう
- 別ファイルからもつかう

# コードを読む
Civ4からあらかじめ提供されているクラスはまだまだあります。
今回はその中から比較的簡単で読みやすいクラスを例に
実際にコードを読み解いてみたいと思います。

## Pyhelpers.py
早速 "(BtSのインストールフォルダ)\\Assets\\Python\\Pyhelpers.py"を開いてみましょう。
BtSのAssetsに元からあるファイルですね。
開いたウィンドウを横において読み進めてください。

最初の20行ほどを引用します...
``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	' CyPlayer Helper Functions - Requires Player ID to initialize instance '
	
	def __init__(self, iPlayer):
		' Called whenever a new PyPlayer instance is created '
		if iPlayer:
			self.player = gc.getPlayer(iPlayer)
		else:
			self.player = gc.getPlayer(0)
	
	def CyGet(self):
		' used to get the CyUnit instance for quick calls '
		return self.player

# ...他にもたくさんたくさん...
```
大量のコードが並んでいますが、落ち着いてよく見ると`PyPlayer`というクラスを定義し、
その中にインスタンスメソッドをいくつも定義しているのだとわかります。
ひとつひとつのインスタンスメソッドは短いので、比較的読み解きやすそうです。

## \_\_init\_\_(self, iPlayer):
メソッドをみてみましょう。

``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	' CyPlayer Helper Functions - Requires Player ID to initialize instance '
	
	def __init__(self, iPlayer):
		' Called whenever a new PyPlayer instance is created '
		if iPlayer:
			self.player = gc.getPlayer(iPlayer)
		else:
			self.player = gc.getPlayer(0)
```
コンストラクタです。プレイヤーIDを受け取って、そのプレイヤーIDが0でないなら
`gc`にお願いして`CyPlayer`型のインスタンスに変えて、
インスタンス変数`self.player`として保持しています。

``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	# ...(中略)...
	
	def isAlive(self):
		return self.player.isAlive()
	
	def getID(self):
		' int - ID # '
		return self.player.getID()

	def getName(self):
		return self.player.getName()
```
それぞれ、生存しているか、IDの取得、名前の取得のメソッドです。
いずれも、`CyPlayer`型にある同名のメソッドに丸投げしてしまって、
その値をそのまま返しています。
よく見ると、`PyPlayer`クラスのメソッドはほとんどがこの形です。
無意味に見えるかもしれませんが、
こうしておくことで`PyPlayer`のインスタンスを
`CyPlayer`とだいたい同じように扱うことができるようになります。

## hasResearchedTech(self, iTech):
そのうえで、
``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	# ...(中略)...
	
	def hasResearchedTech(self, iTech):
		' bool - Has researched iTech '
		if self.getTeam().isHasTech( iTech ):
			return True
```
`CyPlayer`にはない便利メソッドをこうして定義しています。

本来`isHasTech()`は`CyTeam`にしかありませんが
(技術はプレイヤー個人のものではなくチームの共有財産なのでした。)
所属チームを調べて、そのチームのインスタンスにお願いして技術を持っているか調べてもらう、
までの処理をメソッドの中に閉じ込めて便利に使えるようにしています。
(関数の数ある利点の一つが処理のかたまりにわかりやすい名前を付けられることでしたね。)
こうすることで、「`iTech`を研究済みかどうか調べる」のが簡単にできるようになっています。

ところで、`self.getTeam()`がインスタンスであるかのように`isHasTech()`を呼び出していますが、
たしか`CyPlayer`の`getTeam()`の戻り値はチームIDだったような気がします。
あれ？と思ってよくよく見てみると、
`self.player.getTeam()`ではなく`self.getTeam()`になっています。
`CyPlayer`ではなく、`PyPlayer`自身のインスタンスメソッドを呼び出しているのですね。
同じクラスのメソッド同士であっても、できるだけ分業化をはかっていることが分かります。

## getTeam(self):
では、その`PyPlayer`版`getTeam()`を見てみましょう...
``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	# ...(中略)...
	
	def getTeamID(self):
		' int - gets the players teamID '
		return self.player.getTeam()
	
	def getTeam(self):
		' obj - returns Team Instance '
		return gc.getTeam( self.getTeamID() )
```
2つメソッドが見えます。下のメソッドに注目すると、
`gc.getTeam()`が出てきました。このメソッドの戻り値は`CyTeam`ですから、
`PyPlayer`の`getTeam()`は所属チームのIDではなくインスタンスを返します。
実際その方が便利ですね。

が、引数のチームIDのところに`self.getTeamID()`という
さらなるメソッド呼び出しが入っています。
名前からしてチームIDを取得するのだろうとすぐわかりますが、
読む練習のため一応さらに見てみましょう...

............すぐ上にありました。
`CyPlayer`型のインスタンス`self.player`がやっと出てきました。
`CyPlayer`の`getTeam()`はチームIDを返しますから、これでうまくいっています。

## getResearchedTechList(self):
`hasResearchedTech()`「この技術をすでに研究したか？」をさらに呼び出しているメソッドもあります...
``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	# ...(中略)...
	
	def getResearchedTechList(self):
		' intlist - list of researched techs '
		lTechs = []
		for i in range(gc.getNumTechInfos()):
			if self.hasResearchedTech(i):
				lTechs.append(i)
		return lTechs
```

`getResearchedTechList()`「そのプレイヤーが研究済みの全技術のリストを取得する」です。
for文の回数のところに(`range()`でリスト化しているので、中身は回数だとわかります)、
`gc.getNumTechInfos()`という見慣れないメソッドがあります。
技術のInfoの数、すなわち全技術を順番に並べたときの総数です。

for文の中で`i`を渡して`self.hasResearchedTech(i)`としています。
`hasReserchedTech()`の引数は`iTech`、すなわち技術IDのはずですが...
Civ4ではIDは0からの連番になっているので、これでうまくいっているのです。
その判定に成功したら(`i`番目の技術が研究済みなら)、
`lTechs`というリスト型の変数に対して
`append()`というメソッドらしきものを呼び出しています。
リスト型にもメソッドは定義されていて、
`append()`は引数に渡した値をリストの末尾に追加します。

そうして研究済みと判定されたIDを追加していくと、
最終的に研究済みの技術IDのリストが出来上がります。
そのリストを`return lTechs`で戻り値として返せば、
お疲れさまでした、研究した技術のリストを取得するメソッドができました。

技術に限らず、条件を満たしたもののリストをつくりたい、と思ったときは、
「対象すべてを用意して→for文で1個ずつ取り出し→各要素ついて条件を判定して→Trueなら結果用リストに追加する」
ことで得ることができます。
([はじめての その７]({{<ref "getstarted7.md">}})で似た題材を扱いました。今の視点で復習すると新しい発見があるかも？)

## getUnitList(self):
`PyPlayer`型のメソッドには「そのプレイヤーに属する全○○のリスト」のたぐいが
それなりに用意されていて、こういったものもあります...
``` python
## Sid Meier's Civilization 4
## Copyright Firaxis Games 2005
from CvPythonExtensions import *
#import Info as PyInfo
import CvUtil
gc = CyGlobalContext()

class PyPlayer:
	# ...(中略)...
	
	def getUnitList(self):
		' UnitList - All of the players alive units '
		lUnit = []
		(loopUnit, iter) = self.player.firstUnit(false)
		while( loopUnit ):
			if ( not loopUnit.isDead() ): #is the unit alive and valid?
				lUnit.append(loopUnit) #add unit instance to list
			(loopUnit, iter) = self.player.nextUnit(iter, false)
		return lUnit
```
「そのプレイヤーに属する全ユニットのリスト」です。
CyPlayerのインスタンスからユニットのリストを取り出す方法は(見てわかる通り)すこし難しいので、
まとめてメソッドにしてあるのは心強いですね。
中身の解説はすこし長くなってしまうので、[付録]({{<ref "readgetunitlist.md">}})としてまとめました。

# つかう

自軍の全ユニットに対して何かすることが可能になりました。
《チチェン・イッツァ完成時、自軍の全ユニットを首都に集めるMOD》
を作ってみましょう。

いつものようにはじめて...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()
        
class MyEventManager(CvEventManager.CvEventManager, object):

<<<<<<<<<<
```
世界遺産も建造物ですから建造物が完成したときのイベントを使って...
``` python
>>>>>>>>>>
    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        pCity, iBuilding = argsList
        ##########
<<<<<<<<<<
```
建てられたのがチチェン・イッツァだったとき、
``` python
>>>>>>>>>>
        if iBuilding == gc.getInfoTypeForString("BUILDING_CHICHEN_ITZA"):
<<<<<<<<<<
```

都市のオーナーに対して`PyPlayer`のインスタンスを作成し、`getUnitList()`を呼び出します。
`クラス名(コンストラクタ引数)`でつくれるのでした。さっそくつくり...
``` python
<<<<<<<<<<
            pyPlayer = PyPlayer(pCity.getOwner())
>>>>>>>>>>
```
............つくりたかったのですが、これではうまくいきません。
`PyPlayer`クラスを提供しているのが、Civ4本体ではなく、
AssetsフォルダにあるPythonファイルだからです。

# 他のファイルからクラスを使う
他のファイルに定義されているクラスや関数を使うときはすこし記述をしてあげないといけません。

## モジュール
Pythonではファイル全体が１つの**モジュール**とみなされ、
ファイル名の拡張子を除いた部分が自動的に**モジュール名**として命名されます。
Pythonで他のファイルのクラスや関数を使いたいときは、
この**モジュール名**を指定してまず読み込む必要があります。

ファイル冒頭に`import ほにゃほにゃ`が並んでいるところに、
こうやって足してあげます...
``` python
import (モジュール名)
```
もうすでに書いてあるimport文がいくつか見えると思いますが、それらも実はモジュールの読み込み指定です。
同じフォルダか、あるいは元のBtsのAssets\\Pythonに必ず同じ名前の
`(モジュール名).py`のファイルがありますので、
覗いてみるのもよいでしょう。

モジュールは自分でつくることもできます。
方法は簡単、新しいファイルを作ってそこにPythonコードを書くだけです。
自動的にファイル名からモジュール名が命名されます。

このとき、Assets\\Pythonの中にさらにフォルダ階層を作ってしまうと、
ファイル名とモジュール名が一致しなくなるので、
最初のうちは同じフォルダにPythonファイルを置きましょう。

今回は、BtsのAssets\\Pythonフォルダにある`PyHelpers.py`をMODから使いたいのでした。
モジュール名は`PyHelpers`になりますから、ファイル冒頭付近で...
``` python
import PyHelpers
```
とします。

# モジュール内のクラス名

import文を書き、あらためて...
``` python
<<<<<<<<<<
            pyPlayer = PyPlayer(pCity.getOwner())
>>>>>>>>>>
```
............これでもまだうまくいきません。
実際に使うところで、モジュール名とクラス名を***両方***明示するする必要があります。
すなわち、このようにします...
``` python
<<<<<<<<<<
            pyPlayer = PyHelpers.PyPlayer(pCity.getOwner())
>>>>>>>>>>
```
不便に思えますが、このことは
「モジュールをまたげば同じクラス名を使っても混ざらない」
ということを意味します。
変数のスコープで述べたように、気にしなければならない範囲が狭まるので、
うっかり被らせてしまうことがなくなる利点でもあるのです。

ともかく、インスタンスを作ってしまえばあとは普通のインスタンスと同じです。
首都のインスタンス経由で移動先の座標を求めて、
``` python
>>>>>>>>>>
            pyCapital = pyPlayer.getCapitalCity()
            toX = pyCapital.getX()
            toY = pyCapital.getY()
<<<<<<<<<<
```

全ユニットのリストからfor文で各ユニットに対し、
その座標に強制移動させます。
``` python
>>>>>>>>>>
            for pUnit in pyPlayer.getUnitList():
                pUnit.setXY(toX, toY, False, True, True)
<<<<<<<<<<
```

# ためす
ぜんぶでこうなりました...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil
import PyHelpers

gc = CyGlobalContext()
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        pCity, iBuilding = argsList
        ##########

        if iBuilding == gc.getInfoTypeForString("BUILDING_CHICHEN_ITZA"):
            pyPlayer = PyHelpers.PyPlayer(pCity.getOwner())
            pyCapital = pyPlayer.getCapitalCity()
            toX = pyCapital.getX()
            toY = pyCapital.getY()
            for pUnit in pyPlayer.getUnitList():
                pUnit.setXY(toX, toY, False, True, True)
```

{{<img src="/img/kujira_class_30.png">}}
いいですね！
