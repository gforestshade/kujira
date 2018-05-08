+++
date = "2018-05-05T17:56:30+09:00"
title = "Civ4CivilizationInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
+++

# はじめに
Civ4CivilizationInfos.xmlの各項目について説明しています。

## \<Civ4CivilizationInfos\>
ルートタグです。名前空間として、`"x-schema:CIV4CivilizationsSchema.xml"`を指定します。

## \<CivilizationInfo\>
このタグ1つが、文明の定義1つと対応しています。

以下\<CivilizationInfo\>の中身です。

<!--more-->

### \<Type\>
この文明の文明キーを定義します。
他と被らなければなんでも構いませんが、CIVILIZATION\_英語名 にするのが無難です。

値：文明キー

例：
\<Type\>CIVILIZATION\_JAPAN\</Type\>

### \<Description\>
この文明の正式名称を指定します。

値：テキストキー

例：(日)「日本」 (英)"Japanese Empire"
\<Description\>TXT\_KEY\_CIV\_JAPAN\_DESC\</Description\>

### \<ShortDescription\>
この文明の略称を指定します。
こちらの方がゲーム中ではよく使われます。こちらを基準にするのがよいでしょう。
とはいえ、BtS日本語版では正式名称と略称はあまり区別されていません。
多くの文明で２つとも同じにされていますので、そうするのもよいでしょう。

値：テキストキー

例：(日)「日本」 (英)"Japan"
\<ShortDescription\>TXT\_KEY\_CIV\_JAPAN\_SHORT\_DESC\</ShortDescription\>

### \<Adjective\>
この文明の名称の形容詞形を指定します。
"Japan"と"Japanese"の違いを吸収するために項目が分けられているのですが、
日本語にはその区別が必要ないため、適当でもOKです。

値：テキストキー

例：(日)「日本」 (英)"Japanese"
\<Adjective\>TXT\_KEY\_CIV\_JAPAN\_ADJECTIVE\</Adjective\>

### \<Civilopedia\>
この文明のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_CIV\_JAPAN\_PEDIA\</Civilopedia\>

### \<DefaultPlayerColor\>
文明のテーマ色を指定します。
文化圏の境界・旗の色・スコア表示などに使用されます。

キーの定義は \\Assets\\XML\\Interface\\CIV4PlayerColorInfos.xml にあります。
プライマリカラー・セカンダリカラー・テキストカラーがキーで指定されています。

値：色キー

例：
\<DefaultPlayerColor\>PLAYERCOLOR\_RED\</DefaultPlayerColor\>

### \<ArtDefineTag\>
文明のグラフィックを指定します。

キーの定義は \\Assets\\XML\\Art\\CIV4ArtDefines_Civilization.xml にあります。
旗の模様とボタンがキーで指定されています。

値：文明アートキー

例：
\<ArtDefineTag\>ART\_DEF\_CIVILIZATION\_JAPAN\</ArtDefineTag\>

### \<ArtStyleType\>
この文明が使用する、改善・都市などのマップグラフィックの雰囲気を指定します。

値：次のいずれか
`ARTSTYLE_EUROPEAN`
`ARTSTYLE_ASIAN`
`ARTSTYLE_SOUTH_AMERICA`
`ARTSTYLE_MIDDLE_EAST`
`ARTSTYLE_GRECO_ROMAN`
`ARTSTYLE_BARBARIAN`

例：
\<ArtStyleType\>ARTSTYLE\_ASIAN\</ArtStyleType\>

### \<UnitArtStyleType\>
この文明が使用する、ユニットグラフィックの雰囲気を指定します。
太古や古代のユニットは、同じ種類でも地域ごとに見た目が違います。
この文明はそのうちのどれを採用するかをここで指定します。

値：次のいずれか
`UNIT_ARTSTYLE_EUROPEAN`
`UNIT_ARTSTYLE_ASIAN`
`UNIT_ARTSTYLE_SOUTH_AMERICA`
`UNIT_ARTSTYLE_MIDDLE_EAST`
`UNIT_ARTSTYLE_GRECO_ROMAN`

例：
\<UnitArtStyleType\>UNIT\_ARTSTYLE\_ASIAN\</UnitArtStyleType\>

### \<bPlayable\>
ここに1を指定する場合、人間プレイヤーはこの文明をプレイ可能になります。
0にすると、人間プレイヤーはこの文明ではプレイできなくなります。[^customgame]

[^customgame]: カスタムゲームで指導者を直接指定する場合、その限りではありません。

値：0か1

例：
\<bPlayable\>1\</bPlayable\>

### \<bAIPlayable\>
ここに1を指定する場合、AIプレイヤーはこの文明をプレイ可能になります。
0にすると、AIプレイヤーはこの文明ではプレイできなくなります。[^customgame]

値：0か1

例：
\<bAIPlayable\>1\</bAIPlayable\>

### \<Cities\>
この文明のデフォルトの都市名を指定します。
リストの上から使用されます。

値：テキストキーのリスト

例：
``` txt
<Cities>
    <City>TXT_KEY_CITY_NAME_KYOTO</City>
    <City>TXT_KEY_CITY_NAME_OSAKA</City>
    <City>TXT_KEY_CITY_NAME_TOKYO</City>
    <City>TXT_KEY_CITY_NAME_SATSUMA</City>
    <City>TXT_KEY_CITY_NAME_KAGOSHIMA</City>
    <City>TXT_KEY_CITY_NAME_NARA</City>
    <City>TXT_KEY_CITY_NAME_NAGOYA</City>
    <City>TXT_KEY_CITY_NAME_IZUMO</City>
    <City>TXT_KEY_CITY_NAME_NAGASAKI</City>
    <City>TXT_KEY_CITY_NAME_YOKOHAMA</City>
    <City>TXT_KEY_CITY_NAME_SHIMONOSEKI</City>
    <City>TXT_KEY_CITY_NAME_MATSUYAMA</City>
    <City>TXT_KEY_CITY_NAME_SAPPORO</City>
    <City>TXT_KEY_CITY_NAME_HAKODATE</City>
    <City>TXT_KEY_CITY_NAME_ISE</City>
    <City>TXT_KEY_CITY_NAME_TOYAMA</City>
    <City>TXT_KEY_CITY_NAME_FUKUSHIMA</City>
    <City>TXT_KEY_CITY_NAME_SUO</City>
    <City>TXT_KEY_CITY_NAME_BIZEN</City>
    <City>TXT_KEY_CITY_NAME_ECHIZEN</City>
    <City>TXT_KEY_CITY_NAME_IZUMI</City>
    <City>TXT_KEY_CITY_NAME_OMI</City>
    <City>TXT_KEY_CITY_NAME_ECHIGO</City>
    <City>TXT_KEY_CITY_NAME_KOZUKE</City>
    <City>TXT_KEY_CITY_NAME_SADO</City>
    <City>TXT_KEY_CITY_NAME_KOBE</City>
    <City>TXT_KEY_CITY_NAME_NAGANO</City>
    <City>TXT_KEY_CITY_NAME_HIROSHIMA</City>
    <City>TXT_KEY_CITY_NAME_TAKAYAMA</City>
    <City>TXT_KEY_CITY_NAME_AKITA</City>
    <City>TXT_KEY_CITY_NAME_FUKUOKA</City>
    <City>TXT_KEY_CITY_NAME_AOMORI</City>
    <City>TXT_KEY_CITY_NAME_KAMAKURO</City>
    <City>TXT_KEY_CITY_NAME_KOCHI</City>
    <City>TXT_KEY_CITY_NAME_NAHA</City>
</Cities>
```

### \<Buildings\>
この文明のUBを指定します。
この文明でプレイしている間、指定した各建造物クラスについて、
デフォルトの建造物に分岐するのではなく、指定した建造物に分岐するようにできます。
クラスの仕組みについては[こちら]({{<ref "civ4unitclassinfos">}})も参照してください。
建造物を自作する場合は、[親クラス]({{<ref "civ4buildinginfos">}}#buildingclass)を一致させるのを忘れないようにしましょう。

値：\<Building\>のリスト

{{% div class="subnote" %}}

\<Building\>は以下の2つのタグを含みます。

#### \<BuildingClassType\>
分岐させる建造物クラスを指定します。
値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

#### \<BuildingType\>
分岐先の建造物を指定します。
値：[建造物キー]({{<ref "keyichiran">}}#建造物)

{{% /div %}}

例１：UBなし
\<Buildings /\>

例２：火力発電所のUBとしてシェール油精製施設
``` txt
<Buildings>
    <Building>
        <BuildingClassType>BUILDINGCLASS_COAL_PLANT</BuildingClassType>
        <BuildingType>BUILDING_JAPANESE_SHALE_PLANT</BuildingType>
    </Building>
</Buildings>
```

例３：マドラッサと書院と研究施設
``` txt
<Buildings>
    <Building>
        <BuildingClassType>BUILDINGCLASS_LIBRARY</BuildingClassType>
        <BuildingType>BUILDING_ARABIAN_MADRASSA</BuildingType>
    </Building>
    <Building>
        <BuildingClassType>BUILDINGCLASS_UNIVERSITY</BuildingClassType>
        <BuildingType>BUILDING_KOREAN_SEOWON</BuildingType>
    </Building>
    <Building>
        <BuildingClassType>BUILDINGCLASS_LABORATORY</BuildingClassType>
        <BuildingType>BUILDING_RUSSIAN_RESEARCH_INSTITUTE</BuildingType>
    </Building>
</Buildings>
```

### \<Units\>
この文明のUUを指定します。
この文明でプレイしている間、指定した各ユニットクラスについて、
デフォルトのユニット種に分岐するのではなく、指定したユニット種に分岐するようにできます。
クラスの仕組みについては[こちら]({{<ref "civ4unitclassinfos">}})も参照してください。
ユニット種を自作する場合は、[親クラス]({{<ref "civ4unitinfos">}}#class)を一致させるのを忘れないようにしましょう。

値：\<Unit\>のリスト

{{% div class="subnote" %}}

\<Unit\>は以下の2つのタグを含みます。

#### \<UnitClassType\>
分岐させるユニットクラスを指定します。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<UnitType\>
分岐先のユニット種を指定します。
値：[ユニットキー]({{<ref "keyichiran">}}#ユニット)

{{% /div %}}

例１：UUなし
\<Units /\>

例２：鎚鉾兵のUUとして侍
``` txt
<Units>
    <Unit>
        <UnitClassType>UNITCLASS_MACEMAN</UnitClassType>
        <UnitType>UNIT_JAPAN_SAMURAI</UnitType>
    </Unit>
</Units>
```

例３：ガリア戦士と侍とシールズ
``` txt
<Units>
    <Unit>
        <UnitClassType>UNITCLASS_SWORDSMAN</UnitClassType>
        <UnitType>UNIT_CELTIC_GALLIC_WARRIOR</UnitType>
    </Unit>
    <Unit>
        <UnitClassType>UNITCLASS_MACEMAN</UnitClassType>
        <UnitType>UNIT_JAPAN_SAMURAI</UnitType>
    </Unit>
    <Unit>
        <UnitClassType>UNITCLASS_MARINE</UnitClassType>
        <UnitType>UNIT_AMERICAN_NAVY_SEAL</UnitType>
    </Unit>
</Units>
```

### \<FreeUnitClasses\>
この文明の初期ユニットのうち、開拓者にあたる種類を指定します。
実際の初期ユニット数は、スタートする時代や、難易度による影響を受けます。

値：\<FreeUnitClass\>のリスト

{{% div class="subnote" %}}

\<FreeUnitClass\>は以下の2つのタグを含みます。

#### \<UnitClassType\>
初期ユニットにするユニットクラスを指定します。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<iFreeUnits\>
初期ユニットとして配置する数を指定します。
値：正の整数

{{% /div %}}

例：開拓者を1体
``` txt
<FreeUnitClasses>
    <FreeUnitClass>
        <UnitClassType>UNITCLASS_SETTLER</UnitClassType>
        <iFreeUnits>1</iFreeUnits>
    </FreeUnitClass>
</FreeUnitClasses>
```

### \<FreeBuildingClasses\>
この文明が最初に都市を建造したときに与えられる無償の建造物を指定します。

値：\<FreeBuildingClass\>のリスト

{{% div class="subnote" %}}

\<FreeBuildingClass\>は以下の2つのタグを含みます。

#### \<BuildingClassType\>
初期建造物にする建造物クラスを指定します。
値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

#### \<bFreeBuildingClass\>
1を指定します。

{{% /div %}}

例：宮殿
``` txt
<FreeBuildingClasses>
    <FreeBuildingClass>
        <BuildingClassType>BUILDINGCLASS_PALACE</BuildingClassType>
        <bFreeBuildingClass>1</bFreeBuildingClass>
    </FreeBuildingClass>
</FreeBuildingClasses>
```

### \<FreeTechs\>
この文明の初期技術を指定します。
実際の初期技術は難易度の影響を受けます。

値：\<FreeTech\>のリスト

{{% div class="subnote" %}}

\<FreeTech\>は以下の2つのタグを含みます。

#### \<TechType\>
初期技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

#### \<bFreeTech\>
1を指定します。

{{% /div %}}

例：漁業・車輪
``` txt
<FreeTechs>
    <FreeTech>
        <TechType>TECH_FISHING</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_THE_WHEEL</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
</FreeTechs>
```

### \<DisableTechs\>
この文明が取得できない技術を指定します。

他の技術の前提になっている技術を指定すると、
その先のツリーも研究できなくなくなることに注意してください。[^cantresearch]

[^cantresearch]: とくに、研究できる技術がない状況を作れてしまうと、誤動作を起こす原因となります。

値：\<DisableTech\>のリスト

{{% div class="subnote" %}}

\<DisableTech\>は以下の2つのタグを含みます。

#### \<TechType\>
取得を禁止する技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

#### \<bDisableTech\>
1を指定します。

{{% /div %}}

例１：制限なし
\<DisableTechs /\>

例２：筆記取得禁止
``` txt
<DisableTechs>
    <DisableTech>
        <TechType>TECH_WRITING</TechType>
        <bDisableTech>1</bDisableTech>
    </DisableTech>
</DisableTechs>
```

### \<InitialCivics\>
この文明がゲーム開始時に採用している社会制度を指定します。

値：[社会制度キー]({{<ref "keyichiran">}}#社会制度)のリスト
　　上から、政治体制・法制度・労働制度・経済制度・宗教制度です。

``` txt
<InitialCivics>
    <CivicType>CIVIC_DESPOTISM</CivicType>
    <CivicType>CIVIC_BARBARISM</CivicType>
    <CivicType>CIVIC_TRIBALISM</CivicType>
    <CivicType>CIVIC_DECENTRALIZATION</CivicType>
    <CivicType>CIVIC_PAGANISM</CivicType>
</InitialCivics>
```

### \<Leaders\>
この文明に所属する指導者を指定します。
他の文明にすでに属している指導者であっても、重複して指定することは可能です。

値：\<Leader\>のリスト

{{% div class="subnote" %}}

\<Leader\>は以下の2つのタグを含みます。

#### \<LeaderName\>
指導者を指定します。
値：[指導者キー]({{<ref "keyichiran">}}#指導者)

#### \<bLeaderAvailability\>
1を指定します。

{{% /div %}}

例１：徳川家康を指導者として指定する
``` txt
<Leaders>
    <Leader>
        <LeaderName>LEADER_TOKUGAWA</LeaderName>
        <bLeaderAvailability>1</bLeaderAvailability>
    </Leader>
</Leaders>
```

例２：ワシントンとルーズベルトとリンカーン
``` txt
<Leaders>
    <Leader>
        <LeaderName>LEADER_WASHINGTON</LeaderName>
        <bLeaderAvailability>1</bLeaderAvailability>
    </Leader>
    <Leader>
        <LeaderName>LEADER_FRANKLIN_ROOSEVELT</LeaderName>
        <bLeaderAvailability>1</bLeaderAvailability>
    </Leader>
    <Leader>
        <LeaderName>LEADER_LINCOLN</LeaderName>
        <bLeaderAvailability>1</bLeaderAvailability>
    </Leader>
</Leaders>
```

### \<DerivativeCiv\>
この文明から植民地が独立するとき、優先して現れる文明を指定します。
この文明から独立する文明を選定するとき、ここに指定した文明を可能な限り優先しようとしますが、
すでに星に存在しているなどの理由からできない場合は、ランダムに文明を選択します。

値：[文明キー]({{<ref "keyichiran">}}#文明)

例：
\<DerivativeCiv\>CIVILIZATION\_KOREA\</DerivativeCiv\>

### \<CivilizationSelectionSound\>
ユニットを選択したときの効果音を指定します。

値：3Dサウンドスクリプトキー

\<CivilizationSelectionSound\>AS3D\_JAPAN\_SELECT\</CivilizationSelectionSound\>

### \<CivilizationActionSound\>
ユニットに命令したときの効果音を指定します。

値：3Dサウンドスクリプトキー

\<CivilizationActionSound\>AS3D\_JAPAN\_ORDER\</CivilizationActionSound\>

<div style="height:6em"></div>
