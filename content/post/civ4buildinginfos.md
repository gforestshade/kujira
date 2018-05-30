+++
date = "2018-03-07"
draft = false
title = "CIV4BuildingInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4BuildingInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Buildings\CIV4BuildingInfos.xml{{</path>}}

にあります。

## \<Civ4BuildingInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4BuildingSchema.xml"`を指定します。

## \<BuildingInfo\>
このタグ1つが、建造物の定義1つと対応しています。

以下\<BuildingInfo\>の中身です。

<!--more-->

### \<BuildingClass\>
この建造物が属する親の建造物クラスを指定します。

値：建造物クラスキー

例：
\<BuildingClass\>BUILDINGCLASS\_WALLS\</BuildingClass\>

### \<Type\>
この建造物の建造物キーを定義します。
他と被らなければなんでも構いませんが、BUILDING\_英語名 にするのが無難です。

値：建造物キー

例：
\<Type\>BUILDING\_CELTIC\_DUN\</Type\>

### \<SpecialBuildingType\>
特にグループを作って、そのグループごとに特殊な処理をしたい場合、
この建造物がどのグループの一員であるか指定します。

通常は、NONEを指定します。
BtSでは、核シェルター・寺院・大聖堂・僧院がグループを利用しています。

値：[特殊建造物キー]({{<ref "keyichiran">}}#特殊建造物グループ)

\<SpecialBuildingType\>NONE\</SpecialBuildingType\>

### \<Description\>
この建造物の名前を指定します。

値：テキストキー

例：「ダン」
\<Description\>TXT\_KEY\_BUILDING\_CELTIC\_DUN\</Description\>

### \<Civilopedia\>
この建造物のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_BUILDING\_CELTIC\_DUN\_PEDIA\</Civilopedia\>

### \<Strategy\>
この建造物の短い説明文を指定します。
シドのヒントやシヴィロペディアに表示されます。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_BUILDING\_CELTIC\_DUN\_STRATEGY\</Strategy\>

### \<Help\>
この建造物の追加の説明文を指定します。
XMLに指定した要素については、説明文はある程度自動生成されますが、
PythonやDLLにおいて直接拡張したときなどに利用します。

利用しない場合は、タグごと省略します。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_BUILDING\_CELTIC\_DUN\_HELP\</Strategy\>

### \<Advisor\>
生産物を決めるポップアップにおいて、どの分類になるかを指定します。
推奨生産物に選ばれたときや、担当相の表示をオンにしているときなどに表示されます。

値：[アドバイザーキー]({{<ref "keyichiran">}}#担当相)

例：
\<Advisor\>ADVISOR\_MILITARY\</Advisor\>

### \<ArtDefineTag\>
建造物のグラフィックを指定します。
キーの定義は \\XML\\Art\\CIV4ArtDefines_Building.xml にあります。

値：建造物アートキー

例：
\<ArtDefineTag\>ART\_DEF\_BUILDING\_CELTIC\_DUN\</ArtDefineTag\>

### \<MovieDefineTag\>
ムービーのグラフィックを指定します。キーの定義は
\\XML\\Art\\CIV4ArtDefines_Movie.xml にあります。

ここにNONE以外のキーを指定する場合、建造物完成時にそのキーの内容に従ってムービーが再生されます。[^movie]

[^movie]: この効果は、遺産に限定されません。

例：
\<MovieDefineTag\>NONE\</MovieDefineTag\>

### \<HolyCity\>
この建造物は、ここに指定した宗教の聖都でしか生産できません。
そのような制限を設けない場合、NONEを指定します。
BtSでは、各宗教の聖廟がこの属性を持ちます。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<HolyCity\>NONE\</HolyCity\>

例２：ユダヤ教の聖都でのみ生産可能
\<HolyCity\>RELIGION\_JUDAISM\</HolyCity\>

### \<ReligionType\>
この建造物がどの宗教に属しているか指定します。
この値がプレイヤーの採用する国教と一致している間、
この建造物は国教に関する建造物と判定され、
一部の遺産やクエストのカウント対象になります。

この建造物が宗教建造物ではない場合、NONEを指定します。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<ReligionType\>NONE\</ReligionType\>

例２：ユダヤ教の建造物にする
\<HolyCity\>RELIGION\_JUDAISM\</HolyCity\>

### \<StateReligion\>
この建造物は、ここに指定した宗教を国教に制定している場合のみ生産できます。
BtSでは、この属性を持つ建造物はありません。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<StateReligion\>NONE\</StateReligion\>

例２：ユダヤ教を国教にしている間だけ生産可能
\<StateReligion\>RELIGION_JUDAISM\</StateReligion\>

### \<bStateReligion\>
ここに1を指定する場合、この建造物は、国教(なんでもよい)を制定している場合のみ生産できます。
BtSでは、バチカン宮殿のみがこの属性を持ちます。

値：0か1

例：
\<bStateReligion\>0\</bStateReligion\>

### \<PrereqReligion\>
この建造物は、ここに指定した宗教が布教されている都市でのみ生産できます。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

例１：
\<PrereqReligion\>NONE\</PrereqReligion\>

例２：ユダヤ教が布教されている都市でのみ生産可能
\<PrereqReligion\>RELIGION_JUDAISM\</PrereqReligion\>

### \<PrereqCorporation\>
この建造物は、ここに指定した企業が出店している都市でのみ生産できます。
BtSでは、この属性を持つ建造物はありません。

値：[企業キー]({{<ref "keyichiran">}}#企業)

例：
\<PrereqCorporation\>NONE\</PrereqCorporation\>

### \<FoundsCorporation\>
この建造物が建設されたとき、ここに指定した企業が誕生します。
BtSでは、各企業の本社がこの属性を持ちます。

値：[企業キー]({{<ref "keyichiran">}}#企業)

例：
\<FoundsCorporation\>NONE\</FoundsCorporation\>

### \<GlobalReligionCommerce\>
この建造物は、ここに指定した宗教が布教されている全世界の都市数に応じて
その宗教が指定するなにかを産出します。
何が産出されるかは \\XML\\GameInfo\\CIV4ReligionInfo.xml の
\<GlobalReligionCommerces\> によって指定されますが、
BtSではどの宗教も1ゴールドです。
結果として、BtSでは、この建造物は指定された宗教の都市数の分だけ〈ゴールド〉を算出します。

この機能を使わない場合、NONEを指定します。

値：[宗教キー]({{<ref "keyichiran">}}#宗教)

\<GlobalReligionCommerce\>NONE\</GlobalReligionCommerce\>

### \<GlobalCorporationCommerce\>
この建造物は、ここに指定した企業が出店している全世界の都市数に応じて
その企業が指定するなにかを算出します。
何が産出されるかは \\XML\\GameInfo\\CIV4CorporationInfo.xml の
\<HeadquarterCommerces\> によって指定されますが、
BtSではどの企業も4ゴールドです。
結果として、BtSでは、この建造物は指定された宗教の都市数*4だけ〈ゴールド〉を算出します。

この機能を使わない場合、NONEを指定します。

値：[企業キー]({{<ref "keyichiran">}}#企業)

例：
\<GlobalCorporationCommerce\>NONE\</GlobalCorporationCommerce\>

### \<VictoryPrereq\>
この建造物は、ここに指定した勝利条件が有効になっているときのみ生産できます。

特に勝利条件による制限を設けない場合、NONEを指定します。
BtSでは、バチカン宮殿・国際連合・軌道エレベーターがこの属性を持ちます。

値：[勝利条件キー]({{<ref "keyichiran">}}#勝利条件)

例１：
\<VictoryPrereq\>NONE\</VictoryPrereq\>

例２：宇宙開発勝利が有効のときのみ建造可能
\<VictoryPrereq\>VICTORY\_SPACE\_RACE\</VictoryPrereq\>

### \<FreeStartEra\>
ここに指定した時代以降でゲームをスタートする場合、
都市建造時この建造物が無償で与えられます。

値：[時代キー]({{<ref "keyichiran">}}#時代)

例１：
\<FreeStartEra\>NONE\</FreeStartEra\>

例２：中世以降のスタートで無償提供
\<FreeStartEra\>ERA\_MEDIEVAL\</FreeStartEra\>

### \<MaxStartEra\>
ここに指定した時代以降でゲームをスタートする場合、
この建造物を建造することはできません。

BtSでは、多くの遺産がこの属性を持ちます。[^1]

[^1]: そうすることで、建造物リストが多くなりすぎないようにしていると思われます。

値：[時代キー]({{<ref "keyichiran">}}#時代)

例：
\<MaxStartEra\>NONE\</MaxStartEra\>

### \<ObsoleteTech\>
この建造物は、ここに指定した技術によって陳腐化します。

陳腐化させない場合、NONEを指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例１：
\<ObsoleteTech\>NONE\</ObsoleteTech\>

例２：ライフリングによって陳腐化
\<ObsoleteTech\>TECH\_RIFLING\</ObsoleteTech\>

### \<PrereqTech\>
この建造物は、ここに指定した技術を取得済みのときのみ生産できます。

技術による制限を設けない場合、NONEを指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：あとで

### \<TechTypes\>
2つ以上の前提技術を指定したい場合、
[\<PrereqTech\>](#prereqtech)に加えて、2つ目以降の追加の前提をここに記述します。
[\<PrereqTech\>](#prereqtech)も含め、すべての技術を取得済みのときのみ
この建造物を生産できます。

ここでは最大で3つまでの技術キーを指定することができます。
メインの[\<PrereqTech\>](#prereqtech)とあわせて
最大4つの前提技術を指定できます。
(この数は GlobalDefines.xml の NUM\_BUILDING\_AND\_TECH\_PREREQS で変更できます)

追加の前提が必要ない場合は空タグにします。

値：[技術キー]({{<ref "keyichiran">}}#技術)のリスト

例１：メインの前提技術を石工術にする
``` plain
<PrereqTech>TECH_MASONRY</PrereqTech>
<TechTypes />
```

例２：メインの前提技術をギルド・追加の前提技術を通貨にする[^technum]
``` plain
<PrereqTech>TECH_GUILDS</PrereqTech>
<TechTypes>
    <PrereqTech>TECH_CURRENCY</PrereqTech>
</TechTypes>
```

[^technum]: 実際のところ、BtSでは前提技術2つ(メインとサブ1つずつ)の建造物が最大です。

### \<Bonus\>
この建造物は、ここに指定した資源があるときのみ生産できます。
資源による制限を設けない場合、NONEを指定します。

BtSでは、前提資源を要求する建造物はありません。

値：[資源キー]({{<ref "keyichiran">}}#資源)

例：あとで

### \<PrereqBonuses\>
2つ以上の前提資源を設定したい場合、ここに資源キーのリストを指定します。
\<Bonus\>の資源があって、\<PrereqBonuses\>のうちのいずれかの資源がある都市で、
この建造物は生産可能になります。
\<Bonus\>と\<PrereqBonuses\>の指定の仕方で資源の要求の仕方が変わってきます。

\<Bonus\>指定なし、\<PrereqBonuses\>指定なし の場合
:    この建造物は資源なしで生産できます。

\<Bonus\>指定あり、\<PrereqBonuses\>指定なし の場合
:    この建造物は\<Bonus\>の資源がある都市で生産できます。

\<Bonus\>指定なし、\<PrereqBonuses\>複数指定 の場合
:    この建造物は\<PrereqBonuses\>のうちの***いずれか***の資源がある都市で生産できます。

\<Bonus\>指定あり、\<PrereqBonuses\>1つ指定 の場合
:    この建造物は\<Bonus\>と\<PrereqBonuses\>に
指定された***両方***の資源がある都市で生産できます。

ここには最大で NUM\_BUILDING\_PREREQ\_OR\_BONUSES 個の資源キーを指定できます。
BtSではこの変数の値は4です。
(この数は GlobalDefines.xml で変更できます)

値：[資源キー]({{<ref "keyichiran">}}#資源)のリスト

例１：資源の制限をつけない[^bonusnum]
``` plain
<Bonus>NONE</Bonus>
<PrereqBonuses />
```

例２：銅または鉄があれば生産可能
``` plain
<Bonus>NONE</Bonus>
<PrereqBonuses>
    <Bonus>BONUS_COPPER</Bonus>
    <Bonus>BONUS_IRON</Bonus>
</PrereqBonuses>
```

例３：石油とアルミニウムの両方があれば生産可能
``` plain
<Bonus>BONUS_OIL</Bonus>
<PrereqBonuses>
    <Bonus>BONUS_ALUMINUM</Bonus>
</PrereqBonuses>
```

[^bonusnum]: 実際のところ、BtSでは前提資源を要求する建造物はありません。


### \<ProductionTraits\>
この建造物の生産を加速する志向を指定します。

この機能を使わない場合、空タグにします。

値：\<ProductionTrait\>のリスト

{{% div class="subnote" %}}

\<ProductionTrait\>は以下の2つのタグを含みます。

#### \<ProductionTraitType\>
志向を指定します。
値：[志向キー]({{<ref "keyichiran">}}#志向)

#### \<iProductionTrait\>
〈ハンマー〉への修正率(単位：%)を指定します。
値：整数

{{% /div %}}

例１：
\<ProductionTraits /\>

例２：防衛志向によって生産速度2倍
``` plain
<ProductionTraits>
	<ProductionTrait>
		<ProductionTraitType>TRAIT_PROTECTIVE</ProductionTraitType>
		<iProductionTrait>100</iProductionTrait>
	</ProductionTrait>
</ProductionTraits>
```

### \<HappinessTraits\>
都市の所有者がここで指定した志向を持っている場合、
この建造物はそれぞれ指定されたぶんだけ追加の幸福または不満を産出します。

この機能を使わない場合、空タグにします。
BtSでこの属性を持つ建造物は、モニュメントと放送塔[^uu]です。

[^uu]: それらのUU群を含みます。

値：\<HappinessTrait\>のリスト

{{% div class="subnote" %}}

\<HappinessTrait\>は以下の2つのタグを含みます。

#### \<HappinessTraitType\>
志向を指定します。
値：[志向キー]({{<ref "keyichiran">}}#志向)

#### \<iHappinessTrait\>
その志向を持っているときに追加で算出する幸福の値を指定します。
正の数で幸福、負の数で不満になります。
値：整数

{{% /div %}}

例１：
\<HappinessTraits /\>

例２：カリスマ志向の指導者に+1〈幸福〉
``` plain
<HappinessTraits>
    <HappinessTrait>
        <HappinessTraitType>TRAIT_CHARISMATIC</HappinessTraitType>
        <iHappinessTrait>1</iHappinessTrait>
    </HappinessTrait>
</HappinessTraits>
```

### \<NoBonus\>
この建造物がある都市では、ここに指定した資源を利用できなくなります。

資源の無効化をしない通常の建造物の場合、NONEを指定します。
BtSでは、この属性を持つ建造物は国立公園のみです。

値：[資源キー]({{<ref "keyichiran">}}#資源)

例：
\<NoBonus\>NONE\</NoBonus\>

### \<PowerBonus\>
この建造物は、ここに指定した資源があるときこの都市に電力を供給します。

[\<bPower\>](#bpower)や[\<bDirtyPower\>](#bdirtypower)も参照してください。

この機能を使わない場合、NONEを指定します。

値：[資源キー]({{<ref "keyichiran">}}#資源)

例：
\<PowerBonus\>NONE\</PowerBonus\>

### \<FreeBonus\>
この建造物は、ここに指定した資源を産出します。

この属性は産出する資源の種類を指定します。
特に資源を産出しない普通の建造物の場合、NONEを指定します。

値：[資源キー]({{<ref "keyichiran">}}#資源)

例：あとで

### \<iNumFreeBonuses\>
この建造物が産出する資源の数を産出します。

[\<FreeBonus\>](#freebonus)にNONE以外の値を指定していて、ここに正の値を指定する場合、
この建造物は指定された資源を指定された数だけ産出します。

固定の数ではなく、マップサイズによる変動値を採用したい場合、-1を指定します。
その場合、\\XML\\GameInfo\\CIV4WorldInfo.xml の各マップサイズ定義から、
\<iNumFreeBuildingBonuses\> の値が使用されます。

この機能を使わない場合、0を指定します。

値：整数

例１：
\<FreeBonus\>NONE\</FreeBonus\>
\<iNumFreeBonuses\>0\</iNumFreeBonuses\>

例２：ヒットミュージカルをマップサイズ依存の数だけ産出する
\<FreeBonus\>BONUS_DRAMA\</FreeBonus\>
\<iNumFreeBonuses\>-1\</iNumFreeBonuses\>

例３：馬を1つ産出する
\<FreeBonus\>BONUS_HORSE\</FreeBonus\>
\<iNumFreeBonuses\>1\</iNumFreeBonuses\>


### \<FreeBuilding\>
この建造物を所有している間、同じ文明の全都市はここに指定した無償の建造物を得ます。[^freebuil]

この機能を使わない場合、NONEを指定します。
BtSでは、この属性を持つ建造物はストーンヘンジとエッフェル塔です。


[^freebuil]: この建造物を所有しなくなったり、陳腐化したりしたときは、即座に当該の無償建造物を失います。<br>指定は建造物クラスタイプです。実際には文明ごとに分岐した建造物タイプの建造物を得ます。

値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

例１：
\<FreeBuilding\>NONE\</FreeBuilding\>

例２：全都市に無償のモニュメント(またはそのUB)
\<FreeBuilding\>BUILDINGCLASS\_OBELISK\</FreeBuilding\>

### \<FreePromotion\>
この建造物がある都市で生産された新規ユニットは、ここに指定した無償の昇進を得ます。

この機能を使わない場合、NONEを指定します。

値：[昇進キー]({{<ref "keyichiran">}}#昇進)

例１：
\<FreePromotion\>NONE\</FreePromotion\>

例２：この都市で生産されるユニットに無償のゲリラⅠ
\<FreePromotion\>PROMOTION\_GUERILLA1\</FreePromotion\>

### \<CivicOption\>
この建造物を所有している間、所有者の文明はここに指定した体制に属する社会制度を
無条件に採用できるようになります。

特に体制を解禁しない普通の建造物の場合、NONEを指定します。
BtSでは、この属性を持つ建造物はピラミッドとシェダゴン・パヤです。

値：[体制キー]({{<ref "keyichiran">}}#社会制度)

例１：
\<CivicOption\>NONE\</CivicOption\>

例２：すべての政治体制を採用可能
\<CivicOption\>CIVICOPTION\_GOVERNMENT\</CivicOption\>

### \<GreatPeopleUnitClass\>
この建造物は、ここに指定したユニットに対する偉人ポイントを産出します。

この属性は産出する偉人ポイントの種類を指定します。
特に偉人ポイントを産出しない建造物の場合、NONEを指定します。

ここに指定するユニットクラスタイプは、任意のものを指定できます。
偉人ユニットのいずれかである必要はありませんし、
都市で普通に生産できるようなユニットであっても構いません。

値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

例：あとで

### \<iGreatPeopleRateChange\>
この建造物が産出する偉人ポイントの数を指定します。

[\<GreatPeopleUnitClass\>](#greatpeoppleunitclass)にNONE以外の値を指定していて、ここに正の値を指定する場合、
この建造物は指定された種類の偉人ポイントを指定されたぶんだけ産出します。

この機能を使わない場合、0を指定します。

値：整数

例１：
\<GreatPeopleUnitClass\>NONE\</GreatPeopleUnitClass\>
\<iGreatPeopleRateChange\>0\</iGreatPeopleRateChange\>

例２：大預言者ポイント+2
\<GreatPeopleUnitClass\>UNITCLASS\_PROPHET\</GreatPeopleUnitClass\>
\<iGreatPeopleRateChange\>2\</iGreatPeopleRateChange\>

例３：機械化歩兵ポイント+10
\<GreatPeopleUnitClass\>UNITCLASS\_MECHANIZED\_INFANTRY\</GreatPeopleUnitClass\>
\<iGreatPeopleRateChange\>10\</iGreatPeopleRateChange\>

### \<iHurryAngerModifier\>
奴隷不満のターンに対する修正率を指定します。
この建造物のある都市ではここに指定した割合だけ奴隷不満のターン数が増加します。(単位：%)

この機能を使わない場合、0を指定します。

例１：
\<iHurryAngerModifier\>0\</iHurryAngerModifier\>

例２：人口犠牲による不満の継続期間-50%
\<iHurryAngerModifier\>-50\</iHurryAngerModifier\>

### \<bBorderObstacle\>
ここに1を指定する場合、この建造物を所有している間、
その都市と同じ大陸にある文化圏に蛮族が侵入できなくなります。

値：0か1

例：
\<bBorderObstacle\>0\</bBorderObstacle\>

### \<bTeamShare\>
ここに1を指定する場合、以下のタグの効果範囲が
自文明だけでなく、同じチームの全員にまで広がります。

&nbsp;|&nbsp;
---|---
[\<FreeBuilding\>](#freebuilding)|[\<CivicOption\>](#civicoption)
[\<iGlobalGreatPeopleRateModifier\>](#iglobalgreatpeopleratemodifier)|[\<iGreatGeneralRateModifier\>](#igreatgeneralratemodifier)
[\<iDomesticGreatGeneralRateModifier\>](#idomesticgreatgeneralratemodifier)|[\<iAnarchyModifier\>](#ianarchymodifier)
[\<iGoldenAgeModifier\>](#igoldenagemodifier)|[\<iGlobalHurryModifier\>](#iglobalhurrymodifier)
[\<iGlobalExperience\>](#iglobalexperience)|[\<iGlobalWarWearinessModifier\>](#iglobalwarwearinessmodifier)
[\<iAreaFreeSpecialist\>](#iareafreespecialist)|[\<iGlobalFreeSpecialist\>](#iglobalfreespecialist)
[\<iCoastalTradeRoutes\>](#icoastaltraderoutes)|[\<iGlobalTradeRoutes\>](#iglobaltraderoutes)
[\<iAreaHealth\>](#iareahealth)|[\<iGlobalHealth\>](#iglobalhealth)
[\<iAreaHappiness\>](#iareahappiness)|[\<iGlobalHappiness\>](#iglobalhappiness)
[\<iWorkerSpeedModifier\>](#iworkerspeedmodifier)|[\<iGlobalSpaceProductionModifier\>](#iglobalspaceproductionmodifier)
[\<iAllCityDefense\>](#iallcitydefense)|[\<bAreaCleanPower\>](#bareacleanpower)
[\<bBorderObstacle\>](#bborderobstacle)|[\<GlobalSeaPlotYieldChanges\>](#globalseaplotyieldchanges)
[\<AreaYieldModifiers\>](#areayieldmodifiers)|[\<GlobalYieldModifiers\>](#globalyieldmodifiers)
[\<GlobalCommerceModifiers\>](#globalcommercemodifiers)|[\<SpecialistExtraCommerces\>](#specialistextracommerces)
[\<StateReligionCommerces\>](#statereligioncommerces)|[\<CommerceFlexibles\>](#commerceflexibles)
[\<BuildingHappinessChanges\>](#buildinghappinesschanges)|[\<SpecialistYieldChanges\>](#specialistyieldchanges)

BtSでは、ほとんどの世界遺産がこの属性を持ちます。[^teamww]

[^teamww]: アポロ神殿のような、このリストとは関係ないような遺産までもがこの属性を持ちます。もちろんそのような場合、特に意味はありません。なぜかアルテミス神殿だけはこの属性を持っていません。謎です。

値：0か1

例：
\<bTeamShare\>0\</bTeamShare\>

### \<bWater\>
ここに1を指定する場合、この建造物は水タイルに面した都市でのみ生産できます。

\<bWater\>と[\<bRiver\>](#briver)の両方を1にする場合、
この建造物は水タイルに面しているか、川沿いにある都市で生産できます。[^waterriver]

[^waterriver]: どちらかで構いません。

値：0か1

例：
\<bWater\>0\</bWater\>

### \<bRiver\>
ここに1を指定する場合、この建造物は川沿いの都市でのみ生産できます。

[\<bWater\>](#bwater)と\<bRiver\>の両方を1にする場合、
この建造物は水タイルに面しているか、川沿いにある都市で生産できます。[^waterriver]

値：0か1

例：
\<bRiver\>0\</bRiver\>

### \<bPower\>
ここに1を指定する場合、この建造物はこの都市に電力を供給します。

[\<PowerBonus\>](#powerbonus)と異なり、この属性は無条件で電力を供給します。
[\<PowerBonus\>](#powerbonus)と\<bPower\>の両方を指定した場合、
\<bPower\>が優先され、資源によらず常に電力を供給します。

BtSでは、この属性を持つ建造物はシェール油精製施設と水力発電所です。

値：0か1

例：
\<bPower\>0\</bPower\>

### \<bDirtyPower\>
ここに1を指定する場合、この建造物が供給する電力の種類がきたない電力になります。
ここに0を指定する場合、この建造物が供給する電力の種類が通常電力になります。

この建造物が電力を供給しない場合、この指定は無視されます。

参考：[通常電力ときたない電力]({{<ref "power">}})

値：0か1

例：
\<bDirtyPower\>0\</bDirtyPower\>

### \<bAreaCleanPower\>
ここに1を指定する場合、この建造物と同じ大陸にある都市は無償の通常電力を得ます。

値：0か1

例：
\<bAreaCleanPower\>0\</bAreaCleanPower\>

### \<DiploVoteType\>
この建造物は、ここに指定した国際機関を発足させます。

特に何も発足させない普通の建造物の場合、NONEを指定します。
BtSでは、この属性を持つ建造物はバチカン宮殿と国際連合です。

値：国際機関キー
　　`DIPLOVOTE_UN`: 国際連合
　　`DIPLOVOTE_POPE`: バチカン宮殿

例：
\<DiploVoteType\>NONE\</DiploVoteType\>

### \<bForceTeamVoteEligible\>
ここに1を指定する場合、この建造物が発足させた国際機関において、
この建造物の所有者が必ず議長国選挙に立候補します。
その場合、もう一方は所有者以外の文明で票数を最も多く持つ文明になります。

値：0か1

例：
\<bForceTeamVoteEligible\>0\</bForceTeamVoteEligible\>

### \<bCapital\>
ここに1を指定する場合、この建造物がある都市は、首都です。

値：0か1

例：
\<bCapital\>0\</bCapital\>

### \<bGovernmentCenter\>
ここに1を指定する場合、この建造物は距離維持費の起点になります。

BtSでは、この属性を持つ建造物は宮殿・紫禁城・ヴェルサイユ宮殿です。

値：0か1

例：
\<bGovernmentCenter\>0\</bGovernmentCenter\>

### \<bGoldenAge\>
ここに1を指定する場合、この建造物が完成したとき、黄金期を開始します。

値：0か1

例：
\<bGoldenAge\>0\</bGoldenAge\>

### \<bAllowsNukes\>
ここに1を指定する場合、この建造物が完成したとき、全文明に対して核攻撃を解禁します。

BtSでは、この属性を持つ建造物はありません。

値：0か1

例：
\<bAllowsNukes\>0\</bAllowsNukes\>

### \<bMapCentering\>
ここに1を指定する場合、この建造が完成したとき、世界地図を球体化します。

BtSでは、この属性を持つ建造物はストーンヘンジです。

値：0か1

例：
\<bMapCentering\>0\</bMapCentering\>

### \<bNoUnhappiness\>
ここに1を指定する場合、この建造物のある都市からは不満が発生しなくなります。

BtSでは、この属性を持つ建造物はグローブ座です。

値：0か1

例：
\<bNoUnhappiness\>0\</bNoUnhappiness\>

### \<bNoUnhealthyPopulation\>
ここに1を指定する場合、この建造物のある都市からは人口による不衛生が発生しなくなります。

BtSでは、この属性を持つ建造物は国立公園です。

値：0か1

例：
\<bNoUnhealthyPopulation\>0\</bNoUnhealthyPopulation\>

### \<bBuildingOnlyHealthy\>
ここに1を指定する場合、この建造物のある都市からは建造物による不衛生が発生しなくなります。

BtSでは、この属性を持つ建造物はリサイクル施設です。

値：0か1

例：
\<bBuildingOnlyHealthy\>0\</bBuildingOnlyHealthy\>

### \<bNeverCapture\>
ここに1を指定する場合、この建造物は戦争によって占領された際に必ず破壊されます。

BtSでは、文化値出力がある一般建造物がこの属性を持ちます。
これによって占領した直後の都市からは建造物による〈文化〉が出ないようになっています。[^capcul]

[^capcul]: 元の建造物には文化出力がなく、UUには文化出力があるような場合は指定されていません。<br>なので、棚畑やオデオンが破壊されず残ってしまう場合もあります。

値：0か1

例：
\<bNeverCapture\>0\</bNeverCapture\>

### \<bNukeImmune\>
ここに1を指定する場合、この建造物は核攻撃によって破壊されません。

値：0か1

例：
\<bNukeImmune\>0\</bNukeImmune\>

### \<bPrereqReligion\>
ここに1を指定する場合、この都市に布教されている宗教があるときのみこの建造物を生産できます。

BtSでは、この属性を持つ建造物はありません。

値：0か1

例：
\<bPrereqReligion\>0\</bPrereqReligion\>

### \<bCenterInCity\>
ここに1を指定する場合、建造物の3Dモデルがマップ上で都市の中心に表示されます。

BtSでは、この属性を持つ建造物はモニュメント・防壁・城(とそのUU群)です。

値：0か1

例：
\<bCenterInCity\>1\</bCenterInCity\>

### \<iAIWeight\>
AIの生産物評価値に対して、このユニットの評価値に修正を与えます。
正負どちらの値も指定でき、このユニットに対する評価値が一律その分だけ加算されます。
BtSでは、この属性を持つユニットはありません。

値：整数

例：
\<iAIWeight\>0\</iAIWeight\>

### \<iCost\>
この建造物の生産コストを指定します。(単位：〈ハンマー〉)

値：整数

例：
\<iCost\>50\</iCost\>

### \<iHurryCostModifier\>
この建造物を緊急生産するときのコスト修正率を指定します。(単位：%)

緊急生産コストを普通にする場合、0を指定します。
BtSでは、中世までの国家遺産が50、それ以降の国家遺産やすべての世界遺産は100の値を持ちます。[^wwcm]

[^wwcm]: ここに0を指定した遺産も当然MODでなら作ることができます。

値：整数

例１：
\<iHurryCostModifier\>0\</iHurryCostModifier\>

例２：緊急生産コスト+100%
\<iHurryCostModifier\>100\</iHurryCostModifier\>

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
都市に隣接する[水域]({{<ref "glossary">}}#水域)の大きさがここに指定した値以上のときのみ、
この建造物を生産できます。

そのような制限を設けない普通の建造物の場合、-1を指定します。

値：整数

例：
\<iMinAreaSize\>-1\</iMinAreaSize\>

### \<iConquestProb\>
この建造物のある都市が占領されたとき、ここに指定した確率で(単位：%)
この建造物は***残ることができます***。

[\<bNeverCapture\>](#bnevercapture)に1(必ず破壊)、\<iConquestProb\>に1以上の値を指定する(残る確率がある)場合、
\<bNeverCapture\>が優先され、占領時必ず破壊されます。

BtSでは、防壁や城など一部の建造物で、`bNeverCapture = 0`, `iConquestProb = 0`が指定されていて、
結局占領時に残らないようになっている建造物があります。

値：0(決して残らない)～100(必ず残る)までの整数

例：
\<iConquestProb\>0\</iConquestProb\>

### \<iCitiesPrereq\>
文明全体でここに指定した以上の数の都市を所有しているときのみ、
この建造物を生産できます。
都市数による制限を設けない場合、0を指定します。
BtSでは、宮殿(4)と紫禁城(8)がこの属性を持ちます。

値：整数

例：
\<iCitiesPrereq\>0\</iCitiesPrereq\>

### \<iTeamsPrereq\>
まだゲームに残っているチームの数がここに指定した数以上であるときのみ、
この建造物を生産できます。

残存チーム数による制限を設けない普通の建造物の場合、0を指定します。
BtSでは、国際連合(3)とバチカン宮殿(3)がこの属性を持ちます。

値：整数

例：
\<iTeamsPrereq\>0\</iTeamsPrereq\>

### \<iLevelPrereq\>
過去も含めてユニットレベルがここに指定した数に達したことのある文明でのみ、
この建造物を生産できます。

過去最大レベルによる制限をしない普通の建造物の場合、0を指定します。

値：整数

例：
\<iLevelPrereq\>0\</iLevelPrereq\>

### \<iMinLatitude\>
ここに指定した緯度より高い緯度に都市が建っている場合のみ、
この建造物を生産できます。

緯度は赤道の0が最小で、北極と南極の90が最高です。
\<iMinLatitude\>を0に指定すると、下限を指定しないかのようになります。

値：整数

例：あとで

### \<iMaxLatitude\>
ここに指定した緯度より低い緯度に都市が建っている場合のみ、
この建造物を生産できます。

緯度は赤道の0が最小で、北極と南極の90が最高です。
\<iMaxLatitude\>を90に指定すると、上限を指定しないかのようになります。

値：整数

例１：
\<iMinLatitude\>0\</iMinLatitude\>
\<iMaxLatitude\>90\</iMaxLatitude\>

例２：最高北(南)緯30度で作成可能
\<iMinLatitude\>0\</iMinLatitude\>
\<iMaxLatitude\>30\</iMaxLatitude\>


### \<iGreatPeopleRateModifier\>
都市の偉人ポイントへの修正率を指定します。
この建造物が建っている都市では偉人ポイントの産出が+n%されます。

特に偉人ポイントを割合で増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは民族叙事詩と公共広場です。

値：整数

例：
\<iGreatPeopleRateModifier\>0\</iGreatPeopleRateModifier\>

### \<iGreatGeneralRateModifier\>
大将軍ポイントへの修正率を指定します。
獲得する大将軍ポイントが(どこで戦闘したかを問わず)+n%されます。

特に大将軍ポイントを割合で増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はありません。

値：整数

例：
\<iGreatGeneralRateModifier\>0\</iGreatGeneralRateModifier\>

### \<iDomesticGreatGeneralRateModifier\>
国内大将軍ポイントへの修正率を指定します。
国内での戦闘により獲得する大将軍ポイントが+n%されます。

特に大将軍ポイントを割合で増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物は万里の長城のみです。

値：整数

例：
\<iDomesticGreatGeneralRateModifier\>0\</iDomesticGreatGeneralRateModifier\>

### \<iGlobalGreatPeopleRateModifier\>
全都市の偉人ポイントへの修正率を指定します。
この建造物を所有している文明は、全都市で偉人ポイントの産出が+n%されます。

特に偉人ポイントを割合で増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはパルテノン神殿です。

値：整数

例：
\<iGlobalGreatPeopleRateModifier\>0\</iGlobalGreatPeopleRateModifier\>

### \<iAnarchyModifier\>
無政府状態のターンに対する修正率を指定します。

詳しくは、[用語集]({{<ref "glossary">}}#無政府状態)も参照してください。

無政府状態のターン数にとくに影響を及ぼさない普通の建造物の場合、0を指定します。
ここに-100を指定したときのみ、シヴィロペディアの表示が「無政府状態なし」に変わります。
BtSでは、この属性を持つ建造物はコルコバードのキリスト像のみです。

値：整数

例１：
\<iAnarchyModifier\>0\</iAnarchyModifier\>

例２：社会制度または国境を変える際の待ち時間:-50%
\<iAnarchyModifier\>-50\</iAnarchyModifier\>

### \<iGoldenAgeModifier\>
黄金期の継続ターンに対する修正率を指定します。

黄金期の継続ターンにとくに影響を及ぼさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはマウソロス霊廟のみです。

値：整数

例１：
\<iGoldenAgeModifier\>0\</iGoldenAgeModifier\>

例２：黄金時代の期間+50%
\<iGoldenAgeModifier\>50\</iGoldenAgeModifier\>

### \<iGlobalHurryModifier\>
全都市の緊急生産コスト修正率を指定します。(単位：%)
この建造物を所持している間、文明の全都市で緊急生産[^hurrytype]コストに
ここに指定した分だけ修正を受けます。

緊急生産コストを修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はクレムリン宮殿のみです。

[^hurrytype]: 人口でも、富でも

値：整数

例１：
\<iGlobalHurryModifier\>0\</iGlobalHurryModifier\>

例２：緊急生産コスト-33%
\<iGlobalHurryModifier\>-33\</iGlobalHurryModifier\>

### \<iExperience\>
この都市で生産されるユニットは、ここに指定された分の経験値を追加で得ます。

この属性はこの都市で生産される全ユニットが対象になります。
経験値を付与する対象を(陸上・海洋・兵科などで)制限したい場合は使用できません。
[\<DomainFreeExperiences\>](#domainfreeexperiences)や[\<UnitCombatFreeExperiences\>](#unitcombatfreeexperiences)を参照してください。

とくに経験値を加算しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はウエストポイントのみです。

ここに負の値を指定することはできますが、
各要因からの無償の経験値の合計が負になった場合は0まで底上げされます。

値：整数

例１：
\<iExperience\>0\</iExperience\>

例２：新ユニットが経験値+4ポイントを取得
\<iExperience\>4\</iExperience\>


### \<iGlobalExperience\>
全都市で生産されるユニットに、ここに指定された分の経験値を追加で得させます。

とくに経験値を加算しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はペンタゴンのみです

ここに負の値を指定することはできますが、
各要因からの無償の経験値の合計が負になった場合は0まで底上げされます。

値：整数

例１：
\<iGlobalExperience\>0\</iGlobalExperience\>

例２：全都市の新ユニットが経験値+2ポイントを取得
\<iGlobalExperience\>2\</iGlobalExperience\>


### \<iFoodKept\>
ここに正の値を指定した場合、
この建造物を所有している間に都市に貯蔵されたパンのうちその割合が
人口増加時に追加で貯蔵されます。

とくに食料を追加で持ち越さない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物は穀物庫のみです。

値：整数

例１：
\<iFoodKept\>0\</iFoodKept\>

例２：成長後に食料50%を貯蔵
\<iFoodKept\>50\</iFoodKept\>

### \<iAirlift\>
ここに正の値を指定した場合、都市の空輸能力をその数だけ増やします。

空輸能力が1以上ある都市は、1ターンにその数だけユニットを空輸できます。
また空輸される都市の側では、
空輸能力が0の都市なら1ターンに1ユニットを空輸されることができます。
空輸能力が1以上ある都市なら、空輸されるユニット数は無制限になります。

都市の空輸能力は最初は0です。この属性によってのみ増やすことができます。
空輸能力を増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは空港のみです。

値：整数

例１：
\<iAirlift\>0\</iAirlift\>

例２：ターンごとに1 ユニットの空輸が可能に
\<iAirlift\>1\</iAirlift\>

### \<iAirModifier\>
この都市に駐留するユニットへの空爆ダメージに対する修正率を指定します。

空爆ダメージをとくに修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはバンカーのみです。

値：整数

例１：
\<iAirModifier\>0\</iAirModifier\>

例２：航空ユニットによるダメージ-50%
\<iAirModifier\>-50\</iAirModifier\>

### \<iAirUnitCapacity\>
ここに正の値を指定した場合、都市の航空ユニット配備枠をここに指定した数だけ増やします。

配備枠をとくに増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは空港のみです。

ユニットの配備枠占有についてはユニットの[\<iAirUnitCap\>]({{<ref "civ4unitinfos">}}#iairunitcap)も参照してください。

例１：
\<iAirUnitCapacity\>0\</iAirUnitCapacity\>

例２：+4航空ユニットを収容可能
\<iAirUnitCapacity\>4\</iAirUnitCapacity\>

### \<iNukeModifier\>
核爆発[^nukeexplosion]によるダメージに対する修正率を指定します。

この修正は、ユニットへのダメージと人口減少数に対して適用されます。
建造物の破壊確率には適用されません。

核爆発ダメージをとくに修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは核シェルターのみです。

[^nukeexplosion]: 核攻撃によるものと、メルトダウンによるものの両方に適用されます。

値：整数

例１：
\<iNukeModifier\>0\</iNukeModifier\>

例２：核爆発によるダメージ-50%
\<iNukeModifier\>-50\</iNukeModifier\>

### \<iNukeExplosionRand\>
この建造物がメルトダウンする確率を指定します。

ここに正の値nを指定する場合、この建造物は毎ターン1/nの確率でメルトダウンし、
半径1の核爆発を起こします。

メルトダウンしない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは原子力発電所のみです。

例１：
\<iNukeExplosionRand\>0\</iNukeExplosionRand\>

例２：原発事故の可能性あり、1/2000の確率でメルトダウン
\<iNukeExplosionRand\>2000\</iNukeExplosionRand\>

### \<iFreeSpecialist\>
ここに正の値を指定した場合、その数だけ都市に無償の専門家が与えられます。
この属性では、プレイヤーがどの専門家に割り当てるかを決定します。

とくに無償の専門家を提供しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はありません。

値：整数

例：
\<iFreeSpecialist\>0\</iFreeSpecialist\>

### \<iAreaFreeSpecialist\>
ここに正の値を指定した場合、その数だけ同じ大陸の全都市に無償の専門家が与えられます。
この属性では、プレイヤーがどの専門家に割り当てるかを決定します。

とくに無償の専門家を提供しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物は自由の女神です。

値：整数

例：
\<iAreaFreeSpecialist\>0\</iAreaFreeSpecialist\>


### \<iGlobalFreeSpecialist\>
ここに正の値を指定した場合、その数だけ文明の全都市に無償の専門家が与えられます。
この属性では、プレイヤーがどの専門家に割り当てるかを決定します。

とくに無償の専門家を提供しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はありません。

値：整数

例：
\<iGlobalFreeSpecialist\>0\</iGlobalFreeSpecialist\>

### \<iMaintenanceModifier\>
この都市の維持費に対する修正率を指定します。

とくに維持費を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはイカンダと裁判所(とそのUU群)です。

値：整数

例１：
\<iMaintenanceModifier\>0\</iMaintenanceModifier\>

例２：維持管理費-50%
\<iMaintenanceModifier\>-50\</iMaintenanceModifier\>

### \<iWarWearinessModifier\>
この都市の厭戦感情に対する修正率を指定します。

とくに厭戦感情を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは刑務所と霊廟です。

値：整数

例１：
\<iWarWearinessModifier\>0\</iWarWearinessModifier\>

例２：厭戦感情-25%
\<iWarWearinessModifier\>-25\</iWarWearinessModifier\>

### \<iGlobalWarWearinessModifier\>
文明の全都市の厭戦感情に対する修正率を指定します。

とくに厭戦感情を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはラシュモア山です。

値：整数

例１：
\<iGlobalWarWearinessModifier\>0\</iGlobalWarWearinessModifier\>

例２：全都市で厭戦感情-25%
\<iGlobalWarWearinessModifier\>-25\</iGlobalWarWearinessModifier\>

### \<iEnemyWarWearinessModifier\>
戦争相手の厭戦感情に対する修正率を指定します。

とくに相手の厭戦感情を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはゼウス像です。

値：整数

例１：
\<iEnemyWarWearinessModifier\>0\</iEnemyWarWearinessModifier\>

例２：敵が+100%厭戦感情をこうむります
\<iEnemyWarWearinessModifier\>100\</iEnemyWarWearinessModifier\>

### \<iHealRateChange\>
この都市に駐留するユニットがダメージを回復するとき、
ここに指定したぶんだけ追加でダメージを回復します。

この属性の効果は、都市に駐留したまま回復判定を迎えた場合に、回復値に追加される形で現れます。
回復判定を迎えなければ効果がないことに注意してください。
ユニットの回復判定はダメージを負った状態で移動せずにターンをまたいだ場合に発生します。

追加の回復機能を持たない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは病院のみです。

ここに負の値を指定することもできます。
各要因からの回復値の合計が負の値になった場合、
そのユニットが回復判定を迎えるとその分ダメージを受けます。
その場合でも、ダメージを負っていなければ回復判定が発生しないことに注意してください。

値：整数

例１：
\<iHealRateChange\>0\</iHealRateChange\>

例２：ユニットのダメージを、1ターンごとにさらに10%回復
\<iHealRateChange\>10\</iHealRateChange\>

### \<iHealth\>
この都市の〈衛生〉への増減値を指定します。

ここに正の値を指定する場合、その分だけ〈衛生〉が加算されます。
ここに負の値を指定する場合、その分だけ〈不衛生〉が加算されます。
(この場合のみ、[\<bBuildingOnlyHealthy\>](#bbuildingonlyhealthy)の対象になります。)
ここに0を指定する場合、どちらも発生しない普通の建造物になります。

値：整数

例１：
\<iHealth\>0\</iHealth\>

例２：衛生+2
\<iHealth\>2\</iHealth\>

例３：不衛生-1
\<iHealth\>-1\</iHealth\>

### \<iAreaHealth\>
同じ大陸にある全都市の衛生への増減値を指定します。

指定の仕方は[\<iHealth\>](#ihealth)を参照してください。
BtSでは、この属性を持つ建造物はありません。

例：
\<iAreaHealth\>0\</iAreaHealth\>

### \<iGlobalHealth\>
文明の全都市の衛生への増減値を指定します。

指定の仕方は[\<iHealth\>](#ihealth)を参照してください。
BtSでは、この属性を持つ建造物は空中庭園です。

例１：
\<iGlobalHealth\>0\</iGlobalHealth\>

例２：全都市で衛生+1
\<iGlobalHealth\>1\</iGlobalHealth\>

### \<iHappiness\>
この都市の〈満足〉への増減値を指定します。

ここに正の値を指定する場合、その分だけ〈満足〉が加算されます。
ここに負の値を指定する場合、その分だけ〈不満〉が加算されます。
ここに0を指定する場合、どちらも発生しない普通の建造物になります。

例１：
\<iHappiness\>0\</iHappiness\>

例２：満足+1
\<iHappiness\>1\</iHappiness\>

例３：不満+10
\<iHappiness\>-10\</iHappiness\>

### \<iAreaHappiness\>
同じ大陸にある都市の満足への増減値を指定します。

指定の仕方は[\<iHappiness\>](#ihappiness)を参照してください。
BtSでは、この属性を持つのはノートルダム大聖堂のみです。

例：
\<iAreaHappiness\>0\</iAreaHappiness\>

### \<iGlobalHappiness\>
文明の全都市の満足への増減値を指定します。

指定の仕方は[\<iHappiness\>](#ihappiness)を参照してください。
BtSでは、この属性を持つ建造物はありません。

例：
\<iGlobalHappiness\>0\</iGlobalHappiness\>

### \<iStateReligionHappiness\>
この建造物が[国教建造物](#religiontype)ならば、この建造物はここに指定した値の幸福を産出します。

[\<ReligionType\>](#religiontype)を指定しなかったり、国教と違っている場合は、
この属性からは何も産出しません。

この機能を使わない場合は、0を指定します。
BtSでは、この属性を持つのは各宗教の[大聖堂]({{<ref "glossary">}}#大聖堂)です。

値：整数

例：
\<iStateReligionHappiness\>0\</iStateReligionHappiness\>

### \<iWorkerSpeedModifier\>
労働効率への修正率を指定します。
この建造物を所有している間、この修正は全労働者に対して自動的に有効になります。

とくに労働効率を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはハギア・ソフィア大聖堂のみです。

ここに負の値を指定することもできます。
それによって労働効率が負の値になる場合、0まで底上げされます。
ただし労働効率が0になるとタイル整備コマンドは何もしないことに注意してください。

値：整数

例１：
\<iWorkerSpeedModifier\>0\</iWorkerSpeedModifier\>

例２：労働者の資源活用施設の建設速度が+50%向上
\<iWorkerSpeedModifier\>50\</iWorkerSpeedModifier\>

### \<iMilitaryProductionModifier\>
この都市が[軍事ユニット]({{<ref "civ4unitinfos">}}#bmilitaryproduction)を生産するときの〈ハンマー〉に対する修正率を指定します。

とくに軍事ユニット生産に修正を与えない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは士官学校と英雄叙事詩です。

値：整数

例１：
\<iMilitaryProductionModifier\>0\</iMilitaryProductionModifier\>

例２：軍事ユニット生産+100%
\<iMilitaryProductionModifier\>100\</iMilitaryProductionModifier\>

### \<iSpaceProductionModifier\>
この都市が宇宙船のパーツを生産するときの〈ハンマー〉に対する修正率を指定します。

とくに宇宙船パーツ生産を加速しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは研究所と研究施設です。

値：整数

例１：
\<iSpaceProductionModifier\>0\</iSpaceProductionModifier\>

例２：宇宙船の生産+50%
\<iSpaceProductionModifier\>50\</iSpaceProductionModifier\>

### \<iGlobalSpaceProductionModifier\>
文明の全都市に対し、宇宙船のパーツを生産するときの〈ハンマー〉に対する修正率を指定します。

とくに宇宙船パーツ生産を加速しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは軌道エレベーターです。

値：整数

例１：
\<iGlobalSpaceProductionModifier\>0\</iGlobalSpaceProductionModifier\>

例２：全都市で宇宙船の生産+50%
\<iGlobalSpaceProductionModifier\>50\</iGlobalSpaceProductionModifier\>

### \<iTradeRoutes\>
ここに正の値を指定した場合、その数だけこの都市の交易路を増やします。

とくに交易路を増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは城・城塞・コトン・空港です。

ここに負の値を指定することはできますが、
交易路の総本数が負の値になることは想定されていないため、
そうならないように注意を払うべきです。
実験したところでは、総本数が負の値になっても0本であるかのようにふるまいますが、
想定外の動作であることに注意してください。

値：整数

例１：
\<iTradeRoutes\>0\</iTradeRoutes\>

例２：交易路+1
\<iTradeRoutes\>1\</iTradeRoutes\>

### \<iCoastalTradeRoutes\>
ここに正の値を指定した場合、その数だけ文明の全ての沿岸都市に交易路を増やします。

とくに沿岸交易路を増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのはファロス灯台です。

値：整数

例１：
\<iCoastalTradeRoutes\>0\</iCoastalTradeRoutes\>

例２：沿岸部にある全都市で交易路を+2
\<iCoastalTradeRoutes\>2\</iCoastalTradeRoutes\>

### \<iGlobalTradeRoutes\>
ここに正の値を指定した場合、その数だけ文明の全都市に交易路を増やします。

とくに交易路を増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物はありません。

値：整数

例：
\<iGlobalTradeRoutes\>0\</iGlobalTradeRoutes\>

### \<iTradeRouteModifier\>
この都市の交易路収益に対する修正率を指定します。

とくに交易路収益を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは港・コトン・アルテミス神殿です。

値：整数

例１：
\<iTradeRouteModifier\>0\</iTradeRouteModifier\>

例２：交易路の生産量+50%
\<iTradeRouteModifier\>50\</iTradeRouteModifier\>

### \<iForeignTradeRouteModifier\>
この都市の対外交易路[^foreigntr]からの収益に対する修正率を指定します。

とくに交易路収益を修正しない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは税関・フェイトリアです。

[^foreigntr]: 他国の都市(属国でも可)との間の交易路のこと。シヴィロペディアには誤植があり、別の大陸の都市である必要はありません。

値：整数

例１：
\<iForeignTradeRouteModifier\>0\</iForeignTradeRouteModifier\>

例２：~~大陸間~~ 国際貿易利益+100%
\<iForeignTradeRouteModifier\>100\</iForeignTradeRouteModifier\>

### \<iGlobalPopulationChange\>
この建造物が完成したとき、文明の全都市の人口がここに指定した数だけ増えます。

とくに人口を増やさない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つのは空中庭園です。

値：整数

例１：
\<iGlobalPopulationChange\>0\</iGlobalPopulationChange\>

例２：全都市の人口+1
\<iGlobalPopulationChange\>1\</iGlobalPopulationChange\>

### \<iFreeTechs\>
ここに正の値を指定した場合、この建造物が完成したとき、
建造した文明はその数ぶんの無償のテクノロジーを得ます。

とくに無償の技術を与えない普通の建造物の場合、0を指定します。

値：整数

例１：
\<iFreeTechs\>0\</iFreeTechs\>

例２：1種類のテクノロジーを無償で獲得
\<iFreeTechs\>1\</iFreeTechs\>


### \<iDefense\>
ここに正の値を指定する場合、この都市の建造物防御値がそのぶんだけ増えます。

最終的な都市防御ボーナス基礎値は、素の文化防御値と建造物防御値の高いほうが選ばれます。
この属性は、ユニットの[\<bIgnoreBuildingDefense\>]({{<ref "civ4unitinfos">}}#bignorebuildingdefense)によって無効化されます。

建造物防御値を増やさない普通の建造物の場合、0を指定します。

例１：
\<iDefense\>0\</iDefense\>

例２：防御力+50%
\<iDefense\>50\</iDefense\>

### \<iBombardDefense\>
この都市への砲撃ダメージに対する軽減率を指定します。
ここに正の値を指定する場合、その割合だけこの都市への砲撃ダメージが減ります。

この属性は、ユニットの[\<bIgnoreBuildingDefense\>]({{<ref "civ4unitinfos">}}#bignorebuildingdefense)によって無効化されます。

とくに砲撃ダメージを軽減しない普通の建造物の場合、0を指定します。

値：整数

例１：
\<iBombardDefense\>0\</iBombardDefense\>

例２：砲撃による都市防御へのダメージ-50%
\<iBombardDefense\>50\</iBombardDefense\>

### \<iAllCityDefense\>
ここに正の値を指定する場合、文明の全都市の建造物防御値がそのぶんだけ増えます。

この属性は、ユニットの[\<bIgnoreBuildingDefense\>]({{<ref "civ4unitinfos">}}#bignorebuildingdefense)によって無効化***されません***。

BtSでは、この属性を持つ建造物はチチェンイツァーのみです。

値：整数

例１：
\<iAllCityDefense\>0\</iAllCityDefense\>

例２：全都市の防御力+25%
\<iAllCityDefense\>25\</iAllCityDefense\>

### \<iEspionageDefense\>
他国のスパイがこの都市で行う諜報ミッションのコストに対する修正率を指定します。
さらに、この修正率が正の値になる場合、
スパイユニットが駐留しているのと同様のスパイ活動妨害効果を得ます。

特に防諜能力のない普通の建造物の場合、0を指定します。
BtSでは、この属性を持つ建造物は公安局のみです。

値：整数

例１：
\<iEspionageDefense\>0\</iEspionageDefense\>

例２：防諜レベル+50%、敵スパイの妨害
\<iEspionageDefense\>50\</iEspionageDefense\>

### \<iAsset\>
このユニットは、ここに指定した値だけスコアを増やします。

値：整数

例：
\<iAsset\>1\</iAsset\>

### \<iPower\>
このユニットは、ここに指定した値だけ軍事力を増やします。

値：整数

例：
\<iPower\>3\</iPower\>

### \<fVisibilityPriority\>
マップ上の都市に建造物の3Dモデルを描画する際の優先度を指定します。
都市に入りきらなくなった優先度の低い建造物のモデルは描画を省略されます。

値：小数

例：
\<fVisibilityPriority\>1.0\</fVisibilityPriority\>


### \<YieldChanges\>
この建造物が直接産出する〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。

値は\<iYield\>のリストで、上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。その場合、指定しなかった分は0とみなされます。

〈パン〉・〈ハンマー〉・〈コイン〉のいずれもこの建造物からは直接産出しない場合、空タグにします。

各\<iYield\>に負の値を指定することはできますが、
都市合計で負の値にならないように気を付けてください。
出力にペナルティーを与えたい場合、[\<YieldModifiers\>](#yieldmodifiers)の使用も検討してください。

---

例１：
\<YieldChanges /\>

---

例２：+1〈パン〉
``` plain
<YieldChanges>
    <iYield>1</iYield>
</YieldChanges>
```

---

例２(別解)：+1〈パン〉
``` plain
<YieldChanges>
    <iYield>1</iYield>
    <iYield>0</iYield>
    <iYield>0</iYield>
</YieldChanges>
```

---

例３：+2〈ハンマー〉
``` plain
<YieldChanges>
    <iYield>0</iYield>
    <iYield>2</iYield>
</YieldChanges>
```

---

例３(別解)：+2〈ハンマー〉
``` plain
<YieldChanges>
    <iYield>0</iYield>
    <iYield>2</iYield>
    <iYield>0</iYield>
</YieldChanges>
```

---

例４：+3〈コイン〉
``` plain
<YieldChanges>
    <iYield>0</iYield>
    <iYield>0</iYield>
    <iYield>3</iYield>
</YieldChanges>
```

---

例５：+2〈パン〉・+2〈ハンマー〉・-2〈コイン〉
``` plain
<YieldChanges>
    <iYield>2</iYield>
    <iYield>2</iYield>
    <iYield>-2</iYield>
</YieldChanges>
```


### \<YieldModifiers\>
この都市の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

値は\<iYield\>のリストで、上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。その場合、指定しなかった分は0とみなされます。

この機能を使わない場合、タグごと省略します。

例：+25%〈ハンマー〉
``` plain
<YieldModifiers>
    <iYield>0</iYield>
    <iYield>25</iYield>
    <iYield>0</iYield>
</YieldModifiers>
```


### \<PowerYieldModifiers\>
この都市の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。
ただしこの属性は、[〈電力〉]({{<ref "power">}})が供給されている場合にのみ有効になります。

この機能を使わない場合、タグごと省略します。

例：+50%〈ハンマー〉 エネルギー(電力)があれば
``` plain
<PowerYieldModifiers>
    <iYield>0</iYield>
    <iYield>50</iYield>
    <iYield>0</iYield>
</PowerYieldModifiers>
```

### \<AreaYieldModifiers\>
同じ大陸にある全都市の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

この機能を使わない場合、タグごと省略します。
BtSでは、この属性を持つ建造物はありません。

例：+50%〈コイン〉この大陸の全都市
``` plain
<AreaYieldModifiers>
    <iYield>0</iYield>
    <iYield>0</iYield>
    <iYield>50</iYield>
</AreaYieldModifiers>
```


### \<GlobalYieldModifiers\>
文明の全都市の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

この機能を使わない場合、タグごと省略します。
BtSでは、この属性を持つ建造物はありません。

例：+50%〈コイン〉 全都市
``` plain
<GlobalYieldModifiers>
    <iYield>0</iYield>
    <iYield>0</iYield>
    <iYield>50</iYield>
</GlobalYieldModifiers>
```


### \<SeaPlotYieldChanges\>
この都市の都市圏にある水タイルの〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。

指定の仕方は[\<YieldChanges\>](#yieldchanges)も参照してください。

例１：
\<SeaPlotYieldChanges /\>

例２：海洋スクエア:+1〈パン〉
``` plain
<SeaPlotYieldChanges>
    <iYield>1</iYield>
</SeaPlotYieldChanges>
```

### \<RiverPlotYieldChanges\>
この都市の都市圏にある川沿いタイルの〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。

指定の仕方は[\<YieldChanges\>](#yieldchanges)も参照してください。

例１：
\<RiverPlotYieldChanges /\>

例２：川沿いタイルから+1〈ハンマー〉
``` plain
<RiverPlotYieldChanges>
    <iYield>0</iYield>
    <iYield>1</iYield>
</RiverPlotYieldChanges>
```

### \<GlobalSeaPlotYieldChanges\>
全都市の水タイルの〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。

指定の仕方は[\<YieldChanges\>](#yieldchanges)も参照してください。

例１：
\<GlobalSeaPlotYieldChanges /\>

例２：全都市の海洋スクエア:+1〈コイン〉
``` plain
<GlobalSeaPlotYieldChanges>
    <iYield>0</iYield>
    <iYield>0</iYield>
    <iYield>1</iYield>
</GlobalSeaPlotYieldChanges>
```


### \<CommerceChanges\>
この建造物が直接産出する〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への加減値を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉のいずれもこの建造物からは直接産出しない場合、空タグにします。

各\<iCommerce\>に負の値を指定することはできますが、
都市合計で負の値にならないように気を付けてください。
出力にペナルティーを与えたい場合、[\<CommerceModifiers\>](#commercemodifiers)の使用も検討してください。

---

例１：
\<CommerceChanges /\>

---

例２：+1〈ゴールド〉
``` plain
<CommerceChanges>
    <iCommerce>1</iCommerce>
</CommerceChanges>
```

---

例２・別解：+1〈ゴールド〉
``` plain
<CommerceChanges>
    <iCommerce>1</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
</CommerceChanges>
```

---

例３：+2〈ビーカー〉
``` plain
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
</CommerceChanges>
```

---

例３・別解：+2〈ビーカー〉
``` plain
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
</CommerceChanges>
```

---

例４：+3〈文化〉
``` plain
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>3</iCommerce>
</CommerceChanges>
```

---

例４・別解：+3〈文化〉
``` plain
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>3</iCommerce>
    <iCommerce>0</iCommerce>
</CommerceChanges>
```

---

例５：+4〈諜報〉
``` plain
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>4</iCommerce>
</CommerceChanges>
```

---

例６：-2〈ゴールド〉・+2〈ビーカー〉・+4〈諜報〉
``` plain
<CommerceChanges>
    <iCommerce>-2</iCommerce>
    <iCommerce>2</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>4</iCommerce>
</CommerceChanges>
```


### \<ObsoleteSafeCommerceChanges\>
この建造物が陳腐化後も産出する〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への加減値を指定します。
この属性だけは陳腐化の影響を受けず、陳腐化する前でも後でも同じ出力を産出します。
BtSの建造物が陳腐化後も〈文化〉を出し続けるのは、ここに指定しているからです。

陳腐化する前であれば、[\<CommerceChanges\>](#commercechanges)と重複し、
両方の出力が合計されることに注意してください。
〈文化〉の例では、[\<CommerceChanges\>](#commercechanges)には指定せず
\<ObsoleteSafeCommerceChanges\>に指定することでBtSと同じ挙動になります。

指定の仕方は[\<CommerceChanges\>](#commercechanges)も参照してください。

例１：
\<ObsoleteSafeCommerceChanges /\>

例２：+2〈文化〉(陳腐化しない)
``` plain
<ObsoleteSafeCommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
</ObsoleteSafeCommerceChanges>
```

### \<CommerceChangeDoubleTimes\>
出力を倍にするために必要となる年数を指定します。

ここに正の値nを指定した場合、この建造物が完成してからn年[^year]ごとに、
該当する出力が2倍になります。

BtSでは、〈文化〉に対して1000を指定することで、
俗に「Agedボーナス」と呼ばれる挙動が実現されています。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。
0を指定すると、その出力に対しては2倍になる効果は働きません。

[^year]: ターン数ではなく、年です。ゲーム速度との関連に注意してください。

例１：
\<CommerceChangeDoubleTimes /\>

例２：完成から1000年経つと〈文化〉2倍
``` plain
<CommerceChangeDoubleTimes>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>1000</iCommerce>
</CommerceChangeDoubleTimes>
```

### \<CommerceModifiers\>
この都市の〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への修正率を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉のいずれにも修正率を与えない場合、空タグにします。

---

例１：
\<CommerceModifiers /\>

---

例２：+25%〈ゴールド〉
``` plain
<CommerceModifiers>
    <iCommerce>25</iCommerce>
</CommerceModifiers>
```

---

例３：+25%〈ビーカー〉
``` plain
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>25</iCommerce>
</CommerceModifiers>
```

---

例４：+50%〈文化〉
``` plain
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>50</iCommerce>
</CommerceModifiers>
```

---

例５：+50%〈諜報〉
``` plain
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>50</iCommerce>
</CommerceModifiers>
```


### \<GlobalCommerceModifiers\>
文明の全都市の〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への修正率を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ建造物はありません。

例１：
\<GlobalCommerceModifiers /\>

例２：+50%〈ゴールド〉, +50%〈ビーカー〉, +50%〈文化〉, +50%〈諜報〉 全都市
``` plain
<GlobalCommerceModifiers>
    <iCommerce>50</iCommerce>
    <iCommerce>50</iCommerce>
    <iCommerce>50</iCommerce>
    <iCommerce>50</iCommerce>
</GlobalCommerceModifiers>
```

### \<SpecialistExtraCommerces\>
文明の全都市・全種類の専門家から産出される、
〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉に対する増減値を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ建造物はシスティナ礼拝堂のみです。

例１：
\<SpecialistExtraCommerces /\>

例２：+2〈文化〉を全都市の専門家ごとに取得
``` plains
<SpecialistExtraCommerces>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
</SpecialistExtraCommerces>
```

### \<StateReligionCommerces\>
文明の全都市に建造されている[国教建造物](#religiontype)が追加で産出する
〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ建造物はシスティナ礼拝堂のみです。

例１：
\<StateReligionCommerces\>

例２：+2〈ビーカー〉を すべての国教の建造物から取得
``` plains
<StateReligionCommerces>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
</StateReligionCommerces>
```

### \<CommerceHappinesses\>
この都市について、商業力スライダーを〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉の
いずれかに振ることにより産出される〈幸福〉の量を指定します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

\<iCommerce\>に正の値nを指定した場合、100%の1/nを振るごとに
その都市は+1の〈幸福〉を得ます。

たとえば劇場の記述を例にすると、
```plains
<CommerceHappinesses>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>10</iCommerce>
</CommerceHappinesses>
```
100% の 1/10 = 10% を〈文化〉に振るごとに+1〈幸福〉が産出されます。 


この機能を使わない場合、空タグにします。

例２：
\<CommerceHappinesses /\>

### \<ReligionChanges\>
この建造物から発生する宗教圧力を指定します。
ここに宗教と値の組を指定すると、
その宗教の周囲への自然伝搬率がその値のぶんだけ上がります。

宗教圧力は聖都から1発生しますが、そのほかにはこの属性からのみ発生し、
ただ布教されているだけの都市や、そのほかの宗教建造物からは発生しません。

宗教圧力は交易路を通して伝搬し、交易路がつながっていて、
宗教がまだ布教されていない都市に対してのみ自然伝搬します。
宗教圧力は距離によって急速に減衰するので、遠くにある都市ほど伝搬しにくくなります。[^religiondistance]

また、ここになんらかの宗教を指定する場合、
この建造物が完成したとき、その宗教を自動的に布教する効果も持ちます。

[^religiondistance]: 交易路としての長さとは関係なく、2都市間の絶対距離で決まります。大陸の反対側の都市と長い道路でつながっていて、海を渡っていった方が距離が近い場合、天文学を持っているかどうかに関係なく、近い方の距離が使われます。<br>また、距離によってかなり急速に減衰し、星の反対側では確率1/1000になってしまいます。Pangaea大きさ標準マップにおいて圧力1で実用的に自然伝搬できる距離は、おおむね距離12程度のようです。


値：\<ReligionChange\>のリスト

{{% div class="subnote" %}}

\<ReligionChange\>は以下の2つのタグを含みます。

#### \<ReligionType\>
宗教を指定します。
値：[宗教キー]({{<ref "keyichiran">}}#宗教)

#### \<iReligionChange\>
この都市が追加で発するその宗教の宗教圧力の値を指定します。
値：整数

{{% /div %}}


例１：
\<ReligionChanges /\>

例２：〈ユダヤ教〉を布教
``` plain
<ReligionChanges>
    <ReligionChange>
        <ReligionType>RELIGION_JUDAISM</ReligionType>
        <iReligionChange>1</iReligionChange>
    </ReligionChange>
</ReligionChanges>
```

### \<SpecialistCounts\>
この建造物が解禁する専門化枠を指定します。

とくに専門家の枠を解禁しない建造物の場合、空タグにします。

値：\<SpecialistCount\>のリスト

{{% div class="subnote" %}}

\<SpecialistCount\>は以下の2つのタグを含みます。

#### \<SpecialistType\>
専門家の種類を指定します。
値：[専門家キー]({{<ref "keyichiran">}}#専門家)

#### \<iSpecialistCount\>
その専門家の雇用枠の数を指定します。
値：整数

{{% /div %}}

例１：
\<SpecialistCounts /\>

例２：2人の市民を科学者に転向可能、2人の市民を聖職者に転向可能
``` plain
<SpecialistCounts>
    <SpecialistCount>
        <SpecialistType>SPECIALIST_SCIENTIST</SpecialistType>
        <iSpecialistCount>2</iSpecialistCount>
    </SpecialistCount>
    <SpecialistCount>
        <SpecialistType>SPECIALIST_PRIEST</SpecialistType>
        <iSpecialistCount>2</iSpecialistCount>
    </SpecialistCount>
</SpecialistCounts>
```

### \<FreeSpecialistCounts\>
この建造物により無償で提供される(特定の種類の)専門家の数を指定します。
[\<iFreeSpecialist\>](#ifreespecialist)とは異なり、
無償の専門家の種類はあらかじめここに指定した種類で固定されます。

とくに無償の専門家を与えない建造物の場合、空タグにします。

値：\<SpecialistCount\>のリスト

{{% div class="subnote" %}}

\<SpecialistCount\>は以下の2つのタグを含みます。

#### \<SpecialistType\>
専門家の種類を指定します。
値：[専門家キー]({{<ref "keyichiran">}}#専門家)

#### \<iSpecialistCount\>
その専門家の種類に対して、無償の専門家の人数を指定します。
値：整数

{{% /div %}}

例１：
\<FreeSpecialistCounts /\>

例２：無償の科学者+2
``` plain
<FreeSpecialistCounts>
    <FreeSpecialistCount>
        <SpecialistType>SPECIALIST_SCIENTIST</SpecialistType>
        <iFreeSpecialistCount>2</iFreeSpecialistCount>
    </FreeSpecialistCount>
</FreeSpecialistCounts>
```

### \<CommerceFlexibles\>
この建造物が完成したとき、〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉の
いずれか指定した商業出力について、スライダーを解禁します。
通常、商業力を各商業出力に振り分けるスライダーは[技術によって解禁されます]({{<ref "civ4techinfos">}}#commerceflexible)が、
この属性はそれを無視してスライダーを解禁します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
それぞれの\<iCommerce\>では0または1を指定します。
1を指定した商業出力について、スライダーが解禁されます。

通常、〈ゴールド〉〈ビーカー〉〈諜報〉のスライダーはゲーム開始時から解禁されているので、
3番目以外の\<iCommerce\>指定はとくに意味を成しません。
また、〈諜報〉のスライダーは、解禁された後いずれかの文明と接触していないと
表示されないことに注意してください。

\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

例１：
\<CommerceFlexibles /\>

例２：〈諜報〉を調整可能
``` plain
<CommerceFlexibles>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>1</iCommerce>
</CommerceFlexibles>
```


### \<CommerceChangeOriginalOwners\>
[\<CommerceChanges\>](#commercechanges)や[\<ObsoleteSafeCommerceChanges\>](#obsoletesafecommercechanges)の指定について、[^ccoo]
この建造物を建造した文明にしか効果がないように
(占領した都市にこの建造物が残っても効果がないように)することができます。

値は\<bCommerceChangeOriginalOwner\>のリストで、
上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
それぞれの\<bCommerceChangeOriginalOwner\>では0または1を指定します。
1を指定した商業出力について、この建造物を建造した文明にしか効果がないようになります。

BtSでは、すべての世界遺産の〈文化〉についてこの属性が使われています。
結果として、世界遺産は占領されても〈文化〉を産出しません。
この機能を使わない場合、空タグにします。

[^ccoo]: 効果範囲はこの2つの属性だけです。ほかの属性の効果を抑制することはできないことに注意してください。

例１：
\<CommerceChangeOriginalOwners /\>

例２：(占領されたら〈文化〉を出さないようになる)
``` plain
<CommerceChangeOriginalOwners>
    <bCommerceChangeOriginalOwner>0</bCommerceChangeOriginalOwner>
    <bCommerceChangeOriginalOwner>0</bCommerceChangeOriginalOwner>
    <bCommerceChangeOriginalOwner>1</bCommerceChangeOriginalOwner>
</CommerceChangeOriginalOwners>
```


### \<ConstructSound\>
この建造物が完成したときに流れる効果音を指定します。

値：2Dサウンドスクリプトキー

例：
\<ConstructSound\>AS2D\_BUILD\_WALLS\</ConstructSound\>

### \<BonusHealthChanges\>
資源からの追加の〈衛生〉または〈不衛生〉を指定します。

この機能を使わない場合、空タグにします。

値：\<BonusHealthChange\>のリスト

{{% div class="subnote" %}}

\<BonusHealthChange\>は以下の2つのタグを含みます。

#### \<BonusType\>
資源の種類を指定します。
値：[資源キー]({{<ref "keyichiran">}}#資源)

#### \<iHealthChange\>
その資源から追加で産出される〈衛生〉または〈不衛生〉の数を指定します。
正の数で〈衛生〉、負の数で〈不衛生〉になります。
値：整数

{{% /div %}}

例１：
\<BonusHealthChanges /\>

例２：次の資源から〈衛生〉+1: トウモロコシ, 米, 小麦
``` plain
<BonusHealthChanges>
    <BonusHealthChange>
        <BonusType>BONUS_CORN</BonusType>
        <iHealthChange>1</iHealthChange>
    </BonusHealthChange>
    <BonusHealthChange>
        <BonusType>BONUS_RICE</BonusType>
        <iHealthChange>1</iHealthChange>
    </BonusHealthChange>
    <BonusHealthChange>
        <BonusType>BONUS_WHEAT</BonusType>
        <iHealthChange>1</iHealthChange>
    </BonusHealthChange>
</BonusHealthChanges>
```

例２：次の資源から〈不衛生〉+2: 石炭, 石油
``` plain
<BonusHealthChanges>
    <BonusHealthChange>
        <BonusType>BONUS_OIL</BonusType>
        <iHealthChange>-2</iHealthChange>
    </BonusHealthChange>
    <BonusHealthChange>
        <BonusType>BONUS_COAL</BonusType>
        <iHealthChange>-2</iHealthChange>
    </BonusHealthChange>
</BonusHealthChanges>
```


### \<BonusHappinessChanges\>
資源からの追加の〈満足〉または〈不満〉を指定します。

この機能を使わない場合、空タグにします。

値：\<BonusHappinessChange\>のリスト

{{% div class="subnote" %}}

\<BonusHappinessChange\>は以下の2つのタグを含みます。

#### \<BonusType\>
資源の種類を指定します。
値：[資源キー]({{<ref "keyichiran">}}#資源)

#### \<iHappinessChange\>
その資源から追加で産出される〈満足〉または〈不満〉の数を指定します。
正の数で〈満足〉、負の数で〈不満〉になります。
値：整数

{{% /div %}}

例１：
\<BonusHappinessChanges /\>

例２：次の資源から〈満足〉+1: 宝石, 金, 銀
``` plain
<BonusHappinessChanges>
    <BonusHappinessChange>
        <BonusType>BONUS_GEMS</BonusType>
        <iHappinessChange>1</iHappinessChange>
    </BonusHappinessChange>
    <BonusHappinessChange>
        <BonusType>BONUS_GOLD</BonusType>
        <iHappinessChange>1</iHappinessChange>
    </BonusHappinessChange>
    <BonusHappinessChange>
        <BonusType>BONUS_SILVER</BonusType>
        <iHappinessChange>1</iHappinessChange>
    </BonusHappinessChange>
</BonusHappinessChanges>
```


### \<BonusProductionModifiers\>
この建造物の生産を加速する資源を指定します。

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


例１：
\<BonusProductionModifiers /\>

例２：石材があれば生産速度2倍
``` plain
<BonusProductionModifiers>
    <BonusProductionModifier>
        <BonusType>BONUS_STONE</BonusType>
        <iProductonModifier>100</iProductonModifier>
    </BonusProductionModifier>
</BonusProductionModifiers>
```


### \<UnitCombatFreeExperiences\>
この都市で生産されるユニットに対し、兵科ごとに無償の経験値を与えるよう指定します。

値：\<UnitCombatFreeExperience\>のリスト

{{% div class="subnote" %}}

\<UnitCombatFreeExperience\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
兵科を指定します。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<iExperience\>
その兵科に対して与える経験値の量を指定します。

ここに負の値を指定することはできますが、
各要因からの無償の経験値の合計が負になった場合は0まで底上げされます。

値：整数

{{% /div %}}

例１：
\<UnitCombatFreeExperiences /\>

例２：新しい騎乗ユニットが経験値+2ポイントを取得
``` plain
<UnitCombatFreeExperiences>
    <UnitCombatFreeExperience>
        <UnitCombatType>UNITCOMBAT_MOUNTED</UnitCombatType>
        <iExperience>2</iExperience>
    </UnitCombatFreeExperience>
</UnitCombatFreeExperiences>
```

### \<DomainFreeExperiences\>
この都市で生産されるユニットに対し、
行動領域ごと(陸上・海洋・航空)に無償の経験値を与えるよう指定します。

値：\<DomainFreeExperience\>のリスト

{{% div class="subnote" %}}

\<DomainFreeExperience\>は以下の2つのタグを含みます。

#### \<DomainType\>
行動領域を指定します。
値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

#### \<iExperience\>
その行動領域に属するユニットに対して与える経験値の量を指定します。

ここに負の値を指定することはできますが、
各要因からの無償の経験値の合計が負になった場合は0まで底上げされます。

値：整数

{{% /div %}}

例１：
\<DomainFreeExperiences\>

例２：新しい海洋ユニットが経験値+4ポイントを取得
``` plain
<DomainFreeExperiences>
    <DomainFreeExperience>
        <DomainType>DOMAIN_SEA</DomainType>
        <iExperience>4</iExperience>
    </DomainFreeExperience>
</DomainFreeExperiences>
```

### \<DomainProductionModifiers\>
ここに指定した行動領域に属するユニットをこの都市で生産する際の
〈ハンマー〉への修正率を指定します。

値：\<DomainProductionModifier\>のリスト

{{% div class="subnote" %}}

\<DomainProductionModifier\>は以下の2つのタグを含みます。

#### \<DomainType\>
行動領域を指定します。
値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

#### \<iProductonModifier\>
その行動領域に属するユニットを生産する際の
〈ハンマー〉への修正率を指定します。
値：整数

{{% /div %}}

例１：
\<DomainProductionModifiers\>

例２：海洋ユニットの建設速度が+50%向上
``` plain
<DomainProductionModifiers>
    <DomainProductionModifier>
        <DomainType>DOMAIN_SEA</DomainType>
        <iProductionModifier>50</iProductionModifier>
    </DomainProductionModifier>
</DomainProductionModifiers>
```


### \<BuildingHappinessChanges\>
特定の建造物クラスを指定し、
この建造物を所有している間その建造物クラスから追加の〈幸福〉を産出させます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ建造物はありません。

例１：
\<BuildingHappinessChanges /\>

例２：図書館により〈幸福〉+3
``` plain
<BuildingHappinessChanges>
    <BuildingHappinessChange>
        <BuildingType>BUILDINGCLASS_LIBRARY</BuildingType>
        <iHappinessChange>3</iHappinessChange>
    </BuildingHappinessChange>
</BuildingHappinessChanges>
```


### \<PrereqBuildingClasses\>
この建造物を生産するための前提となる建造物クラスと数を指定します。
文明全体で指定した建造物クラスに属する建造物がそれぞれ指定した数建っているときに限り、
この建造物を生産できます。
もし生産し始めた後で前提を満たさなくなると、生産は強制的に中断されます。

[\<iNumFreeBonuses\>](#inumfreebonuses)とは異なり、
この属性に指定した値は常にマップサイズの影響を受けます。

この建造物自体に(国家遺産や世界遺産によるなどの)建造数制限がない限り、
もう一度前提を指定した数用意すればまたこの建造物を1つ生産できます。
BtSでの[大聖堂]({{<ref "glossary">}}#大聖堂)がそのような挙動になっています。

BtSでは、この属性を持つのは以下の建造物です。

建造物|前提|数
---|---|---
紫禁城|裁判所|4
各宗教の大聖堂|対応した寺院|2
グローブ座|劇場|4
オックスフォード大学|大学|4
ウォール街|銀行|4
製鉄所|溶鉱炉|4
赤十字|病院|4
ゼウス像|モニュメント|2

実際に必要な数は、マップサイズの\<iBuildingClassPrereqModifier\>により以下の修正を得ます。

マップサイズ|修正率
---|---
最小|+0%
極小|+0%
小さい|+25%
標準|+50%
大きい|+75%
最大|+100%


値：\<PrereqBuildingClass\>のリスト

{{% div class="subnote" %}}

\<PrereqBuildingClass\>は以下の2つのタグを含みます。

#### \<BuildingClassType\>
建造物クラスを指定します。
値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

#### \<iNumBuildingNeeded\>
その建造物クラスがいくつ必要かの基本値を指定します。
値：整数

{{% /div %}}

この機能を使わない場合、空タグにします。

例１：
\<PrereqBuildingClasses /\>

例２：
``` plain
<PrereqBuildingClasses>
    <PrereqBuildingClass>
        <BuildingClassType>BUILDINGCLASS_COURTHOUSE</BuildingClassType>
        <iNumBuildingNeeded>4</iNumBuildingNeeded>
    </PrereqBuildingClass>
</PrereqBuildingClasses>
```


### \<BuildingClassNeededs\>
この建造物を生産するための前提となる建造物クラスを指定します。
この都市にその前提建造物クラスが建っているときに限り、この建造物を生産できます。
もし生産し始めた後で前提を満たさなくなると、生産は強制的に中断されます。

ここに複数の建造物クラスを指定することもできます。
この建造物の生産をするには、[\<PrereqBuildingClasses\>](#prereqbuildingclass)も含めて、
全ての前提を満たしている必要があります。

\<PrereqBuildingClasses\>と同じ建造物クラスを指定する場合、
この都市の前提建造物も数の1つとして含まれます。
また、\<PrereqBuildingClasses\>と同じ建造物クラスを必ずしも指定する必要はありません。
ここには指定しなかった場合、文明全体で数が揃っていれば
この都市に前提建造物が建っている必要はなくなります。
BtSでの大聖堂がそのような挙動になっています。

値：\<BuildingClassNeeded\>のリスト

{{% div class="subnote" %}}

\<BuildingClassNeeded\>は以下の2つのタグを含みます。

#### \<BuildingClassType\>
建造物クラスを指定します。
値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

#### \<iNeededInCity\>
その建造物クラスがいくつ必要かを指定します。
通常、ここには1を指定することになるでしょう。
値：1

{{% /div %}}

前提建造物を設定しない建造物の場合、空タグにします。

例１：
\<BuildingClassNeededs /\>

例２：裁判所が必要
``` plain
<BuildingClassNeededs>
    <BuildingClassNeeded>
        <BuildingClassType>BUILDINGCLASS_COURTHOUSE</BuildingClassType>
        <bNeededInCity>1</bNeededInCity>
    </BuildingClassNeeded>
</BuildingClassNeededs>
```


### \<SpecialistYieldChanges\>
この文明の全都市で、指定した専門家が追加で〈パン〉・〈ハンマー〉・〈コイン〉を産出します。

値：\<SpecialistYieldChange\>のリスト

{{% div class="subnote" %}}

\<SpecialistYieldChange\>は以下の2つのタグを含みます。

#### \<SpecialistType\>
専門家の種類を指定します。
値：[専門家キー]({{<ref "keyichiran">}}#専門家)

#### \<YieldChanges\>
その専門家が追加で産出する、
〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。

値は\<iYield\>のリストで、
上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。
その場合、指定しなかった分は0とみなされます。

{{% /div %}}

とくに専門家に追加の出力を与えない普通の建造物の場合、空タグにします。
BtSでは、この属性を持つのはアンコールワットのみです。

例１：
\<SpecialistYieldChanges /\>

例２：+1〈ハンマー〉を全都市の聖職者から取得
``` plain
<SpecialistYieldChanges>
    <SpecialistYieldChange>
        <SpecialistType>SPECIALIST_PRIEST</SpecialistType>
        <YieldChanges>
            <iYield>0</iYield>
            <iYield>1</iYield>
            <iYield>0</iYield>
        </YieldChanges>
    </SpecialistYieldChange>
</SpecialistYieldChanges>
```

### \<BonusYieldModifiers\>
この都市に指定した資源があるときに発生する、
〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

値：\<BonusYieldModifier\>のリスト

{{% div class="subnote" %}}

\<BonusYieldModifier\>は以下の2つのタグを含みます。

#### \<BonusType\>
資源を指定します。
値：[資源キー]({{<ref "keyichiran">}}#資源)

#### \<YieldModifiers\>
その資源があるときに発生する
〈パン〉、〈ハンマー〉、〈コイン〉への修正率を指定します。

値は\<iYield\>のリストで、
上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。
その場合、指定しなかった分は0とみなされます。

{{% /div %}}

資源による修正率を持たない場合、空タグにします。
BtSでは、この属性を持つのは製鉄所のみです。

例１：
\<BonusYieldModifiers /\>

例２：+50%〈ハンマー〉(石炭の保有時)、+50%〈ハンマー〉(鉄の保有時)
``` plain
<BonusYieldModifiers>
    <BonusYieldModifier>
        <BonusType>BONUS_COAL</BonusType>
        <YieldModifiers>
            <iYield>0</iYield>
            <iYield>50</iYield>
            <iYield>0</iYield>
        </YieldModifiers>
    </BonusYieldModifier>
    <BonusYieldModifier>
        <BonusType>BONUS_IRON</BonusType>
        <YieldModifiers>
            <iYield>0</iYield>
            <iYield>50</iYield>
            <iYield>0</iYield>
        </YieldModifiers>
    </BonusYieldModifier>
</BonusYieldModifiers>
```

### \<ImprovementFreeSpecialists\>
この都市の都市圏にある特定の地形改善のぶんだけ、この都市に無償の専門家を提供します。
この属性では、プレイヤーがどの専門家に割り当てるかを決定します。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つのは国立公園のみです。

値：\<ImprovementFreeSpecialist\>のリスト

{{% div class="subnote" %}}

\<ImprovementFreeSpecialist\>は以下の2つのタグを含みます。

#### \<ImprovementType\>
地形改善の種類を指定します。
値：[地形改善キー]({{<ref "keyichiran">}}#地形改善)

#### \<iFreeSpecialistCount\>
その地形改善1つあたり、何人の無償の専門家を都市に提供するか指定します。
値：整数

{{% /div %}}

例１：
\<ImprovementFreeSpecialists /\>

例２：次のものごとに+1人の専門家を無償で取得:保安林
``` plain
<ImprovementFreeSpecialists>
    <ImprovementFreeSpecialist>
        <ImprovementType>IMPROVEMENT_FOREST_PRESERVE</ImprovementType>
        <iFreeSpecialistCount>1</iFreeSpecialistCount>
    </ImprovementFreeSpecialist>
</ImprovementFreeSpecialists>
```

### \<Flavors\>
この建造物が持つフレーバーを指定します。
この指定と指導者の好むフレーバーが近いほど、
AI指導者はこの建造物を優先して生産します。

例：
``` plain
<Flavors>
    <Flavor>
        <FlavorType>FLAVOR_MILITARY</FlavorType>
        <iFlavor>10</iFlavor>
    </Flavor>
</Flavors>
```


### \<bAltDown\>
1を指定した場合、この建造物を生産するショートカットキーにAltキーを追加します。
ただし、Altキーは無限生産のショートカットと衝突してしまいます。
Altキーを足すのは推奨されません。

値：0か1

### \<bShiftDown\>
1を指定した場合、この建造物を生産するショートカットキーにShiftキーを追加します。
ただし、Shiftキーは生産キューの最後に追加のショートカットと衝突してしまいます。
Shiftキーを足すのは推奨されません。

値：0か1

### \<bCtrlDown\>
1を指定した場合、この建造物を生産するショートカットキーにCtrlキーを追加します。
ただし、Ctrlキーは生産キューの先頭に追加のショートカットと衝突してしまいます。
Ctrlキーを足すのは推奨されません。

値：0か1

### \<HotKey\>
この建造物を生産するショートカットキーを定義します。

BtSでは、この属性を持つ建造物はありません。

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

### \<iHotKeyPriority\>
ショートカットキーの優先度を指定します。
ショートカットキーが被ってしまったとき、
ここに指定した値が大きいほうが優先されます。

例：
\<iHotKeyPriority\>0\</iHotKeyPriority\>

<br><br>
