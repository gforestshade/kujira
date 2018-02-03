+++
date = "2017-08-07"
lastmod = "2018-01-29"
draft = false
title = "はじめてのPythonMOD 7"
banner = "photo_yellow"
tags = ["はじめてのPythonMOD", "講座"]
+++

[api]: http://civ4bug.sourceforge.net/PythonAPI/index.html

# はじめに
- [その６]({{<ref "getstarted6.md">}})のつづき
- XMLとPythonの合わせ技・Python編

# Python
残った効果「都市圏内をすべて草原化する」なんてことは
XMLでできるはずもありません。Pythonで実装していきましょう。

## 構想
いつもどおり、「いつ・どういう条件で・何をするか」を明らかにする必要があります。
「建造物が建ったとき」「それが肥沃化の神殿であれば」まではすぐにわかります。
「都市圏内を草原化する」............都市圏内とは何でしょうか？

<!--more-->

## 都市圏とは
{{<img src="/img/kujira_fert_city_area.png" width="300" height="300">}}
このように図を使えばなんとなくわかるのですが、
『ここからここまで』というのをちゃんとした言葉で、
ひいてはプログラムで表現できないとMODとしては動いてくれません。

まず、それは**Plot**の**リスト**と考えることができます。

+ 都市から←←↑と動いたところにある**Plot**
+ 都市から←←　と動いたところにある**Plot**
+ 都市から←←↓と動いたところにある**Plot**
+ 都市から←↑↑と動いたところにある**Plot**
+ 都市から←↑　と動いたところにある**Plot**
+ 都市から←　　と動いたところにある**Plot**
+ 都市から←↓　と動いたところにある**Plot**
+ 都市から←↓↓と動いたところにある**Plot**
+ 都市から↑↑　と動いたところにある**Plot**
+ 都市から↑　　と動いたところにある**Plot**

これで半分。ぜひ図を書いて、どのタイルに相当するかを考えながら読んでください。

+ 都市から↓　　と動いたところにある**Plot**
+ 都市から↓↓　と動いたところにある**Plot**
+ 都市から→↑↑と動いたところにある**Plot**
+ 都市から→↑　と動いたところにある**Plot**
+ 都市から→　　と動いたところにある**Plot**
+ 都市から→↓　と動いたところにある**Plot**
+ 都市から→↓↓と動いたところにある**Plot**
+ 都市から→→↑と動いたところにある**Plot**
+ 都市から→→　と動いたところにある**Plot**
+ 都市から→→↓と動いたところにある**Plot**

そして忘れてはいけない

+ 都市直下の**Plot**

《これら21個の**Plot**それぞれについて、**Terrain**(地形)を**Grass**(草原)に変更する》
ことが今回の目標です。

## Plotの座標
マップ上のPlotは、マップの左下隅を(0,0)として、
そこから何歩分進めばそのPlotに到達するか、という数字で表すことができます。
→に進むことをx座標を+1すると呼び、↑に進むことをy座標を+1すると呼びます。
(0,0)を起点に→→↑↑↑と進んだところにあるPlotはx座標が+2、y座標が+3になっています。
逆にx座標が+2、y座標が+3であるPlotを座標(2,3)にあるPlotと呼ぶことにします。

{{<img src="/img/kujira_fert_coordinate.png" width="300" height="300">}}
各Plotの座標を書き込んでみた図。
数学が得意な方は、大体数学の2次元座標と同じと思っていただいてよいですが、
点でなくマス全体に座標が割り当てられている点、
それゆえ座標は0以上の整数しかとらない点に注意してください。

## ラップ
普通のマップスクリプトに慣れた方は、「いやそもそもマップの左下隅ってどこ？」と思われたかもしれません。
確かに「ラップ：円筒形」だと左下隅がどこかわかりづらいので、
いつものマップスクリプトで「ラップ：平面」にしてマップを作ってみてください。
マップの端が確かに存在していることが分かります。

この「ラップ：平面」の状態のマップを『くるんっ』と巻いて、
左端と右端をくっつけて円筒型にしたものが「ラップ：円筒形」です(だから円筒という名前なのですね)。
円筒形のマップであっても、巻いてくっつける前の元になった平面のマップで、
左下隅であったタイルが(0,0)です。
ゲーム画面右下のミニマップは平面だったころの姿を映していますので、それを参考にするとよいでしょう。

{{<img src="/img/kujira_fert_10.png">}}
実際に円筒形のマップで座標(0,0) (マップ左下隅)に都市を建ててみた例。
ミニマップ右下のほうにも文化圏があることが分かります。
ゲーム上では左端と右端はつながっていますから、１つの文化圏に見えています。

そして、実際のコードで`plot`のx座標は`plot.getX()`で、y座標は`plot.getY()`で取得することができます。
また逆に、座標(`ix`,`iy`)にあるPlotは`gc.getMap().plot(ix, iy)`とすることで取得することができます。

## ラップしてるほう
座標からPlotを取得するときには、x方向にマップがラップしている場合、
つまり右端と左端がつながっている場合、
実際の平面マップを超えたx座標を指定することもできます。

例えば3x3の小さい円筒形のマップを考えましょう。
{{<img src="/img/kujira_fert_wrapx.png" width="600" height="200">}}
ラップしているマップの境目ではいきなりx座標が逆の端に戻るため、
x座標に+1することが必ずしもマップ上を→に移動することとは一致しません。
例えば座標(1,1)の→のPlotはx座標に+1して座標(2,1)ですが、
座標(2,1)の→のPlotは左端に戻って(0,1)であり、(3,1)ではありません。
勢いあまって座標(3,1)を指定してしまっても、空気を読んで座標(0,1)のことだと解釈してくれたらいいのに...
と思っていたら、なんと、最初からその機能が`gc.getMap().plot()`にはついています。

ですので、実はラップしている方向に関してはあまり深く考える必要はありません。
たとえマップのつなぎ目であっても、
x座標を+1することと→へ1マス進むことは常に同じですし、
たとえマップのつなぎ目であっても、
x座標を-1することと←へ1マス進むことは常に同じです。
x座標をはみ出して指定しても、端から端へ飛ぶ計算をよしなにやってくれます。
エラーにはなりません。

{{<img src="/img/kujira_fert_wrapx_2.png" width="600" height="200">}}
↑こうやって指定しても

{{<img src="/img/kujira_fert_wrapx.png" width="600" height="200">}}
↑こうやって解釈される

## ラップしてないほう
ですがそれも、ラップしている方向だけです。

{{<img src="/img/kujira_fert_10.png">}}
円筒形マップの(0,0)に都市を建てた様子をもう一度見てもらうとわかりますが、
マップの一番下よりさらに下はそもそも存在していません。
文化圏も完全に切れてしまっていることがわかります。
範囲外のy座標を`gc.getMap().plot()`で取得しようとしても
単に存在しないとしてエラーになってしまいますから、
そのような座標はそもそも指定しないようにしなければいけません。

# 実装
## 座標の有効性を判定する
というわけで、こんな関数を作ります。
``` python
def isValidPlot(x, y):
    pMap = gc.getMap()

    bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
    by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
    return bx and by
```

`gc.getMap()`で**Map**が取得できます。マップの大きさ、気候、大陸の情報などがここから取得できます。
`pMap = gc.getMap()`と受けたとして、今回使うのはこれらです。

`pMap.isWrapX()`
:    x軸方向(左右)にラップしているならTrue、していないならFalse

`pMap.isWrapY()`
:    y軸方向(上下)にラップしているならTrue、していないならFalse

`pMap.getGridWidth()`
:    マップの幅(横幅)をタイル数換算の数値で返す

`pMap.getGridHeight()`
:    マップの高さ(縦幅)をタイル数換算の数値で返す

まず、「x軸方向にラップしているなら、x座標としてはみ出した値を指定してもエラーにならない」のでした。
なので、この場合はx座標によらず、x軸方向についてOKということにしたいです。

また、「x座標が"0～横幅"までに収まっていてくれるならやはりOK」と言えそうです。
正確には左端のx座標が0、右端のx座標が(横幅-1)ですから、
(なぜそうなるか、余裕のある方は上の3x3の例を見て考えてみてください)
『「x座標が0以上」と「x座標が横幅"未満"」の両方』を満たした場合、
この場合もx軸方向についてOKを出します。

あわせてこうなります...
``` python
<<<<<<<<<<
bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
>>>>>>>>>>
```
どちらかが`True`ならx座標の有効性としても`True`にしたいので、`or`を使っていることに注意してください。
まったく同様にy軸方向について...
``` python
<<<<<<<<<<
by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
>>>>>>>>>>
```
これが`True`なら、y座標として有効な座標であると判定できそうです。
最後に、x座標とy座標の両方が有効な範囲にある必要があります。
``` python
>>>>>>>>>>
return bx and by
<<<<<<<<<<
```
こうですね。

これで、
「x座標とy座標を引数にとって、それは有効な座標か？
　その座標のPlotを取得しようとしてもエラーにならないか？」
を判定する関数ができました。

## 座標のリスト？座標の差分のリスト？
たとえば、座標(2,3)から周囲1マスの全Plotのリストを作ることを考えます。
{{<img src="/img/kujira_fert_plotlist1.png" width="300" height="300" >}}

基準のマスからどのように動くと自分のマスにたどり着くかを図にして...
{{<img src="/img/kujira_fert_diff.png" width="300" height="300" >}}

それを

- →:x座標に+1
- ←:x座標に-1
- ↑:y座標に+1
- ↓:y座標に-1

に従って"座標の差分"に直すとこうなります。
{{<img src="/img/kujira_fert_diff2.png" width="300" height="300" >}}
これは基準のマスからの"座標の差分"になっています。
例えば、左上に書いてある+(-1,1)を基準の(2,3)に足すと(1,4)になり、
これは最初の図で(2,3)の左上のマスが(1,4)であることと一致しています。
<!-- これは要するに2次元ベクトルの加算です. -->

つまりこれらの座標の差分のリスト
``` python
range1 = [
 (-1,-1),
 (-1, 0),
 (-1, 1),
 ( 0,-1),
 ( 0, 0),
 ( 0, 1),
 ( 1,-1),
 ( 1, 0),
 ( 1, 1),
 ]
```
を逐次中心座標に足していくことで周囲1マスの全Plotを得ることができそうです。
なお、リストの要素を書き並べている最中は改行しても文の終わりとはみなされません。
なので、このように各自で見やすいように整形して書くことができます。

コードにするとこうなるでしょうか...
``` python
>>>>>>>>>
lPlot = []
for li in range1:
    ix = pCity.getX() + li[0]
    iy = pCity.getY() + li[1]

    if isValidPlot(ix, iy):
        lPlot.append( gc.getMap().plot(ix, iy) )
<<<<<<<<<
```
`lPlot = []`として空のリストを作ってから、`lPlot.append()`で要素を追加しています。

`range1`の各要素`li`について、
都市のx座標と`li`のx座標を足して`ix`に代入しています。
同様に、都市のy座標と`li`のy座標を足して`iy`に代入しています。
そうして出した(ix, iy)が有効な座標、つまりマップからはみ出ていないならば、
`gc.getMap().plot(ix, iy)`として所得したPlotを`lPlot`の要素として追加しています。

## 草原化
こうしてできた`lPlot`は、**Plot**の**リスト**になっています。
もう一度for文を使って各要素を取り出し、取り出した各Plotを草原化させていく
...前に、Plotを草原化させる方法を調べましょう。

[リファレンス][api]のCyPlotからTerrainで探すと、

>
``` plain
VOID setTerrainType (TerrainType eNewValue, BOOL bRecalculate, BOOL bRebuildGraphics)
void (TerrainTypes eNewValue, bool bRecalculate, bool bRebuildGraphics)
```

が見つかりました。

TerrainType eNewValue
:    TerrainのTypeですから地形のIDですね。例によって`gc.getInfoTypeForString()`の戻り値を入れましょう。

BOOL bRecalculate
:    Recalculate(再計算)をするかどうか。この場合、タイル出力の再計算です。
たいていはTrueを指定することになるでしょう。

BOOL bRebuildGraphics
:    グラフィックをRebuild(再構築)するかどうか。見た目だけツンドラのままなんて嫌ですから、
やはりたいていはここにもTrueを指定することになるでしょう。

これをfor文とあわせて、こうなります...
```
<<<<<<<<<<
for plot in lPlot:
    grassType = gc.getInfoTypeForString('TERRAIN_GRASS')
    plot.setTerrainType(grassType, True, True)
>>>>>>>>>>
```

# KujiraEventManager.py
これまでのことを一旦まとめて`KujiraEventManager.py`にぶつけます。
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

range1 = [(-1, 1), ( 0, 1), ( 1, 1),
          (-1, 0), ( 0, 0), ( 1, 0),
          (-1,-1), ( 0,-1), ( 1,-1),]

def isValidPlot(x, y):
    pMap = gc.getMap()

    bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
    by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
    return bx and by
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        ##########
        pCity, iBuildingType = argsList

        if iBuildingType == gc.getInfoTypeForString('BUILDING_FERTILIZE_SHRINE'):
            lPlot = []
            for li in range1:
                ix = pCity.getX() + li[0]
                iy = pCity.getY() + li[1]

                if isValidPlot(ix, iy):
                    lPlot.append( gc.getMap().plot(ix, iy) )

            for plot in lPlot:
                grassType = gc.getInfoTypeForString('TERRAIN_GRASS')
                plot.setTerrainType(grassType, True, True)
                
```
リスト内では改行自由であることを利用して、`range1`の要素を書いている部分をさらに整形してみています。
2つのfor文が同列になっていることに注意してください。
for文を抜けて、lPlotへの追加がすべて終わってから、改めてfor文を回しています。

# ためす
ためしてみましょう！

わかりやすいようにWBで雪原地帯に都市を建て、生物学をプレイヤーに与えて実験します。
{{<img src="/img/kujira_fert_20.png">}}
{{<img src="/img/kujira_fert_21.png">}}
できました！

ただ、さらにいろんな場所で試していると、
{{<img src="/img/kujira_fert_22.png">}}
{{<img src="/img/kujira_fert_23.png">}}
このままでは水タイルまでもを草原化してしまうことがわかってきます。
その際、`setTerrainType()`の仕様で、上にあった資源や海軍ユニットも消し飛んでしまいます。
............これはあまりうまくないですね。直しましょう。


# なおす & ひろげる
ここで最初の目標を思い出してみると、《2マスの都市圏内すべてを草原化》でしたから、
現在の目標は

- 草原化の範囲を都市圏内まで広げる
- 水タイルは草原化の対象から外す

です。どちらも、ここまで頑張って読んできた方にはそれほど難しくありません。
やっていきましょう。

範囲を広げます。周囲1マスでやっていたことを2マスに広げましょう。
座標の差分のリストで利用していたのでしたね。
``` python
range2 = [         (-1, 2), ( 0, 2), ( 1, 2),
          (-2, 1), (-1, 1), ( 0, 1), ( 1, 1), ( 2, 1),
          (-2, 0), (-1, 0), ( 0, 0), ( 1, 0), ( 2, 0),
          (-2,-1), (-1,-1), ( 0,-1), ( 1,-1), ( 2,-1),
                   (-1,-2), ( 0,-2), ( 1,-2),         ]
```
たとえば、こうなります。
(よーく自分で観察して、あっていることを確認してくださいね。どういう処理になるか予想できればなおGOODです。)

水タイルを草原化の対象から外すためには、2つの考え方があります。

- Plotのリストに追加する直前に水判定を入れる
「そのPlotが水タイルでないならば、そのPlotをリストに追加する」という処理になります。
結果としてリストに追加されませんから、そのPlotが草原化されることもなくなります。
- 実際に草原化する直前に水判定を入れる
「そのPlotが水タイルでないならば、そのPlotを草原化する」という処理になります。

一概にどちらがいいとも言えず、一長一短ですが、今回は前者を採用しましょう。
後者の大きな利点は、「水タイルにもなにかする余地を残す」ということです。
前者でリストそのものからはじいてしまうと、
2つめのfor文ではもはや水タイルに触ることはできなくなります。
触れなくなる、というとデメリットにも聞こえますが、必ずしもそうでもありません。
間違っていじってしまう可能性を完全に排除できる、とも考えられるからです。
水タイルに何かする予定がこの先全くないなら、そのほうがむしろ安全なのです。

というわけで安全を取って「そのPlotが水タイルでないならば、そのPlotをリストに追加する」
という処理をを書きたいのですが、
実はPlotには「水タイルであるかどうか」を取得する`plot.isWater()`という関数しかありません。
何が問題かというと、私たちは「水タイルで『ない』ならば」という判定をしたかったのです。
真偽を反転させる`not`が必要になります。
式に`not`をつけると、True->Falseに、False->Trueに、真偽が反転します。
とくに`if not 式:`と書いた場合、元の式がFalseなら`not`で反転してTrueに変わるので、
ifの条件を満たすことになります。
つまり...
``` python
<<<<<<<<<<
if isValidPlot(ix, iy):
    # 座標が有効ならPlotを取得しても安全
    plot = gc.getMap().plot(ix, iy)
    # そのPlotが水タイルで『ない』なら
    if not plot.isWater():
        lPlot.append(plot)
>>>>>>>>>>
```
このようになります。


# KujiraEventManager.py 改
2か所を書き直して、こうなります...
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

range2 = [         (-1, 2), ( 0, 2), ( 1, 2),
          (-2, 1), (-1, 1), ( 0, 1), ( 1, 1), ( 2, 1),
          (-2, 0), (-1, 0), ( 0, 0), ( 1, 0), ( 2, 0),
          (-2,-1), (-1,-1), ( 0,-1), ( 1,-1), ( 2,-1),
                   (-1,-2), ( 0,-2), ( 1,-2),         ]

def isValidPlot(x, y):
    pMap = gc.getMap()

    bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
    by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
    return bx and by
        
class MyEventManager(CvEventManager.CvEventManager, object):

    def onBuildingBuilt(self, argsList):
        'Called when a building is built'
        super(self.__class__, self).onBuildingBuilt(argsList)
        ##########
        pCity, iBuildingType = argsList

        if iBuildingType == gc.getInfoTypeForString('BUILDING_FERTILIZE_SHRINE'):
            lPlot = []
            for li in range2:
                ix = pCity.getX() + li[0]
                iy = pCity.getY() + li[1]

                if isValidPlot(ix, iy):
                    plot = gc.getMap().plot(ix, iy)
                    if not plot.isWater():
                        lPlot.append(plot)

            for plot in lPlot:
                grassType = gc.getInfoTypeForString('TERRAIN_GRASS')
                plot.setTerrainType(grassType, True, True)
                
```


## ためす
わかりやすくするため今回もWBで極地かつ沿岸に都市を建てて...
{{<img src="/img/kujira_fert_30.png">}}
{{<img src="/img/kujira_fert_31.png">}}
できました！

# おしまい
これで、ひとまずこのチュートリアルは終わりです。
ここで作ったMODをもっと納得のいくようにバランスを調整したりして作り込んでいくもよし。
紹介しきれなかったイベントや関数はまだまだたくさんありますから、
まだ見ぬ奇抜な効果を探しに漕ぎ出してみるもよし。

Pythonでどんなことができるかというのは、ぶっちゃけた話どれだけ関数を知っているかにかかっています。
人のMODのPythonコードを読ませてもらいましょう。
このチュートリアルには基本的なPythonの構文から、
例示したコードをどう読むかの心構えまでをできるだけ誤魔化さず盛り込みました。
ここまでついてこられた方なら、ただコピペするだけ以上のことを吸収できるはずです。

もちろん、つくるのはあなたのMODなのですから、最後にはちゃんと自分で考えることが大事です。
作る前・作っている最中には頑張って考えましょう。
作った後にはテストプレイをしましょう。自分で、ちゃんと、プレイしましょう。
少なくとも、あなたが「いい」と思わなければ、MODを作っている意味はあまりありません。
ためして、ためして、ためしましょう。

では、また会う日まで。
