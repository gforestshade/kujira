+++
date = "2017-11-06"
draft = true
title = "それからのPython 6"
banner = "/green1024x200.png"
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
早速 `(略)\Beyond the Sword(J)\Assets\Python\Pyhelpers.py`を開いてみましょう。
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
生存しているか、IDの取得、名前の取得のメソッドです。
いずれも、`CyPlayer`型にある同名のメソッドに丸投げしてしまって、
その値をそのまま返しています。
よく見ると、`PyPlayer`クラスのメソッドはほとんどがこの形です。
無意味に見えるかもしれませんが、
こうしておくことで`PyPlayer`のインスタンスを
`CyPlayer`とだいたい同じように扱うことができるようになります。
