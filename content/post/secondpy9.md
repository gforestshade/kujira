+++
date = "2017-12-30T12:03:00"
lastmod = "2018-01-30"
draft = false
title = "それからのPython 9"
banner = "photo_pink1"
tags = ["それからのPython", "講座"]
+++

# はじめに

- [その８]({{<ref "secondpy8.md">}})のつづき
- 簡単なスペルの仕組みをつくってみる
- ４部作のうちの３回目・Python共通編
- クラスを活用する

# スペル情報クラス

スペル情報クラスです。BuildingInfoやUnitInfoのスペル版のようなイメージで、
このクラスを通してスペルのいろいろな情報を取得することができるようにします。
<!--more-->

``` python
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

```
............のですが、今回は設計を簡単にしたので、
登録される情報は「名前」と「クラスオブジェクト」(後述)だけです。
コンストラクタではこの2つを受け取り、インスタンス変数として代入しておきます。
そして、`getName()`や`getSpellClass()`でそれらを取得できるようにしています。
`setName()`や`setSpellClass()`を作っていないことに注意してください。
名前やクラスオブジェクトは取得できるだけで、設定はできません。
これは「Info」を表すクラスであって、ゲーム中に変更されることはないからです。

なお、ここでいう「名前」とは、内部処理に使う名前を指します。
具体的には、`SPELL_WATER`や`SPELL_POISON`といったXMLキーのようなものです。
今回は発動条件に昇進を使うため、
`SPELL_WATER`を発動させる昇進名は`PROMOTION_SPELL_WATER`、
`SPELL_POISON`を発動させる昇進名は`PROMOTION_SPELL_POISON`、
のように定めることにします。
自分のスペル名に`PROMOTION_`をつけた文字列を返す、
`getPromotionName()`というインスタンスメソッドもつくっておきます。

インスタンス変数の名前に`self._name`・`self._spell_class`のように
`_`をつけています。`_`1つで始まるインスタンス変数は、慣習として、
「どうか外部からいじらないでね」という意味を持ちます。
名前やクラスオブジェクトが知らないうちに変わってほしくはありませんので、
`_`をつけています。
(外部からの参照禁止を強制する効果はありません。あくまで慣習によるお願いです。)

このクラスは**型**ですから、SpellInfo型の変数をつくることができます。
そのインスタンス1つが、スペル1種類を表します。
今回はスペルの種類は3つですから、3つのSpellInfoインスタンスをつくることになります。

そして、最後に`spell = []`という文が書いてあります。
これは代入文ですが、`self`がついていません。
クラス内・メソッド外に記述されている、このような変数を
**クラス変数**(Class Variable)と呼びます。

クラス変数の所属する先は、インスタンスではなくクラス全体になります。
このことは、すべてのインスタンス(今回は3つのインスタンス)で値が共有される、
ということを意味します。
`self`がついているインスタンス変数はインスタンスごとに値が違っていましたから、
この点がインスタンス変数との違いになります。

今回は、このクラス変数`SpellInfo.spells`に3つのインスタンスをすべて登録します。
(これも後述します)

# スペル用基底クラス
では、「クラスオブジェクト」のところに入れるクラスをこれから定義しましょう。
まず、すべてのスペルで共通となる部分です。
``` python
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

```

スペル用のクラスでは、「発動したユニットのCyUnitインスタンス」を
インスタンス変数として保持します。
この"詠唱者"はゲーム中にいくらでも変わりうる、
あるいは複数存在しうるものですから、
(自分のユニットが発動するスペルとAIのユニットが発動するスペルは
別のインスタンスにしたいですよね？)
Infoに入れることはできません。ここで保持します。

その詠唱者インスタンスを利用して、スペルを実行します。
今回は設計を簡単にしたためやりませんが、
スペルに実行条件を付けて、スペル発動ボタンを非表示にしたり暗転表示にしたり
したい場合なども詠唱者の情報を利用するでしょうから、
(詠唱者が都市上にいるときだけ使えるスペルをつくりたい？
詠唱者がどのPlotにいるか、そのPlotに都市があるかの判定が必要ですね)
このクラスのメソッドとして書くことになるでしょう。

ともあれ、今回このクラスにはスペルを実際に詠唱する`cast()`と、
いろんなスペルで共同利用するためのメソッドが定義されます。
(今回は毒でも炎でも使う「1マス圏内にいる敵ユニットを列挙する」
メソッドを定義しています)

## 共通メソッド

メソッドを順番に見ていきましょう。まずは`__init__()`です。
``` python
    def __init__(self, caster):
        self._caster = caster
        self._myTeam = gc.getTeam(caster.getTeam())
    
```

詠唱者を引数に取ってインスタンス変数に代入するほか、
そのユニットが所属しているチームのCyTeamインスタンスも
インスタンス変数としてつくっています。
これはあとで戦争相手のユニットを識別したり、
自領土であるかどうかを調べたりするのに使います。
なにかと使い道が多いので、いちいちその場でつくるよりは、
ここで最初に作っておいて使いまわしする作戦です。
ほかにも、ほとんどのスペルで必要になるような値があるなら、
ここで設定することになるでしょう。

---

`cast()`です。スペル処理の本体になります。
``` python
    def cast(self):
        """スペル処理を呼び出し、成功したらエフェクトも出す"""
        r = self.execute()

        if r:
            EFFECT = gc.getInfoTypeForString('EFFECT_PING')
            point = self._caster.plot().getPoint()
            CyEngine().triggerEffect(EFFECT, point)

```

`execute()`という謎のインスタンスメソッドを呼び出しています。
これは、スペルごとに異なる部分をギリギリまで狭くして、
共通処理で済ませようとする工夫です。
どこまでが共通で、どこからが個別なのか切り分けるのは、
バグの少ないプログラムを書く上では重要になってきます。

ここでは、本当に個別の処理の部分だけをあとで個別に`execute()`という
メソッドとして書くことで、共通な部分――スペル発動のエフェクトなど――
を共通としてまとめておくことを意図しています。
こうして外側をしっかり書いておくことで、
実際のスペル処理を書くことに集中できるようになります。

あるいは、共通処理に追加したくなったときにも拡張が簡単になります。
スペル発動後移動を強制終了したいとか、特定の昇進をつけたいとか、
そういった場合にまとまっていれば1か所の追加で済みますが、
共通で同じ処理だからといって安易にコピペしていると
スペル3個でもう3か所、スペルを増やしていって100種類くらいになってから
仕様変更したくなってしまった場合は......？
最悪の場合すべてを書き直す羽目になってしまうかもしれません。
***事前の準備が大切なのです。***

`execute()`は成功で真、失敗で偽を返すようにするので、
成功したら`EFFECT_PING`というアニメーションを詠唱者と同じ画面座標で再生します。
これはチーム戦などで座標をチームメイトに伝えるときのアニメーションを流用しています。
今回はやりませんが、発動成功したときに上にメッセージを出したい、というときも
ここに書くことになるでしょう。

---

`isEnemy()`です。ユニットの引数を1つ取り、
そのユニットの所属と詠唱者の文明とが戦争状態にあるかを判定します。
``` python
    def isEnemy(self, pUnit):
        return self._myTeam.isAtWar(pUnit.getTeam())
```
外交関係はチームごとに設定されますから、チームを求めておいたのが役に立っています。

---

`selectEnemyUnits()`です。範囲内にいる敵対ユニットを集めてリストにして返します。
攻撃系のスペルではよく使うので、共通処理に入れておきます。
``` python
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

```

`range_plots = getRangePlotList(self._caster, i_range, False)`
まずさっきつくっていた関数を呼び出して、範囲内のPlotのリストを取得します。
詠唱者を中心に、周囲`i_range`マス、詠唱者自身のマスは含めません。

`range_plots`の中の各Plotに対して、
`re_units += filter(self.isEnemy, getPlotUnits(plot))`
という文を実行しています。

2つのリストを`+`すると、そのリストが1つに連結された新しいリストを得ます。
あるリストに別のリストを`+=`すると、そのリストの末尾に別のリストの内容がくっつきます。
メソッド全体の目的と、ここがfor文の中でPlotを列挙中であることを考えると、
右辺の`filter(self.isEnemy, getPlotUnits(plot))`は
「`plot`の上にいる敵対ユニットのリスト」になっているはずです。
それを後ろにどんどん連結していけば範囲内の全敵対ユニットを求めたことになりますね。

さて、この`filter()`という関数は、リストを加工する関数です。
第１引数に条件、第２引数にリストを入れると、
条件を満たした要素だけを残した新しいリストを得ます。
第２引数として指定している`getPlotUnits(plot)`というのは
さっきつくった関数で`plot`上にいる全ユニットのリスト
...ではなくジェネレーターを得るのでした。
ただ直接出力しようとしない限りだいたい扱いは同じでしたので、
ここに`plot`上にいる全ユニットのジェネレータを指定します。

条件は、関数で指定します。
`self.isEnemy`という関数オブジェクトです。呼び出しのための`()`をまだつけていません。
`filter()`関数の中で、関数オブジェクトが呼び出され、要素を残すかどうか判定がされます。
結局、`isEnemy()`――詠唱者と敵対しているかどうか――を満たすユニットのみが残され、
`re_units`に連結されていきます。

[その１０につづく]({{<ref "secondpy10.md">}})
