+++
date = "2017-11-16"
draft = false
title = "付録：getUnitList()"
banner = "/green1024x200.png"
tags = ["付録", "せつめい"]
+++

# はじめに

- [それからのPython その６]({{<ref "secondpy6.md">}})の付録
- 全ユニットを列挙するには

# 読む

早速 `(略)\Beyond the Sword(J)\Assets\Python\Pyhelpers.py`を開いて、
`getUnitList()`というメソッドを見ていきます...
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

最初に空のリストを作って、`lUnit = []`
最後にそのリストを返しています。`return lUnit`
その間に、変数`lUnit`に`CyUnit`のインスタンスを詰め込んでいきます。

まず`CyPlayer`のメソッド`firstUnit()`を呼び出しています。

    109. TUPLE firstUnit (BOOL bRev)

引数のBoolは「逆順に調べるか？」を表します。
ここに`True`を指定すると逆順に調べることになりますが、
ここでは`false`で順に調べています。

このメソッドが返すのは、「最初のユニットの`CyUnit`インスタンス」と「イテレータ」の
２つが入った「タプル」です。

## タプル
「タプル」はリストとすごく似ていますが、１点、
タプルの中身は代入によっては変更できない、ということが異なります。

``` python
listA = [1,5,3] # リスト変数
tupleB = (1,5,3) # タプル変数

listA[1] = 2 # 1番目を指定して書き換えができる
# tupleB[1] = 2 # タプルではできない、エラー

print listA
print tupleB

ai, aj, ak = listA # ばらして代入できる
bi, bj, bk = tupleB # タプルでもできる(タプルの中身を変更しているわけではないのでOK)

print "ai = %d, aj = %d, ak = %d" % (ai, aj, ak) # フォーマット文字列の変数指定にタプルが利用できる
print "bi = %d, bj = %d, bk = %d" % (bi, bj, bk) # (bi, bj, bk)は新しく作ったタプルでありもとのタプルとは別物であることに注意
```

`PyPlayer.getUnitList()`の定義に目を戻すと、
`(loopUnit, iter) = self.player.firstUnit(false)`とばらして代入しています。
これで`loopUnit`は最初のユニットのインスタンス、
`iter`は「イテレータ」という謎の存在が入っていることになります。

# while文
while文は繰り返しの一種です。
``` python
while (条件式):
    (ブロック)
```
で「条件式が真の間」ブロックを何度でも繰り返し実行します。
当然そのままだといつまでも繰り返しが終わらないので(無限ループと呼びます)、
ブロック中で条件式に使っている変数を変更する必要があります。

例えば:
``` python
a = 10
while a > 0:
    print "a = %d" % a
    a = a - 1 # aを1減らす。これがあることでそのうち条件を満たさなくなる
```

`PyPlayer.getUnitList()`の定義では、
`while( loopUnit ):`となっています。
変数をそのまま突っ込むことで、`loopUnit`が

- `False`
- 数値の`0`
- 空の文字列`""`
- 空のタプル`()`・空のリスト`[]`・空のディクショナリ`{}`
- `None`

のどれかに該当するまでブロックを繰り返すことになります。
条件式において「偽」以外はすべて「真」でしたから、
これらのどれにも該当しない値を取る間は「真」になりますね。

whileブロックの中を見ていきます。
``` python
>>>>>>>>>>
		while( loopUnit ):
			if ( not loopUnit.isDead() ): #is the unit alive and valid?
				lUnit.append(loopUnit) #add unit instance to list
			(loopUnit, iter) = self.player.nextUnit(iter, false)
<<<<<<<<<<
```

`if( not loopUnit.isDead() ):`とあります。
`not`は`True`と`False`を逆にするのでした。
「「`loopUnit`が致死ダメージを負っているなら」の逆ならば」なので、
「`loopUnit`が致死ダメージを負っていないなら」になります。
もしそうならば、`lUnit.append(loopUnit)`で
インスタンス`loopUnit`をリスト`lUnit`に追加しています。

ここまで、`loopUnit`は最初のユニットのインスタンスでした。
ここで、`loopUnit`が次のユニットのインスタンスになってくれたら、
繰り返しによって『もう一度`loopUnit`の生死判定→生きてたら追加→次のユニットへ』
をずーっと繰り返していけば生きているユニットを全員リストに追加することができそうです。
その『次のユニットを取得する』をやっているのが、
`(loopUnit, iter) = self.player.nextUnit(iter, false)`
です。やっていることはつまり「イテレータ」を渡して、(falseは逆順にしないという意味でした)
「次のユニット」と「更新された新しいイテレータ」を受け取るということです。
おおざっぱに、「イテレータ」というのは、
「いま何番目くらいのユニットを数えていたか覚えておいてくれるもの」
という認識でいいでしょう。
次のユニットを取得すると同時にイテレータの持つ位置情報も更新することで
次に呼び出したときにはさらにその次のユニットが取得できるのですね。

最終的に、`nextUnit()`はユニットを最後まで数え終わると
次のユニットとして`None`を返します。`loopUnit`の中身が`None`になりますから、
`while( loopUnit ):`を満たさなくなってループが終了します。

`CyPlayer`のメソッドだけから全ユニットのリストを取得するのは
このようにすこし難しいですが、処理をまとめて提供してくれる便利クラスも
同時に提供されているので、ありがたく使わせてもらいましょう。
