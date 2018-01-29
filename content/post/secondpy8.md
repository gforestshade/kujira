+++
date = "2017-12-30T12:02:00"
draft = false
title = "それからのPython 8"
banner = "green"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その７]({{<ref "secondpy7.md">}})のつづき
- 簡単なスペルの仕組みをつくってみる
- ４部作のうちの２回目・Python準備編
- オブジェクト
- リスト操作

# Pythonファイル
Python側のファイル構成はいつもの感じです。
EntryPoints\\CvEventInterface.pyはいずれかのKujira MODから使いまわします。
忘れてしまった方は[こちら](/src/prefab/CvEventInterface.py)にも置いてあります。

``` plain
└─kujira_promospell
    └─Assets
        ├─Python
        │  ├─KujiraEventManager.py
        │  │
        │  └─Entrypoints
        │      └─CvEventInterface.py
        │
        └─XML
            ├─Text
            │  └─Text_Kujira.xml
            │
            └─Units
                └─CIV4PromotionInfos.xml
```


# プログラムリスト
先にKujiraEventManager.pyの全容を見ておきましょう。
このようなプログラムを作っていきます...
``` python
# -*- coding: utf-8 -*-

from CvPythonExtensions import *
import CvEventManager
import CvUtil
import PyHelpers

gc = CyGlobalContext()
git = gc.getInfoTypeForString


### 関数
########################

def isValidPlot(x, y):
    """ラップを考慮して、有効な座標であるか判定する"""
    pMap = gc.getMap()

    bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
    by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
    return bx and by

def getRangePlotList(center, i_range, include_center):
    """
    中心から周囲nタイルのCyPlotのリストを返す
    center - 中心タイル
    i_range - 範囲
    include_center - Trueならリストに中心タイルを含める
    """

    pMap = gc.getMap()
    result = []
    
    for xx in range(-i_range, i_range+1):
        for yy in range(-i_range, i_range+1):
            x = xx + center.getX()
            y = yy + center.getY()
            
            if not isValidPlot(x,y):
                continue
            if (xx == 0 and yy == 0) and not include_center:
                continue

            result.append( pMap.plot(x,y) )

    return result

def getPlotUnits(plot):
    """plot上にいる全ユニットのジェネレータを返す"""
    return ( plot.getUnit(i) for i in range(plot.getNumUnits()) )


### スペル情報クラスとスペル用基底クラス
########################

class SpellInfo:
    
    def __init__(self, name, spell_class):
        self._name = name
        self._spell_class = spell_class
        
    def getName(self):
        return self._name

    def getPromotionName(self):
        return "PROMOTION_" + self.getName()

    def getSpellClass(self):
        return self._spell_class

    spells = []

class Spell:
    
    def __init__(self, caster):
        self._caster = caster
        self._myTeam = gc.getTeam(caster.getTeam())
    
    def cast(self):
        """スペル処理を呼び出し、成功したらエフェクトも出す"""
        r = self.execute()

        if r:
            EFFECT = gc.getInfoTypeForString('EFFECT_PING')
            point = self._caster.plot().getPoint()
            CyEngine().triggerEffect(EFFECT, point)

    def isEnemy(self, pUnit):
        return self._myTeam.isAtWar(pUnit.getTeam())

    def selectEnemyUnits(self, i_range):
        """
        範囲内の全敵対ユニットのリストを返す
        i_range - self.casterを中心として周囲i_rangeマスを範囲とする
        """
        range_plots = getRangePlotList(self._caster, i_range, False)
        
        re_units = []
        for plot in range_plots:
            re_units += filter(self.isEnemy, getPlotUnits(plot))

        return re_units


### 具体的なスペル
########################

class SpellWater(Spell):
    """湧き水"""
    
    def execute(self):
        """
        直下のタイルが自チームの砂漠なら平原に変化させる
        """

        caster_plot = self._caster.plot()
        DESERT = git("TERRAIN_DESERT")
        PLAINS = git("TERRAIN_PLAINS")
        
        if caster_plot.getTeam() == self._caster.getTeam() and caster_plot.getTerrainType() == DESERT:
            caster_plot.setTerrainType(PLAINS, True, True)
            return True
            

# スペル一覧に追加
SpellInfo.spells.append(SpellInfo("SPELL_WATER", SpellWater))


class SpellPoison(Spell):
    """毒散布"""
    
    def execute(self):
        """
        周囲1マスの敵対ユニットに『毒』を与える
        """

        POISONED = git("PROMOTION_POISONED")
        units = self.selectEnemyUnits(1)
        for unit in units:
            unit.setHasPromotion(POISONED, True)

        return True

SpellInfo.spells.append(SpellInfo("SPELL_POISON", SpellPoison))


class SpellFire(Spell):
    """火炎幕"""
    
    def execute(self):
        """
        周囲1マスの敵対ユニットに10%のダメージを与える
        最大40%まで
        """

        i_damage = 10
        max_damage = 40
        caster_owner = self._caster.getOwner()
        units = self.selectEnemyUnits(1)
        
        for unit in units:
            if unit.getDamage() >= max_damage:
                continue
            
            damage = min(unit.getDamage() + i_damage, max_damage)
            unit.setDamage(damage, caster_owner)

        return True

SpellInfo.spells.append(SpellInfo("SPELL_FIRE", SpellFire))


### EventManager
########################

class MyEventManager(CvEventManager.CvEventManager, object):

    def onUnitPromoted(self, argsList):
        'Called when a unit is promoted'
        super(self.__class__, self).onUnitPromoted(argsList)
        pUnit, iPromotion = argsList
        ##########

        for spellinfo in SpellInfo.spells:
            iSpellPromo = git(spellinfo.getPromotionName())
            if iPromotion == iSpellPromo:
                SpellClass = spellinfo.getSpellClass()
                spell = SpellClass(pUnit)
                spell.cast()
```


# オブジェクト
Pythonでは、ほとんどすべてのものが「オブジェクト」の値として変数に代入ができます。
その力は、関数やクラスにも及びます。
例えば、`git = gc.getInfoTypeForString`という文は、
`gc.getInfoTypeForString`という関数を変数に代入しています。
(関数呼び出しを表す`()`をつけずに関数名だけを書いていることに注意してください)

関数を変数に代入するとはどういうことなのでしょうか？
Pythonでは、変数や関数の名前は実体につけられたラベルのようなものだと考えます。
実体としてのオブジェクトはそのあたりに漂っていて、名前をつけることで
実体にアクセスすることができるようになります。
代入文というのは、その名前をつける行為に相当します。
まだ名前がないオブジェクトに対しては命名、(`a=42`)
もう名前があるオブジェクトに対しては別名をつけることに相当します。(`a=b`)

`git = gc.getInfoTypeForString`によって`git`は関数の別名になります。
あとで`git("PROMOTION_POISONED")`などとして「呼び出す」ことができます。
(関数オブジェクトに、呼び出しを表す`()`をつければ関数の呼び出しになります)

あるいは、型もオブジェクトです。
クラス名がクラスオブジェクトを指し示しています。

``` python
class A
  def f(self):
    return 0

# クラスオブジェクトの別名
class_a = A

# クラスオブジェクトの別名からインスタンス化
a = class_a()

# 関数オブジェクトの別名
method_f = a.f

# 別名から関数を呼び出す
print method_f()
```

上の例で、`a`は`A`のインスタンスになっています。
別名を経由してインスタンス化していますが、指している実体は`A`に変わりないので、
`A`のインスタンスができます。

この例では、ただ遠回りしているだけに見えますが、関数や型を変数に代入できるということは、
「関数のリスト」や「型のリスト」をつくることができます。
リスト内の関数を順番に呼び出すとかリスト内の型のインスタンスをつくるとかいうことが可能になります。

# 関数

最初の方は関数です...
``` python
def isValidPlot(x, y):
    """ラップを考慮して、有効な座標であるか判定する"""
    pMap = gc.getMap()

    bx = pMap.isWrapX() or (0 <= x and x < pMap.getGridWidth())
    by = pMap.isWrapY() or (0 <= y and y < pMap.getGridHeight())
    return bx and by
```
座標に足し算や引き算をしたとき、その座標がマップからはみ出していないかチェックします。
この関数は[はじめての・その７]({{<ref "getstarted7.md">}}#座標の有効性を判定する)で作ったものと同じものです。
「周囲nマス」を表現するためにはいつでも必要になる関数なので、使いまわしましょう。


つぎは実際に周囲nタイルのCyPlotインスタンスを求めます...
``` python
def getRangePlotList(center, i_range, include_center):
    """
    中心から周囲nタイルのCyPlotのリストを返す
    center - 中心タイル
    i_range - 範囲
    include_center - Trueならリストに中心タイルを含める
    """

    pMap = gc.getMap()
    result = []
    
    for xx in range(-i_range, i_range+1):
        for yy in range(-i_range, i_range+1):
            x = xx + center.getX()
            y = yy + center.getY()
            
            if not isValidPlot(x,y):
                continue
            if (xx == 0 and yy == 0) and not include_center:
                continue

            result.append( pMap.plot(x,y) )

    return result
```

## 多重ループ・ブロックのネスト

目新しいのはこの部分です。
``` python
>>>>>>>>>>
    for xx in range(-i_range, i_range+1):
        for yy in range(-i_range, i_range+1):
<<<<<<<<<<
```
for文の中にさらにfor文が2重になって入っています。
ループ処理が2重になっているので「2重ループ」と呼びます。

`i_range`が変数なので少しわかりにくいですね。
`i_range = 1`だと仮定して書き直してみましょう。
``` python
    for xx in range(-1, 2):
        for yy in range(-1, 2):
```
`range(-1, 2)`は-1 <= x < 2の範囲にある整数を順番に並べたリストを返します。
つまり`[-1,0,1]`になります。(`2`を含まないことに注意してください。)
さらに処理の流れをばらして図解すると、こうなります。

{{<img src="/img/sentence_for.png">}}

こうして得た`xx`と`yy`で中身の処理をします。
まずはこのような計算をします。
``` python
>>>>>>>>>>
            x = xx + center.getX()
            y = yy + center.getY()
<<<<<<<<<<
```
中心座標からx方向に`xx`, y方向に`yy`ずらした座標を求めています。
これが`xx`について`-1,0,1` と`yy`について`-1,0,1` で合計で9回繰り返されますので、
中心から周囲1マスの座標がそれぞれ計算できます。

まだこの時点では座標の数字を計算しただけです。
そこに本当にタイルがあるかどうかはまだわかりません。
マップ端などの場合はそれ以上進めないこともあるのでした。
そのような範囲外の座標を使ってCyPlotインスタンスをつくろうとしても、
そんなマスはないので作成できません。

なので、まずはマップの範囲に収まっているか判定します。
``` python
>>>>>>>>>>
            if not isValidPlot(x,y):
                continue
<<<<<<<<<<
```
`not`を使って結果を反転させています。
`(x,y)`がマップ範囲内ではないとき、`continue`という文を実行します。

`continue`は最も内側のforループの次の繰り返しまで飛ぶ命令です。

{{<img src="/img/sentence_continue.png">}}

このとき、現在の繰り返しの残りの処理は飛ばされます。
処理をする前に前提条件をチェックして、満たさない場合はさっさと次に行く、
のような書き方ができます。

実は、`continue`を使わなくても、if文だけで前提条件をチェックすることはできます。
``` python
        # if文だけで
        for i in list:
                if 前提条件:
                        if 前提条件2:
                                if 前提条件3:
                                        処理...
                                        処理...
                                        処理...
                                        ちょっと長い名前のメソッドを呼んでしまって横に伸びてしまった処理
        
        # continueで
        for i in list:
                if not 前提条件:
                        continue
                if not 前提条件2:
                        continue
                if not 前提条件3:
                        continue
            
                処理...
                処理...
                処理...
                ちょっと長い名前のメソッドを呼んでしまって横に伸びてしまった処理
```

が、見てわかるように、if文だけで制御すると前提条件があればあるほど
インデントが右へ右へと深くなっていきます。
コードが画面右からはみ出してしまい、読みにくくなるリスクも高くなってしまいます。

for文の中のif文の中のif文の中の...という入れ子構造を「ネスト」と呼びますが、
一般的にあまりネストを深くしすぎるとコードは読みにくくなってしまいます。
なので、できるなら`continue`や`return`といった
残りの文を飛ばす効果を持った文を使う、一部を関数として分離する、
など、深くなり過ぎないように努力すべきです。

というわけで、マップ内にあるかの確認と、ついでに中心座標を含めるかどうかの判定を
ここでやっています。
``` python
>>>>>>>>>>
            if not isValidPlot(x,y):
                continue
            if (xx == 0 and yy == 0) and not include_center:
                continue
<<<<<<<<<<
```

前提条件をクリアしたら、座標の数字からCyPlotのインスタンスをつくり、
リスト型の変数`result`に追加しています。
``` python
>>>>>>>>>>
            result.append( pMap.plot(x,y) )
<<<<<<<<<<
```

これで、周囲1マスのCyPlotインスタンスのリストを得ることができました。

# リスト内包表記

Plot上には複数のユニットが存在できます。
Plot上にいる全ユニットのCyUnitインスタンスのリストを取得したくなります。
このようにします。
``` python
def getPlotUnits(plot):
    """plot上にいる全ユニットのジェネレータを返す"""
    return ( plot.getUnit(i) for i in range(plot.getNumUnits()) )
```
Pythonでは「リストを作る」ことに特別な記法が用意されていて、
このように短く書くことができるようになっています。

素のPythonプログラムで、書き方を見ていきましょう。
「リストを加工して新しくリストをつくる」ときはこのようにするのでした。
``` python
# 元のリスト
list1 = range(10)
# 加工後のリスト(の入れ物)
list2 = []

# 元リストの各要素について
for i in list1:
    # 2で割り切れるならば
    if i % 2 == 0:
        # 3倍して
        a = i * 3
        # 追加する
        list2.append(a)

print list2 # [0, 6, 12, 18, 24]
```

これを、このように縮めることができます。
``` python
# 元のリスト
list1 = range(10)
# 2で割り切れる要素を選んで3倍して新しいリストをつくる
list2 = [i * 3 for i in list1 if i % 2 == 0]

print list2 # [0, 6, 12, 18, 24]
```
上のループを１行にくっつけたような形をしています。
この書き方をPythonの「リスト内包表記」(List Comprehension)と呼びます。
これで、どちらも全く同じ処理になっています。
実行してみて、`[0, 6, 12, 18, 24]`が出力されるかどうか、試してみましょう。
(これらは素のPythonプログラムです。MODではないので、しかるべきところで実行しましょう。)

条件式の部分は、必要なければ書かなくても構いません。
``` python
# 元のリスト
list1 = range(10)

# 長い版
##########
list2 = []

for i in list1:
    # 3倍して
    a = i * 3
    # 追加する
    list2.append(a)

print list2

# リスト内包表記版
##########
list3 = [i * 3 for i in list1]

print list3

```
実行して、どちらも同じリストが出力されることを確かめましょう。
「各要素を3倍する」という目的が、リスト内包表記版ではより分かりやすくなっています。

逆に3倍する処理の方を削って、条件式は復活させてみましょう。
``` python
# 元のリスト
list1 = range(10)

# 長い版
##########
list2 = []

for i in list1:
    if i % 2 == 0:
        list2.append(i)

print list2

# リスト内包表記版
##########
list3 = [i for i in list1 if i % 2 == 0]

print list3

```
どちらも同じリストが出力されるはずです。実行して確かめましょう。

リスト内包表記では、囲む記号を変えるとすこし違ったものが出てきます。
`[]`を`()`にしてみましょう。
{{<img src="/img/generator_expression.png">}}
`[0, 2, 4, 6, 8]`......ではなく、よくわからないものが出力されました。
これは「ジェネレーターオブジェクト」(Generator Object)というもので、
それを生成した、内包表記を`()`で囲んだものを「ジェネレーター式」(Generator Expression)と呼びます。

ジェネレーター式によってつくられたジェネレーターオブジェクトは、
いってみればリストを加工するレシピを予約したもの、です。
このオブジェクト自体はあくまでリストを加工する方法を記したレシピであって、
リストではないので、直接出力しようとしても
それがGenerator Objectであることしかわかりません。

実際に料理をするには、for文を使います。
``` python
# 元のリスト
list1 = range(10)

# ジェネレーター式
##########
list2 = (i for i in list1 if i % 2 == 0)

print list2

# ジェネレーターから1要素ずつ取り出して、list3に追加する
list3 = []
for i in list2:
    list3.append(i)

print list3

```

リスト内包表記もforを使っていますので、後半をリスト内包表記で書き直すこともできます。

``` python
# 元のリスト
list1 = range(10)

# ジェネレーター式
##########
list2 = (i for i in list1 if i % 2 == 0)

print list2

# ジェネレーターから1要素ずつ取り出して、list3に追加する
list3 = [i for i in list2]

print list3

```
それぞれ実行してみて動作を確かめましょう。
どのみちリストをつくるときはさらにfor文で回すことがほとんどですから、
`list2`を直接出力しようとしない限りジェネレーターと本物のリストは
大体区別せずに同じような感じで扱うことができます。

というわけで、冒頭の関数はジェネレーター式を利用していました。
``` python
def getPlotUnits(plot):
    """plot上にいる全ユニットのジェネレータを返す"""
    return ( plot.getUnit(i) for i in range(plot.getNumUnits()) )
```

わかりにくいですか？
インデントをいつものPython風につけてみると少しわかりやすいかもしれません。
``` python
for i in range(plot.getNumUnits()):
    plot.getUnit(i)
```

`i`番目のユニットを、そのプロットにいるユニットの数だけ取得していますね。

[その９につづく]({{<ref "secondpy9.md">}})
