+++
date = "2017-10-21"
draft = false
title = "それからのPython 3"
banner = "photo_pink1"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その２]({{<ref "secondpy2.md">}})のつづき
- クラス

# 準備
kujira\_classというMODを新しく作ります。

## フォルダ構成

``` plain
└─kujira_class
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

<!--more-->

## KujiraEventManager.py
これもリセットしておきます。
```
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class Hito:
    def getAge(self):
        return 18
    
class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
```


# 型を作る
今日は**型**を新しく自作します。
まずその部分のコードを見てみましょう...
``` python
>>>>>>>>>>
class Hito:
    def getAge(self):
        return 18
<<<<<<<<<<
```
これはHito型という型の定義です。
実際に使うところも見てみましょう...
```
>>>>>>>>>>
a = Hito()
age = a.getAge()
<<<<<<<<<<
```
２つとも代入文ですね。
`a = Hito()`でHito型の値を作り`a`に代入しています。
`age = a.getAge()`では「Hito型の変数`a`の」関数である`getAge()`を呼び出しています。
`getAge()`はreturn文で`18`を返しますから、`age`には`18`が代入されます。

変数の中身は直接見ることはできません。
文字列に埋め込んで、表示してみましょう...
```
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class Hito:
    def getAge(self):
        return 18
    
class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########

        a = Hito()
        age = a.getAge()
        
        message = "age=%d" % age
        CyInterface().addImmediateMessage(message, "")

```

{{<img src="/img/kujira_class_10.png">}}
いいですね！

# クラス
今使ったのは**クラス**という仕組みです。
`class クラス名:`とすると、直後の**ブロック**の内容が**クラス**として定義されます。
クラス名は同時に型名にもなっていて、あとで`クラス名()`とするとその型の値を生成することができます。
クラス型の値ひとつひとつを特に**インスタンス**と呼びます。
クラス→型、インスタンス→値、と対応しています。ついてきていますか？

クラス定義に戻りまして、ブロックには関数の定義が並びます。
大体普通の関数と同じなのですが、`def getAge(self):`の行を見ると、
第1引数が`self`になっていることが見て取れます。
この`self`の中身が、実はインスタンスになっています。

............どういうことでしょうか？
少し上で「`age = a.getAge()`では『Hito型の変数`a`の』関数である`getAge()`を呼び出しています。」と説明をしました。
意味合い的には「`a`の年齢を取得する」になるわけです。
なので、`getAge()`を処理するにあたって「自分は誰なのか？」に当たる情報、
自分の持ち主たるインスタンス`a`の情報を利用できるように、
`self`に`a`が代入された状態で`getAge()`が呼び出されるわけです。
(わかりずらいでしょうか...わからなくてもとりあえず読み進めてください)

クラス定義ブロックの中にある関数のことを特に**メソッド**とよびます。
普通にメソッドを定義するとインスタンスの所有物になり、
そのようなメソッドを**インスタンスメソッド**と呼びます。
`インスタンス.インスタンスメソッド名(追加の引数)`とすることで
インスタンスメソッドを呼び出すことができます。
インスタンスメソッドの第1引数`self`はインスタンスだというのは書いた通りですが、
ただのインスタンスではなく「この関数を呼び出した所有者たる」インスタンスなので、
特に**レシーバ**と呼ぶこともあります。

そして、civ4MODのやりたいことのほとんどが
このインスタンスメソッドの仕組みにより行われます。たとえば、

+ 都市`pCity`の人口を4にする
+ プレイヤー`pPlayer`の文明IDを取得する
+ ユニット`pUnit`に昇進`e`を持たせる

これらはそれぞれ、

+ `pCity.setPopulation(4)`
+ `pPlayer.getCivilizationType()`
+ `pUnit.setHasPromotion(e, True)`

このようなインスタンスメソッドの呼び出しになるわけです。

# インスタンス変数
Hito型に戻りましょう。
Hitoクラスのインスタンスメソッド`getAge()`は、今のことろ
レシーバの`self`を無視して、常に`18`を返しています。
これではやや味気ないので、インスタンスの情報から年齢を読み取って
返すようにしてみましょう。このようにします。
``` python
>>>>>>>>>>
     def getAge(self):
         return self.age
<<<<<<<<<<
```
インスタンスの所有するメソッドがインスタンスメソッドだったように、
インスタンスの所有する変数を**インスタンス変数**と呼びます。
`インスタンス.インスタンス変数名`で代入したり参照したりできます。
ここでは「インスタンス`self`の変数`age`」の値を戻り値として返しています。

`self.age`にはまだ値がありません。
そのまま読み出そうとするとエラーになってしまいますから、
代入して設定するためのメソッドを新しく作ります。
``` python
>>>>>>>>>>
     def setAge(self, age):
         self.age = age
<<<<<<<<<<
```
`self`はレシーバです。そのほかに、`age`という引数をとって、
それを「`self`の`age`」に代入します。
`a`の`setAge()`を呼び出すには`a.setAge(25)`のようにします。
呼び出すときにはレシーバ`self`は自動的に設定されますので、
`self`以外の引数を指定しましょう。

ここまでをまとめてプログラムしてみましょう...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class Hito:
    def getAge(self):
        return self.age
    
    def setAge(self, age):
        self.age = age
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########

        # aさんをつくる
        a = Hito()

        # aさんを25歳にする
        a.setAge(25)

        # aさんの年齢を聞いてageに代入する
        age = a.getAge()
        
        message = "age=%d" % age
        CyInterface().addImmediateMessage(message, "")
```

ゲームを開始して...
{{<img src="/img/kujira_class_11.png">}}
できているようです。

# 自己紹介させる
インスタンス変数やインスタンスメソッドは同じ要領でいくつでも作ることができます。
Hito型に名前を持たせてみましょう。

``` python
>>>>>>>>>>
    def getName(self):
        return self.name
    
    def setName(self, name):
        self.name = name
<<<<<<<<<<
```

これで、`a.setName("Warrior")`や`a.getName()`などとできるようになりました。
もうすこし複雑な例として、名前と年齢から自己紹介っぽい文字列を作るメソッドを見てみましょう。

``` python
>>>>>>>>>>
    def getSelfIntro(self):
        s = "I'm %s, %d years old." % (self.name, self.age)
        return s
<<<<<<<<<<
```


これらを使って...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class Hito:
    def getAge(self):
        return self.age
    
    def setAge(self, age):
        self.age = age

    def getName(self):
        return self.name
    
    def setName(self, name):
        self.name = name

    def getSelfIntro(self):
        s = "I'm %s, %d years old." % (self.name, self.age)
        return s
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########

        # aさんをつくる
        a = Hito()

        # aさんを25歳にする
        a.setAge(25)

        # aさんをジョンにする
        age = a.setName("John")

        # 自己紹介を表示
        message = a.getSelfIntro()
        CyInterface().addImmediateMessage(message, "")
```
こんな感じでしょうか。
ゲームを開始して...
{{<img src="/img/kujira_class_12.png">}}
いいですね！

# コンストラクタ
いまのHito型は、年齢と名前をまず設定しないといけません。
設定しないまま年齢を取得しようとしたり自己紹介を生成しようとすれば
「値がないのに取り出そうとした」のエラーになってしまいます。
どうせ必ず設定しなければいけないのなら、最初にHito型のインスタンスを作るときに
`a = Hito("Emily", 35)`みたいにできれば忘れることもなく安心なような気がします。
それを実現するには、`__init__()`( 前と後ろにアンダーバー(_)2つずつ )というメソッドを定義します。


``` python
>>>>>>>>>>
    def __init__(self, name, age):
        self.name = name
        self.age = age
<<<<<<<<<<
```

そうすると、`a = Hito("Emily", 35)`と書けるようになり、
逆に`a = Hito()`とは書けなくなります。

インスタンスを作るときに呼び出されるメソッドを**コンストラクタ**と呼び、
コンストラクタが要求している(`self`以外の)引数をすべて与えないと
インスタンスを作ることができなくなります。

この仕組みによって、インスタンスにとって必須なインスタンス変数を
設定し忘れるエラーを***未然に防げる***ため、べんりです。

# ふえるインスタンス
インスタンスは1つであるとは限りません。
``` python
>>>>>>>>>>
        a = Hito("John", 25)
        b = Hito("Emily", 35)
        c = Hito("Montezuma", 7)
<<<<<<<<<<
```
むしろこのようにどんどん作っていく方が便利に使えます。
同じクラス(型)から複数の異なるインスタンス(値)が作れるので、
都市型のインスタンス、ユニット型のインスタンス、プレイヤー型のインスタンス
などなどに応用が利くのですね。

Hito型のインスタンスも3人ほど作って、それぞれに自己紹介させてみましょう...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class Hito:
    def __init__(self, name, age):
        self.name = name
        self.age = age
        
    def getAge(self):
        return self.age
    
    def setAge(self, age):
        self.age = age

    def getName(self):
        return self.name
    
    def setName(self, name):
        self.name = name

    def getSelfIntro(self):
        s = "I'm %s, %d years old." % (self.name, self.age)
        return s
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########

        a = Hito("John", 25)
        b = Hito("Emily", 35)
        c = Hito("Montezuma", 7)

        messageA = a.getSelfIntro()
        CyInterface().addImmediateMessage(messageA, "")
        messageB = b.getSelfIntro()
        CyInterface().addImmediateMessage(messageB, "")
        messageC = c.getSelfIntro()
        CyInterface().addImmediateMessage(messageC, "")
```

ゲームを起動して...
{{<img src="/img/kujira_class_13.png">}}
できました！
