+++
date = "2017-12-04"
draft = false
title = "それからのPython 7"
banner = "/green1024x200.png"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その６]({{<ref "secondpy6.md">}})のつづき
- 継承について
- 今回は理論回です。この回に出てくるコードはすべてMODではなく
ただのPythonプログラムになっていますので、[paiza.io](https://paiza.io/ja)などでためしましょう。
(Python2を選ぶことを忘れずに。)

# クラスの継承
「継承」(inheritance)という仕組みを使って、
既存のクラスを拡張したクラスを新しく作ることができます。

とても簡単なクラスから始めましょう...
``` python
class A:
    def methodA():
        return "This is methodA()."
```

...というクラスがあったとき、"`A`をもとにした新しいクラス`B`"を
`class クラス名(もとにするクラス名):`のようにして作ることができます...

``` python
class A:
    def methodA():
        return "This is methodA()."

class B(A):
    def methodB():
        return "This is methodB()."


a = A() # Aのインスタンスa
s = a.methodA() # Aのインスタンスメソッドを呼び出せる
print s

b = B() # Bのインスタンスb
s = b.methodB() # Bのインスタンスメソッドを呼び出せる
print s
s = b.methodA() # Aのインスタンスメソッドも呼び出せる！
print s

```

「継承」において、もとになったクラスを「基底クラス」(super class)、
基底クラスを受け継いで新しく作ったクラスを「派生クラス」(derived class)または「サブクラス」(subclass)と呼びます。

派生クラスは基底クラスに定義されているものをすべてそのまま受け継ぎます。
上の例で、`B`のインスタンス`b`を使って`b.methodA()`を呼び出していますが、
`B`は`A`のメソッドを受け継いでいるので、`methodA()`と`methodB()`が両方とも存在することになります。

# 使ってみる

実際に継承の機能を使ってみましょう。
まずとにかくもとになる基底クラスが必要です。
RPGのキャラをモチーフにしたクラスから始めてみましょう...
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


# ここからメインの処理

a = Unit(20,10,3)
b = Unit(20,8,4)

for i in range(5):
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
        
```

## 説明文
各メソッドを見ていきましょう...
``` python
>>>>>>>>>>
class Unit:
    """RPGのキャラっぽいなにか"""
<<<<<<<<<<
```
...の前に、見慣れない表記が出てきています。
クラスや関数の冒頭にある、`"""ダブルクオーテーション3つで囲まれた文字列"""`は、
そのクラスやその関数の説明だとみなされます。
そのクラスやその関数が何をするものなのか、わかりやすい名前をつけるのが一番ですが、
やはり日本語で説明するほうがなにかとよいです。

特に関数では、引数や戻り値があります。
それぞれの引数が何を表すのか(呼び出す際にどういう値を指定してほしいのか)、
どういう戻り値を返しうるのか、などは
名前だけでは十分に表しきれませんので、***日本語で説明を加えるべきです。***
``` python
>>>>>>>>>>
    def attackTo(self, enemy):
        """
        別のUnitインスタンスに攻撃を仕掛ける
        勝ったら正の値,負けたら負の値,引き分けなら0を返す
        enemy - 攻撃を仕掛けるUnitインスタンス
        """
<<<<<<<<<<
```

## メソッド巡り
こんどこそ各メソッドを見ていきましょう。

``` python
>>>>>>>>>>
    def __init__(self, hp, attack, defence):
        """初期化時にHP,攻撃力,防御力を設定する"""
        self.hp = hp
        self.attack = attack
        self.defence = defence
<<<<<<<<<<
```
コンストラクタです。説明文の通りですね。


``` python
>>>>>>>>>>
    def getStatus(self):
        """ステータス画面的なもの"""
        return "HP: %d | Atk %d | Def %d" % (self.hp, self.attack, self.defence)
<<<<<<<<<<
```
現在のステータスを画面に出力する方法が欲しかったので、
(何もしなければ変数の中身の値は見えません！)
フォーマット文字列を使ってステータス画面っぽい文字列を生成して返しています。

``` python
>>>>>>>>>>
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
<<<<<<<<<<
```
ダメージを受けます。

`max()`関数は、与えられた引数の中で最も大きい数を返す関数です。
このことは、下限を設定することに応用できます。
たとえば、片方の引数を`3`に、もう片方の引数をいろいろ変えて最も大きい数を暗算してみましょう。

- `max(6,3)` -> `6`
- `max(5,3)` -> `5`
- `max(4,3)` -> `4`
- `max(3,3)` -> `3`
- `max(2,3)` -> `3`
- `max(1,3)` -> `3`

変化する部分が`3`より大きいうちはそのままになり、
しかも`3`よりは下がらないことがわかります。

ここでは、`damage = max(damage - self.defence, 1)`としています。
自分の防御力のぶんだけダメージから引き(コンストラクタでインスタンス変数として設定していました)、
ただし下限を`1`として、`damage`に再代入しています(変数の今の値を加工して、同じ変数に再び代入することができるのでしたね)。

ところで、"変数から数字を引いて同じ変数に再代入する"操作はよく使います。
なので、専用の書き方があります。次の行の`self.hp -= damage`がそれです。
"`self.hp`から`damage`を引いて`self.hp`に再代入する"、
すなわち"`self.hp`の値を`damage`だけ減らす"ためにこの書き方を使うことができます。

この書き方は減算だけでなく加減乗除それぞれに用意されています。

- `a += 3` : `a`に`3`を足す
- `a -= 3` : `a`から`3`を引く
- `a *= 3` : `a`に`3`を掛ける
- `a /= 3` : `a`から`3`を割る

``` python
>>>>>>>>>>
    def isDead(self):
        """自分はもう死んでいる、かどうか"""
        return self.hp <= 0
<<<<<<<<<<
```
自分が死んでいるかどうかを判定します。
(短いメソッドですが、あとでこれが活躍します)

``` python
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
```
他の`Unit`に攻撃を仕掛けます。
`Unit`のインスタンスに属するメソッドでありながら、
"他の`Unit`インスタンス"を引数に取っていることがポイントです。
そうすることで操作できる`Unit`インスタンスが 自分:`self`と相手:`enemy` で
2つになり、戦闘を実現できるようになります。

`enemy`の`isDead()`や`enemy`の`dealDamage()`を呼び出して
処理をしているところもポイントです。
「`enemy`にあなたは死んでいますか、と聞く」・「`enemy`にお願いしてダメージを受けてもらう」
というイメージでしょうか。
`enemy`の内部状態のことは`enemy`自身が一番知っているはずですから、
`enemy`の状態に関することは`enemy`にお願いする、
またそうできるように最初から`Unit`のインスタンスメソッドを作っておく、ことが大事です。

さらにメインプログラムが続いています...
``` python
>>>>>>>>>>
a = Unit(20,10,3)
b = Unit(20,8,4)

for i in range(5):
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print

<<<<<<<<<<
```

`Unit`のインスタンスを2つ作り、
「`a`から`b`に攻撃してステータス画面を表示する」のを5回繰り返しています。

各自実行してみましょう。
4回目の攻撃で`a`が`b`を削り切って勝っていることが確認できると思います。


# 魔法を使いたい

殴り合うのもよいですが、やはり魔法での攻撃もしてみたいところです。
「魔法攻撃は攻撃力ではなく魔法攻撃力を用いて計算し、
反撃を受けないが、魔法が使えるのは魔法使いだけ」
というのを目指しましょう。

従来の`Unit`の機能に加えて、魔法攻撃ができる新しいクラスをつくります。
「継承」の出番です。

``` python
>>>>>>>>>>
class Wizard(Unit):
    """魔法使い"""

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
        
<<<<<<<<<<
```

...これが`Wizard`クラスの定義のすべてです。
`Unit`クラスを継承して`Wizard`クラスをつくり、魔法攻撃用のメソッドを1つ追加しています。
`Unit`クラスを継承しているので、`Unit`クラスに定義されていたもの――`self.hp`,`self.attack`,`self.defence`,`self.isDead()`,`self.dealDamage()`,などなど――がすべて`Wizard`クラスに引き継がれています。
追加分だけを書けばよい、ということになります。

`Unit`クラスはそこにそのまま存在していることにも注意してください。
引き続き`Unit`のインスタンスは作成することができ、戦闘をさせることもできつつ、
`Wizard`のインスタンスも新しく作成できるのです。

さらに、`Wizard`は`Unit`から***すべてを***引き継いでいるので、
`Unit`で出来たことは`Wizard`でもできます。
`Wizard`のインスタンス`a`と`b`に拳で殴り合わせる(`a.attackTo(b)`)ことも可能です。
`attackTo()`を処理するためには`self`と`enemy`の双方に
変数`attack`,メソッド`isDead()`,メソッド`dealDamage()`
がなければなりませんが、`Wizard`インスタンスにもそれらは存在していますから、
(なぜなら***すべてを***引き継いでいるから、記述していないのに！)
問題なく`attackTo()`を呼び出すことができます。

さらにいえば、`Wizard`から`Unit`に`attackTo()`することも、
まったく同じ理屈で可能です。
`Wizard`から`Unit`へは魔法攻撃、`Unit`から`Wizard`へは通常攻撃、を
1セットにして繰り返すメインプログラムにしてみましょう。
こうなります...

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

プログラム全体は次のようになります。
各自実行してみましょう...
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
b = Wizard(12,3,3)
b.magic_attack = 13

for i in range(5):
    print b.magicalAttackTo(a)
    print a.attackTo(b)
    print "a | %s" % a.getStatus()
    print "b | %s" % b.getStatus()
    print
    
```
...2ターン目で戦闘終了していることが確認できると思います。


