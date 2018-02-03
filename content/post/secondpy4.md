+++
date = "2017-10-23"
lastmod = "2018-01-30"
draft = false
title = "それからのPython 4"
banner = "photo_pink1"
tags = ["それからのPython", "講座"]
+++

# はじめに

- [その３]({{<ref "secondpy3.md">}})のつづき
- クラス巡り

# 提供されているクラスを探訪してみる
新しいクラスをつくる体験をしたところで、
既存のクラスを使ってみる体験もしてみます。
[APIリファレンス](http://civ4bug.sourceforge.net/PythonAPI/index.html)を見ながら、すすめていきましょう。

左上フレームにリストされているのが、クラス名(型名)です。
ためしにCyCityをクリックしてみましょう。
すると、右フレームにCyCity型のインスタンスメソッドがずらずらーっと出てきます。
CyCity型のメソッドだけでもずいぶん数があります。
流し読みしつつ、気になったのを見ていきましょう。

なお、色付き文字になっているのは**型**です。例えば、
BOOL - ブール型(真と偽の2択)
INT - 数値型
VOID - なし(戻り値を返さないもの)
茶色 - なにかのID(基本的なふるまいはINTと同じ)
緑色 - クラス型
こんな具合です。
<!--more-->

---

筆者が気になったのは、まずこれ。

>
``` plain
19. INT calculateDistanceMaintenance ()
```

距離維持費を計算して返してくれるインスタンスメソッドですね。
最初に書いてあるINTが戻り値の型を表します。この場合は数値型です。
追加の引数がないメソッドは`c = pCity.calculateDistanceMaintenance()`のように
都市のインスタンスさえ用意できれば簡単に呼び出せるので練習台によいですね。

---

次はこれ。

>
``` plain
47. VOID changeExtraHappiness (INT iChange)
48. VOID changeExtraHealth (INT iChange)
```

幸福や衛生を`iChange`ぶんだけ変えてしまうメソッドです。
「やったー！」や「文明により」で追加される幸福や衛生がこれに当たります。
`pCity.changeExtraHealth(3)`とすれば衛生+3にできますね。
数値型の引数をひとつだけ取るメソッドも練習台にはよいです。

---

どんどんいきましょう。

>
``` plain
50. VOID changeFood (INT iChange)
63. VOID changeProduction (INT iChange)
```

食料やハンマーのたまり具合を直接増減させてしまいます。

---

## CommerceとYield
と、ここで、少し用語の説明をしましょう。
**Commerce**と**Yield**についてです。

**Yield**とは**Food**(パン)・**Production**(ハンマー)・**Commerce**(コイン)の総称です。
内部ではこれらをひとまとめで扱い、個々の出力は**YieldID**によって区別します。
たとえばバニラでは、Yield0番が**Food**・Yield1番が**Production**・Yield2番が**Commerce**になっています。
何が何番なのかは`YieldTypes.YIELD_FOOD`などとしても求められるので、
実際にMODを作る際はそちらを使うほうがよいでしょう。

**Commerce**とは**Gold**(ゴールド)・**Research**(ビーカー)・**Culture**(文化)・**Espionage**(スパイポイント)の総称です。
**Commerce**(コイン)と英名がまったく同じなのでものずごく紛らわしいですが、とにかくそうなっています。
コインをスライダーによって振り分けるこの4つの出力を
内部ではひとまとめで扱い、個々の出力は**CommerceID**によって区別します。
たとえばバニラでは、Commerce0番が**Gold**・Commerce1番が**Research**・Commerce2番が**Culture**・Commerce3番が**Espionage**になっています。
何が何番なのかは`CommerceTypes.COMMERCE_ESPIONAGE`などとしても求められるので、
実際にMODを作る際はそちらを使うほうがよいでしょう。
(もちろん、スパイなしのオプションを入れると、Commerce3番は全く出なくなり、
Commerce2番に振り分けられます。MODでもスパイなしオプションに対応する場合は
考慮しなければならないため、いちおう覚えておきましょう。)

---

したがって、CyCity型のインスタンスメソッドでも、
都市のインスタンスから毎ターン何ビーカー出ているか求めたいと思ったとき、

>
``` plain
139. INT getCommerceRate (CommerceType eIndex)
```

`iResearch = pCity.getCommerceRate(CommerceTypes.COMMERCE_RESEARCH)`とする必要があります。
なお、ここでのRateはPer Turn(ターンごと)のRateです。
スライダーで決めるCommerceの割り振り割合ではありません。そちらはCommercePercentと呼ばれています。

---

さらに、図書館などの効果でよくある「ビーカー+25%」のパーセントはCommerceRateModifierです。

>
``` plain
140. INT getCommerceRateModifier (CommerceType eIndex)
```

こちらにより、その都市に合計で+何%の修正があるか取得できます。

---

## ID
なにかのIDの指定を引数で要求してくるメソッドは他にもたくさんあります。
たとえば建造物種IDでいえば、

    229. INT getNumBuilding (BuildingType iIndex)
これは指定した建造物種IDに対応した建造物が都市内にいくつ建っているか
(といっても通常0か1ですが)を取得してくるメソッドです。

建造物種IDは`gc.getInfoTypeForString(XMLキーの文字列)`とすることで求められます。
`if pCity.getNumBuilding( gc.getInfoTypeForString('BUILDING_LIBRARY') ) > 0:`
などとすれば、都市インスタンスに図書館が建っているかどうかを判定できます。

---

IDを要求するのではなく、戻り値として返してくれるメソッドもあります。

    243. PlayerType getOwner ()
都市の所有者のPlayerIDを返してくれます。

# あなたのインスタンスはどこから？
ところで、便利なメソッドがたくさんあるのはいいのですが、肝心のインスタンスは
どこから取得すればよいのでしょうか。
方法は大きく分けて2つあります。

- 関数の引数として渡ってきたものを利用する
- CyGlobalContext型のメソッドにIDを渡して取得する

## 関数の引数として渡ってきたものを利用する
[イベントリスト](http://modiki.civfanatics.com/index.php?title=CvEventManager)を見てみましょう。
たとえば、「建造物が都市で作成されたとき」を表すイベント、
`def onUnitBuilt() `を見てみます。
このイベントの主たる注目点は「どの都市で？」「どのユニットが？」作成されたのか、ということですが、
それらの情報は`argsList`にリストにされて送られてきています。
{{<img src="/img/event_onunitbuilt.png">}}
表を見ると、`argsList`の中身は`city, unit, player`の3つだと書いてあります。

なので、このようにしてみます。
``` python
    def onUnitBuilt(self, argsList):
        'Called when a unit is built in a city'
        super(self.__class__, self).onUnitBuilt(argsList)
        pCity, pUnit、pPlayer = argsList
        ##########
```

`pCity, pUnit, pPlayer = argsList`で`argsList`の中身を3つに分けて代入しています。
ここで代入した変数`pCity`の中身が「ユニットを作った都市」を表すインスタンスになっています。
例えばつづけて`cityname = pCity.getName()`と書けば、
ユニットが作成されるたび、その都市の名前が`cityname`に代入されるようになります。

どうせなので作成されたユニットのインスタンスからも名前を取得してみましょう。
`unitname = pUnit.getName()`です。

さらにさらにどうせですから`u"%sで%sがつくられました。" % (cityname, unitname)`
というフォーマット文字列を作って表示してみましょう...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onUnitBuilt(self, argsList):
        'Called when a unit is built in a city'
        super(self.__class__, self).onUnitBuilt(argsList)
        pCity, pUnit, pPlayer = argsList
        ##########
        cityname = pCity.getName()
        unitname = pUnit.getName()

        message = u"%sで%sがつくられました。" % (cityname, unitname)
        CyInterface().addImmediateMessage(message, "")

```

が、ターンを進めてみても、メッセージが現れず、うまくいきません。
PythonErr.logをみると、13行目で"more than 2 values to unpack."というエラーになっています。
『リストの中身が2個しかないから(3個の変数には)代入できないよ＞＜』ということです。
表を何度見ても3個なのですが......ここは表の方が間違っていたということでしょう。
`pPlayer`を諦めて、`pCity, pUnit = argsList`と書き直します。

しばらくプレイして、ユニット作成報告を楽しみましょう。

しばらく眺めていると、他国のユニットも流れてくることが分かります。
`onUnitBuilt()`は「ユニットが都市で作成されたとき」はいつでも呼び出され、
それが人間プレイヤーの配下であるかどうかはとくに区別されないことがわかります。

# CyGlobalContext型のメソッドにIDを渡して取得する

CyCity型のメソッド`getOwner()`で返ってくるのはPlayerIDでした。
``` python
iPlayer = pCity.getOwner()
```
このIDを持っていったらCyPlayer型のインスタンスを返してくれる関数があったらいいのに...
と思うところですが、それはCyGlobalContext型のインスタンスメソッドとして用意されています。

>
``` plain
208. CyPlayer getPlayer (INT idx)
```

まずCyGlobalContext型のインスタンスを作って、
``` python
gc = CyGlobalContext()
```
インスタンスメソッド`getPlayer()`を呼び出します。
``` python
pPlayer = gc.getPlayer(iPlayer)
```
そうすると、この返ってきた`pPlayer`はCyPlayer型のインスタンスです。

CyGlobalContext型のインスタンスはひとつあれば十分なので、
ファイル冒頭に`gc = CyGlobalContext()`として作ってしまって、
以後`gc`を使いまわすようにしているMODが多いようです。

CyPlayerのインスタンスメソッドでできることは本当に多岐にわたっていて、
とてもここでは説明しつくせない量ですので各自[リファレンス](http://civ4bug.sourceforge.net/PythonAPI/index.html)を見ていただくことにして、

今回は例として「奴隷制」の社会制度を採用しているときにだけ
ユニット作成報告が上がるようにしてみましょう。
奴隷制のXMLキーは`"CIVIC_SLAVERY"`ですから、
`gc.getInfoTypeForString("CIVIC_SLAVERY")`でCivicTypeを取得できます。
そのCivicTypeと、先に手に入れたCyPlayer型のインスタンスを使って、

これを呼び出します。

>
``` plain
328. BOOL isCivic (CivicType eCivic)
```

全部でこうなります...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onUnitBuilt(self, argsList):
        'Called when a unit is built in a city'
        super(self.__class__, self).onUnitBuilt(argsList)
        pCity, pUnit = argsList
        ##########

        iPlayer = pCity.getOwner()
        pPlayer = gc.getPlayer(iPlayer)
        eMan = gc.getInfoTypeForString("CIVIC_SLAVERY")
        
        if pPlayer.isCivic(eMan):
            cityname = pCity.getName()
            unitname = pUnit.getName()

            message = u"奴隷制を採用する%sで%sがつくられました。" % (cityname, unitname)
            CyInterface().addImmediateMessage(message, "")
```

`pCity`が人間プレイヤーの都市とは限らないことに注意してください。
したがって`pCity.getOwner()`で取得したPlayerIDも「そのユニットを作ったPlayer」であって、
必ずしも人間プレイヤーではありません。
そのPlayerのインスタンスが`pPlayer`になるので、それを使って`pPlayer.isCivic(eMan)`と判定すると
「ユニットを作ったPlayerが奴隷制を採用しているなら」を判定していることになります。

それを踏まえて眺めていると...
{{<img src="/img/kujira_class_20.png">}}
奴隷制を採用している文明だけダダ漏れになっています。いいですね。


