+++
date = "2017-10-17"
draft = false
title = "それからのPython 1"
banner = "/green1024x200.png"
tags = ["それからのPython", "せつめい"]
+++

# はじめに
## これは何か
これは、
「はじめてのCvEventManager.py」シリーズの続きです。
もうちょっとPythonの書き方について勉強して、より思い通りに記述できるようになろう、というのが大きな目的です。

## これは何でないか
これは、前シリーズよりもさらに技術的な解説、Pythonの文法の解説に偏重しています。
また、「はじめてのCvEventManager.py」程度のMOD制作経験を前提としています。
コピペですぐ動くコードはあまりないかもしれません。

# 準備
最小構成からスタートしましょう。
## CivilizationIV.ini
``` ini
<<<<<<<<
; Enable the logging system
; Documents\My Games\Beyond the Sword(J)\Logs
LoggingEnabled = 1

; Enable synchronization logging
SynchLog = 1

; Overwrite old network and message logs
OverwriteLogs = 1
>>>>>>>>
```
ログファイルが出力されるようにしておきます。

## フォルダ構成
``` plain
└─kujira_var
    └─Assets
        └─Python
            │─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```
## CvEventInterface.py
``` python
# Sid Meier's Civilization 4
# Copyright Firaxis Games 2005
#
# CvEventInterface.py
#
# These functions are App Entry Points from C++
# WARNING: These function names should not be changed
# WARNING: These functions can not be placed into a class
#
# No other modules should import this
#
import CvUtil
# import CvEventManager
import KujiraEventManager
from CvPythonExtensions import *

# normalEventManager = CvEventManager.CvEventManager()
myEventManager = KujiraEventManager.MyEventManager()

def getEventManager():
	return myEventManager

def onEvent(argsList):
	'Called when a game event happens - return 1 if the event was consumed'
	return getEventManager().handleEvent(argsList)

def applyEvent(argsList):
	context, playerID, netUserData, popupReturn = argsList
	return getEventManager().applyEvent(argsList)

def beginEvent(context, argsList=-1):
	return getEventManager().beginEvent(context, argsList)
```
## KujiraEventManager.py
``` python
from CvPythonExtensions import *
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

## ためす
実行してゲームを開始し(開始さえすればそのあとすぐに終了して構いません)、
PythonDbg.log(日本語パッケージ版の場合Documents\My Games\Beyond the Sword(J)\Logs にあります)に
ちゃんと出力されているか確認しましょう。
{{<img src="/img/kujira_var_10.png">}}
いいですね。

# 変数
いきなりですが、ちょっと変えてゲームを開始してみましょう。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        a = "Hello, Python!"
        CvUtil.pyPrint(a)
<<<<<<<<<<
```
さっきと同じく、PythonDbg.logに```PY:Hello, Python!```と出力されています。

このように、プログラムではデータに名前を付けてとっておいて、後からその名前で中のデータを参照できるのですが、
そのうちの```a```を「変数」、その中に納まっているデータを「値」と呼びます。
そして```a = "Hello, Python!"```のように、```変数名 = 値```の形になっている「文」を代入と呼びます。
この場合「```a```という名前の変数に```"Hello, Python!"```という値を代入している」ということになります。

代入でない場所に書かれている変数は中身の値を表します。
いま```a```の中身は代入によって```"Hello, Python!"```ですから、```CvUtil.pyPrint(a)```は```CvUtil.pyPrint("Hello, Python!")```と同じ意味を表すことになります。

## 型
「値」にはデータの性質によって種類があります。
たとえば...

+ 数値型 ```a = 123```
+ 文字列型 ```a = "123"```
+ リスト型 ```a = [1,2,3]```
+ ブール型 ```a = True```

...などなど、いろいろあります。

## 型の一致
「型」の話で大事なのは、***種類があっていないと関数は基本的に失敗する***ということです。

試してみましょう。文字列型の代わりに数値型を使って```CvUtil.pyPrint(a)```してみます。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        a = 1234
        CvUtil.pyPrint(a) # 数値型で呼び出す
<<<<<<<<<<
```
これでゲームを開始してみてください。

PythonDbg.logをいくら眺めてみても、「1234」が出力されている様子はありません。
かわりにPythonErr.logを見てみると、"KujiraEventManager"の12行目、
すなわち```CvUtil.pyPrint(a)```と呼び出したところで
エラーになってしまっていることがわかります。

かわりにこうすべきです。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        a = "1234"
        CvUtil.pyPrint(a) # 数値型で呼び出す
<<<<<<<<<<
```
ゲームを開始して、どういう動作になるか自分で確かめてみましょう。

## 例外もある
先に***基本的に***と書いたのは、まれに融通が利く場面もあるからです。
その筆頭がprint文です。どんな型の変数を指定しても、ある程度はいい感じに出力してくれます。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        var1 = 1234
        var2 = "1234"
        var3 = [1,2,3,4]
        print var1
        print var2
        print var3
<<<<<<<<
```
ゲームを開始して、どういう動作になるか確かめましょう。

## でも基本はだめ
しかし、融通が利くことはまれです。
基本的には型があっていないとだめです。
例えば、同じようなプログラムでも、片方はOKでもう片方はエラーです。数値型同士でないと自由に計算はできません。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        tokugawa = 12
        saradin = 34
        answer = tokugawa * saradin
        print answer
<<<<<<<<
```

``` python
>>>>>>>>>>
        # ログファイルに出力する
        ragunaru = "12"
        monte = "34"
        answer = ragunaru * monte
        print answer
<<<<<<<<
```
どちらがエラーになるか、予想して確かめましょう。(エラーになったことを確認するにはどうすればよいでしょうか？)

あるいは、ややこしいことに、同じ書き方でも動作が違ってくるような場合もあります。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        tokugawa = 12
        saradin = 34
        answer = tokugawa + saradin
        print answer
<<<<<<<<
```

``` python
>>>>>>>>>>
        # ログファイルに出力する
        ragunaru = "12"
        monte = "34"
        answer = ragunaru + monte
        print answer
<<<<<<<<
```
どちらもエラーにはなりません。両方実行してみて、出力結果を見比べ、どうなっているか考えてみましょう。

そして、違う型同士の値を足し算することはできません。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        pakaru = "12"
        ramusesu = 34
        answer = pakaru + ramusesu # エラー！
        print answer
<<<<<<<<
```
エラーになることを確かめてみましょう。

# 文字列と、数値と。
でも、作っているMODによっては、数値型で計算した後、計算結果を文字列に混ぜて表示したいこともあるかもしれません。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        message1 = "ato "
        turnleft = 10 - 2  # 全部で10ターンあるうちの2ターン消化した
        message2 = " ta-n desu!"
        
        # "ato 8 ta-n desu!"という文字列の値をつくりたい！
        message = message1 + turnleft + message2 # でも型があってないからエラー。
        print message
<<<<<<<<
```
文字列を足し算して連結しようとしたところで、```turnleft```の値が数値型のため失敗してしまいます。
そこで、文字列型へと変換してあげましょう。```str()```という関数があり、
引数を文字列型に変換したものを返してくれます。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        message1 = "ato "
        turnleft = 10 - 2  # 全部で10ターンあるうちの2ターン消化した
        message2 = " ta-n desu!"
        
        # "ato 8 ta-n desu!"という文字列の値をつくりたい！
        message = message1 + str(turnleft) + message2 # 文字列型の値に変換してから足し算。
        print message
<<<<<<<<
```
起動して、PythonDbg.logに`ato 8 ta-n desu!`と書き込まれていることを確認しましょう。

## 文字列を表示する
文字列の値が用意できれば、画面上にメッセージとして出すことができるようになります。
```CyInterface().addImmediateMessage(表示したい文字列の値, "")```です。

``` python
>>>>>>>>>>
        # ログファイルに出力する
        message1 = "ato "
        turnleft = 10 - 2
        message2 = " ta-n desu!"
        
        message = message1 + str(turnleft) + message2
        CyInterface().addImmediateMessage(message, "")
<<<<<<<<
```
ゲームを開始して...
{{<img src="/img/kujira_var_20.png">}}
いいですね！

## フォーマット文字列
足し算で連結する方法がうまくいきましたが、やや見づらいですしわかりづらいです。
"ato (turnleftの値) ta-n desu!"みたいにかけたらいいのに...
というわけで、フォーマット文字列という機能がそれを実現してくれます。
`%d`と`%`を使って```message = "ato %d ta-n desu!" % turnleft```のように書くと、
`%d`のある位置に数値型の変数、つまり`turnleft`の値が文字列の一部として埋め込まれます。

これを用いると、前後の文字列を一旦ためておく必要もなくなり、次のようにすっきりします。
``` python
>>>>>>>>>>
        # ログファイルに出力する
        turnleft = 10 - 2
        message = "ato %d ta-n desu!" % turnleft
        CyInterface().addImmediateMessage(message, "")
<<<<<<<<
```

## 文字列と、数値と、それから日本語と
ここまでわかると、どうせなら「あと8ターンです！」と日本語で表示したくなるのですが、
今までの方法をそのまま流用してもうまくいきません。
それもそのはず、日本語の文字列は型が違うのです。
日本語の文字列はUnicode文字列型という型になり、```u"日本語"```と書きます。
ただひとつ注意点があり、この書き方でソースコード中に日本語を書き込むとき、
「その.pyファイルはどの文字コードで保存されているか」を1行目に明示的に示す必要があります。
普通にしていればおそらくshift_jisという文字コードになりますから、
(もちろん、わかっている方で、euc_jpやutf-8をお使いの方は読み替えてください)
1行目に```# -*- coding: shift_jis -*-```と書き込みます。
そのうえで、フォーマット文字列の仕組みを使い、
```message = u"あと%dターンです！" % turnleft```とすればよいです。

ファイル全体で...
```
# -*- coding: shift_jis -*-
from CvPythonExtensions import *
import CvEventManager
import CvUtil

class MyEventManager(CvEventManager.CvEventManager, object):

    def onGameStart(self, argsList):
        'Called at the start of the game'
        super(self.__class__, self).onGameStart(argsList)
        ##########
        # ログファイルに出力する
        turnleft = 10 - 2
        
        message = u"あと%dターンです！" % turnleft
        print message
        
        CyInterface().addImmediateMessage(message, "")
```
こうなります。
このコードではUnicode文字列に対してprint文を使っていますが、その場合もよしなにやってくれて
正しくPythonDbg.logに日本語が書き込まれるので、覗いてみてください。

さて、ゲームを開始して...
{{<img src="/img/kujira_var_21.png">}}
できました！
