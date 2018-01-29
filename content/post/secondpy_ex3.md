+++
date = "2017-12-05"
draft = false
title = "付録：継承２"
banner = "green"
tags = ["付録", "せつめい"]
+++

# はじめに

- [付録：継承１]({{<ref "secondpy_ex2.md">}})のつづき
- 続・継承について
- 今回は理論回です。この回に出てくるコードはすべてMODではなく
ただのPythonプログラムになっていますので、[paiza.io](https://paiza.io/ja)などでためしましょう。
(Python2を選ぶことを忘れずに。)

# 前回のあらすじ
「継承」という仕組みを使って、
既存のクラスを拡張した新しいクラスをつくれることを
RPGっぽい世界をつくって勉強しました。

# 上書き

## 不満
魔法使いクラスを無事追加できましたが、不満があります。
メインプログラムを再掲しましょう...

``` python
>>>>>>>>>>
a = Unit(20,10,3)
b = Wizard(12,3,3)
b.magic_attack = 13

for i in range(5):
    print b.magicalAttackTo(a)
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
<<<<<<<<<<
```

`Unit`のすべてをそのまま受け継ぐ、という性質から、コンストラクタもそのまま受け継いでしまい、
`Wizard`のインスタンス生成時には魔法攻撃力を設定できません。
なので、後で個別に代入していますが、これではやや不満です。

また、`getStatus()`もそのまま受け継いでいるので、
ステータス画面に魔法攻撃力が表示されません。
これもやや不満です。

## オーバーライド
派生クラスの定義中で基底クラスから受け継いだものと同名のメソッドを定義すると、
上書きしてしまうことができます。
これを「オーバーライド」(override)と呼びます。

コンストラクタと`getStatus()`をじっさいに`Wizard`用のもので上書きしてみましょう...
``` python
>>>>>>>>>>
    def __init__(self, hp, attack, defence, magic_attack):
        """初期化時にHP,攻撃力,防御力,魔法攻撃力を設定する"""
        self.hp = hp
        self.attack = attack
        self.defence = defence
        self.magic_attack = magic_attack

    def getStatus(self):
        """ステータス画面的なもの"""
        return "HP: %d | Atk %d | Def %d | MAtk %d" % (self.hp, self.attack, self.defence, self.magic_attack)
<<<<<<<<<<
```

これで、
``` python
b = Wizard(12,3,3,13) #上書きしたほうのコンストラクタが呼ばれる
print b.getStatus() #上書きしたほうのgetStatus()が呼ばれる
```
などと書くことができるようになります。
これでいいのですが、途中までは元の`Unit`のメソッドと同じ処理なのでだぶってしまっているのが気になります。
完全な上書きではなく、もとのメソッドを利用して「ちょい足し」できればもっとよいですね。

そこで、`Unit.メソッド名(self, 他の引数)`とすることで、`Unit`のメソッドを直接指定して呼び出すことができます。
これを使って、次のようにできます...
``` python
>>>>>>>>>>
    def __init__(self, hp, attack, defence, magic_attack):
        """初期化時にHP,攻撃力,防御力,魔法攻撃力を設定する"""

        # もとのコンストラクタにも投げつつ
        Unit.__init__(self, hp, attack, defence)

        # 処理を追加する
        self.magic_attack = magic_attack

    def getStatus(self):
        """ステータス画面的なもの"""

        # もとのメソッドから帰ってくる文字列に
        ss = Unit.getStatus(self)

        # 追加する
        return "%s | MAtk %d" % (ss, self.magic_attack)
<<<<<<<<<<
```

`getStatus()`では、`Unit.getStatus(self)`として
「`Unit`の`getStatus()`」を直接指定して呼び出しています。
そもそも今まさに「`Unit`の`getStatus()`」を`Wizard`で上書きしている最中なのですが、
こうすることで完全な上書きではなく、もとの処理も行ったうえで拡張することができるようになります。
ここでは、いったん戻り値を変数`ss`で受けて、
`"%s | MAtk %d" % (ss, self.magic_attack)`と埋め込んでいます。

`__init__()`でも同じことをやっています。
メソッド名が`__init__`なこと、`self`を第1引数に持ってきていることで
すこし読みづらく感じますが、よく読めば大丈夫なはずです。

## こうなった
プログラム全体はこうなりました。
``` python
# -*- coding: utf-8 -*-

class Unit:
    """RPGのキャラっぽいなにか"""
    
    def __init__(self, hp, attack, defence):
        """初期化時にHP,攻撃力,防御力を設定する"""
        self.hp = hp
        self.attack = attack
        self.defence = defence

    def getStatus(self):
        """ステータス画面的なもの"""
        return "HP: %d | Atk %d | Def %d" % (self.hp, self.attack, self.defence)

    def dealDamage(self, damage):
        """
        ダメージを受ける
        damage - 受けるダメージ
        """

        # 実際のダメージは防御力のぶんだけ減算される
        # ただし1を下限とする
        damage = max(damage - self.defence, 1)

        # HPからダメージを減らす
        self.hp -= damage

    def isDead(self):
        """自分はもう死んでいる、かどうか"""
        return self.hp <= 0

    def attackTo(self, enemy):
        """
        別のUnitインスタンスに攻撃を仕掛ける
        勝ったら正の値,負けたら負の値,引き分けなら0を返す
        enemy - 攻撃を仕掛けるUnitインスタンス
        """

        # 自分が死んでいるなら即負け,
        # 相手が死んでいるなら即勝ち
        if self.isDead():
            return -1
        if enemy.isDead():
            return 1

        # 攻撃側優先、攻撃力の分だけ相手にダメージを与える
        enemy.dealDamage(self.attack)

        # この時点で相手が死んでいるなら勝ち
        if enemy.isDead():
            return 2

        # 相手が死んでいないなら反撃を受ける
        # 相手の攻撃力ぶんだけ自分にダメージを与える
        self.dealDamage(enemy.attack)

        # この時点で自分が死んでしまったら負け
        if self.isDead():
            return -2

        # 自分も相手も死ななかったら引き分け判定
        return 0


class Wizard(Unit):
    """魔法使い"""

    def __init__(self, hp, attack, defence, magic_attack):
        """初期化時にHP,攻撃力,防御力,魔法攻撃力を設定する"""

        # もとのコンストラクタにも投げつつ
        Unit.__init__(self, hp, attack, defence)

        # 処理を追加する
        self.magic_attack = magic_attack

    def getStatus(self):
        """ステータス画面的なもの"""

        # もとのメソッドから帰ってくる文字列に
        ss = Unit.getStatus(self)

        # 追加する
        return "%s | MAtk %d" % (ss, self.magic_attack)

    def magicalAttackTo(self, enemy):
        """
        別のUnitインスタンスに魔法攻撃を仕掛ける
        勝ったら正の値,負けたら負の値,引き分けなら0を返す
        enemy - 攻撃を仕掛けるUnitインスタンス
        """

        # 自分が死んでいるなら即負け,
        # 相手が死んでいるなら即勝ち
        if self.isDead():
            return -1
        if enemy.isDead():
            return 1

        # 魔法攻撃力の分だけ相手にダメージを与える
        enemy.dealDamage(self.magic_attack)

        # この時点で相手が死んでいるなら勝ち
        if enemy.isDead():
            return 2

        # 魔法なので反撃なし、死ななかったら引き分け判定
        return 0
        
    

a = Unit(20,10,3)
b = Wizard(12,3,3,13)

for i in range(5):
    print b.magicalAttackTo(a)
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
    
```

だいぶメインプログラムがすっきりしました。
各自実行して結果を確かめましょう。

# 継承のもうひとつの顔
メソッドの上書きができるのであれば、
最初から新しいメソッドなど追加せず、
ただ既存のメソッドを上書きすることを目的に
継承して派生クラスをつくることもできるはずです。

「攻撃時に攻撃力を2倍で計算するが、反撃時に相手の攻撃力を3倍で計算する」
狂戦士クラスを考えてみましょう。
この構想は戦闘のルールそのものを変更してしまっています。
が、派生クラスではメソッドのオーバーライドができるのでした。
`attackTo()`を狂戦士用に書き換えてしまえば実現できそうです。
やってみましょう。

``` python
class Berserker(Unit):
    """狂戦士"""

    def attackTo(self, enemy):
        """
        別のUnitインスタンスに攻撃を仕掛ける
        勝ったら正の値,負けたら負の値,引き分けなら0を返す
        狂戦士特性：狂戦士から攻撃するとき攻撃力2倍・反撃時相手攻撃力3倍
        enemy - 攻撃を仕掛けるUnitインスタンス
        """

        # 自分が死んでいるなら即負け,
        # 相手が死んでいるなら即勝ち
        if self.isDead():
            return -1
        if enemy.isDead():
            return 1

        # 攻撃側優先、攻撃力*2の分だけ相手にダメージを与える
        enemy.dealDamage(self.attack * 2)

        # この時点で相手が死んでいるなら勝ち
        if enemy.isDead():
            return 2

        # 相手が死んでいないなら反撃を受ける
        # 相手の攻撃力*3のぶんだけ自分にダメージを与える
        self.dealDamage(enemy.attack * 3)

        # この時点で自分が死んでしまったら負け
        if self.isDead():
            return -2

        # 自分も相手も死ななかったら引き分け判定
        return 0
```
これで`Berserker`クラスの定義はすべてです。
残りのものは(記述していないが)基底クラスである
`Unit`クラスから受け継いでいるのでしたね。
つまりこれで、ほぼ`Unit`と同じだけれど、
`attackTo()`の動作のみが異なる`Berserker`クラスができました。

はい、変わったのは`attackTo()`の内部動作だけです。
普通の`Unit`を扱う要領でメインプログラムを書けば...
``` python
a = Berserker(20,10,3)
b = Unit(20,10,3)

for i in range(3):
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
```
...自動的に`Berserker`の`attackTo()`が呼ばれるようになりました。


# もっとコンパクトに、もっと大胆に
もっと変更を小さくして、
「`isDead()`で常に`False`を返す`Zombie`クラス」を
つくってみたらどうなるでしょうか。

``` python
class Zombie(Unit):
    """ゾンビ"""
    
    def isDead(self):
        """
        ゾンビ特性：死なない。
        """
        return False
```

たったこれだけ、やったことは`isDead()`をオーバーライドしただけです。
が、このたった少しの変更で、`Unit`から受け継いだ他のメソッド――`attackTo()`など――が
`isDead()`を呼び出した際、必ず「死んでない」という答えを受け取ることになります。

結果として...どうなるかは各自実行してみましょう。
メインプログラムはたとえばこうなります...
``` python
a = Unit(20,10,3)
b = Zombie(1,5,1)

for i in range(10):
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
```


# 多態性

さらに注目すべきは、`Unit`版・`Berseker`版・`Zombie`版で
メインプログラムの核心部分が完全に同じだということです。
``` python
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
```
(↑この部分。)

変わっているのは`a`や`b`の型(それからfor文の繰り返し回数)だけです。
それらに共通して実装されている`attackTo()`の動作
(あるいは`attackTo()`の内部で呼び出されているもっと深いメソッドの動作)
が型によって異なるのであって、
`a`や`b`を使う側はそれを意識せず、ただ「攻撃せよ」とだけ書けばよい状態になっています。

このように、書き方が同じでも、インスタンスの型によって実際の動作が変わる性質のことを
「多態性」と呼びます。(ポリモルフィズム・ポリモーフィズム・polymorphismとも)
Pythonにおいてポリモーフィズムを実現する方法は継承でなくともよいのですが、
継承の「受け継ぐ」「上書きする」という性質は
ポリモーフィズムを実現するのに都合がよい仕組みなのです。

# おまたせ
そしてもちろん、この概念はCiv4のMODでも有用です。
ポリモーフィズムを、
「メインプログラムは変更できないが内部動作だけ変更する」
ための手段として用いることができるのです。

...といいますか、実はもうすでに充分活用していました。

([はじめてのPythonEventManager.py その1]({{<ref "getstarted1.md">}})より)

>
``` python
import CvEventManager
import CvUtil

class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
        # ログファイルに出力する
        CvUtil.pyPrint("Hello, Python!")
```

>
こうしてみました。元のCvEventManagerを継承して、onGameStartメソッドをオーバーライドします。
気持ち的には、ゲーム開始時に割って入って、独自の処理をするイメージです。

「CvEventManagerを継承して、onGameStartメソッドをオーバーライド」しています。
(`CvEventManager.CvEventManager`の部分は`パッケージ名.クラス名`ですね。
`CvEventManager`クラスは別ファイルにあるのでこういう書き方になります)
これで、「ほとんど`CvEventManager`クラスと同じだけれども、
`onGameStart()`メソッドだけがオーバーライドされて上書きされた
新しいクラス`MyEventManager`」をつくったことになるわけです。

このことは、`MyEventManager`に対して`onGameStart()`以外のメソッドが呼び出されても、
`CvEventManager`から受け継いだメソッドがうまくやってくれる、ということを意味します。
変えたい部分だけをオーバーライドして書けばよいのです。

とくに`CvEventManager`は`handleEvent()`というメソッドでイベントを一括して受け取り、
そこから各メソッドに処理を振り分けています。
もちろん、`MyEventManager`はこのメソッドも自動的に受け継いでいますから、
何も考えなくとも正常に動きます。

これであとは`CvEventManager`インスタンスを実際に作成している行を探し出して、
`CvEventManager`インスタンスの代わりに
`MyEventManager`インスタンスをつくるようにすれば
`CvEventManager.onGameStart()`ではなく
`MyEventManager.onGameStart()`が呼ばれるようになりそうです。

それをやっているのが、CvEventInterface.pyのこの部分です。
``` python
>>>>>>>>>>
# normalEventManager = CvEventManager.CvEventManager()
myEventManager = KujiraEventManager.MyEventManager()

def getEventManager():
	return myEventManager
<<<<<<<<<<
```

`getEventManager()`関数の戻り値として、もとの`CvEventManager`型ではなく、
(KujiraEventManager.pyにある)`MyEventManager`型のインスタンスを返すようにしています。

これで、ゲーム開始時の処理を書き換えたことになるわけです。
XMLのように巨大なファイルをコピーしてきて、該当箇所を頑張って探して......
としなくてもよいのは、まさに「継承」の機能のおかげなのでした。

