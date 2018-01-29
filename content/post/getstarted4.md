+++
date = "2017-07-26"
lastmod = "2018-01-28"
draft = false
title = "はじめてのPythonMOD 4"
banner = "photo_yellow"
tags = ["はじめてのPythonMOD", "せつめい"]
+++

# はじめに

- [その３]({{<ref "getstarted3.md">}})のつづき
- その３でMODひとつしか作れなかったので応用編の別立て

# もう少し先へ
前半戦たるその３では
《都市が建設されたとき、所有者の志向が防衛志向ならば、その都市のタイルに弓兵を３体即座に作成するMOD》
を作りました。少し拡張してみましょう。

「弓兵固定ではなく、時代に合わせた防衛ユニットが出るようにしたい」

と思ったとします。が、少々厄介です。
というのも、「時代に合わせた防衛ユニット」という表現があいまいなのです。
これをプログラムするには「どういう条件で」「何が起こるのか」を具体的に定めるところから始めないといけません。

## 例えば

- なにもなければ弓兵が3体出る
- 封建制と弓術を取得済みなら長弓兵が3体出る
- 鉄道を取得済みなら機関銃兵が3体出る
- ロボット工学とライフリングを取得済みなら機械化歩兵が3体出る

このように、まず条件を具体的に書きだします。
すこしプログラムっぽくなってきましたが、
これをそのままif文で並べても以下の理由によりまだうまくいきません。

- 封建制と弓術と鉄道をどれも取得済みのとき、
２つの条件を同時に満たしてしまい、両方が3体出てしまう
- 弓兵の出る条件である「ほかの条件をどれも満たさないなら」は
今知っているif文では書けない

# そして今日の理論編
<iframe src="https://paiza.io/projects/e/WmGaoo_zPs6GaaW9LGFx0A?theme=twilight" width="100%" height="500" scrolling="no" seamless="seamless"></iframe>

## elifとelse

if文には条件を満たす場合と満たさない場合、両方の処理を書くことができます。
``` python
if 条件:
    条件を満たす場合の処理
else:
    条件を満たさない場合の処理
```

また、複数の条件をつなげて書くこともできます。
``` python
if 条件１:
    条件１を満たす場合の処理
elif 条件２:
    条件１は満たさないが条件２を満たす場合の処理
elif 条件３:
    条件１も条件２も満たさないが条件３を満たす場合の処理
else:
    条件１も条件２も条件３も満たさない場合の処理
```

## 真と偽
if文は条件式が**真**と解釈される場合にブロックを実行し、**偽**と解釈される場合にはelseのブロックを実行します。
pythonにおいて**真**と解釈されるものは以下の通りです。

- `True`
- その他**偽**と解釈されるもの以外全部

「えっ」と思われた方もいるかもしれませんが、そういうものなのです。
では肝心の**偽**と解釈されるものは以下の通りです。

- `False`
- 数値の`0`
- 空の文字列`""`
- 空のタプル`()`・空のリスト`[]`・空のディクショナリ`{}`
- `None`

知らない用語がいろいろ出てきましたが、
とりあえず今回は`True`(**真**)と`False`(**偽**)について知っておけばよいです。

`==`, `<`, `>`といった左辺と右辺を比較する**演算子**は、
比較した結果により`True`か`False`のどちらかに「置き換えられます」。
`3 == 3`は`True`ですし、`3 == 5`は`False`です。
(覚えていますか？`==`は左辺と右辺が等しいかどうかを比較してくれるのでした。)

このあたりは、関数の呼び出し文字列が「戻り値」で置き換えられていたのと似ています。
理論編はただ読んでいてもなかなか頭に入りません。実際に少し書いてみましょう。
Python2の実行環境で...

``` python
print "=="
print 3 == 3
print 3 == 5
print 

print "!="
print 3 != 3
print 3 != 5
print

print "<"
print 3 < 3
print 3 < 5
print

print ">"
pritn 3 > 3
print 3 > 5
print

print "<="
print 3 <= 3
print 3 <= 5
print

print ">="
pritn 3 >= 3
print 3 >= 5
print
```

どういう出力になるか書きながら予想して、それから実行してみましょう。
どうでしょうか。比較が正しいか正しくないかによって
`True`か`False`に「なって」いることがわかると思います。

(あまり実用上の意味はありませんが)if文に`True`や`False`を直接書くこともできます。

``` python
if True:
    print "jikkou sareru kana?"

if False:
    print "sarenai kana?"

```
予想して、実行してみましょう。

`True`も`False`も値なので、それら自体を変数に代入してしまうこともできます。
``` python
a = True
if a:
    print "itsumo jikkou sareru YO!"
else:
    print "zettai jikkou sarenai kamo"
```
予想して、実行してみましょう。

## andとor
もう少しだけ我慢しておつきあいください。
例えば「`a`も`b`も3以上ならば」と書きたいときはどうすればよいでしょうか。
少し解体して、`a>=3`と`b>=3`の「両方が`True`のときに限り`True`になる」表現が必要になります。
つまり、それが、`and`です。書いてみましょう。

``` python
a = 8
b = 3

if a >= 3 and b >= 3:
    print "hyoji sareru kana?"

if a > 3 and b > 3:
    print "koreha dou kana?"

```
予想して、実行してみてください。

対になる「どちらかが`True`なら`True`、どちらも`False`のときのみ`False`」もあります。
`or`です。
``` python
a = 8
b = 3

if a >= 3 and b >= 3:
    print "dou kana?"

if a > 3 and b > 3:
    print "kou kana?"

if a > 9 and b > 9:
    print "kou kamo"
```

表で見る `and`と`or`

| &nbsp;&nbsp; a &nbsp;&nbsp; | &nbsp;&nbsp; b &nbsp;&nbsp; |a and b|
|:---:|:---:|:---:|
|〇|〇|〇|
|〇|×|×|
|×|〇|×|
|×|×|×|


| &nbsp;&nbsp; a &nbsp;&nbsp; | &nbsp;&nbsp; b &nbsp;&nbsp; |a or b|
|:---:|:---:|:---:|
|〇|〇|〇|
|〇|×|〇|
|×|〇|〇|
|×|×|×|

# とことこMOD
## 条件の優先度を考える
さて、「複数条件を満たしたときに優先されてほしい順」に条件を並び替えましょう。

- なにもなければ弓兵が3体出る
- 封建制と弓術を取得済みなら長弓兵が3体出る
- 鉄道を取得済みなら機関銃兵が3体出る
- ロボット工学とライフリングを取得済みなら機械化歩兵が3体出る

の例ですと、まるっと逆にして
機械化歩兵→機関銃兵→長弓兵の順にしましょう。
機関銃兵が出る条件と長弓兵が出る条件を
両方満たしたときには機関銃兵が優先されてほしいですし、
機関銃兵が出る条件を満たしてなくて、長弓兵が出る条件は満たしているときに限り、
長弓兵が出てほしいのです。

``` python
if ロボット工学を取得済み and ライフリングを取得済み:
    機械化歩兵
elif 鉄道を取得済み: #上は満たさず鉄道があるなら
    機関銃兵
elif 封建制を取得済み and 弓術を取得済み: #上のいずれも満たさず封建弓術があるなら
    長弓兵
else: #上のいずれでもないなら
    弓兵
```

「両方を取得済み」をどう書くかの知識も利用して、
こんな感じになることがわかります。

## 技術は誰のものか
技術はPlayerが研究するわけですから取得済みの技術のリストもPlayerの元にある
............わけではありません。
そもそも実際のゲームでも、取得済み技術のリストはPlayerの占有財産ではありません。
そう、チーム全体で共有しているのです。それはTeamの持ち物です。
(通常のシングルプレイでは、Pleyer１人だけがメンバーのTeamが仮想的につくられています)

PythonでのMOD開発ではプログラムを記述するので、
コンピュータが迷わないようにはっきりきっかり記述しなければなりません。
PlayerとTeamのような通常の一人プレイではあまり意識しないような細かい違いであっても重要になってきます。
細かい仕様に一喜一憂するのもMOD開発の楽しみのひとつだと思って、ゆるゆるいきましょう。

さて、そうなればPlayerが属するTeamを取得しましょう。
`iTeam = pPlayer.getTeam()`です。これの戻り値は例によってチームIDです。
チーム本体<!-- インスタンス -->を`gc`から取ってきましょう。 `pTeam = gc.getTeam(iTeam)`です。
もちろん、直接`gc.getTeam( pPlayer.getTeam() )`としてもよいでしょう。

## 関数の名前
そして技術を持っているか判定です。
[リファレンス][api]のCyTeamをクリックしてTechで探すと...

>
``` plain
BOOL isHasTech (TechType iIndex)
bool (TechID) - has the team researched techID
```

それっぽいのがありました。
だいぶ知識も蓄えたので、だんだん読めるようになってきました。

>
``` plain
BOOL isHasTech (TechType iIndex)
戻り値の種類 関数名(引数の種類 仮引数名)
```

<!-- 私は型についてちゃんと説明する驚くべき方法を発見したが、それを記すには余白が狭すぎる -->
上の行はこう読みます。
(下の行は説明ですが、あったりなかったりで当てにならないことも多いので...)

BOOLとあるのは要するに戻り値として`True`か`False`を返すよ、の意です。
TechType、すなわち技術の種類IDを引数として渡せば、
持ってるなら`True`、持ってないなら`False`を戻り値として返すよ、というわけですね。

こうして`isHasTech`という名前から機能を推測したりできるのも、関数の強みなのでした。
この場合、動作を表す一般動詞(～する)ではなく、
状態を表すbe動詞(～である)で始まっているので、
「～であるか？」という疑問形になっていてその情報を取得するのだろう
ということが戻り値BOOLとの合わせ技でわかってきます。

ほかにもCiv4の関数名はcan(～できるか？)で始まっている関数も
戻り値BOOLであることが多いようですし、
Yes/Noで答えられない戻り値はget(取得する)で始まっていることが多いようです。
`pCity.getPlayer()`や`pPlayer.getTeam()`などがまさにその例ですね。

***名前は大事です。***

ともあれ、`pTeam.isHasTech( gc.getInfoTypeForString('TECH_ARCHERY') )`のようにすれば
(XMLキーを渡すと対応する数値が返る関数を介して`isHasTech()`に渡していますね)
`True`か`False`かが返ってきますから、if文なりで分岐させればよいことがわかりました。

[api]: http://civ4bug.sourceforge.net/PythonAPI/index.html
## 共通な部分をまとめる
今回のMODでは、出るのはどの兵種であっても3体です。
3体出す部分を共通化してしまって、こうしてしまいましょう...
``` python
>>>>>>>>>>
# 変数unitにユニットIDをどうにかして代入しておく
createUnit(pPlayer, unit, x, y)
createUnit(pPlayer, unit, x, y)
createUnit(pPlayer, unit, x, y)
<<<<<<<<<<
```
さらに言えば、`unit`には
「Playerの(技術)状況に合わせた防衛ユニットの種類IDを取得して」
それを代入するのですから、
***まとめて言い表せる処理のかたまりにはわかりやすい名前を付けて関数にしましょう。***

このようにします...
``` python
def getDefensiveUnitType(pPlayer):
    pTeam = gc.getTeam( pPlayer.getTeam() )
    t = gc.getInfoTypeForString
    
    if pTeam.isHasTech( t('TECH_ROBOTICS') ) and pTeam.isHasTech( t('TECH_RIFLING') ):
        return t('UNIT_MECHANIZED_INFANTRY')
    elif pTeam.isHasTech( t('TECH_RAILROAD') ):
        return t('UNIT_MACHINE_GUN')
    elif pTeam.isHasTech( t('TECH_FEUDALISM') ) and pTeam.isHasTech( t('TECH_ARCHERY') ):
        return t('UNIT_LONGBOWMAN')
    else:
        return t('UNIT_ARCHER')

```

[関数の定義方法]({{<ref "getstarted3.md">}}#関数)は覚えていましたか？
`pPlayer`の状況に左右される情報を使いたいので、
どの`pPlayer`かを呼び出し側に指定してもらうことにします。
指定するのは呼び出し側なので、定義側では引数をつくるだけです。

PlayerからチームID経由で`pTeam`を取得して...
`t = gc.getInfoTypeForString`で関数に別名をつけています。
せっかくちゃんとした名前がついている関数があるのに
それを勝手に縮めてしまうなんて本来は重大な反逆行為ですが、
`if pTeam.isHasTech( gc.getInfoTypeForString('TECH_ROBOTICS') ) and pTeam.isHasTech( gc.getInfoTypeForString('TECH_RIFLING') ):`
のように多くの環境で折り返されて２行に渡ってしまい、ものすごく読み辛くなってしまうので
(折り返さない環境であっても見切れてしまって読み辛いことには変わりないので)
涙をのんでここで短縮しています。
<!-- まあでも実際、gc.getInfoTypeForString()は呼び出す頻度のわりに長すぎる気はする -->

if-elif-elseの中で、ユニットの種類IDを`return`で返しています。
この戻り値を`unit = getDefensiveUnitType(pPlayer)`として`unit`に代入して、
`createUnit(pPlayer, unit, x, y)`につなげていきます。

## KujiraEventManager.py
お待たせしました。全体像です。
``` python
from CvPythonExtensions import *
import CvEventManager
import CvUtil

gc = CyGlobalContext()

def createUnit(pPlayer, unit, x, y):
    pPlayer.initUnit(unit, x, y, UnitAITypes.NO_UNITAI, DirectionTypes.DIRECTION_SOUTH)

def getDefensiveUnitType(pPlayer):
    pTeam = gc.getTeam( pPlayer.getTeam() )
    t = gc.getInfoTypeForString
    
    if pTeam.isHasTech( t('TECH_ROBOTICS') ) and pTeam.isHasTech( t('TECH_RIFLING') ):
        return t('UNIT_MECHANIZED_INFANTRY')
    elif pTeam.isHasTech( t('TECH_RAILROAD') ):
        return t('UNIT_MACHINE_GUN')
    elif pTeam.isHasTech( t('TECH_FEUDALISM') ) and pTeam.isHasTech( t('TECH_ARCHERY') ):
        return t('UNIT_LONGBOWMAN')
    else:
        return t('UNIT_ARCHER')

    
class MyEventManager(CvEventManager.CvEventManager, object):

    def onCityBuilt(self, argsList):
        'Called when a player builds a city'
        super(self.__class__, self).onCityBuilt(argsList)
        ##########
        pCity = argsList[0]
        pPlayer = gc.getPlayer( pCity.getOwner() )

        if pPlayer.hasTrait( gc.getInfoTypeForString('TRAIT_PROTECTIVE') ):
            unit = getDefensiveUnitType(pPlayer)
            x = pCity.getX()
            y = pCity.getY()
            
            createUnit(pPlayer, unit, x, y)
            createUnit(pPlayer, unit, x, y)
            createUnit(pPlayer, unit, x, y)

```
<!-- いろいろとまずいところがあります。こんなところを読んでいる暇な人は粗探ししてみるのも一興。 -->

## ためす
{{<img src="/img/kujira_def_21.png" width="800" height="460">}}
封建制取得後の都市建設ではちゃんと長弓兵が出ているようです。
