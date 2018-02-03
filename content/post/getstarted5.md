+++
date = "2017-07-30"
lastmod = "2018-01-28"
draft = false
title = "はじめてのPythonMOD 5"
banner = "photo_yellow"
tags = ["はじめてのPythonMOD", "せつめい"]
+++

# はじめに

- [その４]({{<ref "getstarted4.md">}})のつづき
- リストと繰り返し
- 他のイベント

# 今日のMOD
## 準備
例によって`kujira_for`というMODを作ります。
`kujira_if`をフォルダごとコピーして、フォルダ名をリネームしましょう。
``` plain
└─kujira_for
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

## 構想
《建造物が建設されたとき、その建造物がダンならば、
　都市と同じタイル上にいる全ユニットに教練Ⅰと教練Ⅱを与えるMOD》
を作りましょう。
捕まえるイベントをいつもと変えているほか、ユニットへの操作を入れています。

バニラの建造物によくある
「この都市で生産されたユニットに教練Ⅰと教練Ⅱ」
との違いに注意してください。
今作ろうとしているのはダンが建設完了したその瞬間に
都市直上にいたユニットに影響を与える一回限りの即時的な効果です。

<!--more-->

## 建造物が建設されたとき

KujiraEventManager.pyをこのようにします...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        ##########
        CvUtil.pyPrint("onBuildingBuilt: called")
```

前回からの変更点はこの部分です...
``` python
>>>>>>>>>>
def onBuildingBuilt(self, argsList):
    'Called when a building is built'
    super(self.__class__, self).onBuildingBuilt(argsList)
<<<<<<<<<<
```
`onCityBuilt`だったところを`onBuildingBuilt`に変えています。

[イベントのリスト](http://modiki.civfanatics.com/index.php?title=CvEventManager)からonBuildingBuiltを探すと、

>
``` plain
Function: def onBuildingBuilt()
Parameters: self, argsList (pCity, iBuildingType)
Description: Called when a building is built
```

となっています。
argsListに2つの値が入っているようです。例えば、

``` python
>>>>>>>>>>
pCity = argsList[0]
iBuildingType = argsList[1]
<<<<<<<<<<
```
などとして取り出すことができます。今回はこの`[0]`とか`[1]`とかいう書き方について。

# 今日の理論編
Python実行環境を用意しましょう。
一応埋め込みも置いておきます。
<iframe src="https://paiza.io/projects/e/WmGaoo_zPs6GaaW9LGFx0A?theme=twilight" width="100%" height="500" scrolling="no" seamless="seamless"></iframe>

## リスト
**リスト**とは、**要素**を順番に並べたもののことです。次のようにして作成します。
``` python
a = [2, 3, 5, 7, 11]
```
それぞれの**要素**は**0番目**・**1番目**・**2番目**......と順番が割り当てられていて、
`a[2]`として**2番目**を取り出すことができます。
試してみましょう。

``` python
a = [2, 3, 5, 7, 11]
print a[0]
print a[1]
print a[2]
print a[3]
print a[4]
```
何が出力されるでしょうか。予想して、実行してみましょう。
この番号の部分を**インデックス**(index)と呼びます。

**インデックス**は数値ですが、「整数を表すなにか」であれば
整数そのものである必要はありません。
``` python
def f(x):
    return x*x

a = [13, 17, 23, 29, 31, 37]
b = 5
print a[1]    # 数値
print a[b]    # 数値入り変数
print a[f(2)] # 関数の戻り値
```
頑張って予想しましょう。
`a = [13, 17, 23, 29, 31, 37]`とあることから、

- 0番目: 13
- 1番目: 17
- 2番目: 23
- 3番目: 29
- 4番目: 31
- 5番目: 37

となっています(番号は0から始まるのでした)。

`a[1]`は直接1番目の要素を参照していますから`17`ですね。
`b`は`5`ですから、`a[b]`はaの5番目の要素を指すはずです。`37`ですね。

`f(2)`は何でしょうか。関数の定義の部分に戻ってみると、
引数の`x`を`x*x`にして返しているようです。
いま、引数に`2`を渡していますから2*2で`4`ですね。
呼び出した部分がそのまま戻り値である`4`に置き換わるのでしたから
`a[4]`となり、`31`になります。
さて予想もできたところで本当にそうなるか実行してみましょう。

要素数が十分少ないなら、左辺を`,`で区切って順番に全て取り出すこともできます。
<!-- シーケンス型(正確に言えばiterableな型)のunpack。概念は難しいがイディオムとして便利なのでここで紹介。 -->
``` python
a = ["apple", "orange", "banana"]
e, f, g = a
print e
print f
print g
```
予想して、実行してみましょう。

## 繰り返し
どうせ全要素printするのなら、「リストの各要素に対して、」という表現があれば便利です。
というわけで、**for文**がそれにあたります。
例えばこのように書きます。
``` python
fib = [1, 1, 2, 3, 5, 8, 13, 21, 34]
for i in fib:
    print i
```
`fib`の要素を1つずつ取り出して`i`に代入しつつ、中のブロックを実行します。
ブロックを実行し終わったらまた次の要素を`i`に代入して、中のブロックを実行します。
これを、リストの要素が尽きるまで"繰り返し"ます。
上のプログラムを実行して動作を確かめてみましょう。

リストの内容分繰り返したいのではなく、ただ単に10回繰り返したいときもあるでしょう。
10個の要素を持ったリストを手作りすればよいのですが、めんどくさいですし、
数え間違いなどが起こってもいやですので、`range()`という関数を使います。
これは、0以上n未満の整数のリストを作って返してくれます。
動作を見てみましょう。
``` python
print range(15)
```
中の数字をいろいろいじっていろいろ実行してみるとよいでしょう。
(なるほどなるほどー。)

これを使って、このように書けます。
```python
for i in range(10):
    print i, "banme"
```
`range()`の動作をいろいろ試した方なら、予想できるかもしれません。
予想してから、実行してみましょう。

for文を学んだことで、例えばもし、
「タイル上のユニット数を取得する関数」と、
「i番目のユニットを取得する関数」があったなら、
このように書けるはずです。
``` python
nUnits = ユニット数を取得
for i in range(nUnits):
    pUnit = ユニット取得(i)
    pUnit.いろいろ...
```
`nUnits`回だけブロックを繰り返しますから、
タイル上の全ユニットになにかしていることになるはずです。
夢が広がりますね。

# MODへ戻る
## onBuildingBuilt

というわけで、`onBuildingBuilt()`の`##########`より下をこうしてみました...
``` python
>>>>>>>>>>
##########
pCity, iBuildingType = argsList

if iBuildingType == gc.getInfoTypeForString('BUILDING_CELTIC_DUN'):
    plot = pCity.plot()

    for i in range( plot.getNumUnits() ):
        pUnit = plot.getUnit(i)
        pUnit.setHasPromotion(gc.getInfoTypeForString('PROMOTION_DRILL1'), True)
        pUnit.setHasPromotion(gc.getInfoTypeForString('PROMOTION_DRILL2'), True)
<<<<<<<<<<
```
全体像だけ見てみると、インデントが入れ子になっていることが分かります。
for文も文ですから、if文のブロックの一員にすることができて、
しかしfor文自身の中身ブロックはそれとは区別しなければなりませんから
さらに空白文字を足さなければならないのですね。


さて、`argsList`が何だったかというと、`onBuildingBuilt()`においては
`[pCity,iBuildingType]`という**リスト**なのでした。
<!-- 本当はリストじゃなくてタプルかもしれない。多分リスト。どのみちシーケンス型なので書き方には影響はない。 -->
ので、このようにして取り出すことが[できるのでした](#リスト)...
``` python
>>>>>>>>>>
pCity = argsList[0]
iBuildingType = argsList[1]
<<<<<<<<<<
```
あるいは
``` python
>>>>>>>>>>
pCity, iBuildingType = argsList
<<<<<<<<<<
```

`iBuildingType`は今まさに建ったその建造物のTypeを表しているので、
それがダンかどうかはこのようにすればわかります...
``` python
>>>>>>>>
if iBuildingType == gc.getInfoTypeForString('BUILDING_CELTIC_DUN'):
<<<<<<<<
```
(`gc.getInfoTypeForString()`の働きは大丈夫ですね？キーを対応する種類IDに直す関数なのでした)

さて、ゲーム中、各タイルの状況は刻々と変わります。
(上に乗っているユニットや、建っている改善や、道が引かれているか、鉄道はどうか、etc...)
なのでこれにも例によって新しい名前があります。**Plot**(地点)です。
**Terrain**(地形)や**Improvement**(改善)といったものが**Plot**の制御下にあるほか、
**Unit**や**City**は自分がどこにあるかの情報を**Plot**でもっています。
たとえば`PCity.plot()`として`pCity`の**Plot**を取得できます。

そして、`plot`上にあるユニットの数は`plot.getNumUnits()`、
`plot`上の`i`番目のユニットは`plot.getUnit(i)`で取得できます。
`pUnit = plot.getUnit(i)`と受けてあげることで
各**Unit**に操作ができるようになります。

今回は昇進を与えたいのでしたから、[リファレンス][api]のCyUnitからpromotionで探すと...

>
``` plain
VOID setHasPromotion (PromotionType eIndex, BOOL bNewValue)
void (int (PromotionTypes) eIndex, bool bNewValue)
```

結構たくさんヒットしましたが、「昇進を無償で与える」に該当しそうなのはこれでしょうか。
PromotionType eIndex は例によって昇進の種類IDなのでいいとして、
もうひとつBOOL bNewValueという引数をとっています。
これは昇進を持っている状況を`True`、持っていない状況を`False`とみなしているのですね。

つまり「昇進を持つようにする」と「昇進の所持状況を`True`にする」を同一視しているのです。
もちろん逆に「昇進を剥奪する」と「昇進の所持状況を`False`にする」が同一視されるわけです。

ここまでわかれば教練Ⅰを持たせられます。
`pUnit.setHasPromotion(gc.getInfoTypeForString('PROMOTION_DRILL1'), True)`ですね。

[api]: http://civ4bug.sourceforge.net/PythonAPI/index.html

## KujiraEventManager.py
全体でこうなります...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        ##########
        pCity, iBuildingType = argsList

        if iBuildingType == gc.getInfoTypeForString('BUILDING_CELTIC_DUN'):
            plot = pCity.plot()

            for i in range( plot.getNumUnits() ):
                pUnit = plot.getUnit(i)
                pUnit.setHasPromotion(gc.getInfoTypeForString('PROMOTION_DRILL1'), True)
                pUnit.setHasPromotion(gc.getInfoTypeForString('PROMOTION_DRILL2'), True)

```

## ためす
起動して、ユニットを貯めて、ダンを建てて...
{{<img src="/img/kujira_for_10.png">}}
できました！
