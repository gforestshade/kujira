+++
date = "2018-03-04"
title = "CIV4UnitInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4UnitInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Units\CIV4UnitInfos.xml{{</path>}}

にあります。

## \<Civ4UnitInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4UnitSchema.xml"`を指定します。

## \<UnitInfo\>
このタグ1つが、ユニットの定義1つと対応しています。

以下\<UnitInfo\>の中身です。

<!--more-->

### \<Class\>
このユニットが属する親ユニットクラスを指定します。

値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

例：
\<Class\>UNITCLASS\_WARRIOR\</Class\>

### \<Type\>
このユニットのユニットキーを定義します。
他と被らなければなんでも構いませんが、UNIT\_英語名 にするのが無難です。

値：ユニットキー

例：
\<Type\>UNIT\_WARRIOR\</Type\>

### \<UniqueNames\>
ユニット一体一体にこの中からランダムで名前がつきます。BtSでは偉人で利用されています。
この機能を利用しないなら空タグにします。

値：テキストキーの配列

例：
``` plain
<UniqueNames>
    <UniqueName>TXT_KEY_UNITNAME_WARRIOR_1</UniqueName>
    <UniqueName>TXT_KEY_UNITNAME_WARRIOR_2</UniqueName>
    <UniqueName>TXT_KEY_UNITNAME_WARRIOR_3</UniqueName>
</UniqueNames>
```

### \<Special\>
このユニットの搭乗タイプを指定します。
船の方の[\<SpecialCargo\>](#specialcargo)で同じ値を設定すると、
その船に搭乗できるようになります。

値：[搭乗タイプキー]({{<ref "keyichiran">}}#搭載分類)

例１：
\<Special\>NONE\</Special\>

例２：
\<Special\>SPECIALUNIT\_PEOPLE\</Special\>
→ キャラベル船や攻撃型潜水艦の\<SpecialCargo\>にも同じ値が設定されているため、
キャラベル船や攻撃型潜水艦に搭乗可能になる(斥候・宣教師 など)

### \<Capture\>
このユニットが捕獲可能か、捕獲可能ならどのユニットとして捕獲されるかを指定します。
ここにキーを指定した場合、このユニットが何であるかには関係なく、
戦闘時必ず敗北し、指定したユニットとして敵側に加入します。(開拓者→労働者 など)
ユニットの種類が変わってほしくない場合は、[\<Class\>](#class)と同じ値を指定します。
このユニットが捕獲不能な普通のユニットならば、NONEを指定します。

値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

例１：
\<Capture\>NONE\</Capture\>

例２：
\<Capture\>UNITCLASS\_WORKER\</Capture\>

### \<Combat\>
このユニットがどの兵科であるか指定します。

値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

例：
\<Combat\>UNITCOMBAT\_MELEE\</Combat\>

### \<Domain\>
このユニットの行動領域を指定します。
海洋ユニット・陸上ユニット・航空ユニットの別がここで決まります。

値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

例：
\<Domain\>DOMAIN\_LAND\</Domain\>

### \<DefaultUnitAI\>
このユニットの既定の行動タイプを指定します。

値：[ユニットAIタイプキー]({{<ref "keyichiran">}}#ユニットai)

例：
\<DefaultUnitAI\>UNITAI\_ATTACK\</DefaultUnitAI\>

### \<Invisible\>
このユニットが他の文明からどのように不可視であるか指定します。
ここにキーを指定した場合、他の文明視点から見えなくなり攻撃も受けなくなりますが、
[\<SeeInvisible\>](#seeinvisible)に同じ値が指定されているユニットの視界に入ると発見され、
発見されている間は見えるようになり攻撃も受けるようになります。
(潜水艦→駆逐艦によって発見される など)
このユニットが普通に見えるユニットの場合、NONEを指定します。

値：[不可視タイプキー]({{<ref "keyichiran">}}#不可視グループ)

例１：
\<Invisible\>NONE\</Invisible>\

例２：潜水艦を発見するユニットが近くにいない限り不可視
\<Invisible\>INVISIBLE\_SUBMARINE\</Invisible\>

### \<SeeInvisible\>
このユニットがどの不可視属性を発見できるかを指定します。
このユニットが特に何も発見しない普通のユニットである場合、NONEを指定します。

値：[不可視タイプキー]({{<ref "keyichiran">}}#不可視グループ)

例：
\<SeeInvisible\>NONE\</SeeInvisible\>

例２：潜水艦を発見
\<SeeInvisible\>INVISIBLE\_SUBMARINE\</SeeInvisible\>


### \<Description\>
このユニットの名前を指定します。

値：テキストキー

例：
\<Description\>TXT\_KEY\_UNIT\_WARRIOR\</Description\>
→「戦士」

### \<Civilopedia\>
このユニットのシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_UNIT\_WARRIOR\_PEDIA\</Civilopedia\>

### \<Strategy\>
このユニットの短い説明文を指定します。
シドのヒントやシヴィロペディアに表示されます。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_UNIT\_WARRIOR\_STRATEGY\</Strategy\>

### \<Help\>
このユニットの追加の説明文を指定します。
XMLに指定した要素については、説明文はある程度自動生成されますが、
PythonやDLLにおいて直接拡張したときなどに利用します。

利用しない場合は、タグごと省略します。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_UNIT\_WARRIOR\_HELP\</Strategy\>

### \<Advisor\>
生産物を決めるポップアップにおいて、どの分類になるかを指定します。
推奨生産物に選ばれたときや、担当相の表示をオンにしているときなどに表示されます。

値：[アドバイザーキー]({{<ref "keyichiran">}}#担当相)

例：
\<Advisor\>ADVISOR\_MILITARY\</Advisor\>

### \<bAnimal\>
1を指定した場合、このユニットは動物です。

値：0か1

例：
\<bAnimal\>0\</bAnimal\>

### \<bFood\>
1を指定した場合、このユニットを生産する際、ハンマーに加えてパンを用いるようになります。
(労働者・開拓者 など)

値：0か1

例：
\<bFood\>0\</bFood\>

### \<bNoBadGoodies\>
1を指定した場合、このユニットは部族集落から敵対的な結果を引きません。

BtSでは、斥候と探検家がこの属性を持ちます。

値：0か1

例：
\<bNoBadGoodies\>0\</bNoBadGoodies\>

### \<bOnlyDefensive\>
1を指定した場合、このユニットは自分から攻撃を仕掛けることができません。

値：0か1

例：
\<bOnlyDefensive\>0\</bOnlyDefensive\>

### \<bNoCapture\>
1を指定した場合、このユニットは捕獲・占領ができません。
1が指定されたユニットは、[\<Capture\>](#capture)が指定されているユニットに
攻撃を仕掛けることはできますが、捕獲ユニットは入手できません。
また、都市上のユニットに攻撃を仕掛けることはできますが、
ユニットのいない敵対都市に侵入することはできず、占領できません。

BtSでは、この属性を持つのはガンシップです。

値：0か1

例：
\<bNoCapture\>0\</bNoCapture\>

### \<bQuickCombat\>
1を指定した場合、このユニットの戦闘アニメーションは強制的にスキップされます。

値：0か1

例：
\<bQuickCombat\>0\</bQuickCombat\>

### \<bRivalTerritory\>
1を指定した場合、このユニットは相互通商条約が無くてもライバル領土に侵入可能になります。

BtSでは、この属性を持つのはキャラベル船や大商人などです。

値：0か1

例：
\<bRivalTerritory\>0\</bRivalTerritory\>

### \<bMilitaryHappiness\>
1を指定した場合、このユニットは都市の治安に貢献します。
1が指定されたユニットが1体もいない都市からは、
「身の危険を感じる。軍の保護を求めたい！」の不満が発生します。
1が指定されたユニットは、「軍は本当に頼もしい」の満足(君主政治の効果)の対象としてカウントされます。

値：0か1

例：
\<bMilitaryHappiness\>1\</bMilitaryHappiness\>

### \<bMilitarySupport\>
1を指定した場合、このユニットは社会制度による追加の軍事ユニット維持費において(平和主義の効果)、
軍事ユニットとしてカウントされます。

値：0か1

例：
\<bMilitarySupport\>1\</bMilitarySupport\>

### \<bMilitaryProduction\>
1を指定した場合、このユニットを生産する際に「軍事ユニット生産+〇〇%」の効果
(英雄叙事詩・警察国家 など)を受けることができます。
0を指定した場合、たとえこのユニットが戦闘力をもっていたとしても、
このユニットは軍事ユニット生産ボーナスの対象になりません。

値：0か1

例：
\<bMilitaryProduction\>1\</bMilitaryProduction\>

### \<bPillage\>
1を指定した場合、このユニットはタイルを略奪できます。

値：0か1

例：
\<bPillage\>1\</bPillage\>

### \<bSpy\>
1を指定した場合、このユニットはライバル都市でスパイ活動ミッションを行うことができます。

値：0か1

例：
\<bSpy\>0\</bSpy\>

### \<bSabotage\>
WLのスパイシステム用です。BtSでは陳腐化しました。

値：0か1

例：
\<bSabotage\>0\</bSabotage\>

### \<bDestroy\>
WLのスパイシステム用です。BtSでは陳腐化しました。

値：0か1

例：
\<bDestroy\>0\</bDestroy\>

### \<bStealPlans\>
WLのスパイシステム用です。BtSでは陳腐化しました。

値：0か1

例：
\<bStealPlans\>0\</bStealPlans\>

### \<bInvestigate\>
WLのスパイシステム用です。BtSでは陳腐化しました。

値：0か1

例：
\<bInvestigate\>0\</bInvestigate\>

### \<bCounterSpy\>
1を指定した場合、このユニットは防諜能力を持ちます。
同じタイルにいる敵スパイのミッション成功率が下がり、捕獲確率が上がります。

値：0か1

例：
\<bCounterSpy\>0\</bCounterSpy\>

### \<bFound\>
1を指定した場合、このユニットは「都市の建設」コマンドを実行できます。
BtSでは、この属性を持つのは開拓者のみです。

値：0か1

例：
\<bFound\>0\</bFound\>

### \<bGoldenAge\>
1を指定した場合、このユニットは黄金期を発動できます。
BtSでは、この属性を持つのは大将軍以外の偉人ユニットです。

値：0か1

例：
\<bGoldenAge\>0\</bGoldenAge\>

### \<bInvisible\>
1を指定した場合、このユニットは他の文明から完全に不可視になります。
[\<Invisible\>](#invisible)とは異なり、決して発見されません。
BtSでは、この属性を持つのはスパイと大スパイです。

値：0か1

例：
\<bInvisible\>0\</bInvisible\>

### \<bFirstStrikeImmune\>
1を指定した場合、このユニットは相手の先制攻撃を無効化します。

値：0か1

例：
\<bFirstStrikeImmune\>0\</bFirstStrikeImmune\>

### \<bNoDefensiveBonus\>
1を指定した場合、このユニットは防御ボーナスを受けられません。

値：0か1

例：
\<bNoDefensiveBonus\>0\</bNoDefensiveBonus\>

### \<bIgnoreBuildingDefense\>
1を指定した場合、このユニットは攻撃時、建造物による都市防御ボーナスを無効化します。
BtSでは、火薬以降のユニットがこの属性を持ちます。

値：0か1

例：
\<bIgnoreBuildingDefense\>0\</bIgnoreBuildingDefense\>

### \<bCanMoveImpassable\>
1を指定した場合、このユニットは通行不能な地形を通過できます。
ここで対象となるのは山岳や氷河といった純粋に通行不能な地形であり、
陸上⇔海上を行き来できるのではないことに注意してください。
BtSでは、この属性を持つのは潜水艦系統のみです。

値：0か1

例：
\<bCanMoveImpassable\>0\</bCanMoveImpassable\>

### \<bCanMoveAllTerrain\>
1を指定した場合、このユニットは陸タイルと水タイルの両方に侵入可能になります。
BtSでは、この属性を持つユニットはありません。

値：0か1

例：
\<bCanMoveAllTerrain\>0\</bCanMoveAllTerrain\>

### \<bFlatMovementCost\>
1を指定した場合、このユニットはタイルによる移動コスト修正を増減共に無視します。
この属性を持つユニットは、1マス進むのに必要な移動力が1に固定されます。
たとえ丘陵や死の灰があっても、逆に道路や鉄道があっても、
1マス進むのに移動力1で固定になります。
BtSでは、この属性を持つユニットはありません。

値：0か1

例：
\<bFlatMovementCost\>0\</bFlatMovementCost\>

### \<bIgnoreTerrainCost\>
1を指定した場合、このユニットはタイルによる移動コスト増加修正を無視します。
この属性を持つユニットは、1マス進むのに必要な移動力が1を超えません。
たとえ丘陵や死の灰があっても、移動力1の消費で通過できます。
道路(コスト0.5)や鉄道(コスト0.1)があって消費移動力が1を下回る場合、
それをそのまま利用できます。
BtSでは、この属性を持つのは探検家・ケシク・ガンシップです。

値：0か1

例：
\<bIgnoreTerrainCost\>0\</bIgnoreTerrainCost\>


### \<bNukeImmune\>
1を指定した場合、このユニットは核攻撃からの被害を受けません。

値：0か1

例：
\<bNukeImmune\>0\</bNukeImmune\>

### \<bPrereqBonuses\>
このユニットが陸上ユニットなら、1を指定した場合、
同じ大陸に可視状態の資源(なんでもよい)が
1つ以上あるときにのみこのユニットを生産できます。

このユニットが海洋ユニットなら、1を指定した場合、
都市が面しているひとつながりの水タイル群(海や湖)の中に
可視状態の資源(なんでもよい)が
1つ以上あるときにのみこのユニットを生産できます。

BtSでは、この属性を持つのは作業船のみです。

値：0か1

例：
\<bPrereqBonuses\>0\</bPrereqBonuses\>

### \<bPrereqReligion\>
1を指定した場合、このユニットは何らかの宗教(なんでもよい)が
布教されている都市でのみ生産できます。
BtSでは、この属性を持つユニットはありません。

値：0か1

例：
\<bPrereqReligion\>0\</bPrereqReligion\>

### \<bMechanized\>
1を指定した場合、このユニットは無生物ユニットです。
BtSでは、兵器や乗り物に該当するユニットがこの属性を持ちますが、
それを利用した効果は実装されていません。

値：0か1

例：
\<bMechanized\>0\</bMechanized\>

### \<bRenderBelowWater\>
1を指定した場合、このユニットのグラフィックが
シヴィロペディアに表示される際水辺が背景に描写されます。
このタグをタグごと省略した場合、陸上の背景になります。

値：1か省略

例：
\<bRenderBelowWater\>1\</bRenderBelowWater\>

### \<bSuicide\>
1を指定した場合、このユニットは攻撃後に消滅します。
BtSでは、ミサイルに該当するユニットがこの属性を持ちます。

値：0か1

例：
\<bSuicide\>0\</bSuicide\>

### \<bLineOfSight\>
1を指定した場合、プレイヤーはこのユニットが得る視界に関して、
このユニットが向いている方向のみの視界を得ます。
このタグをタグごと省略した場合、通常通り全方向の視界を得ます。
BtSでは、この属性を持つユニットはありません。

値：1か省略

例：
\<bLineOfSight\>1\</bLineOfSight\>


### \<bHiddenNationality\>
1を指定した場合、このユニットは他の文明視点から国籍が蛮族であるかのように見えるようになります。
この属性単体では、国籍を秘匿する効果のみであり、
領土侵入能力や宣戦なし戦闘能力は得られないことに注意してください。
BtSでは、この属性を持つユニットは私掠船のみです。

値：0か1

例：
\<bHiddenNationality\>0\</bHiddenNationality\>

### \<bAlwaysHostile\>
1を指定した場合、このユニットは他文明と敵対扱いになり、戦闘や略奪を実行できます。
BtSでは、この属性を持つユニットは私掠船のみです。

値：0か1

例：
\<bAlwaysHostile\>0\</bAlwaysHostile\>

### \<UnitClassUpgrades\>
このユニットのアップグレード先を指定します。
ここにリストされているユニット種がすべて生産可能になると、
このユニットは陳腐化し、生産できなくなります。

アップグレード先を指定したくない場合、空タグにします。

値：\<UnitClassUpgrade\>のリスト

{{% div class="subnote" %}}

\<UnitClassUpgrade\>は以下の2つのタグを含みます。

#### \<UnitClassUpgradeType\>
アップグレード先のユニットクラスです。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<bUnitClassUpgrade\>
1を指定します。
値：1

{{% /div %}}

例：斧兵と槍兵にアップグレード可能
``` plain
<UnitClassUpgrades>
    <UnitClassUpgrade>
        <UnitClassUpgradeType>UNITCLASS_AXEMAN</UnitClassUpgradeType>
        <bUnitClassUpgrade>1</bUnitClassUpgrade>
    </UnitClassUpgrade>
    <UnitClassUpgrade>
        <UnitClassUpgradeType>UNITCLASS_SPEARMAN</UnitClassUpgradeType>
        <bUnitClassUpgrade>1</bUnitClassUpgrade>
    </UnitClassUpgrade>
</UnitClassUpgrades>
```

### \<UnitClassTargets\>
このユニットはこのリストにあるユニット種を優先して攻撃します。
この属性は都市上にないスタックへの攻撃において防御ユニットの選択ルールを変更し、
指定したユニット種クラスが優先して選ばれるようにします。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<UnitClassTarget\>のリスト

{{% div class="subnote" %}}

\<UnitClassTarget\>は以下の2つのタグを含みます。

#### \<UnitClassTargetType\>
優先攻撃対象のユニットクラスです。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<bUnitClassTarget\>
1を指定します。
値：1

{{% /div %}}

例：野戦でカノン砲と長距離砲を優先して攻撃する
``` plain
<UnitClassTargets>
    <UnitClassTarget>
        <UnitClassTargetType>UNITCLASS_CANNON</UnitClassTargetType>
        <bUnitClassTarget>1</bUnitClassTarget>
    </UnitClassTarget>
    <UnitClassTarget>
        <UnitClassTargetType>UNITCLASS_ARTILLERY</UnitClassTargetType>
        <bUnitClassTarget>1</bUnitClassTarget>
    </UnitClassTarget>
</UnitClassTargets>
```

### \<UnitCombatTargets\>
このユニットはこのリストにある兵科を持つユニットを優先して攻撃します。
この属性は都市上にないスタックへの攻撃において
防御ユニットの選択ルールを変更し、指定した兵科が優先して選ばれるようにします。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはクメール戦象のみです。

値：\<UnitCombatTarget\>のリスト

{{% div class="subnote" %}}

\<UnitCombatTarget\>は以下の2つのタグを含みます。

#### \<UnitCombatTargetType\>
優先攻撃対象のユニット戦闘タイプです。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<bUnitCombatTarget\>
1を指定します。
値：1

{{% /div %}}

例：野戦で騎乗ユニットを優先して攻撃する
``` plain
<UnitCombatTargets>
    <UnitCombatTarget>
        <UnitCombatTargetType>UNITCOMBAT_MOUNTED</UnitCombatTargetType>
        <bUnitCombatTarget>1</bUnitCombatTarget>
    </UnitCombatTarget>
</UnitCombatTargets>
```

### \<UnitClassDefenders\>
[\<UnitClassTargets\>](#unitclasstargets)の防御版です。
この属性は、このユニットを含むスタックが指定したユニット種から攻撃されたとき、
防御ユニットの選択ルールを変更し、このユニットが優先して選ばれるようにします。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<UnitClassDefender\>のリスト

{{% div class="subnote" %}}

\<UnitClassDefender\>は以下の2つのタグを含みます。

#### \<UnitClassDefenderType\>
優先防御対象のユニットクラスです。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<bUnitClassDefender\>
1を指定します。
値：1

{{% /div %}}

例：まずは胸甲騎兵と騎兵隊に対して防戦を展開する
``` plain
<UnitClassDefenders>
    <UnitClassDefender>
        <UnitClassDefenderType>UNIT_CUIRASSIER</UnitClassDefenderType>
        <bUnitClassDefender>1</bUnitClassDefender>
    </UnitClassDefender>
    <UnitClassDefender>
        <UnitClassDefenderType>UNITCLASS_CAVALRY</UnitClassDefenderType>
        <bUnitClassDefender>1</bUnitClassDefender>
    </UnitClassDefender>
</UnitClassDefenders>
```

### \<UnitCombatDefenders\>
[\<UnitCombatTargets\>](#unitcombattargets)の防御版です。
この属性は、このユニットを含むスタックが指定した兵科から攻撃されたとき、
防御ユニットの選択ルールを変更し、このユニットが優先して選ばれるようにします。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<UnitCombatDefender\>のリスト

{{% div class="subnote" %}}

\<UnitCombatDefender\>は以下の2つのタグを含みます。

#### \<UnitCombatDefenderType\>
優先防御対象のユニット戦闘タイプです。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<bUnitCombatDefender\>
1を指定します。
値：1

{{% /div %}}

例：まずは騎乗ユニットに対して防戦を展開する
``` plain
<UnitCombatDefenders>
    <UnitCombatDefender>
        <UnitCombatDefenderType>UNITCOMBAT_MOUNTED</UnitCombatDefenderType>
        <bUnitCombatDefender>1</bUnitCombatDefender>
    </UnitCombatDefender>
</UnitCombatDefenders>
```

### \<FlankingStrikes\>
このユニットの側面攻撃の対象となるユニット種のリストを指定します。
側面攻撃を行わない場合、空タグにします。

値：\<FlankingStrike\>のリスト

{{% div class="subnote" %}}

\<FlankingStrike\>は以下の2つのタグを含みます。

#### \<FlankingStrikeUnitClass\>
側面攻撃対象のユニットクラスです。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<iFlankingStrength\>
側面攻撃ダメージの修正値です。単位は%で、デフォルトは100です。
値：整数

{{% /div %}}

例：カタパルトとトレビュシェットへの側面攻撃
``` plain
<FlankingStrikes>
    <FlankingStrike>
        <FlankingStrikeUnitClass>UNITCLASS_CATAPULT</FlankingStrikeUnitClass>
        <iFlankingStrength>100</iFlankingStrength>
    </FlankingStrike>
    <FlankingStrike>
        <FlankingStrikeUnitClass>UNITCLASS_TREBUCHET</FlankingStrikeUnitClass>
        <iFlankingStrength>100</iFlankingStrength>
    </FlankingStrike>
</FlankingStrikes>
```

### \<UnitAIs\>
AI文明に対して、このユニットに指定したユニットAIを持たせることを強制的に許可します。
AI文明は、物理的に行動可能なユニットAIに
(例えば陸上ユニットには航空偵察は物理的にできないので排除します)、
[\<DefaultUnitAI\>](#defaultunitai)と[\<UnitAIs\>](#unitais)で指定されているものを加え、
その中から[\<NotUnitAIs\>](#notunitais)に指定されているものを外した中から、
最も評価値が高いものをユニットAIとして選びます。

値：\<UnitAI\>のリスト

{{% div class="subnote" %}}

\<UnitAI\>は以下の2つのタグを含みます。

#### \<UnitAIType\>
許可するユニットAIタイプを指定します。
値：[ユニットAIタイプキー]({{<ref "keyichiran">}}#ユニットAI)

#### \<bUnitAI\>
1を指定します。
値：1

{{% /div %}}

例：攻撃AIを許可する
``` plain
<UnitAIs>
    <UnitAI>
        <UnitAIType>UNITAI_ATTACK</UnitAIType>
        <bUnitAI>1</bUnitAI>
    </UnitAI>
</UnitAIs>
```

### \<NotUnitAIs\>
AI文明に対して、このユニットに指定したユニットAIを持たせることを禁止します。
リストの指定方法は[\<UnitAIs\>](#unitais)と同じです。

例：防御AIを禁止する
``` plains
<NotUnitAIs>
    <UnitAI>
        <UnitAIType>UNITAI_CITY_DEFENSE</UnitAIType>
        <bUnitAI>1</bUnitAI>
    </UnitAI>
</NotUnitAIs>
```


### \<Builds\>
このユニットは、ここに指定したタイル整備命令を実行できます。
タイル整備の速さについては、[\<iWorkRate\>](#iworkrate)も参照してください。

値：\<Build\>のリスト

{{% div class="subnote" %}}

\<Build\>は以下の2つのタグを含みます。

#### \<BuildType\>
許可する整備命令を指定します。
値：[整備タイプキー]({{<ref "keyichiran">}}#整備命令)

#### \<bBuild\>
1を指定します。
値：1

{{% /div %}}

例：「道路の施設」コマンドと「鉄道の施設」コマンドを使用可能にする
``` plains
<Builds>
    <Build>
        <BuildType>BUILD_ROAD</BuildType>
        <bBuild>1</bBuild>
    </Build>
    <Build>
        <BuildType>BUILD_RAILROAD</BuildType>
        <bBuild>1</bBuild>
    </Build>
</Builds>
```


### \<ReligionSpreads\>
このユニットが布教できる宗教を指定します。

布教力を指定した場合、
この値が自チームの都市への布教成功率の最低確率になります。

都市にすでに布教されている宗教の数が多いほど、
布教成功率が100%から最低確率まで下がります。
他チームの都市への布教では、最高確率は100%のままですが、最低確率が半減します。

BtSの宣教師の布教力は40です。

値：\<ReligionSpread\>のリスト

{{% div class="subnote" %}}

\<ReligionSpread\>は以下の2つのタグを含みます。

#### \<ReligionType\>
布教できる宗教を指定します。
値：[宗教キー]({{<ref "keyichiran">}}#宗教)

#### \<iReligionSpread\>
布教力を指定します。
値：整数

{{% /div %}}

例：ユダヤ教を布教可能にする
``` plain
<ReligionSpreads>
    <ReligionSpread>
        <ReligionType>RELIGION_JUDAISM</ReligionType>
        <iReligionSpread>40</iReligionSpread>
    </ReligionSpread>
</ReligionSpreads>
```

### \<CorporationSpreads\>
このユニットが出店できる企業を指定します。

出店力を指定した場合、
この値が自チームの都市への出店成功率の最低確率になります。

都市にすでに出店されている企業の数が多いほど、
出店成功率が100%から最低確率まで下がります。
(企業の場合、競合の関係で全種類が出店されることはないため、
最低確率まで下がることはありません)

他チームの都市への出店では、最高確率は100%のままですが、最低確率が半減します。

BtSの重役の出店力は40です。

値：\<CorporationSpread\>のリスト

{{% div class="subnote" %}}

\<CorporationSpread\>は以下の2つのタグを含みます。

#### \<CorporationType\>
出店できる企業を指定します。
値：[企業キー]({{<ref "keyichiran">}}#企業)

#### \<iCorporationSpread\>
出店力を指定します。
値：整数

{{% /div %}}

例：シリアル・ミルを出店可能にする
``` plain
<CorporationSpreads>
    <CorporationSpread>
        <CorporationType>CORPORATION_1</CorporationType>
        <iCorporationSpread>40</iCorporationSpread>
    </CorporationSpread>
</CorporationSpreads>
```

### \<GreatPeoples\>
このユニットはここに指定された専門家として定住できます。

特に定住できない普通のユニットの場合は空タグにします。
BtSでは偉人ユニットがこの属性を持ちます。

値：\<GreatPeople\>のリスト

{{% div class="subnote" %}}

\<GreatPeople\>は以下の2つのタグを含みます。

#### \<GreatPeopleType\>
どの専門家として定住を許可するか指定します。
値：[専門家キー]({{<ref "keyichiran">}}#専門家)

#### \<bGreatPeople\>
1を指定します。
値：1

{{% /div %}}

例：偉大な科学者として都市に定住できる
``` plain
<GreatPeoples>
    <GreatPeople>
        <GreatPeopleType>SPECIALIST_GREAT_SCIENTIST</GreatPeopleType>
        <bGreatPeople>1</bGreatPeople>
    </GreatPeople>
</GreatPeoples>
```

### \<Buildings\>
このユニットを消費して、ここに指定した建造物を建設できます。
建造コマンドを実行するには、建造物のほうに設定されている建造条件を
満たしていなければなりません。
(士官学校を建設するには軍事科学の技術が必要となる など)
建造コマンドを持たない普通のユニットの場合、空タグにします。

値：\<Building\>のリスト

{{% div class="subnote" %}}

\<Building\>は以下の2つのタグを含みます。

#### \<BuildingType\>
どの建造物を建設できるか指定します。
値：[建造物キー]({{<ref "keyichiran">}}#建造物)

#### \<bBuilding\>
1を指定します。
値：1

{{% /div %}}

例：このユニットを消費して、"スタンダード・エタノール本社"・アルミニウム本社・アカデミーを建設できる
(建造物ごとの前提条件を満たしていることが必要)
``` plain
<Buildings>
    <Building>
        <BuildingType>BUILDING_CORPORATION_3</BuildingType>
        <bBuilding>1</bBuilding>
    </Building>
    <Building>
        <BuildingType>BUILDING_CORPORATION_6</BuildingType>
        <bBuilding>1</bBuilding>
    </Building>
    <Building>
        <BuildingType>BUILDING_ACADEMY</BuildingType>
        <bBuilding>1</bBuilding>
    </Building>
</Buildings>
```

### \<ForceBuildings\>
このユニットを消費して、ここに指定した建造物を建設できます。
[\<Buildings\>](#buildings)とは異なり、建造物のほうに設定されている建造条件を無視します。

リストの記述方法は[\<Buildings\>](#buildings)と同じです。
建造コマンドを持たない普通のユニットの場合、空タグにします。

例：このユニットを消費して、総合組立工場を建設できる
(建造条件を無視し、必ず建設できる)
``` plain
<Buildings>
    <Building>
        <BuildingType>BUILDING_GERMAN_ASSEMBLY_PLANT</BuildingType>
        <bBuilding>1</bBuilding>
    </Building>
</Buildings>
```

### \<HolyCity\>
このユニットは指定した宗教の聖都でのみ生産できます。
そのような制限を設けない場合、NONEを指定します。
BtSでは、この属性を持つユニットはありません。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<HolyCity\>NONE\</HolyCity\>

例２：
\<HolyCity\>RELIGION_JUDAISM\</HolyCity\>


### \<ReligionType\>
このユニットは指定した宗教が布教されている都市を(どこかに)もつ文明でのみ生産できます。
......という触れ込みですが、BtSではこの制限は実装されていません。
ここに何かを指定してもしなくても、追加の制限はとくにかかりません。
BtSでは、この属性を持つユニットはありません。

値：[宗教キー？]({{<ref "keyichiran">}}#宗教)

例：
\<ReligionType\>NONE\</ReligionType\>

### \<StateReligion\>
このユニットは指定した宗教を国教に制定している文明の都市でのみ生産できます。
そのような制限を設けない場合、NONEを指定します。
BtSでは、この属性を持つユニットはありません。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<StateReligion\>NONE\</StateReligion\>

例２：
\<StateReligion\>RELIGION_JUDAISM\</StateReligion\>


### \<PrereqReligion\>
このユニットは指定した宗教が布教されている都市でのみ生産できます。
そのような制限を設けない場合、NONEを指定します。
BtSでは、各宣教師がこの属性を持ちます。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<PrereqReligion\>NONE\</PrereqReligion\>

例２：
\<PrereqReligion\>RELIGION_JUDAISM\</PrereqReligion\>

### \<PrereqCorporation\>
このユニットは指定した企業が出店されている都市でのみ生産できます。
そのような制限を設けない場合、NONEを指定します。
BtSでは、各重役がこの属性を持ちます。

値：[企業キー]({{<ref "keyichiran">}}#企業)

例１：
\<PrereqCorporation\>NONE\</PrereqCorporation\>

例２：
\<PrereqCorporation\>CORPORATION_1\</PrereqCorporation\>


### \<PrereqBuilding\>
このユニットは指定した建造物が建設されている都市でのみ生産できます。
そのような制限を設けない場合、NONEを指定します。
BtSでは、各宣教師がこの属性を持ちます。

値：[建造物キー]({{<ref "keyichiran">}}#建造物)

例１：
\<PrereqBuilding\>NONE\</PrereqBuilding\>

例２：図書館が建設されている都市でのみ生産できる
\<PrereqBuilding\>BUILDING_LIBRARY\</PrereqBuilding\>


### \<PrereqTech\>
このユニットは指定した技術を取得済みの文明でのみ生産できます。
前提技術を設定しない場合、NONEを指定します。
設定しない場合、他の前提条件が無ければ、いつでも生産可能になります。
(戦士など)

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：あとで

### \<TechTypes\>
2つ以上の前提技術を指定したい場合、
[\<PrereqTech\>](#prereqtech)に加えて、2つ目以降の追加の前提をここに記述します。
[\<PrereqTech\>](#prereqtech)も含め、すべての技術を取得済みのときのみ
このユニットを生産できます。

ここでは最大で3つまでの技術キーを指定することができます。
メインの[\<PrereqTech\>](#prereqtech)とあわせて
最大4つの前提技術を指定できます。
(この数は GlobalDefines.xml の NUM\_UNIT\_AND\_TECH\_PREREQS で変更できます)

追加の前提が必要ない場合は空タグにします。

値：[技術キー]({{<ref "keyichiran">}}#技術)のリスト

例１：メインの前提技術を青銅器にする
``` plain
<PrereqTech>TECH_BRONZE_WORKING</PrereqTech>
<TechTypes />
```

例２：メインの前提技術を職業軍人・追加の前提技術をライフリング・騎乗にする[^1]
``` plain
<PrereqTech>TECH_MILITARY_TRADITION</PrereqTech>
<TechTypes>
    <PrereqTech>TECH_RIFLING</PrereqTech>
    <PrereqTech>TECH_HORSEBACK_RIDING</PrereqTech>
    <PrereqTech>NONE</PrereqTech>
</TechTypes>
```

[^1]: BtSでは、このように3つすべてを埋めてありますが、必ずしも3つすべてを埋める必要はありません。

### \<BonusType\>
このユニットはここに指定した資源がある都市でのみ生産できます。

値：[資源キー]({{<ref "keyichiran">}}#資源)

例：あとで

### \<PrereqBonuses\>
2つ以上の前提資源を設定したい場合、ここに資源キーのリストを指定します。
\<BonusType\>の資源があって、\<PrereqBonuses\>のうちのいずれかの資源がある都市で、
このユニットは生産可能になります。
\<BonusType\>と\<PrereqBonuses\>の指定の仕方で資源の要求の仕方が変わってきます。

\<BonusType\>指定なし、\<PrereqBonuses\>指定なし の場合
:    このユニットは資源なしで生産できます。

\<BonusType\>指定あり、\<PrereqBonuses\>指定なし の場合
:    このユニットは\<BonusType\>の資源がある都市で生産できます。

\<BonusType\>指定なし、\<PrereqBonuses\>複数指定 の場合
:    このユニットは\<PrereqBonuses\>のうちの***いずれか***の資源がある都市で生産できます。

\<BonusType\>指定あり、\<PrereqBonuses\>1つ指定 の場合
:    このユニットは\<BonusType\>と\<PrereqBonuses\>に
指定された***両方***の資源がある都市で生産できます。

ここには最大で NUM\_UNIT\_PREREQ\_OR\_BONUSES 個の資源キーを指定できます。
BtSではこの変数の値は4です。
(この数は GlobalDefines.xml で変更できます)

値：[資源キー]({{<ref "keyichiran">}}#資源)のリスト

例１：資源の制限をつけない
``` plain
<BonusType>NONE</BonusType>
<PrereqBonuses />
```

例２：銅または鉄があれば生産可能
``` plain
<BonusType>NONE</BonusType>
<PrereqBonuses>
    <BonusType>BONUS_COPPER</BonusType>
    <BonusType>BONUS_IRON</BonusType>
    <BonusType>NONE</BonusType>
    <BonusType>NONE</BonusType>
</PrereqBonuses>
```

例３：石油とアルミニウムの両方があれば生産可能
``` plain
<BonusType>BONUS_OIL</BonusType>
<PrereqBonuses>
    <BonusType>BONUS_ALUMINUM</BonusType>
    <BonusType>NONE</BonusType>
    <BonusType>NONE</BonusType>
    <BonusType>NONE</BonusType>
</PrereqBonuses>
```

### \<ProductionTraits\>
このユニットの生産を加速する志向を指定します。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つのは開拓者と労働者です。

値：\<ProductionTrait\>のリスト

{{% div class="subnote" %}}

\<ProductionTrait\>は以下の2つのタグを含みます。

#### \<ProductionTraitType\>
志向を指定します。
値：[志向キー]({{<ref "keyichiran">}}#志向)

#### \<iProductionTrait\>
ハンマーへの修正値(単位：%)を指定します。
値：整数

{{% /div %}}

例１：
\<ProductionTraits /\>

例２：拡張志向によって生産+25%
``` plain
<ProductionTraits>
    <ProductionTrait>
        <ProductionTraitType>TRAIT_EXPANSIVE</ProductionTraitType>
        <iProductionTrait>25</iProductionTrait>
    </ProductionTrait>
</ProductionTraits>
```


### \<Flavors\>
[\<iBaseDiscover\>](#ibasediscover)や[\<iDiscoverMultiplier\>](#idiscovermultiplier)といっしょに指定することで、
このユニットは「テクノロジーを獲得」コマンド(電球消費)を実行することが可能になります。
ここでは、獲得/加速できる技術の種類をフレーバーで指定します。
現在研究可能な技術の中から、ここで指定したフレイバーを最も多く持つ技術が
電球の対象として選ばれます。[^2]

[^2]: 各フレーバーには重み値をつけることができ、重み値 * フレーバー値 の合計が最も高い技術が対象として選ばれます。

値：\<Flavor\>のリスト

{{% div class="subnote" %}}

\<Flavor\>は以下の2つのタグを含みます。

#### \<FlavorType\>
フレーバーを指定します。
値：[フレーバーキー]({{<ref "keyichiran">}}#フレーバー)

#### \<iFlavor\>
そのフレーバーの重み値を指定します。
値：整数

{{% /div %}}

例：電球コマンド発動時、科学フレーバーを多く持つ技術を選ぶようにする
``` plain
<Flavors>
    <Flavor>
        <FlavorType>FLAVOR_SCIENCE</FlavorType>
        <iFlavor>1</iFlavor>
    </Flavor>
</Flavors>
```

### \<iAIWeight\>
AIの生産物評価値に対して、このユニットの評価値に修正を与えます。
正負どちらの値も指定でき、このユニットに対する評価値が一律その分だけ加算されます。
BtSでは、この属性を持つユニットはありません。

値：整数

例：
\<iAIWeight\>0\</iAIWeight\>

### \<iCost\>
このユニットを生産するのに必要なハンマー数です。
-1を指定した場合、都市では生産できなくなります。

値：整数

例：
\<iCost\>15\</iCost\>

### \<iHurryCostModifier\>
このユニットの緊急生産を行う際、ここに指定した数(単位：%)だけコストの修正を受けます。
BtSでは、この属性を持つユニットはありません。

値：整数

例１：
\<iHurryCostModifier\>0\</iHurryCostModifier\>

例２：緊急生産コスト-50%
\<iHurryCostModifier\>-50\</iHurryCostModifier\>

### \<iAdvancedStartCost\>
先行スタートにおいて、このユニットは本来の購入コストから
ここに指定した割合(単位：%)を掛けた金額で購入できます。
-1を指定した場合、このユニットは先行スタートで購入できません。

値：整数

例１：
\<iAdvancedStartCost\>100\</iAdvancedStartCost\>

例２：先行スタート時、本来の60%の価格で購入可能
\<iAdvancedStartCost\>60\</iAdvancedStartCost\>

### \<iAdvancedStartCostIncrease\>
先行スタートにおいて、このユニットは購入するごとに
ここに指定した割合で(単位：%)購入コストが増加していきます。

値：整数

例１：
\<iAdvancedStartCostIncrease\>0\</iAdvancedStartCostIncrease\>

例２：先行スタート時、1体購入するごとに50%ずつ購入コスト増加
\<iAdvancedStartCostIncrease\>50\</iAdvancedStartCostIncrease\>

### \<iMinAreaSize\>
都市が面している[水域]({{<ref "glossary">}}#水域)の大きさがここで指定した数以上のときのみ、
このユニットを生産できます。
この機能を使わない場合、-1を指定します。

値：整数

例：
\<iMinAreaSize\>-1\</iMinAreaSize\>

### \<iMoves\>
このユニットの移動力です。

値：整数

例：
\<iMoves\>1\</iMoves\>

### \<bNoRevealMap\>
1を指定した場合、このユニットは未踏タイル[^unknown]を視界に入れるようには移動できません。
結果として、このユニットは未踏タイルを明らかにできません。
BtSでは、この属性を持つユニットはありません。

[^unknown]: 一度も視界に入れたことのない、マップ上で真っ黒に表示されるタイルのこと。

値：0か1

例：
\<bNoRevealMap\>0\</bNoRevealMap\>

### \<iAirRange\>
このユニットの航空射程(行動範囲)です。
この範囲内で、爆撃、偵察、迎撃などを行うことができます。

この属性は、間接攻撃範囲との兼用です。
このユニットが航空ユニットでなく、間接攻撃範囲と間接攻撃力の両方が正の値をとる場合、
このユニットはその範囲に間接攻撃が可能になります。
[\<iAirCombat\>](#iaircombat)と[\<iAirCombatLimit\>](#iaircombatlimit)も参照してください。

値：整数

例：
\<iAirRange\>0\</iAirRange\>

### \<iAirUnitCap\>
このユニットはここに指定した分だけ都市の配備枠を占有します。
例えば空港のない都市には配備枠が4あり、
占有値が1のユニットを4機配備できます。
このユニットが航空ユニットであるにもかかわらずこの値を0に設定する場合、
このユニットは枠を占有しません。
結果として、配備数に制限がなくなります。(ミサイルなど)

この属性は、都市や要塞の配備数にのみ影響します。
艦載数には影響しないことに注意してください。

都市の配備枠については、建造物の[\<iAirUnitCapacity\>]({{<ref "civ4buildinginfos">}}#iairunitcapacity)も参照してください。

値：整数

例：
\<iAirUnitCap\>0\</iAirUnitCap\>

### \<iDropRange\>
このユニットの空挺降下可能範囲です。
ここに正の値を指定する場合、このユニットは空挺降下コマンドが実行可能になります。

値：整数

\<iDropRange\>0\</iDropRange\>

### \<iNukeRange\>
このユニットが起こす核爆発の半径を指定します。
0以上の値nを指定した場合、このユニットは核攻撃コマンドを使用できるようになり、
着弾地点の周囲nマスに核爆発を起こします。
n=0のとき、着弾地点だけに被害を及ぼします。

-1を指定した場合、このユニットは核攻撃コマンドを使用できません。

値：整数

例：
\<iNukeRange\>-1\</iNukeRange\>

### \<iWorkRate\>
このユニットの労働効率を指定します。
この値(単位：%)が高いほどタイル整備コマンドが早く終了します。
BtSの労働者は100%です。
タイル整備の種類については、[\<Builds\>](#builds)も参照してください。

値：整数

例：
\<iWorkRate\>100\</iWorkRate\>

### \<iBaseDiscover\>
このユニットが「テクノロジーを獲得」コマンド(電球消費)を実行する際、
得られるビーカーの基本値を指定します。

値：整数

例：あとで

### \<iDiscoverMultiplier\>
このユニットが「テクノロジーを獲得」コマンド(電球消費)を実行する際、
得られるビーカーの人口に対する係数を指定します。

電球による獲得研究力は以下の式によります。
獲得研究力 = \<iBaseDiscover\> + \[文明の総人口\] * \<iDiscoverMultiplier\>
これにゲーム速度・既知率ボーナスなどの影響を加味したものが、
最終的に得られるビーカーになります。

[\<Flavors\>](#flavors)で種類が指定されていて、獲得研究力が正の値になる場合、
このユニットは「テクノロジーを獲得」コマンドを実行できます。
片方だけでは実行できないことに注意してください。

例１：
\<iBaseDiscover\>0\</iBaseDiscover\>
\<iDiscoverMultiplier\>0\</iDiscoverMultiplier\>

例２：偉大な科学者の場合
\<iBaseDiscover\>1500\</iBaseDiscover\>
\<iDiscoverMultiplier\>3\</iDiscoverMultiplier\>

例３：科学者以外の偉人の場合
\<iBaseDiscover\>1000\</iBaseDiscover\>
\<iDiscoverMultiplier\>2\</iDiscoverMultiplier\>

### \<iBaseHurry\>
このユニットが「都市の生産を加速」コマンドを実行する際、
得られるハンマーの基本値を指定します。

値：整数

例：あとで

### \<iHurryMultiplier\>
このユニットが「都市の生産を加速」コマンドを実行する際、
得られるハンマーの、人口に対する係数を指定します。

獲得する生産力は次の式によります。
獲得生産力 = \<iBaseHurry\> + \[文明の総人口\] * \<iHurryMultiplier\>
これにゲーム速度の影響を加味したものが、
最終的に得られるハンマーになります。

獲得生産力が正の値になる場合、
このユニットは生産加速コマンドを実行可能できます。

例１：
\<iBaseHurry\>0\</iBaseHurry\>
\<iHurryMultiplier\>0\</iHurryMultiplier\>

例２：偉大な技術者の場合
\<iBaseHurry\>500\</iBaseHurry\>
\<iHurryMultiplier\>20\</iHurryMultiplier\>

### \<iBaseTrade\>
このユニットが通商任務コマンドを実行する際、
得られるゴールドの基本値を指定します。

値：整数

例：あとで

### \<iTradeMultiplier\>
このユニットが通商任務コマンドを実行する際、
得られるゴールドの交易路に対する係数を指定します。

仮想交易路収益 = \[このユニットの足元にある都市が、自文明の首都との間にもし交易路が開設されたとしたときの、***相手側都市の***交易路収益\]
獲得ゴールド = \<iBaseTrade\> + 仮想交易路収益 * \<iTradeMultiplier\>

獲得ゴールドが正の値になる場合、
このユニットは通商任務コマンドを実行できます。

値：整数

例１：
\<iBaseTrade\>0\</iBaseTrade\>
\<iTradeMultiplier\>0\</iTradeMultiplier\>

例２：偉大な商人の場合
\<iBaseTrade\>500\</iBaseTrade\>
\<iTradeMultiplier\>200\</iTradeMultiplier\>


### \<iGreatWorkCulture\>
このユニットが「大作を制作」コマンドを使用した際、
獲得する文化力を指定します。

この値が正の場合、このユニットは「大作を制作」コマンドを実行できます。
BtSでは、この属性を持つユニットは大芸術家です。

値：整数

例：
\<iGreatWorkCulture\>0\</iGreatWorkCulture\>

### \<iEspionagePoints\>
このユニットが都市潜入コマンドを使用した際、
獲得するスパイポイントを指定します。

この値が正の場合、このユニットは都市潜入コマンドを実行できます。
BtSでは、この属性を持つユニットは大スパイです。

値：整数

例：
\<iEspionagePoints\>0\</iEspionagePoints\>


### \<TerrainImpassables\>
このユニットは、ここに指定された[基本地形]({{<ref "keyichiran">}}#基本地形)に侵入することができません。
この禁止指定は、技術取得により解禁できます。[\<TerrainPassableTechs\>](#terrainpassabletechs)を参照してください。

値：\<TerrainImpassable\>のリスト

{{% div class="subnote" %}}

\<TerrainImpassable\>は以下の2つのタグを含みます。

#### \<TerrainType\>
侵入を禁止する基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bTerrainImpassable\>
1を指定します。
値：1

{{% /div %}}

例１：
\<TerrainImpassables /\>

例２：外洋への進入禁止
``` plain
<TerrainImpassables>
    <TerrainImpassable>
        <TerrainType>TERRAIN_OCEAN</TerrainType>
        <bTerrainImpassable>1</bTerrainImpassable>
    </TerrainImpassable>
</TerrainImpassables>
```

### \<FeatureImpassables\>
このユニットは、ここに指定された[追加地形]({{<ref "keyichiran">}}#追加地形)に侵入することができません。[^3]
この禁止指定は、技術取得により解禁できます。[\<FeaturePassableTechs\>](#featurepassabletechs)を参照してください。
BtSでは、この属性を持つユニットはありません。

[^3]: 地物・地形上の地物とも。森林・ジャングル・氾濫原などを指します。

値：\<FeatureImpassable\>のリスト

{{% div class="subnote" %}}

\<FeatureImpassable\>は以下の2つのタグを含みます。

#### \<FeatureType\>
侵入を禁止する追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<bFeatureImpassable\>
1を指定します。
値：1

{{% /div %}}

例１：
\<FeatureImpassables /\>

例２：ジャングルへの侵入を禁止
``` plain
<FeatureImpassables>
    <FeatureImpassable>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <bFeatureImpassable>1</bFeatureImpassable>
    </FeatureImpassable>
</FeatureImpassables>
```


### \<TerrainPassableTechs\>
[\<TerrainImpassables\>](#terrainimpassables)の禁止指定を無効化して、通行できるように解禁する技術を指定します。

値：\<TerrainPassableTech\>のリスト

{{% div class="subnote" %}}

\<TerrainPassableTech\>は以下の2つのタグを含みます。

#### \<TerrainType\>
侵入を解禁する基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<PassableTech\>
その基本地形の侵入を解禁する技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

{{% /div %}}

例１：
\<TerrainPassableTechs /\>

例２：外洋への進入禁止を天文学取得で無効化する
``` plain
<TerrainPassableTechs>
    <TerrainPassableTech>
        <TerrainType>TERRAIN_OCEAN</TerrainType>
        <PassableTech>TECH_ASTRONOMY</PassableTech>
    </TerrainPassableTech>
</TerrainPassableTechs>
```


### \<FeaturePassableTechs\>
[\<FeatureImpassables\>](#featureimpassables)の禁止指定を無効化して、通行できるように解禁する技術を指定します。

値：\<FeaturePassableTech\>のリスト

{{% div class="subnote" %}}

\<FeaturePassableTech\>は以下の2つのタグを含みます。

#### \<FeatureType\>
侵入を解禁する追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<PassableTech\>
その追加地形の侵入を解禁する技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

{{% /div %}}

例１：
\<FeaturePassableTechs /\>

例２：ジャングルへの進入禁止を鉄器取得で無効化する
``` plain
<FeaturePassableTechs>
    <FeaturePassableTech>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <PassableTech>TECH_IRON_WORKING</PassableTech>
    </FeaturePassableTech>
</FeaturePassableTechs>
```


### \<iCombat\>
このユニットの戦闘力を指定します。

値：整数

例：
\<iCombat\>2\</iCombat\>


### \<iCombatLimit\>
このユニットが戦闘で与えることができるダメージ値の上限を指定します。
この値が100未満の場合、このユニットはその分だけダメージを与えると撤退します。
その場合敵ユニットを撃破することはできません。

値：整数

\<iCombatLimit\>100\</iCombatLimit\>

### \<iAirCombat\>
このユニットの航空戦闘力を指定します。

この属性は、間接攻撃力との兼用です。
このユニットが航空ユニットでなく、間接攻撃範囲と間接攻撃力の両方が正の値をとる場合、
このユニットはその範囲に間接攻撃が可能になります。
[\<iAirRange\>](#iairrange)と[\<iAirCombatLimit\>](#iaircombatlimit)も参照してください。

値：整数

例：
\<iAirCombat\>10\</iAirCombat\>

### \<iAirCombatLimit\>
このユニットが空爆で敵ユニットに与えることができるダメージ値の上限を指定します。

この属性は、間接攻撃ダメージ上限との兼用です。
この値が0のままだと、間接攻撃はダメージを与えられないことに注意してください。

値：整数

例：
\<iAirCombatLimit\>50\</iAirCombatLimit\>

### \<iXPValueAttack\>
敵ユニットが攻撃してこのユニットを撃破したとき、
勝利した敵ユニットが得る経験値の基礎値を指定します。

実際に勝者が得る経験値は、下の式によります。
経験値 = \[敗者の基礎経験値\] * \[勝者の戦闘力\] / \[敗者の戦闘力\]

値：整数

例：
\<iXPValueAttack\>4\</iXPValueAttack\>

### \<iXPValueDefense\>
敵ユニットが防衛時、攻撃してきたこのユニットを撃破したとき、
勝利した敵ユニットが得る経験値の基礎値を指定します。

実際に勝者が得る経験値は、下の式によります。
経験値 = \[敗者の基礎経験値\] * \[勝者の戦闘力\] / \[敗者の戦闘力\]

値：整数

例：
\<iXPValueDefense\>2\</iXPValueDefense\>

### \<iFirstStrikes\>
このユニットが先制攻撃する回数を指定します。

値：整数

例：
\<iFirstStrikes\>0\</iFirstStrikes\>

### \<iChanceFirstStrikes\>
このユニットが持つ先制攻撃の機会の回数を指定します。
ここに正の値nを指定する場合、このユニットは各戦闘で
0-nの範囲でランダムに追加の先制攻撃回数を得ます。

値：整数

\<iChanceFirstStrikes\>0\</iChanceFirstStrikes\>

### \<iInterceptionProbability\>
このユニットの迎撃成功率を指定します。(単位：%)

このユニットが航空ユニットで、ここに正の値を指定する場合、
このユニットは迎撃任務を実行可能になります。

この属性は空戦のダメージ係数兼用です。
この値が高いほど、空戦が発生したとき敵に与えるダメージが増えます。

総合的に、この値が高いほど戦闘機としての性能が高くなります。

値：整数

例：
\<iInterceptionProbability\>0\</iInterceptionProbability\>

### \<iEvasionProbability\>
このユニットの迎撃回避率を設定します。(単位：%)

値：整数

例：
\<iEvasionProbability\>0\</iEvasionProbability\>

### \<iWithdrawalProb\>
このユニットの退却成功率を指定します。

値：整数

例：
\<iWithdrawalProb\>0\</iWithdrawalProb\>

### \<iCollateralDamage\>
このユニットが与える副次的損害の威力係数を指定します。
この値が高いほど、一度の副次的損害で与えるダメージが増えます。

値：整数

例：
\<iCollateralDamage\>0\</iCollateralDamage\>

### \<iCollateralDamageLimit\>
このユニットが副次的損害によって与えるダメージ値の上限を指定します。

値：整数

例：
\<iCollateralDamageLimit\>0\</iCollateralDamageLimit\>

### \<iCollateralDamageMaxUnits\>
このユニットが一度の攻撃で副次的損害を与えられるユニット数を指定します。

[\<iCollateralDamage\>](#icollateraldamage)・[\<iCollateralDamageLimit\>](#icollateraldamagelimit)・[\<iCollateralDamageMaxUnits\>](#icollateraldamagemaxunits)
のすべてが正の値をとるとき、このユニットは副次的損害を与えることができます。

値：整数

例：
\<iCollateralDamageMaxUnits\>0\</iCollateralDamageMaxUnits\>

### \<iCityAttack\>
このユニットが都市を攻撃するとき、戦闘力に対してこの値だけ修正を受けます。(単位：%)

値：整数

例：
\<iCityAttack\>0\</iCityAttack\>

### \<iCityDefense\>
このユニットが都市を防衛するとき、戦闘力に対してこの値だけ修正を受けます。(単位：%)

値：整数

例：
\<iCityDefense\>25\</iCityDefense\>

### \<iAnimalCombat\>
このユニットが動物と戦闘するとき、戦闘力に対してこの値だけ修正を受けます。(単位：%)

値：整数

例：
\<iAnimalCombat\>0\</iAnimalCombat\>

### \<iHillsAttack\>
このユニットが丘陵にいるユニットを攻撃するとき、戦闘力に対してこの値だけ修正を受けます。(単位：%)

値：整数

例：
\<iHillsAttack\>0\</iHillsAttack\>

### \<iHillsDefense\>
このユニットが丘陵にいて攻撃を受けたとき、戦闘力に対してこの値だけ修正を受けます。(単位：%)

値：整数

例：
\<iHillsDefense\>0\</iHillsDefense\>

### \<TerrainNatives\>
動物として自然沸きできる[基本地形]({{<ref "keyichiran">}}#基本地形)を指定します。

このユニットが[動物](#banimal)であって、星としての動物発生条件を満たしているなら、[^4]
ここに指定した基本地形であって、追加地形のない、
どのプレイヤーの視界にも入っていないタイルに、
このユニットは自然発生します。

このユニットが動物でない場合、この指定は意味を持ちません。

[^4]: 古典に入ると動物が自然発生できなくなるほか、ゲーム開始直後は自然発生できない、難易度で指定される最大数を超えて自然発生できないなど、星の状況によって自然発生できるかどうかがまず決まります。

値：\<TerrainNative\>のリスト

{{% div class="subnote" %}}

\<TerrainNative\>は次の2つのタグを含みます。

#### \<TerrainType\>
自然沸きできる基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bTerrainNative\>
1を指定します。
値：1

{{% /div %}}

例１：
\<TerrainNatives /\>

例２：(森林のない)ツンドラか雪原に沸くようにする
``` plains
<TerrainNatives>
    <TerrainNative>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <bTerrainNative>1</bTerrainNative>
    </TerrainNative>
    <TerrainNative>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <bTerrainNative>1</bTerrainNative>
    </TerrainNative>
</TerrainNatives>
```

### \<FeatureNatives\>
動物として自然沸きできる[追加地形]({{<ref "keyichiran">}}#追加地形)を指定します。

このユニットが[動物](#banimal)であって、星としての動物発生条件を満たしているなら、[^4]
ここに指定した追加地形があって、どのプレイヤーの視界にも入っていないタイルに、
このユニットは自然発生します。

このユニットが動物でない場合、この指定は意味を持ちません。

値：\<FeatureNative\>のリスト

{{% div class="subnote" %}}

\<FeatureNative\>は次の2つのタグを含みます。

#### \<FeatureType\>
自然沸きできる追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<bFeatureNative\>
1を指定します。
値：1

{{% /div %}}

例１：
\<FeatureNatives /\>

例２：森林のあるタイルに沸くようにする
``` plains
<FeatureNatives>
    <FeatureNative>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <bFeatureNative>1</bFeatureNative>
    </FeatureNative>
</FeatureNatives>
```

### \<TerrainAttacks\>
対[基本地形]({{<ref "keyichiran">}}#基本地形)攻撃の戦闘力修正を指定します。
このユニットがここに指定した基本地形にいる敵ユニットを攻撃するとき、
それぞれ指定してある戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<TerrainAttack\>のリスト

{{% div class="subnote" %}}

\<TerrainAttack\>は以下の2つのタグを含みます。

#### \<TerrainType\>
修正を与える基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<iTerrainAttack\>
その基本地形を攻撃するときの戦闘力修正値を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<TerrainAttacks /\>

例２：+100% 氷土攻撃
``` plain
<TerrainAttacks>
    <TerrainAttack>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <iTerrainAttack>100</iTerrainAttack>
    </TerrainAttack>
</TerrainAttacks>
```

### \<TerrainDefenses\>
[基本地形]({{<ref "keyichiran">}}#基本地形)防御の戦闘力修正を指定します。
このユニットがここに指定した基本地形にいる状態で敵ユニットから攻撃されるとき、
それぞれ指定してある戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<TerrainDefense\>のリスト

{{% div class="subnote" %}}

\<TerrainDefense\>は以下の2つのタグを含みます。

#### \<TerrainType\>
修正を与える基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<iTerrainDefense\>
その基本地形で防御するときの戦闘力修正値を指定します。(単位：%)
値：整数

{{% /div %}}


例１：
\<TerrainDefenses /\>

例２：ツンドラによる防御力+50%
```plain
<TerrainDefenses>
    <TerrainDefense>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <iTerrainDefense>50</iTerrainDefense>
    </TerrainDefense>
</TerrainDefenses>
```

### \<FeatureAttacks\>
対[追加地形]({{<ref "keyichiran">}}#追加地形)攻撃の戦闘力修正を指定します。
このユニットがここに指定した追加地形にいる敵ユニットを攻撃するとき、
それぞれ指定してある戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<FeatureAttack\>のリスト

{{% div class="subnote" %}}

\<FeatureAttack\>は以下の2つのタグを含みます。

#### \<FeatureType\>
修正を与える追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<iFeatureAttack\>
その追加地形を攻撃するときの戦闘力修正値を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<FeatureAttacks /\>

例２：+50% 森林攻撃
``` plain
<FeatureAttacks>
    <FeatureAttack>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <iFeatureAttack>50</iFeatureAttack>
    </FeatureAttack>
</FeatureAttacks>
```

### \<FeatureDefenses\>
[追加地形]({{<ref "keyichiran">}}#追加地形)防御の戦闘力修正を指定します。
このユニットがここに指定した追加地形にいる状態で
敵ユニットから攻撃されるとき、
それぞれ指定してある戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つユニットはありません。

値：\<FeatureDefense\>のリスト

{{% div class="subnote" %}}

\<FeatureDefense\>は以下の2つのタグを含みます。

#### \<FeatureType\>
修正を与える追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<iFeatureDefense\>
その追加地形で防御するときの戦闘力修正値を指定します。(単位：%)
値：整数

{{% /div %}}


例１：
\<FeatureDefenses /\>

例２：ジャングルによる防御力-50%
```plain
<FeatureDefenses>
    <FeatureDefense>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <iFeatureDefense>-50</iFeatureDefense>
    </FeatureDefense>
</FeatureDefenses>
```


### \<UnitClassAttackMods\>
特定のユニット種への攻撃修正を指定します。
このユニットは、指定されたユニットクラスを持つユニットに攻撃する際、
それぞれ指定されたぶんだけ戦闘力に修正を受けます。

[\<UnitClassDefenseMods\>](#unitclassdefensemods)と同じ値を指定すると、
    シヴィロペディアでの表示が「対XX+○○%」のようになります。
この属性を使用しない場合、空タグにします。

値：\<UnitClassAttackMod\>のリスト

{{% div class="subnote" %}}

\<UnitClassAttackMod\>は以下の2つのタグを含みます。

#### \<UnitClassType\>
攻撃時に修正を与えるユニットクラスを指定します。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<iUnitClassMod\>
そのユニットクラスに攻撃するときの戦闘力修正を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<UnitClassAttackMods /\>

例２：機関銃兵に対する攻撃+50%、長距離砲に対する攻撃+50%
``` plain
<UnitClassAttackMods>
    <UnitClassAttackMod>
        <UnitClassType>UNITCLASS_MACHINE_GUN</UnitClassType>
        <iUnitClassMod>50</iUnitClassMod>
    </UnitClassAttackMod>
    <UnitClassAttackMod>
        <UnitClassType>UNITCLASS_ARTILLERY</UnitClassType>
        <iUnitClassMod>50</iUnitClassMod>
    </UnitClassAttackMod>
</UnitClassAttackMods>
```


### \<UnitClassDefenseMods\>
特定のユニット種からの防御修正を指定します。
このユニットは、指定されたユニットクラスを持つユニットに攻撃する際、
それぞれ指定されたぶんだけ戦闘力に修正を受けます。

[\<UnitClassAttackMods\>](#unitclassattackmods)と同じ値を指定すると、
シヴィロペディアでの表示が「対XX+○○%」のようになります。
この属性を使用しない場合、空タグにします。

値：\<UnitClassDefenseMod\>のリスト

{{% div class="subnote" %}}

\<UnitClassDefenseMod\>は以下の2つのタグを含みます。

#### \<UnitClassType\>
防御時に修正を与えるユニットクラスを指定します。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<iUnitClassMod\>
そのユニットクラスに攻撃されたときの戦闘力修正を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<UnitClassDefenseMods /\>

例２：チャリオット兵に対する防御+100%
``` plain
<UnitClassDefenseMods>
    <UnitClassDefenseMod>
        <UnitClassType>UNITCLASS_CHARIOT</UnitClassType>
        <iUnitClassMod>100</iUnitClassMod>
    </UnitClassDefenseMod>
</UnitClassDefenseMods>
```

### \<UnitCombatMods\>
兵科ごとの戦闘力修正を指定します。
このユニットは、指定された特定の兵科と戦闘する際、
それぞれここに指定されたぶんだけ戦闘力修正を受けます。

値：\<UnitCombatMod\>のリスト

{{% div class="subnote" %}}

\<UnitCombatMod\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
修正を与える兵科を指定します。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<iUnitCombatMod\>
その兵科と戦闘するときの戦闘力修正を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<UnitCombatMods /\>

例２：対白兵+50%
``` plain
<UnitCombatMods>
    <UnitCombatMod>
        <UnitCombatType>UNITCOMBAT_MELEE</UnitCombatType>
        <iUnitCombatMod>50</iUnitCombatMod>
    </UnitCombatMod>
</UnitCombatMods>
```

### \<UnitCombatCollateralImmunes\>
このユニットは、指定された兵科から副次的損害を受けません。

値：\<UnitCombatCollateralImmune\>のリスト

{{% div class="subnote" %}}

\<UnitCombatCollateralImmune\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
この兵科からの副次的損害に耐性を得ます。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<iUnitCombatCollateralImmune\>
1を指定します。
値：1

{{% /div %}}

例１：
\<UnitCombatCollateralImmunes /\>

例２：攻城兵器からの副次的損害を受けない
``` plain
<UnitCombatCollateralImmunes>
    <UnitCombatCollateralImmune>
        <UnitCombatType>UNITCOMBAT_SIEGE</UnitCombatType>
        <iUnitCombatCollateralImmune>1</iUnitCombatCollateralImmune>
    </UnitCombatCollateralImmune>
</UnitCombatCollateralImmunes>
```

### \<DomainMods\>
行動領域ごとの戦闘力修正を指定します。
このユニットが、指定された行動領域のユニットと戦闘する際、
それぞれ指定されたぶんだけ戦闘力に修正を得ます。

値：\<DomainMod\>のリスト

{{% div class="subnote" %}}

\<DomainMod\>は以下の2つのタグを含みます。

#### \<DomainType\>
修正を与える行動領域を指定します。
値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

#### \<iDomainMod\>
その行動領域を持つユニットに対しての戦闘力修正を指定します。(単位：%)
値：整数
{{% /div %}}


例１：
\<DomainMods /\>

例２：海洋ユニットに対して-50%
``` plain
<DomainMods>
    <DomainMod>
        <DomainType>DOMAIN_SEA</DomainType>
        <iDomainMod>-50</iDomainMod>
    </DomainMod>
</DomainMods>
```

### \<BonusProductionModifiers\>
このユニットの生産を加速する資源を指定します。

{{% div class="subnote" %}}

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

例１：
\<BonusProductionModifiers /\>

例２：銀があれば建設速度+50%
``` plain
<BonusProductionModifiers>
    <BonusProductionModifier>
        <BonusType>BONUS_SILVER</BonusType>
        <iProductonModifier>50</iProductonModifier>
    </BonusProductionModifier>
</BonusProductionModifiers>
```

### \<iBombRate\>
このユニットが(HPが減っていない状態で)戦略爆撃コマンドを実行する際、
都市の文化防御をここに指定した値だけ削ります。

このユニットが航空ユニットで、ここに正の値を指定する場合、
このユニットは戦略爆撃コマンドを実行できます。

実際に文化防御を削る値は、下の式によります。
文化防御ダメージ = \<iBombRate\> * \[現在HP\] / \[最大HP\]

例：
\<iBombRate\>0\</iBombRate\>

### \<iBombardRate\>
このユニットが「都市の砲撃」コマンドを実行する際、
都市の文化防御をここに指定した値だけ削ります。

ここに正の値を指定し、周囲1マスに都市が存在して、乗船中でない場合、
このユニットは「都市の砲撃」コマンドが実行できます。

例：
\<iBombardRate\>0\</iBombardRate\>

### \<SpecialCargo\>
このユニットが(輸送艦として)搭載できる搭乗タイプを指定します。
この属性は搭載できるユニットの種類についての制限です。
搭載数については[\<iCargo\>](#icargo)も参照してください。

ここでのNONEは制限なし、どのユニットでも搭載できることを表します。
ここにNONE以外の値を指定する場合、
このユニットはその搭乗タイプを持つユニットのみを搭載できます。
[\<DomainCargo\>](#domaincargo)と同時に指定される場合、
両方の条件を満たしているユニットのみを搭載できます。

値：[搭乗タイプキー]({{<ref "keyichiran">}}#搭載分類)

例１：
\<SpecialCargo\>NONE\</SpecialCargo\>

例２：斥候、探検家、宣教師、スパイ、偉人を搭載できる
\<Special\>SPECIALUNIT\_PEOPLE\</Special\>

### \<DomainCargo\>
このユニットが(輸送艦として)搭載できるユニットの行動領域を指定します。
この属性は搭載できるユニットの種類についての制限です。
搭載数については[\<iCargo\>](#icargo)も参照してください。

ここでのNONEは制限なし、どのユニットでも搭載できることを表します。
ここにNONE以外の値を指定する場合、
このユニットはその行動領域を持つユニットのみを搭載できます。
[\<SpecialCargo\>](#specialcargo)と同時に指定される場合、
両方の条件を満たしているユニットのみを搭載できます。

値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

例１：
\<DomainCargo\>NONE\</DomainCargo\>

例２：陸上ユニットのみを搭載できる
\<DomainCargo\>DOMAIN\_LAND\</DomainCargo\>

### \<iCargo\>
このユニットが(輸送艦として)搭載できるユニットの搭載数を指定します。

ここに正の値を指定する場合、このユニットは輸送艦としての性質を持ち、
乗船・下船などのコマンドを実行できます。[^7]

[^7]: その際、このユニットの行動圏は必ずしも海洋である必要はありません。陸海逆にして、船を運ぶトラックのようなユニットも設定できます。

例：
\<iCargo\>0\</iCargo\>

### \<iConscription\>
このユニットの徴兵優先度を指定します。

都市で生産できる全ユニットの中で、ここに指定した値が一番高いユニットが
徴兵対象として自動的に選択されます。

ユニット|優先度|ユニット|優先度
---|---|---|---
戦士|1      |鎚鉾兵|3
剣士|1      |長槍兵|3
擲弾兵|1    |マスケット兵|4
対戦車歩兵|1 |ライフル兵|5
移動式SAM|1 |SAM歩兵|5
海兵隊|1    |歩兵|6
空挺部隊|1  |機械化歩兵|7
斧兵|2||
槍兵|2||


例：
\<iConscription\>1\</iConscription\>

### \<iCultureGarrison\>
自文化が弱い都市で、このユニットが反乱を抑える能力を指定します。

反乱率は以下の式によります。

**文化侵略攻撃力基礎値** = \[該当都市が到達したことのある最大人口\] + \[都市の1マス圏内で文化侵略側が所有しているタイル数\] * \[時代値(時代が1つ進むごとに+1)\]

**文化修正率** = 2 - \[都市所有者側蓄積文化値\] / \[文化侵略側蓄積文化値\] [^8]

**国境修正** = (該当都市が文化侵略側の国教を持つなら2倍) * (該当都市が都市所有者側の国教を持つなら半分)

**文化侵略攻撃力** = \[文化侵略攻撃力基礎値\] * \[文化修正率\] * \[国境修正\]

**文化侵略防御力** = \[都市に駐留する\<iCultureGarrison\>の総和\] * \[戦時中修正(文化侵略側と戦争中なら2倍)\]

**反乱率** = 1 - \[文化侵略防御力\] / \[文化侵略攻撃力\]

自文明の文化蓄積値が最も多い場合や、
反乱率が0を下回る場合(文化侵略防御力 > 文化侵略攻撃力の場合)、
反乱は起きません。

[^8]: 文化戦争が生じている時点で \[都市所有者側蓄積文化値\] < \[文化侵略側蓄積文化値\] なので、この値は1倍～2倍の値をとります。

例：
\<iCultureGarrison\>3\</iCultureGarrison\>

### \<iExtraCost\>
追加のユニット維持費を指定します。
通常のユニット維持費や軍事ユニット維持費と異なり、
ここに指定した維持費はあらゆる無料枠の対象にならず、必ずかかります。

BtSでは、この属性を持つユニットはありません。

例：
\<iExtraCost\>0\</iExtraCost\>

### \<iAsset\>
このユニットは、ここに指定した値だけスコアを増やします。

値：整数

例：
\<iAsset\>1\</iAsset\>

### \<iPower\>
このユニットは、ここに指定した値だけ軍事力を増やします。

値：整数

例：
\<iPower\>2\</iPower\>

### \<UnitMeshGroups\>
このユニットの見た目を定義します。

例：
``` plain
<UnitMeshGroups>
    <iGroupSize>3</iGroupSize>
    <fMaxSpeed>1.75</fMaxSpeed>
    <fPadTime>1</fPadTime>
    <iMeleeWaveSize>3</iMeleeWaveSize>
    <iRangedWaveSize>0</iRangedWaveSize>
    <UnitMeshGroup>
        <iRequired>3</iRequired>
        <EarlyArtDefineTag>ART_DEF_UNIT_WARRIOR</EarlyArtDefineTag>
    </UnitMeshGroup>
</UnitMeshGroups>
```

### \<FormationType\>
画面上に表示される際の隊列を指定します。

値：隊形タイプキー

BtSではおおむねこのようになっています。

種類|隊列タイプキー
---|---
動物|FORMATION\_TYPE\_ANIMAL
大砲・戦車・艦船など無機物|FORMATION\_TYPE\_MACHINE
弓・銃など飛び道具を使うユニット|FORMATION\_TYPE\_RANGED
その他|FORMATION\_TYPE\_DEFAULT

例：
\<FormationType\>FORMATION\_TYPE\_DEFAULT\</FormationType\>

### \<bAltDown\>
1を指定した場合、このユニットにアップグレードするショートカットキーにAltキーを追加します。

値：0か1

例：あとで

### \<bShiftDown\>
1を指定した場合、このユニットにアップグレードするショートカットキーにShiftキーを追加します。

値：0か1

例：あとで

### \<bCtrlDown\>
1を指定した場合、このユニットにアップグレードするショートカットキーにCtrlキーを追加します。

値：0か1

例：あとで

### \<HotKey\>
このユニット***に***アップグレードするショートカットキーを定義します。

BtSでは、この属性を持つユニットはありません。

値：キーボードキー

例：ショートカットキーなし
\<HotKey /\>
\<bAltDown\>0\</bAltDown\>
\<bShiftDown\>0\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>

例：\<W\>
\<HotKey\>KB_W\<HotKey\>
\<bAltDown\>0\</bAltDown\>
\<bShiftDown\>0\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>

例：\<Shift+Alt+W\>
\<HotKey\>KB_W\<HotKey\>
\<bAltDown\>1\</bAltDown\>
\<bShiftDown\>1\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>


### \<iHotKeyPriority\>
ショートカットキーの優先度を指定します。
ショートカットキーが被ってしまったとき、
ここに指定した値が大きいほうが優先されます。

例：
\<iHotKeyPriority\>0\</iHotKeyPriority\>

### \<FreePromotions\>
このユニットが得る無償の昇進を指定します。

この機能を使わない場合、空タグにします。

値： \<FreePromotion\>のリスト

{{% div class="subnote" %}}

#### \<PromotionType\>
無償で得る昇進を指定します。
値：[昇進キー]({{<ref "keyichiran">}}#昇進)

#### \<bFreePromotion\>
1を指定します。
値：1

{{% /div %}}


例１：
\<FreePromotions /\>

例２：無償の教練Ⅰ・教練Ⅱ
``` plain
<FreePromotions>
    <FreePromotion>
        <PromotionType>PROMOTION_DRILL1</PromotionType>
        <bFreePromotion>1</bFreePromotion>
    </FreePromotion>
    <FreePromotion>
        <PromotionType>PROMOTION_DRILL2</PromotionType>
        <bFreePromotion>1</bFreePromotion>
    </FreePromotion>
</FreePromotions>
```

### \<LeaderPromotion\>
ウォーロードを示す昇進を指定します。

ここにNONE以外の値を指定する場合、指定した昇進が何であれ、
このユニットは大将軍としてユニットに合流するコマンドを実行できます。
ただし、合流能力を持つユニットはMOD内で1種しか存在できません。

この属性は、実際に合流したときにユニットに与える昇進と兼用です。

大将軍ではない普通のユニットの場合、NONEを指定します。

例１：
\<LeaderPromotion\>NONE\</LeaderPromotion\>

例２：このユニットを大将軍に設定し、合流時に与える昇進を「ウォーロードが指揮」にする
\<LeaderPromotion\>PROMOTION\_LEADER\</LeaderPromotion\>

### \<iLeaderExperience\>
ウォーロードとしてユニットに合流する際、ユニットに与える経験値を指定します。

合流時、同じタイルに複数のユニットがいる場合、この値が合計となるように
各ユニットに経験値が配分されます。

値：整数

例：
\<iLeaderExperience\>0\</iLeaderExperience\>

### \<iOrderPriority\>
このユニットへアップグレードするボタンの表示順を指定します。
まずこの値が小さいほうから大きいほうへと並び、
同じであればこのファイルの記述順に並びます。

この機能を使わない場合、タグごと省略します。
BtSでは、この属性を持つユニットはありません。

例：
\<iOrderPriority\>0\</iOrderPriority\>

<div style="padding:5em"></div>
