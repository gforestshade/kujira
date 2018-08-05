+++
date = "2018-08-05T17:50:43+09:00"
title = "CIV4BonusInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4BonusInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Warlords(J)\Assets\XML\Terrain\CIV4BonusInfos.xml{{</path>}}

にあります。

## \<Civ4BonusInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4TerrainSchema.xml"`を指定します。

## \<BonusInfo\>
このタグ1つが、資源の定義1つと対応しています。

以下\<BonusInfo\>の中身です。

<!--more-->


### \<Type\>
この資源の資源キーを定義します。
他と被らなければなんでも構いませんが、BONUS\_英語名 にするのが無難です。

値：資源キー

例：
\<Type\>BONUS\_ALUMINUM\</Type\>

### \<Description\>
この資源の名前を指定します。

値：テキストキー

例：「アルミニウム」
\<Description\>TXT\_KEY\_BONUS\_ALUMINUM\</Description\>


### \<Civilopedia\>
この資源のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_BONUS\_ALUMINUM\_PEDIA\</Civilopedia\>


### \<BonusClassType\>
この資源がどの資源クラスに属しているか指定します。

値：資源クラスキー
以下のいずれか

|資源クラスキー|説明|例|
|:-:|:-:|:-:|
|BONUSCLASS_GRAIN|穀物資源|米・小麦・トウモロコシ|
|BONUSCLASS_LIVESTOCK|畜産資源|牛・羊・豚|
|BONUSCLASS_RUSH|戦略資源(初期)|銅・鉄・馬|
|BONUSCLASS_MODERN|戦略資源(後期)|石油・ウラン・アルミニウム|
|BONUSCLASS_WONDER|戦略資源(遺産)|石・大理石|
|BONUSCLASS_GENERAL|その他|その他すべて、迷ったらこれ|

例：
\<BonusClassType\>BONUSCLASS\_MODERN\</BonusClassType\>


### \<ArtDefineTag\>
資源のグラフィックを指定します。
キーの定義は \\XML\\Art\\CIV4ArtDefines_Bonus.xml にあります。

値：資源アートキー

例：
\<ArtDefineTag\>ART\_DEF\_BONUS\_ALUMINUM\</ArtDefineTag\>


### \<TechReveal\>
この資源を可視化する技術を指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：
\<TechReveal\>TECH\_INDUSTRIALISM\</TechReveal\>

### \<TechCityTrade\>
この資源を有効化する技術を指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：
\<TechCityTrade\>TECH\_MINING\</TechCityTrade\>

### \<TechObsolete\>
この資源が陳腐化する技術を指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：
\<TechObsolete\>NONE\</TechObsolete\>


### \<YieldChanges\>
この資源が直接産出する〈パン〉・〈ハンマー〉・〈コイン〉への加減値を指定します。
ここで指定する出力は、地形出力・改善出力に加えて常に算出します。

値は\<iYieldChange\>のリストで、上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYieldChange\>を1個や2個で止めることもできます。その場合、指定しなかった分は0とみなされます。

〈パン〉・〈ハンマー〉・〈コイン〉のいずれもこの資源からは直接産出しない場合、空タグにします。

各\<iYieldChange\>に負の値を指定することはできますが、
都市合計で負の値にならないように気を付けてください。

例１：
\<YieldChanges /\>

例２：+1〈ハンマー〉
``` txt
<YieldChanges>
    <iYieldChange>0</iYieldChange>
    <iYieldChange>1</iYieldChange>
    <iYieldChange>0</iYieldChange>
</YieldChanges>
```


### \<iAITradeModifier\>
AIの資源取引評価値に対して、この資源の評価値に修正を与えます。
AIはこのXMLに記述された資源の効果の大きさからできるだけ評価値を計算しようとしますが、
そこにさらに手動で修正を加えることができます。
BtSでは、この属性を持つ資源は アルミニウム(10)・銅(10)・鉄(10)・石油(20)・ウラン(30)です。

値：整数

例：
\<iAITradeModifier\>10\</iAITradeModifier\>


### \<iAIObjective\>
この資源に対する追加のAI優先度を指定します。
この値が高いほど、AIプレイヤーは
この資源を可視化する技術をより優先するようになり、
より優先して労働者がこの資源の改善に向かうようになり、
この資源の防衛により力を割くようになります。

BtSでは、この属性を持つ資源はありません。

値：整数

例：
\<iAIObjective\>0\</iAIObjective\>


### \<iHealth\>
この資源が産出する〈衛生〉を指定します。

ここに正の値を指定する場合、この資源が供給されている都市にその分だけ〈衛生〉が加算されます。
ここに負の値を指定する場合、この資源が供給されている都市にその分だけ〈不衛生〉が加算されます。
ここに0を指定する場合、どちらも発生しない資源になります。

値：整数

例：
\<iHealth\>0\</iHealth\>


### \<iHappiness\>
この資源が産出する〈幸福〉を指定します。

ここに正の値を指定する場合、この資源が供給されている都市にその分だけ〈幸福〉が加算されます。
ここに負の値を指定する場合、この資源が供給されている都市にその分だけ〈不満〉が加算されます。
ここに0を指定する場合、どちらも発生しない資源になります。

値：整数

例：
\<iHappiness\>0\</iHappiness\>


### \<iPlacementOrder\>
この資源をマップ配置する際の順番を指定します。

マップスクリプトは、まずこの値が0の資源を配置します。
次に、空いているマスの中に、この値が1の資源を配置します。
次に、まだ空いているマスの中に、この値が2の資源を配置します。

このようにして、すべての資源を配置するので、順番が後の資源は
マップ配置において少しだけ重要度が下がります。

値：整数

例：
\<iPlacementOrder\>2\</iPlacementOrder\>


### \<iConstAppearance\>
この資源のマップ出現率を指定します。
この値が高いほど、この資源はマップにたくさん配置されるようになります。

マップへの資源配置数は、以下の式によります。

**資源配置基礎値** = ( \[プレイヤー数\] * [\<iPlayer\>](#iplayer) / 100 ) + ( \[資源配置可能タイル数\] / [\<iTilesPer\>](#itilesper) )
**資源配置倍率** = \<iConstAppearance\> + \[乱数1\] + \[乱数2\] + \[乱数3\] + \[乱数4\]
(乱数1: 1 から [\<iRandApp1\>](#rands) までの乱数)
(乱数2: 1 から [\<iRandApp2\>](#rands) までの乱数)
(乱数3: 1 から [\<iRandApp3\>](#rands) までの乱数)
(乱数4: 1 から [\<iRandApp4\>](#rands) までの乱数)
**資源配置数** = \[資源配置基礎値\] * \[資源配置倍率\] / 100

値：整数

例：
\<iConstAppearance\>100\</iConstAppearance\>


### \<iMinAreaSize\>
この資源を配置するために必要な陸地のサイズを指定します。
この値未満の陸地しかない島には、この資源を配置できません。

陸地サイズの制限を設けない場合、-1を指定します。

値：整数

例：
\<iMinAreaSize\>3\</iMinAreaSize\>


### \<iMinLatitude\>
この資源を配置するために必要な最低緯度を指定します。
この値より赤道に近いマスには、この資源を配置できません。

最低緯度の制限を設けない場合、0を指定します。

値：整数

例：
\<iMinLatitude\>0\</iMinLatitude\>


### \<iMaxLatitude\>
この資源を配置するために必要な最高緯度を指定します。
この値より両極に近いマスには、この資源を配置できません。

最高緯度の制限を設けない場合、90を指定します。

値：整数

例：
\<iMaxLatitude\>90\</iMaxLatitude\>


### \<Rands\>
この資源のマップ出現率に加算される乱数を指定します。

値：\<iRandApp1\>～\<iRandApp4\>に値のリストを指定します。

例：
``` txt
<Rands>
    <iRandApp1>10</iRandApp1>
    <iRandApp2>10</iRandApp2>
    <iRandApp3>0</iRandApp3>
    <iRandApp4>0</iRandApp4>
</Rands>
```


### \<iPlayer\>
プレイヤー数による資源配置数への影響度を指定します。
プレイヤー1人あたりこの資源が(n/100)個追加で配置されます。

プレイヤー数による加算をしない場合は、0を指定します。

値：整数

例：
\<iPlayer\>100\</iPlayer\>


### \<iTilesPer\>
タイルによる資源配置数への影響度を指定します。
nタイルあたりこの資源が1つ追加で配置されます。

タイル数による加算をしない場合は、0を指定します。

値：整数

例：
\<iTilesPer\>0\</iTilesPer\>


### \<iMinLandPercent\>
この資源が陸上タイルに配置される割合を指定します。

この属性は陸上タイルと海上タイルの両方に配置可能な資源でのみ有効になります。
どちらかにのみ配置可能な資源の場合は、0を指定してください。

BtSでは、この属性を持つ資源は石油のみです。

値：整数

例：
\<iMinLandPercent\>0\</iMinLandPercent\>


### \<iUnique\>
この資源の最低配置間隔を指定します。
この資源が配置された周囲nマス以内には同じ資源が配置されなくなります。

BonusClassにも配置間隔を指定している場合は、長いほうが適用されます。
最低配置間隔をここでは指定しない場合、0を指定します。

値：整数

例：
\<iUnique\>0\</iUnique\>


### \<iGroupRange\>
この資源の連鎖配置範囲を指定します。
この資源が配置されるとき、周囲nマスにも同じ資源を配置しようとします。

値：整数

例：あとで

### \<iGroupRand\>
この資源の連鎖配置確率を指定します。
この資源を連鎖配置中、地形などほかの配置条件を満たしていれば、n%の確率で同じ資源が配置されます。

値：整数

例１：連鎖配置しない
\<iGroupRange\>0\</iGroupRange\>
\<iGroupRand\>0\</iGroupRand\>

例２：周囲1マスに50%の確率で連鎖配置する
\<iGroupRange\>1\</iGroupRange\>
\<iGroupRand\>50\</iGroupRand\>

### \<bArea\>
大陸固有の資源として指定します。
ここに1を指定すると、この資源は別大陸にまたがっての配置が禁止されます。

BtSでは、暦資源がこの属性を持ちます。

値：0か1

例：
\<bArea\>0\</bArea\>


### \<bHills\>
1なら、丘陵への配置を許可します。

値：0か1

例：
\<bHills\>1\</bHills\>


### \<bFlatlands\>
1なら、平地への配置を許可します。

値：0か1

例：
\<bFlatlands\>0\</bFlatlands\>

### \<bNoRiverSide\>
1なら、川沿いへの配置を***禁止***します。

値：0か1

例：
\<bNoRiverSide\>0\</bNoRiverSide\>

### \<bNormalize\>
1なら、首都補正のためにこの資源を追加配置することを許可します。

値：0か1

例：
\<bNormalize\>0\</bNormalize\>


### \<TerrainBooleans\>
この資源を配置可能な[基本地形]({{<ref "keyichiran">}}#基本地形)を指定します。
ここに指定されている基本地形を持つタイルであって、追加地形を持たないタイルであるとき、
この資源が配置可能になります。

値：\<TerrainBoolean\>のリスト

{{% div class="subnote" %}}

\<TerrainBoolean\>は以下の2つのタグを含みます。

#### \<TerrainType\>
配置を許可する基本地形を指定します。
値：[基本地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bTerrain\>
1を指定します。

{{% /div %}}

例：あとで


### \<FeatureBooleans\>
この資源を配置可能な[追加地形]({{<ref "keyichiran">}}#追加地形)を指定します。
[\<FeatureTerrainBooleans\>](#featureterrainbooleans)で指定する基本地形と
\<FeatureBooleans\>で指定する追加地形を同時に持つタイルであるとき、
この資源が配置可能になります。

値：\<FeatureBoolean\>のリスト

{{% div class="subnote" %}}

\<FeatureBoolean\>は以下の2つのタグを含みます。

#### \<FeatureType\>
配置を許可する追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<bFeature\>
1を指定します。

{{% /div %}}

例：あとで


### \<FeatureTerrainBooleans\>
この資源を配置可能な基本地形を指定します。
\<FeatureTerrainBooleans\>で指定する基本地形と
[\<FeatureBooleans\>](#featurebooleans)で指定する追加地形を同時に持つタイルであるとき、
この資源が配置可能になります。

値：\<FeatureTerrainBoolean\>のリスト

{{% div class="subnote" %}}

\<FeatureTerrainBoolean\>は以下の2つのタグを含みます。

#### \<TerrainType\>
配置を許可する基本地形を指定します。
値：[基本地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bFeatureTerrain\>
1を指定します。

{{% /div %}}


例１：(追加地形のない)平原か砂漠かツンドラに配置可能、追加地形のあるタイルには配置不可
``` txt
<TerrainBooleans>
    <TerrainBoolean>
        <TerrainType>TERRAIN_PLAINS</TerrainType>
        <bTerrain>1</bTerrain>
    </TerrainBoolean>
    <TerrainBoolean>
        <TerrainType>TERRAIN_DESERT</TerrainType>
        <bTerrain>1</bTerrain>
    </TerrainBoolean>
    <TerrainBoolean>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <bTerrain>1</bTerrain>
    </TerrainBoolean>
</TerrainBooleans>
<FeatureBooleans/>
<FeatureTerrainBooleans/>
```

---

例２：ジャングル/草原にのみ配置可能
``` txt
<TerrainBooleans/>
<FeatureBooleans>
    <FeatureBoolean>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <bFeature>1</bFeature>
    </FeatureBoolean>
</FeatureBooleans>
<FeatureTerrainBooleans>
    <FeatureTerrainBoolean>
        <TerrainType>TERRAIN_GRASS</TerrainType>
        <bFeatureTerrain>1</bFeatureTerrain>
    </FeatureTerrainBoolean>
</FeatureTerrainBooleans>
```

---

例３：ツンドラか氷土に配置可能、森林/ツンドラか森林/氷土にも配置可能
``` txt
<TerrainBooleans>
    <TerrainBoolean>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <bTerrain>1</bTerrain>
    </TerrainBoolean>
    <TerrainBoolean>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <bTerrain>1</bTerrain>
    </TerrainBoolean>
</TerrainBooleans>
<FeatureBooleans>
    <FeatureBoolean>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <bFeature>1</bFeature>
    </FeatureBoolean>
</FeatureBooleans>
<FeatureTerrainBooleans>
    <FeatureTerrainBoolean>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <bFeatureTerrain>1</bFeatureTerrain>
    </FeatureTerrainBoolean>
    <FeatureTerrainBoolean>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <bFeatureTerrain>1</bFeatureTerrain>
    </FeatureTerrainBoolean>
</FeatureTerrainBooleans>
```

<div style="padding:5em"></div>

