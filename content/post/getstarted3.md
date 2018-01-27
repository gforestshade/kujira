+++
date = "2017-07-13"
draft = false
title = "はじめてのPythonMOD 3"
banner = "/photo_yellow1024x200.jpg"
tags = ["はじめてのPythonMOD", "せつめい"]
+++

# はじめに

- [その２]({{<ref "getstarted2.md">}})のつづき
- 関数について

# 準備
Pythonそのものの文法を確かめるのにいちいちCiv4を起動するのでは面倒なので、
小さなPythonプログラムを試せる環境を用意しましょう。
あなたのコンピュータにPythonをインストールしてもよいですし、
現代ではオンライン上で小さなプログラムを試せるサイトもいろいろあるので、
利用させてもらってもよいでしょう。
この記事では[paiza.io](https://paiza.io/)を使うことにします。
コード作成画面に入ったら、左上(緑)の言語選択ボタンから`Python2`を選択し、
``` python
print 1129
```
と入力して、「実行」ボタンを押します。
「出力」のところに`1129`と出ていればOKです。
{{<img src="/img/paiza_0.png">}}

## ちょっとあそぶ
小さいプログラムを書いて遊んでみましょう。
``` python
a = 5
b = 2
if a > 3:
    b = a * a - 5
print b
```
さて、なにが出力されるでしょうか。まず予想を立ててみてください。
予想ができたら、実行してみます。合っていたでしょうか。違っていたでしょうか。

## 関数
Pythonでは、ブロックが上から下に順番に実行されるのは先述の通りですが、
処理をまとめておく方法もあります。
``` python
def doOreore():
    print "oreore,"
    print "oredayo."

doOreore()
```

`def 関数名():`とその直下の「ブロック」が「関数」として「定義」されます。
あとで`関数名()`とすると関数を「呼び出し」ます。
関数名は(かぶらない限り)自由につけて構いませんが、その処理のまとまりは要するに全体で何をするものなのか、
動詞っぽいものをつけておく例が多いようです。

関数の旨みのひとつは一度定義すれば何度呼び出しても構わないことにあります。

``` python
def doOreore2():
    print "oreore,"
    print "oredayo."

doOreore2()
doOreore2()
doOreore2()
doOreore2()
doOreore2()
```

とすると、ひたすら5回もオレオレ詐欺を仕掛けてくるプログラムができるのです。

## 引数
関数のさらに強力なところは、値を外から中に持ち込めるところにあります。

``` python
def doOreore3(son):
    print "oreore,"
    print "oredayo."
    print son
    print "dayo."
    print 

doOreore3("takashi")
doOreore3("yuta")
doOreore3("jiro")
doOreore3("kazuma")
```

(ついてきていますか？焦らず実際に実行しながら進んでくださいね)
定義の時点では変数で記述しておいて、呼び出し時に実際の値を"渡し"ています。
受け渡しを担当している`son`のことを「引数」(ひきすう)あるいは「仮引数」(かりひきすう)と呼びます。
息子の名前だけが違ってあとはほとんど同じ内容をしゃべっていますが、
ほとんど同じな部分をいちいちコピペすることなくほかのおうちに移れるようになっています。
"処理のまとまりに名前が付けられる"という点も強力で、
実際に実行されているのはただのprint文20回分、なのですが、名前があることで
"オレオレ詐欺を4回している"ということが明確になっています。

そういえば、第１回で出てきた`pCity.setPopulation(4)`と今回の`doOreore3("takashi")`がすこし似ていますね。
そうです。`pCity.setPopulation(4)`も関数呼び出しです。
引数に`4`を渡して呼び出しているのですね。
市民を再配置したり、制覇条件を更新したり...とめんどくさい内部処理をすべて請け負って
"要するに何をするのか"わかりやすい名前がついていることで、
やりたいことを素直に記述することに専念できるのです。

## 戻り値
関数は、呼び出した側に値を投げ返すこともできます。
``` python
def three():
    return 3

a = three() * 4
print a
```
関数内で`return 値`にたどり着くと、***その関数の処理を中断して***自分を呼び出したところまで戻ってきます。
その際、`関数名()`という呼び出し文字列全体がその`値`で置き換わります。
この場合の表記法は数式の関数表記法に倣っていますので、数式をご存知の方は馴染みやすいかもしれません。
このとき投げ返す値のことを「戻り値」と呼びます。
呼び出した側は、投げ返されてきた戻り値をさらに何かに活用することができます。

引数を使って戻り値を計算することもできます。
``` python
def square(x):
    return x * x

a = square(5)
print a
```
(実行してみながらついてきてくださいね)
より数学の関数に近い感じになりました。

ずっとお世話になっている`gc.getInfoTypeForString('BUILDING_LIBRARY')`はこのタイプの関数です。
XMLキーの文字列を引数に渡して、それに対応するIDという数値が戻り値として投げ返されるのですね。
わたしたちはその戻り値を変数に代入したり、直接別の関数の引数として渡したりしていました。

# やっとこMOD
前回の`kujira_if`MODをフォルダごとコピーしてリネーム、`kujira_def`というMODを作ります。
``` plain
└─kujira_def
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

## Yet Another 防衛志向
前回は『都市が建設されたとき、その都市の所有者の所属する文明がマリならば、その都市に図書館を建設するMOD』を作りました。

- 都市が建設されたとき
- その都市の所有者の所属する文明がマリならば
- その都市に図書館を建設する

に分けられて、それらは個別に別の条件/処理に変えてしまうことができるのでした。
今回は少し難しくして、『都市が建設されたとき、所有者の志向が防衛志向ならば、その都市のタイルに弓兵を３体即座に作成する』MODを目指します。

## KujiraEventManager.py
というわけで...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

def createUnit(pPlayer, unit, x, y):
    pPlayer.initUnit(unit, x, y, UnitAITypes.NO_UNITAI, DirectionTypes.DIRECTION_SOUTH)

class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityBuilt(self, argsList):
        'Called when a player builds a city'
        super(self.__class__, self).onCityBuilt(argsList)
        ##########
        pCity = argsList[0]
        pPlayer = gc.getPlayer( pCity.getOwner() )
        if pPlayer.hasTrait( gc.getInfoTypeForString('TRAIT_PROTECTIVE') ):
            archerUnit = gc.getInfoTypeForString('UNIT_ARCHER')
            x = pCity.getX()
            y = pCity.getY()
            createUnit(pPlayer, archerUnit, x, y)
            createUnit(pPlayer, archerUnit, x, y)
            createUnit(pPlayer, archerUnit, x, y)
```
こうしてみました。

## Playerが防衛志向を持つなら
`gc.getInfoTypeForString('TRAIT_PROTECTIVE')`とすると防衛志向のIDが戻るのでした。
`iProtec = gc.getInfoTypeForString('TRAIT_PROTECTIVE')`のように変数に代入しておくこともできますし、
`pPlayer.hasTrait( gc.getInfoTypeForString('TRAIT_PROTECTIVE') )`
のように直接引数として渡すこともできます。
下の２つのプログラムは同じ動作をします。

``` python
if pPlayer.hasTrait( gc.getInfoTypeForString('TRAIT_PROTECTIVE') ):
    'something'
```
``` python
iProtective = gc.getInfoTypeForString('TRAIT_PROTECTIVE')
if pPlayer.hasTrait(iProtective):
    'something'
```

[api]: http://civ4bug.sourceforge.net/PythonAPI/

## 弓兵を作成する
[リファレンス][api]のCyPlayerからinitUnitを探すと、こうなっています。

``` plain
CyUnit initUnit (UnitType iIndex, INT iX, INT iY, UnitAIType eUnitAI, DirectionType eFacingDirection)
 
CyUnit* initUnit(UnitTypes iIndex, plotX, plotY, UnitAITypes iIndex) - place Unit at X,Y NOTE: Always use UnitAITypes.NO_UNITAI
```
前半でがんばって勉強したおかげで、これは引数がいっぱいある関数だ！とわかります。
引数をひとつひとつ読んでいきましょう。

UnitType iIndex
: UnitのTypeとあるのでユニットIDですね。作りたいユニットのXMLキーを`gc.getInfoTypeForString()`して
ここに指定すればよさそうです。

INT iX
: INTとあるので数値だということはわかりますが...Xというのはx座標でしょうか。
これはPlayerに対する操作なのでした。Playerは都市と違い
シド星上に特定の位置を占めているわけではありませんから、
そのユニットがどこに降り立つのか教えてあげないといけないのですね。

INT iY
: 同じくy座標です。今回は都市と同じタイル状に生成されてほしいので、PCityの座標を取得する方法を探して
取得した座標をそのまま(同じ数値として)指定したらよさそうですね。

UnitAIType eUnitAI
: UnitAIのTypeなのでユニットAIのIDですね(そのまま)。下の行の注釈に
「どんなときでも`UnitAITypes.NO_UNITAI`を使ってね」
とあるので`UnitAITypes.NO_UNITAI`を指定しておきましょう。

DirectionType eFacingDirection
: FacingなDirectionですから"向いている方向"でしょうか。...ユニットの向いている方向ですね(そのまま)。
DirectionTypeとあるのでこれまた数値指定ですが、"南"を表す数値がもう代入されている変数があるので
利用させてもらいましょう。`DirectionTypes.DIRECTION_SOUTH`です。

## 自分で関数を定義する
`pPlayer.initUnit()`を呼び出すだけの関数`createUnit()`を定義してみましょう...
``` python
def createUnit(pPlayer, unit, x, y):
    pPlayer.initUnit(unit, x, y, UnitAITypes.NO_UNITAI, DirectionTypes.DIRECTION_SOUTH)
```
こうしてみました。
どのPlayer、どのUnit、どこのx座標、どこのy座標 を引数として受け取っています。
別の言い方をすれば、ここではそれらを決めずに、呼び出す側が決める、ということです。

呼び出し側は、例えばこうなります。
``` python
>>>>>>>>>>
archerUnit = gc.getInfoTypeForString('UNIT_ARCHER')
x = pCity.getX()
y = pCity.getY()
createUnit(pPlayer, archerUnit, x, y)
createUnit(pPlayer, archerUnit, x, y)
createUnit(pPlayer, archerUnit, x, y)
<<<<<<<<<<
```

さて、すこし想像力が必要かもしれません。
前半3行では弓兵のユニットID、都市のx座標、都市のy座標を変数に代入していますね。
それらの「値」をいまさっき「定義」した関数に引数として渡しています。
そうすると、pPlayer=所有者, unit=弓兵のユニットID, x=都市のx座標, y=都市のy座標
に相当する「値」が入った状態で`createUnit()`(を定義したところの)のブロックが実行されます。
`Player.initUnit()`を呼び出して...都市と同じタイル上に弓兵が生成されますね。
`createUnit()`を3回同じ引数で呼び出していますから、処理も3回実行され、弓兵が3体できるはずです。

## ためす
{{<img src="/img/kujira_def_10.png" width="800" height="460">}}
{{<img src="/img/kujira_def_11.png" width="800" height="460">}}
できました！

余談ですが、このようなMODを作ったときは、防衛志向に弓が来るかだけでなく、
防衛志向でない指導者には弓が来ないことをちゃんと確認したほうがよいと思います。
防衛志向のみならず金融/哲学に弓が来てしまったら、それはおそらくバグです。
『防衛志向かどうか』の判定がうまくいっていないことを疑う必要があるかもしれません。
