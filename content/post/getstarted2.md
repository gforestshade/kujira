+++
date = "2017-07-12"
draft = false
title = "はじめてのCvEventManager.py 2"
banner = "/green1024x200.png"
tags = ["はじめてのCvEventManager.py", "せつめい"]

+++

# はじめに

- [その１]({{<ref "getstarted1.md">}})のつづき
- 条件分岐を使ってみる

# 準備

前回の`kujira`MODをフォルダごとコピーしてリネーム、`kujira_if`というMODを作ります。
``` plain
└─kujira_if
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

# 選り好みする図書館
前回は『都市が建設されたとき、その都市に図書館を建設するMOD』をつくりました。
しばらくプレイするとわかりますが、このMODは誰の都市か、首都かどうか、などを区別せず、全都市に無差別に図書館を建設します。
それもそのはず、「都市が建設されたとき」以外の条件を付けていないからです。
これだと創造志向があまりにもかわいそうですし、せめて自動建設は首都だけにして少しマイルドにできないでしょうか。

この制限を考慮に入れて、『都市が建設されたとき、その都市が首都であれば、その都市に図書館を建設するMOD』をつくっていきます。

## 文
Pythonのプログラムは1行で1つの処理を表すことになっています。そのひとつひとつの処理を「文」(statement)と呼びます。
基本的に１行で文になるので、`pCity = argsList[0]`や`iLib = gc.getInfoTypeForString('BUILDING_LIBRARY')`も文です。
複数の処理を記述するときは、上から順番に文を並べます。

``` python
a = 4       # aを4にする
b = 8       # bを8にする
c = a + b   # cをa+bの計算結果の値にする
print c     # cの値を出力する
# 12が出力される
```

## if文
ただ順番に実行するだけではない特殊な文がいくつかあります。
そのうちのひとつがif文です。
``` python
if 条件:
    中身の文1
    中身の文2
    中身の文3
    ...
```
条件を満たした場合に限り、"中身"が上から順番に実行されます。
この"中身"のことを「ブロック」(block)と呼びます。

``` python
a = 2           # aを4にする
b = 3           # bを8にする
c = a * b       # cをa*bの計算結果の値にする
if c > 20:      # cが20より大き...くないので中身は実行されない
    a = 4
    b = 5
    c = a * b
print c         # cの値を出力する
# 6が出力される
```
if文は自分のブロックを含めて大きいひとつの「文」です。他の文と混ぜることができ、順番通りに実行されます。
どこからどこまでが「ブロック」なのかは、「空白文字」を使って"字下げ"(indent)することで表します。
書き出しが揃えられている行どうしが同じブロックとして認識されます。
ブロック内の文どうしで揃ってさえいればいいので、何文字分インデントすればいいのかというと、
Pythonのルールとしては何文字分でも構いません。
ただ、基本的には自分ルールで何文字分インデントするかあらかじめ決めておくのがよいでしょう。
Kujiraでは半角スペース4つで統一しています。
空白文字として認識されるのは半角スペースまたはタブ文字です。全角スペースではだめなことにだけ注意しておきましょう。

## KujiraEventManager.py
というわけで...
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
        if pCity.isCapital():
            iLib = gc.getInfoTypeForString('BUILDING_LIBRARY')
            pCity.setNumRealBuilding(iLib, 1)

```
こうしてみました。

``` python
<<<<<<<<<<
        if pCity.isCapital():
            iLib = gc.getInfoTypeForString('BUILDING_LIBRARY')
            pCity.setNumRealBuilding(iLib, 1)
>>>>>>>>>>
```
前回から変わったのはこの部分ですね。
`BUILDING_LIBRARY`の内部数値を取得して/それを建設する という処理をまるごとブロックにして、
`pCity.isCapital()`(pCityは首都か？)の答えが「はい」であるときに限り、実行されるようにしています。

## ためす
これで『都市が建設されたとき、その都市が首都であれば、その都市に図書館を建設するMOD』になったはずです。

{{<img src="/img/kujira_if_10.png" width="800" height="460">}}
{{<img src="/img/kujira_if_11.png" width="800" height="460">}}
できました！

# もう少し進める
これまでは図書館は公平に与えられてきましたが、対象を限定するこの力を使えばちょっとずるしたバージョンもつくれます。
『都市が建設されたとき、その都市の所有者の所属する文明がマリならば、その都市に図書館を建設するMOD』を目指してみましょう。

## その都市の所有者の所属する文明がマリならば
「それがマリの都市ならば」でいいのに、なんだか迂遠な言い方になっていると感じた方もいらっしゃるかもしれません。
これはCiv4の内部データ的に「指導者が都市を所有している」「指導者は文明に属している」になっていることに由来しています。
指導者←都市 に逆引きの後 指導者→文明 をすることは可能でも、
一足飛びに 都市→文明 とすることはできない、ということですね。

より正確には、Playerという概念があります。これは、**実際にシド星に登場している**指導者ひとりひとりのことです。
このとき、操作しているのが**人間であるかAIであるかは問いません。**
もちろん、Playerの状態(ビーカーはどれだけ出ているか・国庫はどれくらいあるか・どんな技術を持っているか・などなど他にもたくさん)はターンごとに刻々と変わっていきます。こういった変わっていくものにも干渉できるというのがXMLではできないPythonでのMODの楽しみのひとつです。

[1]: http://civ4bug.sourceforge.net/PythonAPI/index.html

## 指導者←都市
[リファレンス][1]でCyCityをクリックしてから"player"で検索すると...
``` plain
PlayerType getOwner()
```
それっぽいのがありました。
`PlayerType`とあるので、`ip = pCity.getOwner()`とすると`ip`にはPlayerを表す数値が入るのでしょう。
(覚えていますか？Typeとあるときは数値を表すのでした)
私たちはこのPlayerに対してさらに操作(今回は所属文明という情報の取得)したいのでPlayer本体が欲しいです。
そこで、`pPlayer = gc.getPlayer(ip)`とすると、pPlayerにPlayer本体がぎゅっと入ります。
``` python
ip = pCity.getOwner()
pPlayer = gc.getPlayer(ip)
```
`pCity.getOwner()`で取れた数値をいったん`ip`に代入していますが、直接その番号をgc.getPlayer()することもできます。
そうすると、
``` python
pPlayer = gc.getPlayer( pCity.getOwner() )
```
こうなります。

## 指導者→文明
あらためて[リファレンス][1]でCyPlayerの中から"Civilization"で探すと...
``` plain
CivilizationType getCivilizationType ()
```
ありました。これで`ic = pPlayer.getCivilizationType()`とすれば、`ic`に文明の数値が代入できるのですが、
ここでいう「文明」とはマリとは何か、カルタゴとは何か、という定義です。
MODではXMLであってもPythonであっても、そのような定義を「Info」と呼びます。
「文明」は「Player」や「都市」とちがい、ゲーム中に状態が変化したりはしません。
(私たちがプレイしてるときによく言う"プレイヤー文明"や"AI文明"という概念はここでは「Player」になることに注意してください。)
都市の出力や建造物なんかはどんどん増えていきますが、ゲーム中にマリの指導者が突然徳川家康になったりマリのUBがヒッポドロームになったりはしません。
もしそうなるようなMODを(XMLで)作るのだとしても、マリのUBが最初からヒッポドロームになるのであって、マリのUBがゲームの途中でヒッポドロームに変わるのではないはずです。
ですから、この数値によって取得できるのは「文明のInfo」、すなわち`CivilizationInfo`です。
(ここでいうCivilizationInfoというのはXML編集した時の\<CivilizationInfo\>タグと同じものです！世界がつながってきました。)
というわけで`civinfo = gc.getCivilizationInfo(ic)`としてpPlayerが所属している文明のInfoになったはずです。

長かった道のりもそろそろ終わり、知りたいのはその「文明」がマリかどうか、なのでした。
`civinfo.getType()`として\<Type\>タグが`CIVILIZATION_MALI`になっているかどうかで判断しましょう。
``` python
ip = pCity.getOwner()
pPlayer = gc.getPlayer(ip)
ic = pPlayer.getCivilizationType()
civinfo = gc.getCivilizationInfo(ic)
if civinfo.getType() == 'CIVILIZATION_MALI':
    # 図書館を建設する
```
まとめてこうなります。
Pythonを含め、多くのプログラミング言語では`=`は右辺を左辺に代入する機能しかありません。
「等しいかどうかの比較」には`==`を使います。

## あるいは
CyCity->PlayerType->CyPlayer->CivilizatonType->CivilizationInfo->XMLキー
と一直線につないでいってXML_KEYで比較する方法を見てきましたが、
マリのXMLキー`CIVILIZATION_MALI`からマリを表す数値はたしか
`gc.getInfoTypeForString('CIVILIZATION_MALI')`で取得できたはず、
という発想を試すこともできます。その場合
``` python
pPlayer = gc.getPlayer( pCity.getOwner() )
if pPlayer.getCivilizationType() == gc.getInfoTypeForString('CIVILIZATION_MALI'):
    # 図書館を建設する
```
となります。if文の条件式の左辺はpPlayerの文明ID、右辺はマリの文明IDになっていますから、
もしこれらが等しければpPlayerはマリ所属のはずです。

## くみこむ
どちらの書き方でも意味は同じなのですが、筆者は"あるいは"の方がすきなので、その方式を`KujiraEventManager.py`の`onCityBuilt()`に組み込むと、
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
        pPlayer = gc.getPlayer( pCity.getOwner() )
        if pPlayer.getCivilizationType() == gc.getInfoTypeForString('CIVILIZATION_MALI'):
            iLib = gc.getInfoTypeForString('BUILDING_LIBRARY')
            pCity.setNumRealBuilding(iLib, 1)

```
こうなります。

## ためす
{{<img src="/img/kujira_if_12.png" width="800" height="460">}}
AIマリの都市には最初から図書館が建っていて、
{{<img src="/img/kujira_if_13.png" width="800" height="460">}}
ケルトの都市にはありません。

動きました！
