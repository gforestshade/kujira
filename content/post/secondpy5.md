+++
date = "2017-11-04"
draft = false
title = "それからのPython 5"
banner = "green"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その４]({{<ref "secondpy4.md">}})のつづき
- もっとクラスをつかう

# インスタンスの中のインスタンス
インスタンス変数にクラス型の変数を使う例を見てみましょう。

題材は、ちょっと賢い建造物クラス`KujiraBuilding`と、
それを用いて『建造された都市で生産されたユニットだけでなく、
その都市で立ち止まったユニットにも衛生兵Ⅰを付与する赤十字』
をつくることです。

``` python
class KujiraBuilding:

    def __init__(self, pCity, pPlot):
        self.pCity = pCity
        self.pPlot = pPlot
        self.iBuilding = gc.getInfoTypeForString("BUILDING_RED_CROSS")
        self.iPromotion = gc.getInfoTypeForString("PROMOTION_MEDIC1")
```

クラス`KujiraBuilding`を作り、コンストラクタ`__init__()`で
`CyCity`型のインスタンス`pCity`と`CyPlot`型のインスタンス`pPlot`を
インスタンス変数として`self`の中に保持します。
ついでに赤十字の建造物IDと衛生兵Ⅰの昇進IDも
数値型のインスタンス変数として保持しておきます。

# 即時的効果と継続的効果
これは筆者の造語なのですが、Pythonで実現できる類の効果はタイミングによって
即時的効果と継続的効果に分類されます。
例えば同じ『衛生兵Ⅰを付与する』という効果にしても、
発動するタイミングによって、

『プロジェクトAが完成したとき自文明の全ユニットに』
でしたら一回ぽんと発生して終わりですし、
(この類の効果はプロジェクトに多いです)

『建造物Bが建っている都市にユニットが駐留したとき』
ならば建造物Bが建ってから何らかの理由で壊されるまでずっと
効果が発生し続けることになります。
(この類の効果は建造物に多いです)

という違いが生じてきます。
...なのですが、実のところPythonで『ずっと』を表現する手段はありません。
継続的効果を作りたい場合であっても、
どうにかして即時的効果に読み替える必要が出てきます。

そこで役に立つことがあるのが、『ターン処理開始時に』というタイミングです。
少しゆるい言葉で言うなら、『～を毎ターン行う』ということです。
毎ターン毎回即時的効果のチェックをするなら継続してるっぽく見えるだろう、
ということですね。

つまりたとえば、
『ターン処理開始時に、各都市を調べ、その都市に赤十字があるならば、
その都市が建っている地点の、その地点にいる各ユニットに、衛生兵Ⅰを持たせる』
とすることで、継続的効果っぽく見せることが可能になるのです。

# 毎ターン各都市で
というわけで、ターン処理開始時に都市のインスタンスをまとめて取得したいのですが、
なんとそれをやってくれるイベントがあらかじめ存在しています。
うれしいですね。`onCityDoTurn()`です。

``` python
<<<<<<<<<<
    def onCityDoTurn(self, argsList):
        'Called every turn for every city'
        super(self.__class__, self).onCityDoTurn(argsList)
        pCity, iPlayer = argsList
        ##########
<<<<<<<<<<
```
`argsList`の0番目はいま注目すべき都市のインスタンス、
1番目はいま誰のターン処理中かのプレイヤーIDです。

このメソッド中で、`KujiraBuilding`クラスを使ってみることにしましょう...
``` python
>>>>>>>>>>
        # インスタンスpCity()とその地点pCity.plot()をもとにして
        # KujiraBuildingのインスタンスをつくる
        kuBuil = KujiraBuilding(pCity, pCity.plot())
        
        # つくったインスタンスのメソッドを呼び出す(中身はまだない)
        # ユニットに昇進を与えるっぽい名前にしておく
        kuBuil.giveUnitsPromotion()
<<<<<<<<<<
```

# 効果を書こう

まだ書いてもいないインスタンスメソッドを呼び出すよう書いてしまったので、
KujiraBuildingの定義の中に戻って書いていきましょう...

``` python
class KujiraBuilding:

    # ...(中略)...
        
    def giveUnitsPromotion(self):
        if self.pCity.getNumBuilding(self.iBuilding):
            N = self.pPlot.getNumUnits()
            for i in range(N):
                pUnit = self.pPlot.getUnit(i)
                pUnit.setHasPromotion(self.iPromotion, True)
```

`self.pCity`, `self.pPlot`, `self.iBuilding`, `self.iPromotion`の
4つのインスタンス変数を使っています。
それぞれの中身の値がなんだったか忘れてしまった方は
コンストラクタのところまで戻って復習しておきましょう。

まず『その都市に赤十字があるならば』ですね。
`CyCity`のインスタンスメソッドにお願いして調べてもらいます。

    229. INT getNumBuilding (BuildingType iIndex)

指定した建造物IDが自身のインスタンスにいくつあるか数値で返します。
たとえば赤十字があるかどうか調べたいときには次のようにします。

``` python
>>>>>>>>>>
        if self.pCity.getNumBuilding(self.iBuilding):
<<<<<<<<<<
```

(難しいですか？`self.pCity`が都市のインスタンス、`self.iBuilding`が建造物IDだったことを思い出してくださいね。)

勘がよい方は`self.pCity.getNumBuilding(self.iBuilding)`
の戻り値の数値を何とも比較していないことにお気づきになるかもしれません。
もちろん、意味をそのまま書き下して
`if self.pCity.getNumBuilding(self.iBuilding) == 1:`
としてもかまわないのですが、
if文にはTrueでもFalseでもない値を入れてもいい感じに判定してくれる機能があります。
その基準はこうです。([はじめての その4]({{<ref "getstarted4.md">}})から転載)

if文において「真」と解釈されるもの

- `True`
- その他「偽」と解釈されるもの以外全部

「偽」と解釈されるもの

- `False`
- 数値の`0`
- 空の文字列`""`
- 空のタプル`()`・空のリスト`[]`・空のディクショナリ`{}`
- `None`

`0`が「偽」の仲間になっているところがポイントです。
「真」の条件より、`0`以外の数値はif文においては「真」扱いになります。

建造物数が0なら、「ない」と判定されて正しいですし、
建造物数が1なら(もしくは2以上だったとしても！)「ある」と判定されて正しいですね。


次は『その地点にある全ユニットに対し』です。
`CyPlot`のインスタンスメソッド2つの合わせ技で実現します。

    56. INT getNumUnits ()
    81. CyUnit getUnit (INT iIndex)

「CyPlotのインスタンスが表している地点」にいる`i`番目のユニットは
`pPlot.getUnit(i)`で取得できます。
が、そもそもその地点に全部でユニットが何体いるのかわからないと
何人分ユニット取得すればよいのかわかりません。
そこであらかじめ「CyPlotのインスタンスが表している地点」にいるユニットの数を
`N = pPlot.getNumUnits()`で取得しておきます。

そうしてから、for文で`N`回ループしてあげればよいですね。こうなります。

``` python
>>>>>>>>>>
            N = self.pPlot.getNumUnits()
            for i in range(N):
                pUnit = self.pPlot.getUnit(i)
<<<<<<<<<<
```

得られたユニットのインスタンス`pUnit`をつかって、昇進をつけましょう。
CyUnitのインスタンスメソッドからそれっぽいのを探します。

    292. VOID setHasPromotion (PromotionType eIndex, BOOL bNewValue)

そのインスタンスの昇進ID`eIndex`の取得状況を`nNewValue`に書き換えます。
つまり『持たせる』というよりは『持っているかどうか、のデータをTrue(そうです)に書き換える』のですね。
``` python
>>>>>>>>>>
                pUnit.setHasPromotion(self.iPromotion, True)
<<<<<<<<<<
```
...とすればよいでしょう。

# ためす
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class KujiraBuilding:

    def __init__(self, pCity, pPlot):
        self.pCity = pCity
        self.pPlot = pPlot
        self.iBuilding = gc.getInfoTypeForString("BUILDING_RED_CROSS")
        self.iPromotion = gc.getInfoTypeForString("PROMOTION_MEDIC1")
        
    def giveUnitsPromotion(self):
        if self.pCity.getNumBuilding(self.iBuilding):
            N = self.pPlot.getNumUnits()
            for i in range(N):
                pUnit = self.pPlot.getUnit(i)
                pUnit.setHasPromotion(self.iPromotion, True)
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityDoTurn(self, argsList):
        'Called every turn for every city'
        super(self.__class__, self).onCityDoTurn(argsList)
        pCity, iPlayer = argsList
        ##########

        kuBuil = KujiraBuilding(pCity, pCity.plot())
        kuBuil.giveUnitsPromotion()
```

[はじめての その5]({{<ref "getstarted5.md">}})で書いたMODとタイミングが違うだけで
効果はほとんど同じですが、効果の処理のほとんどが
自作クラスのインスタンスメソッドに分離されていることが見た目からもわかります。

# 変数のスコープ
変数には、「変数がつくられた関数内でしか使えない」という制限があります。
変数が使える範囲を、その変数の「スコープ」と呼びます。

## 普通の変数
通常の変数のスコープは、その関数内です。

``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class KujiraBuilding:

    def __init__(self, pCity, pPlot):
        self.pCity = pCity
        self.pPlot = pPlot
        self.iBuilding = gc.getInfoTypeForString("BUILDING_RED_CROSS")
        self.iPromotion = gc.getInfoTypeForString("PROMOTION_MEDIC1")
        
    def giveUnitsPromotion(self):
        if self.pCity.getNumBuilding(self.iBuilding):
            N = self.pPlot.getNumUnits()
            for i in range(N):
                pUnit = self.pPlot.getUnit(i)
                pUnit.setHasPromotion(self.iPromotion, True)

    def makeI(self):
        i = 15 # iに15を代入しておく

    def useI(self):
        # iの値を使おうとするが...
        a = i + 20 # エラー！ iという変数はもはや存在しない
        
        return a
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityDoTurn(self, argsList):
        'Called every turn for every city'
        super(self.__class__, self).onCityDoTurn(argsList)
        pCity, iPlayer = argsList
        ##########

        kuBuil = KujiraBuilding(pCity, pCity.plot())
        kuBuil.giveUnitsPromotion()

        kuBuil.makeI()
        result = kuBuil.useI()
```
不便に思えますが、悪いことばかりではありません。
関数をまたぐと消えてしまうということはむしろ、
「『この名前の変数はどこかで使ってたっけ、上書きしても大丈夫かな...』と考える必要がなくなる」
ということでもあるからです。
特にこのことは、関数が100を超えるような中規模以上のMODで
プログラムのすべてを頭の中に収めることができなくなってくる規模になってから
大変違いが生じてくるので、できれば最初のうちから
***それでも関数は分割する***ようにしておくのがよいです。

MODのすべてを自分が書いているわけではない場合にも
スコープがあることは利点になります。
関数さえまたいでいれば、変数の名前をうっかり被らせてしまい、
値を勝手に変更して元の部分の動作をおかしくしてしまう危険がゼロになるからです。
MODMODを開発するようなとき、
この種のバグは***ものすごく見つけづらい***ので、
発生する心配自体がないというのは心強いですね。

## インスタンス変数
それでも、この値は保存しておかないと困る！という需要にお応えするのが
インスタンス変数です。
インスタンス変数のスコープはそのクラス内に拡大されます。
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class KujiraBuilding:

    def __init__(self, pCity, pPlot):
        self.pCity = pCity
        self.pPlot = pPlot
        self.iBuilding = gc.getInfoTypeForString("BUILDING_RED_CROSS")
        self.iPromotion = gc.getInfoTypeForString("PROMOTION_MEDIC1")
        
    def giveUnitsPromotion(self):
        if self.pCity.getNumBuilding(self.iBuilding):
            N = self.pPlot.getNumUnits()
            for i in range(N):
                pUnit = self.pPlot.getUnit(i)
                pUnit.setHasPromotion(self.iPromotion, True)

    def makeI(self):
        self.i = 15 # インスタンス変数iに15を代入しておく

    def useI(self):
        # iの値を使おうとするが...
        a = self.i + 20 # 参照できる
        return a
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityDoTurn(self, argsList):
        'Called every turn for every city'
        super(self.__class__, self).onCityDoTurn(argsList)
        pCity, iPlayer = argsList
        ##########

        kuBuil = KujiraBuilding(pCity, pCity.plot())
        kuBuil.giveUnitsPromotion()

        kuBuil.makeI()
        result = kuBuil.useI() # 35が返ってくる
```

インスタンス変数はインスタンスに紐づいている変数なので、
インスタンス本体が生きている限り消えてもらっては困りますのでこうなっています。
この場合も、同じインスタンスに対するインスタンス変数が共有されるだけで、
別のインスタンスのインスタンス変数は当然別の変数ですから、
(`a.i`と`b.i`は別の値を取ります)
インスタンスさえ分けてしまえば影響範囲を最小限に抑えることができるといえそうです。

## グローバル変数
一応、スコープがファイル内全体になる変数も存在して、「グローバル変数」と呼びます。
クラス定義や関数定義などのさらに外に記述してある代入文がグローバル変数の定義になり、
上の例では`gc = CyGlobalContext()`がそれにあたります。
確かに、ファイル内のどこからでも`CyGlobalContext`型のインスタンス`gc`を使用できていましたね。

グローバル変数に対して関数内から代入して値を上書きすることは基本的には***できません***。<!-- 普通にやろうとすると同名のローカルスコープな変数に対して代入される。globalキーワードを使えばできるのだが、そうしなければならないほど再代入には慎重になるべきだということである。 -->
それができてしまうと結局上記の問題の抜け道になるだけなので、当然ですね。

Civ4のMODでは、プログラムの時点で固定の値(＝ゲーム中に一切変更されない値)を入れておくのに使えますが、
固定の値を返す関数のほうが適切な場合もままあるので、
使用には慎重に行きたいところです。
