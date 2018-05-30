+++
date = "2018-05-29T18:58:22+09:00"
title = "CIV4ProjectInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4ProjectInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\GameInfo\CIV4ProjectInfos.xml{{</path>}}

にあります。

## \<Civ4ProjectInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4GameInfoSchema.xml"`を指定します。

## \<ProjectInfo\>
このタグ1つが、プロジェクトの定義1つと対応しています。

以下\<ProjectInfo\>の中身です。

<!--more-->


### \<Type\>
このプロジェクトのプロジェクトキーを定義します。
他と被らなければなんでも構いませんが、PROJECT\_英語名 にするのが無難です。

値：プロジェクトキー

例：
\<Type\>PROJECT\_MANHATTAN\_PROJECT\</Type\>

### \<Description\>
このプロジェクトの名前を指定します。

値：テキストキー

例：「マンハッタン計画」
\<Description\>TXT\_KEY\_PROJECT\_MANHATTAN\_PROJECT\</Description\>


### \<Civilopedia\>
このプロジェクトのシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_PROJECT\_MANHATTAN\_PROJECT\_PEDIA\</Civilopedia\>

### \<Strategy\>
このプロジェクトの短い説明文を指定します。
シドのヒントやシヴィロペディアに表示されます。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_PROJECT\_MANHATTAN\_PROJECT\_STRATEGY\</Strategy\>

### \<VictoryPrereq\>
このプロジェクトは、ここに指定した勝利条件が有効になっているときのみ生産できます。

特に勝利条件による制限を設けない場合、NONEを指定します。
BtSでは、アポロ計画と宇宙船の各パーツがこの属性を持ちます。

値：[勝利条件キー]({{<ref "keyichiran">}}#勝利条件)

例１：
\<VictoryPrereq\>NONE\</VictoryPrereq\>

例２：宇宙開発勝利が有効のときのみ建造可能
\<VictoryPrereq\>VICTORY\_SPACE\_RACE\</VictoryPrereq\>

### \<TechPrereq\>
このプロジェクトは、ここに指定した技術を取得済みのときのみ生産できます。

特に技術による制限を設けない場合、NONEを指定します。
BtSでは、すべてのプロジェクトがなんらかの前提技術を持ちます。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：核分裂が必要
\<TechPrereq\>TECH\_FISSION\</TechPrereq\>

### \<AnyonePrereqProject\>
前提プロジェクトを指定します。
このプロジェクトを生産するには、ゲームに参加している誰かが
ここに指定したプロジェクトを完成させている必要があります。
自分で完成させる必要はありません。

特にこの意味での前提を設けない場合、NONEを指定します。
BtSでは、この属性を持つのは戦略防衛構想です。

値：[プロジェクトキー]({{<ref "keyichiran">}}#プロジェクト)

例１：
\<AnyonePrereqProject\>NONE\</AnyonePrereqProject\>

例２：世界中で誰かがインターネットを完成させている必要がある
\<AnyonePrereqProject\>PROJECT\_THE\_INTERNET\</AnyonePrereqProject\>

### \<iMaxGlobalInstances\>
世界プロジェクトとして指定します。
ここに正の整数nを指定した場合、このプロジェクトは全世界合計でn個まで建設することができます。

このプロジェクトが世界プロジェクトではない場合、`-1`を指定します。
BtSでは、世界プロジェクトはマンハッタン計画とインターネットです。

値：整数

例１：
\<iMaxGlobalInstances\>-1\</iMaxGlobalInstances\>

例２：世界プロジェクト(1個まで)
\<iMaxGlobalInstances\>1\</iMaxGlobalInstances\>

### \<iMaxTeamInstances\>
チームプロジェクトとして指定します。
ここに正の整数nを指定した場合、このプロジェクトはチーム内合計でn個まで建設することができます。

このプロジェクトがチームプロジェクトではない場合、`-1`を指定します。
BtSでは、チームプロジェクトは戦略防衛構想・アポロ計画・宇宙船の各パーツです。

なお、[\<iMaxGlobalInstances\>](#imaxglobalinstances)と[\<iMaxTeamInstances\>](#imaxteaminstances)の両方に`-1`を指定した場合、
このプロジェクトには一切の建造数制限がかからなくなります。
その場合、このプロジェクトは何度でも繰り返し生産することができるようになります。

値：整数

例１：
\<iMaxTeamInstances\>-1\</iMaxTeamInstances\>

例２：チームプロジェクト(1個まで)
\<iMaxTeamInstances\>1\</iMaxTeamInstances\>

### \<iCost\>
この建造物の生産コストを指定します。(単位：〈ハンマー〉)

ここに`-1`を指定した場合、このプロジェクトは都市で生産することができなくなります。

値：整数

例：
\<iCost\>1500\</iCost\>

### \<iNukeInterception\>
核兵器の迎撃率を指定します。
このプロジェクトが完成したとき、その文明の核兵器迎撃率が+n%上昇します。
実際に核攻撃されたときの迎撃率は、チーム内で最も大きい迎撃率を持つ文明の値に合わせられます。

核迎撃率を上げないプロジェクトの場合、0を指定します。

値：整数

例１：
\<iNukeInterception\>0\</iNukeInterception\>

例２：核兵器に対する迎撃のチャンス+75%
\<iNukeInterception\>75\</iNukeInterception\>

### \<iTechShare\>
インターネット効果を持たせます。
ここに正の整数nを指定した場合、このプロジェクトが完成したとき、
その文明は「技術共有状態:n」になります。
文明が「技術共有状態:n」である間、その文明から見て既知の文明のうち、
n文明[^team]に取得済みの技術を毎ターン無償で取得するようになります。

文明が複数の「技術共有状態」を持つ場合は、最も小さい数字のものが常に優先されます。
文明が同じ「技術共有状態」を複数持っても、効果に変化はありません。

[^team]: n文明と書いていますが、正確にはnチームです。

この機能を使わないプロジェクトの場合、NONEを指定します。

値：整数

例１：
\<iTechShare\>0\</iTechShare\>

例２：既知の2文明が取得した全テクノロジーを共有
\<iTechShare\>2\</iTechShare\>

### \<EveryoneSpecialUnit\>
このプロジェクトで解禁されるユニットを指定します。
ただし、[搭乗タイプ]({{<ref "civ4unitinfos">}}#special)単位で1つしか指定できません。

とくにユニットを解禁しないプロジェクトの場合、NONEを指定します。
BtSでは、この属性を持つプロジェクトはありません。

値：[搭乗タイプキー]({{<ref "keyichiran">}}#搭載分類)

例：
\<EveryoneSpecialUnit\>NONE\</EveryoneSpecialUnit\>

### \<EveryoneSpecialBuilding\>
このプロジェクトで解禁される建造物を指定します。
ただし、[特殊建造物グループ]({{<ref "civ4buildinginfos">}}#specialbuildingtype)単位で1つしか指定できません。

とくに建造物を解禁しないプロジェクトの場合、NONEを指定します。
BtSでは、この属性を持つプロジェクトはマンハッタン計画のみです。

値：[特殊建造物キー]({{<ref "keyichiran">}}#特殊建造物グループ)

例１：
\<EveryoneSpecialBuilding\>NONE\</EveryoneSpecialBuilding\>

例２：核シェルターを解禁
\<EveryoneSpecialBuilding\>SPECIALBUILDING\_BOMB\_SHELTER\</EveryoneSpecialBuilding\>

### \<bSpaceship\>
宇宙船のパーツとして指定します。
ここに1を指定した場合、このプロジェクトは宇宙船のパーツになります。
これにより、[建造物による宇宙船生産ボーナス]({{<ref "civ4buildinginfos">}}#ispaceproductionmodifier)を受けることができます。

とくに宇宙船のパーツとは関係ないプロジェクトの場合、0を指定します。

値：0か1

例：
\<bSpaceship\>0\</bSpaceship\>

### \<bAllowsNukes\>
ここに1を指定した場合、全世界で核兵器の生産を解禁します。

とくに核の解禁とは関係ないプロジェクトの場合、0を指定します。

値：0か1

例：
\<bAllowsNukes\>1\</bAllowsNukes\>

### \<Button\>
このプロジェクトを表すボタン画像のファイル名を指定します。
プロジェクトのアイコンとして使用されます。

値：\\Assets\\ からの相対ファイルパス

例：
\<Button\>,Art/Interface/Buttons/Buildings/ManhattanProject.dds,Art/Interface/Buttons/Buildings\_Atlas.dds,7,4\</Button\>

### \<PrereqProjects\>
前提となるプロジェクトを指定します。
チーム全体で見てここに指定されたプロジェクトがすべて必要数完成している文明でのみ、
このプロジェクトを生産することができます。

値：\<PrereqProject\>のリスト

{{% div class="subnote" %}}

\<PrereqProject\>は以下の2つのタグを含みます。

#### \<ProjectType\>
前提となるプロジェクトを指定します。
値：[プロジェクトキー]({{<ref "keyichiran">}}#プロジェクト)

#### \<iNeeded\>
そのプロジェクトの必要数を指定します。
値：整数
{{% /div %}}


例１：
\<PrereqProjects /\>

例２：アポロ計画が1つ必要
``` txt
<PrereqProjects>
    <PrereqProject>
        <ProjectType>PROJECT_APOLLO_PROGRAM</ProjectType>
        <iNeeded>1</iNeeded>
    </PrereqProject>
</PrereqProjects>
```

### \<VictoryThresholds\>
勝利のために十分な最大必要数を指定します。

例：あとで

### \<VictoryMinThresholds\>
勝利のために最低限必要な数を指定します。

[\<VictoryThresholds\>](#victorythresholds)を指定していて、勝利必要数に幅をもたせたくないときに限り、空タグで指定を省略できます。
その場合、[\<VictoryThresholds\>](#victorythresholds)と同じ内容を指定したとみなされます。

例：あとで

### \<iVictoryDelayPercent\>
追加で発生する勝利ターンへの待ち時間を指定します。
ここに正の整数nを指定した場合、このプロジェクトが最大必要数から1不足するごとに
`n / [最大必要数]`%だけ勝利ターンへの待ち時間が延長されます。

値：整数

例：あとで

### \<iSuccessRate\>
\<VictoryThresholds\>に1不足するごとに減少する勝利確率を指定します。

値：整数

---

例１：(勝利に関係しない)
``` txt
<VictoryThresholds>
<VictoryMinThresholds/>
<iVictoryDelayPercent>0</iVictoryDelayPercent>
<iSuccessRate>0</iSuccessRate>
```

---

例２：宇宙勝利のために1が必要
``` txt
<VictoryThresholds>
    <VictoryThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>1</iThreshold>
    </VictoryThreshold>
</VictoryThresholds>
<VictoryMinThresholds/>
<iVictoryDelayPercent>0</iVictoryDelayPercent>
<iSuccessRate>0</iSuccessRate>
```

---

例３：宇宙勝利のために1-2が必要
　　　2から1減るごとに勝利に必要な時間+25% (50/2=25)
``` txt
<VictoryThresholds>
    <VictoryThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>2</iThreshold>
    </VictoryThreshold>
</VictoryThresholds>
<VictoryMinThresholds>
    <VictoryMinThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>1</iThreshold>
    </VictoryMinThreshold>
</VictoryMinThresholds>
<iVictoryDelayPercent>50</iVictoryDelayPercent>
<iSuccessRate>0</iSuccessRate>
```

---

例４：宇宙勝利のために1-5が必要
　　　5から1減るごとに勝利確率-20%
``` txt
<VictoryThresholds>
    <VictoryThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>5</iThreshold>
    </VictoryThreshold>
</VictoryThresholds>
<VictoryMinThresholds>
    <VictoryMinThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>1</iThreshold>
    </VictoryMinThreshold>
</VictoryMinThresholds>
<iVictoryDelayPercent>0</iVictoryDelayPercent>
<iSuccessRate>20</iSuccessRate>
```

---

例５：宇宙勝利のために1-5が必要
　　　5から1減るごとに勝利に必要な時間+20% (100/5=20)
``` txt
<VictoryThresholds>
    <VictoryThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>5</iThreshold>
    </VictoryThreshold>
</VictoryThresholds>
<VictoryMinThresholds>
    <VictoryMinThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>1</iThreshold>
    </VictoryMinThreshold>
</VictoryMinThresholds>
<iVictoryDelayPercent>100</iVictoryDelayPercent>
<iSuccessRate>0</iSuccessRate>
```

### \<BonusProductionModifiers\>
このプロジェクトの生産を加速する資源を指定します。

値：\<BonusProductionModifier\>のリスト

{{% div class="subnote" %}}

\<BonusProductionModifier\>は以下の2つのタグを含みます。

#### \<BonusType\>
生産を加速する資源を指定します。
値：[資源キー]({{<ref "keyichiran">}}#資源)

#### \<iProductonModifier\>[^ton]
その資源に対して何%加速するか指定します。
ここに100を指定すると、その時に限りシヴィロペディアの表示が
「生産速度2倍」になります。
値：整数

[^ton]: iProduc**ton**Modifierです。誤字ではありません。

{{% /div %}}


例１：ウランがあれば生産速度2倍
``` txt
<BonusProductionModifiers>
    <BonusProductionModifier>
        <BonusType>BONUS_URANIUM</BonusType>
        <iProductonModifier>100</iProductonModifier>
    </BonusProductionModifier>
</BonusProductionModifiers>
```

### \<CreateSound\>
このプロジェクトが完成したときに流れる効果音を指定します。

値：2Dサウンドスクリプトキー

例：
\<CreateSound /\>

### \<MovieDefineTag\>
ムービーのグラフィックを指定します。キーの定義は
{{<inpath>}}\XML\Art\CIV4ArtDefines_Movie.xml{{</inpath>}}にあります。

ここにNONE以外のキーを指定する場合、プロジェクト完成時にそのキーの内容に従ってムービーが再生されます。

例：
\<MovieDefineTag\>ART\_DEF\_MOVIE\_MANHATTAN\_PROJECT\</MovieDefineTag\>

<div style="padding:5em"></div>

