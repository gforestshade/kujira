+++
date = "2017-10-20"
draft = false
title = "それからのPython 2"
banner = "green"
tags = ["それからのPython", "せつめい"]
+++

# はじめに

- [その１]({{<ref "secondpy1.md">}})のつづき
- いろいろ表示してみる

# -4000年
`gc.getGame().getGameTurnYear()`により現在の年を取得します。
これによって得られる値は数値型ですから、フォーマット文字列により埋め込んで
Unicode文字列を作り、表示してあげます。

コードは...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
        
        year = gc.getGame().getGameTurnYear()
        message = u"ようこそ！現在%d年です。" % year
        
        CyInterface().addImmediateMessage(message, "")

```
こうなりますね。

ゲーム開始してみましょう。
{{<img src="/img/kujira_var_30.png">}}

# 紀元前-4000年
うまく表示されました...が、"紀元前"がマイナスとして表現されてしまっていますね。
もちろん、`year`は数値型であり、数値以外のデータを含むことはできませんから、
これでよいのですが...贅沢を言うなら、ちゃんと"紀元前"と表示されてほしいところです。
さらにわがままを言うなら、プラスなら紀元後、マイナスなら紀元前、がついてくれると
なおうれしいです。if文を使って書いてみましょう。

```
>>>>>>>>>>
        year = gc.getGame().getGameTurnYear()
        if year >= 0:
            ce = u"紀元後"
        else:
            ce = u"紀元前"
        
        message = u"ようこそ！現在%s%d年です。" % (ce, year)
    
        CyInterface().addImmediateMessage(message, "")
<<<<<<<<<<
```
変数の埋め込みを２つにしています。
`message = u"ようこそ！現在%s%d年です。" % (ce, year)`とあるうちの、
`%s`が文字列型、`%d`が数値型、の埋め込み位置を表しています。
実際に埋め込みたい値を`%`の後ろに指定しますが、
2つ以上ある場合は`()`でくくる必要があります。 
ここでは文字列として`ce`の値、数値として`year`の値を指定しています。
で、変数`ce`がどこから来ているのかというと、上のif文で「yearの値が0以上」かそうでないかで異なる値を代入していることが分かります。

処理の流れはこうなります。

+ `year`に`gc.getGame().getGameTurnYear()`の戻り値、すなわち`-4000`という値が代入される
+ if文の条件分岐で、`year >= 0`の判定をする
+ 結果は`False`(ちがう)なので、処理がelseブロックに移る
+ `ce`に`u"紀元前"`が代入される
+ `ce`と`year`の中身、すなわち`u"紀元前"`と`-4000`を`%s`と`%d`の場所に埋めこんで文字列を作る
+ 作った文字列を`message`に代入する
+ `message`の値と`""`を引数として`CyInterface().addImmediateMessage()`を呼び出す

結果、呼び出した関数により画面上にメッセージが表示される...はずです。
やってみましょう。
{{<img src="/img/kujira_var_31.png">}}

# 紀元前4000年
"紀元前"を表示することには成功しました。
が、結局`year`は`-4000`のままなので、
それがそのまま表示されてしまっていることが不満です。
`year`の値を`-4000`から`4000`へと変えたいです。
`year`は数値型ですから、ほかの数値と計算ができます。
それでなんとかならないでしょうか。

そういうわけで、こう書いてみます。
```
year = -year
```
実は、変数は何回でも上書き代入ができます。
その上書きする値を計算するために、自分自身の元の中身を使うことができます。

それを踏まえると、これも代入文(`変数名 = 値`)であることがわかります。
`=`の左には`year`という変数名が書いてありますし、
`=`の右には `-(yearの中身の値)`の計算結果という値が書いてあります。
ですからこの「文」は、「`-year`という値を`year`に代入する」と読みます。

ところで、`-year`とはなにを計算しているのでしょうか。
これは見た目通り「`year`にマイナスをつけた数」を計算しています。
`year`の中身がもうすでにマイナスだったら？
その場合も、数学でいうところの「-(-4000)」を計算します。
この数式の答えは+4000ですから、`-year`の計算結果は+4000を表すことになります。

これでマイナスを取ることができます...が、マイナスを取りたいのは`year`が元からマイナスだった時だけです。
したがって「yearが0以上でないとき」に実行されるelseブロックにだけこの文を書きます。

全部で...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
        
        year = gc.getGame().getGameTurnYear()
        if year >= 0:
            ce = u"紀元後"
        else:
            ce = u"紀元前"
            year = -year
        
        message = u"ようこそ！現在%s%d年です。" % (ce, year)
    
        CyInterface().addImmediateMessage(message, "")
```
こうなります。

さんざん長々と説明しましたが、1行しか変わっていません。(どこかはわかりますね？)
どこが変わったのかわかったら、ゲームを開始してみましょう。
{{<img src="/img/kujira_var_32.png">}}
いいですね！

# showGameTurnYear()
「現在年を上に表示する」というひとつの機能のかたまりが完成しました。
名前をつけておきます。表示する、ですから
`showGameTurnYear()`にしましょう。
```
>>>>>>>>>>
def showGameTurnYear():
    '''現在年を上に表示する'''

    year = gc.getGame().getGameTurnYear()
    if year >= 0:
        ce = u"紀元後"
    else:
        ce = u"紀元前"
        year = -year
        
    message = u"ようこそ！現在%s%d年です。" % (ce, year)
    
    CyInterface().addImmediateMessage(message, "")
<<<<<<<<<<
```

# 毎ターン現在年を知らせてくる
この関数を、`onGameStart()`ではなく`onBeginPlayerTurn()`から呼び出してみます。
GameStartとある部分をBeginPlayerTurnに変えて、
そのブロックの中でshowGameTurnYear()を呼び出しましょう。
全体で...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

def showGameTurnYear():
    '''現在年を上に表示する'''

    year = gc.getGame().getGameTurnYear()
    if year >= 0:
        ce = u"紀元後"
    else:
        ce = u"紀元前"
        year = -year
        
    message = u"現在%s%d年です。" % (ce, year)
    
    CyInterface().addImmediateMessage(message, "")


class MyEventManager(CvEventManager.CvEventManager, object):

    def onBeginPlayerTurn(self, argsList):
        'Called at the beginning of a player's turn'
        super(self.__class__, self).onBeginPlayerTurn(argsList)
        ##########
        # 単に呼び出す
        showGameTurnYear()
```
こうなっているはずです。
ゲーム開始して、一度ターンを進めます。
{{<img src="/img/kujira_var_33.png">}}
わらわらっと出てきてしまいました。
それにめげず、しばらくゲームを進めると
{{<img src="/img/kujira_var_34.png">}}
紀元後への切り替えはうまくいきましたね！

## 一般化
実は、ゲーム開始時、`year = -4000`だと先入観がある時点では、
「マイナスを取って紀元前をつける」だけでも良かったはずです。
わざわざif文まで使って紀元後のことを考えるよりは、短く書けたことでしょう。
が、実際には`gc.getGame().getGameTurnYear()`の戻り値は
ゲームの進行状況によって変わるのであって、マイナスかプラスかは一概にはわからないはずです。
そこで、あえて最初から状況を決めつけないコードを書こうとしました。
この考え方を"一般化"あるいは"抽象化"と呼びます。
変数や関数の力を借りて一般化する、あるいは一般化されたコードを読み解く、
ことで複雑な動作でも把握しやすくすることができるのです。

## 関数
関数化しておいたことで、`onBeginPlayerTurn()`の本体はわずか1行ですんでいます。
さらに私たちは、年代を表示したければいつでもまた別の場所で`showGameTurnYear()`と書くだけで
年代を表示させることができる便利な道具を手に入れたことにもなります。
確かにコードのかたまりを丸ごとコピペすることで同じ恩恵を受けることはできます、が
関数では"集中・集約"されているという非常に大きな利点があります。

たとえばいろんなタイミングで年代を表示してみて参考にしていたとして、さらに
「上に表示されるのはうるさい、ログファイルに書き込んで後から見られたらいいや」
と思ったとすると、やることは`CyInterface().addImmediateMessage(message, "")`を
`print message`に変えることです。
```
>>>>>>>>>>
        year = gc.getGame().getGameTurnYear()
        if year >= 0:
            ce = u"紀元後"
        else:
            ce = u"紀元前"
        
        message = u"ようこそ！現在%s%d年です。" % (ce, year)
    
        # CyInterface().addImmediateMessage(message, "")
        print message
<<<<<<<<<<
```
関数では各地から同じコードを呼び出していますから、関数の中身を変えれば終わりです。

では、このかたまりごと各地にコピペしたとしたらどうでしょうか。
途端にコピペした箇所すべてを探し出して修正しなければならなくなってしまいます。
修正量はコピペした回数に比例して跳ね上がってしまいますし、
そもそもどこにコピペしたのかを一生懸命全箇所思い出す必要があります。
もし、そのつらい修正作業の途中でミスタイプしてしまって新たなバグを仕込んでしまったら...
いろいろと困ってしまいます。

そもそも、
別の場所で同じ動作をするときはコピペせずに同じ関数を呼び出し、
関数の中を変えることによって全箇所でちゃんと挙動が変わってくれる、
まさにそのしくみによってCiv4のMODは動いています。
ターン開始時にCiv4のプログラムが毎回律義に`onBeginPlayerTurn()`を
呼び出してくれているからこそ、私たちが関数の中身を変更しているだけで
毎ターン、開始時の処理がちゃんと変わってくれるのです。

# さて
毎ターン表示されるようになりましたが、2つほど不満が残っています。

+ たくさん出すぎ
+ 1ターンずれている

これらは、onBeginPlayerTurnが正確には
「各Playerの」「ターン処理を開始するとき」であることに由来しています。
PlayerというのはAIのそれを含むのでしたから、人数分出てしまっているのです。
ターン処理というのは研究を進めたり、国庫を増やしたり、生産を進めたり、
といった処理で、これらは移動・生産指示などを終えてターン終了ボタンを押した後に
行われます。つまり人間プレイヤーにとっての「ターン処理開始時」は
ターン終了ボタンを押した直後、ということになります。
その時点ではまだA.D.0ですから「紀元後0年」と上に表示されますが、
次にプレイヤーが操作可能になるのは次のターン、A.D.25になった後です。
なので食い違って見えるのですね。

間違っているわけではないのでずれは仕様ということにしても、
たくさん出るのはなんとかならないでしょうか。
こちらは、「このターンのPlayerが人間操作ならば」の条件を入れてあげることで
AIPlayerのターンでは出ないようにできます。
やってみましょう。

```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

def showGameTurnYear():
    '''現在年を上に表示する'''

    year = gc.getGame().getGameTurnYear()
    if year >= 0:
        ce = u"紀元後"
    else:
        ce = u"紀元前"
        year = -year
        
    message = u"現在%s%d年です。" % (ce, year)
    
    CyInterface().addImmediateMessage(message, "")


class MyEventManager(CvEventManager.CvEventManager, object):

    def onBeginPlayerTurn(self, argsList):
        'Called at the beginning of a players turn'
        super(self.__class__, self).onBeginPlayerTurn(argsList)
        ##########
        iGameTurn, iPlayer = argsList
        pPlayer = gc.getPlayer(iPlayer)

        # 人間のターンなら
        if pPlayer.isHuman():
            showGameTurnYear()
```

起動して何回かターンを進めて...
{{<img src="/img/kujira_var_35.png">}}
できました！

# アイサツ
タイミングの問題で「ようこそ！」を外さざるを得なかったのが少し心残りです。
もうひとつ`%s`をふやして、頭にあいさつを付けられるようにしてみましょう。
そのあいさつの文字列はどこから取るのかというと...
関数の外から指定してもらうようにしてみましょう。
引数の仕組みを使って次のようにできます。
```
def showGameTurnYear(prefix):
    '''現在年を上に表示する'''

    year = gc.getGame().getGameTurnYear()
    if year >= 0:
        ce = u"紀元後"
    else:
        ce = u"紀元前"
        year = -year
        
    message = u"%s現在%s%d年です。" % (prefix, ce, year)
    
    CyInterface().addImmediateMessage(message, "")
```

呼び出し側も書いていきますが、どうせなので引数を違えてゲーム開始時とターン処理開始時の
両方から呼び出してみましょう...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

def showGameTurnYear(prefix):
    '''現在年を上に表示する'''

    year = gc.getGame().getGameTurnYear()
    if year >= 0:
        ce = u"紀元後"
    else:
        ce = u"紀元前"
        year = -year
        
    message = u"%s現在%s%d年です。" % (prefix, ce, year)
    
    CyInterface().addImmediateMessage(message, "")


class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########

        showGameTurnYear(u"ようこそ！")

    def onBeginPlayerTurn(self, argsList):
        'Called at the beginning of a players turn'
        super(self.__class__, self).onBeginPlayerTurn(argsList)
        ##########
        iGameTurn, iPlayer = argsList
        pPlayer = gc.getPlayer(iPlayer)

        # 人間のターンなら
        if pPlayer.isHuman():
            showGameTurnYear(u"処理中...")
```

ターンを進めて...
{{<img src="/img/kujira_var_36.png">}}
{{<img src="/img/kujira_var_37.png">}}
うまくいきました。
処理中であることを明示したことでほんの少し違和感対策ができました。<!-- せやろか -->
