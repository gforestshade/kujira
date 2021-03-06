+++
date = "2018-03-05"
title = "CIV4UnitClassInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4ClassUnitInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Units\CIV4UnitClassInfos.xml{{</path>}}

にあります。

# ユニットクラス

ただ一口に「斧兵」といっても、個々の斧兵のことなのか、斧兵という種類のことなのか、
UUを含むのか含まないのか、どれのことなのか、いまいちよくわかりません。
雰囲気で察している方も多いのではないでしょうか。
Civ4はプログラムですから、内部ではもちろんきっちりと区別しています。
どうなっているのか、図にしてみました。

<!--more-->

![ユニットクラスタイプ→ユニットタイプ→個々のユニット](/img/UnitClassType.png)

まず、個々のユニットがあります。内部では**Unit**と呼びます。
斧兵が1体、斧兵が2体、......などという場合、個々のユニットを指していますね。

それを取りまとめる存在として、**UnitType**というものがあります。
斧兵を生産できるようになった、斧兵が陳腐化した、などという場合、
斧兵という種類を指していますね。

文明によっては、斧兵のかわりにファランクスや死鳥隊や犬戦士が生産できることもあります。
これらは、***すべて別々のユニットタイプです。***
というのも、同じユニットタイプを持つユニットはすべて同じ性能を持つからです。
ですから、UUの性能を元の斧兵から変えたい場合、ユニットクラスを分けなくてはなりません。

ですがゲーム中、私たちはUU同士の区別をあまり意識していません。
例えば、チャリオット兵の「斧兵に対する攻撃+100%」という能力は、
ファランクスにも死鳥隊にも犬戦士にもちゃんと適用されます。
ユニットクラスが違うにも関わらず、です。

つまり、斧兵とそのUU群、図に載っているもののすべての親、
「斧兵という概念」とでも呼ぶべきものが存在しているのです。
内部ではそれを**UnitClassType**と呼びます。
斧兵に対する攻撃+100%、戦士は斧兵にアップグレード可能、
などという場合の「斧兵」はこれを指しています。

ユニットクラスタイプは概念なので、それ自体はゲーム上の何とも対応していません。
子どもとしてユニットタイプを1つ以上持ち、
文明によって適したユニットタイプに分岐させるだけの存在です。

なお、各子どもの立場はすべて対等です。
ユニットタイプ斧兵は「その他の文明」という分岐条件を持つだけの、
ただの1つの子にすぎません。

XMLのModdingにおいて、ユニット種の指定を求められる場合、
ユニットクラスタイプを指定します。
そうすることで、UUも含めて包括的に扱うことができるようになっているのです。

# 各タグの説明

## \<Civ4UnitClassInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4UnitSchema.xml"`を指定します。

## \<UnitClassInfo\>
このタグ1つが、ユニットクラスの定義1つと対応しています。

以下\<UnitClassInfo\>の中身です。

### \<Type\>
このユニットクラスのユニットクラスキーを定義します。
他と被らなければなんでも構いませんが、UNITCLASS\_英語名 にするのが無難です。

値：ユニットクラスキー

例：
\<Type\>UNITCLASS\_WARRIOR\</Type\>

### \<Description\>
このユニットクラスの名前を指定します。

値：テキストキー

例：
\<Description\>TXT\_KEY\_UNIT\_WARRIOR\</Description\>

### \<iMaxGlobalInstances\>
世界ユニットとしての生産制限数を指定します。

これは世界遺産のユニット版です。
ここに正の値nを指定する場合、
このユニットクラスに属するユニットは
ゲーム全体で(子UU合計で)n体までしか生産できません。

生産は早い者勝ちで、間に合わなかった文明が注いだハンマーは換金されます。
ユニットが撃破されることによって生産数が回復することはありません。

特に生産制限のない普通のユニットの場合、-1を指定します。

値：整数

例：
\<iMaxGlobalInstances\>-1\</iMaxGlobalInstances\>

### \<iMaxTeamInstances\>
チームユニットとしての生産数制限を指定します。

ここに正の値nを指定する場合、
このユニットクラスに属するユニットは
チーム全体で(子UU合計で)一度にn体までしか所持できません。

特に生産制限のない普通のユニットの場合、-1を指定します。

値：整数

例：
\<iMaxTeamInstances\>-1\</iMaxTeamInstances\>

### \<iMaxPlayerInstances\>
国家ユニットとしての生産数制限を指定します。

ここに正の値nを指定する場合、
このユニットクラスに属するユニットは
一度にn体までしか所持できません。

特に生産制限のない普通のユニットの場合、-1を指定します。

値：整数

例：
\<iMaxPlayerInstances\>-1\</iMaxPlayerInstances\>

### \<iInstanceCostModifier\>
所持数による生産コスト上昇を指定します。

ここに正の値nを指定する場合、
このユニットクラスに属するユニットを生産する際、
(所持数 * n)%だけ生産コストが上昇します。

値：整数

例：
\<iInstanceCostModifier\>0\</iInstanceCostModifier\>

### \<DefaultUnit\>
デフォルトの子ユニットタイプを指定します。

文明による指定がなければ、その文明においては
このユニットクラスタイプはこのユニットタイプに分岐します。

\<DefaultUnit\>UNIT\_WARRIOR\</DefaultUnit\>

<br><br>
