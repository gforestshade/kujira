+++
date = "2018-10-11T01:20:39+09:00"
title = "CIV4ImprovementInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4ImprovementInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Terrain\CIV4ImprovementInfos.xml{{</path>}}

にあります。

## \<Civ4ImprovementInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4TerrainSchema.xml"`を指定します。

## \<ImprovementInfo\>
このタグ1つが、地形改善の定義1つと対応しています。

以下\<ImprovementInfo\>の中身です。

<!--more-->

### MakesValid
地形改善の属性には、MakesValidとつくものがいくつかあります。
1が指定されているMakesValid属性のうち、いずれか一つの条件を満たしていれば、
ほかのMakesValid属性を満たしていなくてもタイルにこの地形改善を建設することができます。
逆にいえば、1が指定されているMakesValid属性のうちのいずれも満たさないタイルの上には
この地形改善を建設することができません。
地形改善を自作する場合は、少なくとも1つのMakesValid属性に1を指定してください。

用意されているMakesValid属性：
丘陵・きれいな水・川沿い・各基本地形・各追加地形

例：
小屋は、きれいな水・草原・平原のいずれかのあるタイルに建設可能
(したがって、きれいな水があればツンドラにも建設可能)
保安林は、森林・ジャングルのいずれかのあるタイルに建設可能
(したがって、森林かジャングルさえあれば雪原や丘陵にも建設可能)

### \<Type\>
この地形改善の地形改善キーを定義します。
他と被らなければなんでも構いませんが、IMPROVEMENT\_英語名 にするのが無難です。

値：地形改善キー

例：
\<Type\>IMPROVEMENT\_FARM\</Type\>

### \<Description\>
この地形改善の名前を指定します。

値：テキストキー

例：「農場」
\<Description\>TXT\_KEY\_IMPROVEMENT\_FARM\</Description\>


### \<Civilopedia\>
この地形改善のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_IMPROVEMENT\_FARM\_PEDIA\</Civilopedia\>

### \<ArtDefineTag\>
地形改善のグラフィックを指定します。
キーの定義は \\XML\\Art\\CIV4ArtDefines_Improvement.xml にあります。

値：地形改善アートキー

例：
\<ArtDefineTag\>ART\_DEF\_IMPROVEMENT\_FARM\</ArtDefineTag\>

### \<PrereqNatureYields\>
この地形改善を建設するために必要な〈パン〉・〈ハンマー〉・〈コイン〉を指定します。
この地形改善を建設するには、地形改善を建設する前の素の地形の状態でここに指定しただけの
〈パン〉・〈ハンマー〉・〈コイン〉を産出している必要があります。
この値に満たない場合、この地形改善は建設できません。

値は\<iYield\>のリストで、上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。その場合、指定しなかった分は0とみなされます。

地形の産出による制限を設けない場合、このタグ自体を省略します。

例：〈パン〉が1必要
``` txt
<PrereqNatureYields>
  <iYield>1</iYield>
  <iYield>0</iYield>
  <iYield>0</iYield>
</PrereqNatureYields>
```

### \<IrrigatedYieldChange\>
この地形改善の灌漑ボーナスを指定します。
この地形改善が[灌漑済みタイル]({{<ref "irrigation">}}#灌漑済み)であるならば、この地形改善はここに指定した分の
〈パン〉・〈ハンマー〉・〈コイン〉を追加で産出します。

値は\<iYield\>のリストで、上から順に〈パン〉、〈ハンマー〉、〈コイン〉を表します。
\<iYield\>を1個や2個で止めることもできます。その場合、指定しなかった分は0とみなされます。

灌漑からとくにボーナスを与えない地形改善の場合、このタグ自体を省略します。

例：灌漑から〈パン〉+1
``` txt
<IrrigatedYieldChange>
  <iYield>1</iYield>
  <iYield>0</iYield>
  <iYield>0</iYield>
</IrrigatedYieldChange>
```

### \<bActsAsCity\>
ここに1を指定した場合、この地形改善は交易路やユニットの面で都市と同等に扱われるようになります。

- 都市と同様に、直下の資源が交易路に接続されます
- 都市と同様に、陸上交易路と海上交易路をつなぎます
- 都市と同様に、都市攻撃ボーナスや都市防御ボーナスがつきます
- 都市と同様に、海洋ユニットが通行可能になります
- 都市と同様に、航空ユニットが駐留できます

BtSでは、この属性を持つ地形改善は要塞のみです。

値：0か1

例：
\<bActsAsCity\>0\</bActsAsCity\>

### \<bHillsMakesValid\>
この地形改善は丘陵タイルに建設可能になります。

[MakesValid](#makesvalid)と名前につく属性は互いに関連しています。

BtSでは、この属性を持つ地形改善は鉱山と風車です。

値：0か1

例：
\<bHillsMakesValid\>0\</bHillsMakesValid\>

### \<bFreshWaterMakesValid\>
この地形改善はきれいな水タイルに建設可能になります。

[MakesValid](#makesvalid)と名前につく属性は互いに関連しています。

BtSでは、この属性を持つ地形改善は農場・小屋・工房です。

値：0か1

例：
\<bFreshWaterMakesValid\>1\</bFreshWaterMakesValid\>

### \<bRiverSideMakesValid\>
この地形改善は川沿いタイルに建設可能になります。

[MakesValid](#makesvalid)と名前につく属性は互いに関連しています。

BtSでは、この属性を持つ地形改善は水車です。

値：0か1

例：
\<bRiverSideMakesValid\>0\</bRiverSideMakesValid\>

### \<bNoFreshWater\>
ここに1を指定した場合、この地形改善をきれいな水タイルに建設することができなくなります。

BtSでは、この属性を持つ地形改善はありません。

値：0か1

例：
\<bNoFreshWater\>0\</bNoFreshWater\>

### \<bRequiresFlatlands\>
ここに1を指定した場合、この地形改善は平地にのみ建設できます。

BtSでは、この属性を持つ地形改善は農場・水車・工房です。

値：0か1

例：
\<bRequiresFlatlands\>1\</bRequiresFlatlands\>

### \<bRequiresRiverSide\>
ここに1を指定した場合、この地形改善は川沿いにのみ建設できます。

BtSでは、この属性を持つ地形改善は水車のみです。

値：0か1

例：
\<bRequiresRiverSide\>0\</bRequiresRiverSide\>

### \<bRequiresIrrigation\>
ここに1を指定した場合、この地形改善は[灌漑済み]({{<ref "irrigation">}}#灌漑済み)タイルにのみ建設できます。

この属性は、文明が[\<bIgnoreIrrigation\>]({{<ref "civ4techinfos">}}#bignoreirrigation)の技術を取得するまで有効です。
技術取得以後は、この属性は無視されます。

BtSでは、この属性を持つ地形改善は農場のみです。

値：0か1

例：
\<bRequiresIrrigation\>1\</bRequiresIrrigation\>

### \<bCarriesIrrigation\>
ここに1を指定した場合、この地形改善のあるタイルは[灌漑通行可能]({{<ref "irrigation">}}#灌漑通行可能)になります。

この属性は、文明が[\<bIrrigation\>]({{<ref "civ4techinfos">}}#birrigation)の技術を取得してはじめて有効になります。
技術取得以前は、この属性は無視されます。

BtSでは、この属性を持つ地形改善は農場のみです。

値：0か1

例：
\<bCarriesIrrigation\>1\</bCarriesIrrigation\>

### \<bRequiresFeature\>
ここに1を指定した場合、この地形改善はなんらかの追加地形のあるタイルにのみ建設可能になります。

BtSでは、この属性を持つ地形改善は製材所・保安林です。

値：0か1

例：
\<bRequiresFeature\>0\</bRequiresFeature\>

### \<bWater\>
ここに1を指定した場合、この地形改善は水タイルにのみ建設可能になります。

BtSでは、この属性を持つ地形改善は漁船・捕鯨船・洋上プラットフォームです。

値：0か1

例：
\<bWater\>0\</bWater\>

### \<bGoody\>
ここに1を指定した場合、この地形改善は部族集落になります。
マップ生成時に自動配置されたり、ユニット進入時に報酬が抽選されたうえで自動破壊されたりなど、
内部動作が部族集落になります。
(当然ながら)BtSでは、この属性を持つ地形改善は部族集落のみです。

値：0か1

例：
\<bGoody\>0\</bGoody\>

### \<bPermanent\>
ここに1を指定した場合、この地形改善は破壊不能になります。

BtSでは、この属性を持つ地形改善はありません。

値：0か1

例：
\<bPermanent\>0\</bPermanent\>

### \<bUseLSystem\>

値：0か1

例：
\<bUseLSystem\>1\</bUseLSystem\>


### \<iAdvancedStartCost\>
先行スタートにおける購入金額を指定します。
-1を指定した場合、この地形改善は先行スタートで購入できません。

値：整数

例１：
\<iAdvancedStartCost\>-1\</iAdvancedStartCost\>

例２：先行スタート時、30Gで購入可能
\<iAdvancedStartCost\>30\</iAdvancedStartCost\>


### \<iAdvancedStartCostIncrease\>
先行スタートにおいて、地形改善は購入するごとに
ここに指定した割合で(単位：%)購入コストが増加していきます。

値：整数

例１：
\<iAdvancedStartCostIncrease\>0\</iAdvancedStartCostIncrease\>

例２：先行スタート時、1つ購入するごとに50%ずつ購入コスト増加
\<iAdvancedStartCostIncrease\>50\</iAdvancedStartCostIncrease\>


### \<iTilesPerGoody\>
自動配置の割合を設定します。
ここに正の値nを指定した場合、マップ生成時に、
陸タイルn個あたり1つの割合でこの地形改善が自動配置されます。

この機能を使わない場合、0を指定します。
BtSでは、この属性を持つ地形改善は部族集落のみです。

値：整数

例：
\<iTilesPerGoody\>0\</iTilesPerGoody\>

### \<iGoodyRange\>
自動配置の設置半径を設定します。
ここに正の値nを指定した場合、マップ生成時にこの地形改善が自動配置される際、
半径nタイル以内には同じ地形改善が配置されなくなります。

この機能を使わない場合、0を指定します。
BtSでは、この属性を持つ地形改善は部族集落のみです。

値：整数

例：
\<iGoodyRange\>0\</iGoodyRange\>

### \<iFeatureGrowth\>
追加地形の伝播確率を指定します。
ここに正の数nを指定した場合、毎ターンn/10000の確率で、
周囲1マスにある追加地形も地形改善もないマスに、
このマスにあるものと同じ追加地形を伝播させます。
追加地形そのものにも伝播確率が設定されている場合、
この属性はそれを上書きします。

この機能を使わない場合、0を指定します。
BtSでは、この属性を持つ地形改善は保安林のみです。

値：整数

例：
\<iFeatureGrowth\>0\</iFeatureGrowth\>

### \<iUpgradeTime\>
この地形改善が次の段階に成長するまでのターン数を指定します。
ここに正の値nを指定した場合、この地形改善に市民配置をしたままnターンが経過すると
次の段階の地形改善に成長するようになります。
ここで指定するのはターン数のみです。何に成長するかは[\<ImprovementUpgrade\>](#improvementupgrade)で指定します。

とくに成長しない地形改善の場合、0を指定します。

値：整数

例：
\<iUpgradeTime\>0\</iUpgradeTime\>

### \<iAirBombDefense\>
航空ユニットから戦略爆撃を受けた際の防御力を指定します。
この値が高いほど、戦略爆撃が失敗する確率が上がります。

戦略爆撃を全く受けない地形改善の場合、-1を指定します。
BtSでは、ほとんどの地形改善で5ですが、戦略資源を改善する鉱山や油井などは10、
要塞や保安林は20です。

値：整数

例：
\<iAirBombDefense\>5\</iAirBombDefense\>

### \<iDefenseModifier\>
防御ボーナスを指定します。
ここに正の値nを指定した場合、この地形改善の上にいる陸上ユニットは
+n%の防御ボーナスを得ます。

防御ボーナスを与えない普通の地形改善の場合、0を指定します。
BtSでは、この属性を持つ地形改善は要塞のみです。

値：整数

例：
\<iDefenseModifier\>0\</iDefenseModifier\>

### \<iHappiness\>
この地形改善が直接産出する〈幸福〉を指定します。
ここに正の値nを指定した場合、この地形改善を都市圏内に収めている都市は
改善1つにつき〈幸福〉+nを得ます。

〈幸福〉を算出しない普通の地形改善の場合、0を指定します。
BtSでは、この属性を持つ地形改善は保安林のみです。

値：整数

例：
\<iHappiness\>0\</iHappiness\>

### \<iPillageGold\>
この地形改善を略奪したときに得られる〈金銭〉の量を指定します。
ここに正の値nを指定した場合、この地形改善を略奪したとき、
0からnまでの抽選を2回行い、その2回の合計値だけ〈金銭〉を得ます。[^ave]

[^ave]: 結果として、おおむね平均的にはこの値の数と同じ程度の〈金銭〉を得ることになります。

略奪しても金銭を得られない地形改善の場合、0を指定します。

値：整数

例：
\<iPillageGold\>5\</iPillageGold\>

### \<bOutsideBorders\>
ここに1を指定した場合、この地形改善は文化圏内だけでなく、
文化圏外の誰の領土でもないタイルにも建設することができるようになります。

0ならば、通常通り文化圏内にしか作れない地形改善になります。

値：0か1

例：
\<bOutsideBorders\>0\</bOutsideBorders\>


### \<TerrainMakesValids\>
この地形改善が建設可能な基本地形を指定します。

値：\<TerrainMakesValid\>のリスト

{{% div class="subnote" %}}

\<TerrainMakesValid\>は以下の2つのタグを含みます。

#### \<TerrainType\>
建設可能にする基本地形を指定します。
値：[基本地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bMakesValid\>
1を指定します。

{{% /div %}}

[MakesValid](#makesvalid)と名前につく属性は互いに関連しています。
建設可能な基本地形を設定しない場合、空タグにします。

例１：
\<TerrainMakesValids /\>

例２：草原と平原に建設可能
``` txt
<TerrainMakesValids>
  <TerrainMakesValid>
    <TerrainType>TERRAIN_GRASS</TerrainType>
    <bMakesValid>1</bMakesValid>
  </TerrainMakesValid>
  <TerrainMakesValid>
    <TerrainType>TERRAIN_PLAINS</TerrainType>
    <bMakesValid>1</bMakesValid>
  </TerrainMakesValid>
</TerrainMakesValids>
```


### \<FeatureMakesValids\>
この地形改善が建設可能な追加地形を指定します。

値：\<FeatureMakesValid\>のリスト

{{% div class="subnote" %}}

\<FeatureMakesValid\>は以下の2つのタグを含みます。

#### \<FeatureType\>
建設可能にする追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<bMakesValid\>
1を指定します。

{{% /div %}}

[MakesValid](#makesvalid)と名前につく属性は互いに関連しています。
建設可能な追加地形を設定しない場合、空タグにします。

例１：
\<FeatureMakesValids /\>

例２：森林とジャングルに建設可能
``` txt
<FeatureMakesValids>
  <FeatureMakesValid>
    <FeatureType>FEATURE_FOREST</FeatureType>
    <bMakesValid>1</bMakesValid>
  </FeatureMakesValid>
  <FeatureMakesValid>
    <FeatureType>FEATURE_JUNGLE</FeatureType>
    <bMakesValid>1</bMakesValid>
  </FeatureMakesValid>
</FeatureMakesValids>
```

### \<BonusTypeStructs\>
この地形改善と資源に関する設定をします。

値：以下の5つのタグを含む\<BonusTypeStruct\>のリスト

{{% div class="subnote" %}}
#### \<BonusType\>
資源を指定します。
値：[資源キー]({{<ref "keyichiran">}}#資源)

#### \<bBonusMakesValid\>
ここに1を指定することにより、他の地形に関する制約を無視して
資源上に地形改善を建設することができるようになります。
値：0か1

#### \<bBonusTrade\>
ここに1を指定することにより、この地形改善は資源を交易路に接続します。
河川や道、近海などにより都市まで交易路を接続することで、
都市はこの資源を利用可能になります。
値：0か1

#### \<iDiscoverRand\>
ここに正の数nを指定すると、この地形改善のあるタイル上に
毎ターン1/nの確率でこの資源を発見するようになります。
0を指定でこの機能を利用しません。
値：整数

#### \<YieldChanges\>
資源上にこの地形改善を建設したときに受け取る追加のボーナスを指定します。
値：\<iYield\>のリスト、上から〈パン〉・〈ハンマー〉・〈コイン〉

{{% /div %}}

例：トウモロコシを改善可能、+2〈パン〉
``` txt
<BonusTypeStruct>
  <BonusType>BONUS_CORN</BonusType>
  <bBonusMakesValid>1</bBonusMakesValid>
  <bBonusTrade>1</bBonusTrade>
  <iDiscoverRand>0</iDiscoverRand>
  <YieldChanges>
    <iYieldChange>2</iYieldChange>
    <iYieldChange>0</iYieldChange>
    <iYieldChange>0</iYieldChange>
  </YieldChanges>
</BonusTypeStruct>
```

### \<ImprovementPillage\>
この地形改善を略奪したときの変化を指定します。
ここに地形改善キーを指定した場合、略奪によってその地形改善に変化します。[^pillage]
ここを空タグにした場合、略奪されると改善は完全に破壊されます。

[^pillage]: たいていの場合「村→小屋」など成長前の改善を指定しますが、違うものを指定しても構いません。

値：[地形改善キー]({{<ref "keyichiran">}}#地形改善)

例１：
\<ImprovementPillage /\>

例２：略奪によって小屋に変化
\<ImprovementPillage\>IMPROVEMENT\_COTTAGE\</ImprovementPillage\>

### \<ImprovementUpgrade\>
この地形改善が成長する先を指定します。
ここに地形改善キーを指定した場合、市民配置したまま一定ターンが経過すると指定した地形改善に変化します。
ここで指定するのは次の改善の種類だけです。
成長するのにかかるターン数は[\<iUpgradeTime\>](#iupgradetime)で指定します。

とくに成長しない普通の地形改善の場合、空タグにします。

値：[地形改善キー]({{<ref "keyichiran">}}#地形改善)

例１：
\<ImprovementUpgrade /\>

例２：村に成長する
\<ImprovementUpgrade\>IMPROVEMENT\_VILLAGE\</ImprovementUpgrade\>

### \<TechYieldChanges\>
技術取得によって変化する〈パン〉・〈ハンマー〉・〈コイン〉を指定します。

とくに技術から追加の産出を得ない地形改善の場合、空タグにします。

値：\<TechYieldChange\>のリスト

{{% div class="subnote" %}}

\<TechYieldChange\>は以下の2つのタグを含みます。

#### \<PrereqTech\>
技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

#### \<TechYields\>
その技術を取得することにより、この地形改善に追加される産出量を指定します。
値：\<iYield\>のリスト　上から〈パン〉・〈ハンマー〉・〈コイン〉

{{% /div %}}

例１：
\<TechYieldChanges /\>

例２：生物学から+1〈パン〉
``` txt
<TechYieldChanges>
  <TechYieldChange>
    <PrereqTech>TECH_BIOLOGY</PrereqTech>
    <TechYields>
      <iYield>1</iYield>
      <iYield>0</iYield>
      <iYield>0</iYield>
    </TechYields>
  </TechYieldChange>
</TechYieldChanges>
```

例３：共通規格から+1〈ハンマー〉・電気から+2〈コイン〉
``` txt
<TechYieldChanges>
  <TechYieldChange>
    <PrereqTech>TECH_REPLACEABLE_PARTS</PrereqTech>
    <TechYields>
      <iYield>0</iYield>
      <iYield>1</iYield>
      <iYield>0</iYield>
    </TechYields>
  </TechYieldChange>
  <TechYieldChange>
    <PrereqTech>TECH_ELECTRICITY</PrereqTech>
    <TechYields>
      <iYield>0</iYield>
      <iYield>0</iYield>
      <iYield>2</iYield>
    </TechYields>
  </TechYieldChange>
</TechYieldChanges>
```

### \<RouteYieldChanges\>
道や鉄道によって変化する〈パン〉・〈ハンマー〉・〈コイン〉を指定します。

とくに道から追加の産出を得ない地形改善の場合、空タグにします。

値：\<RouteYieldChange\>のリスト

{{% div class="subnote" %}}

\<RouteYieldChange\>は以下の2つのタグを含みます。

#### \<RouteType\>
道の種類を指定します。
値：[道キー]({{<ref "keyichiran">}}#道)

#### \<RouteYields\>
その種類の道が同じタイルに施設されている場合に、この地形改善に追加される産出量を指定します。
値：\<iYield\>のリスト　上から〈パン〉・〈ハンマー〉・〈コイン〉

{{% /div %}}


例１：
\<RouteYieldChanges /\>

例２：鉄道から+1〈ハンマー〉
``` txt
<RouteYieldChanges>
  <RouteYieldChange>
    <RouteType>ROUTE_RAILROAD</RouteType>
    <RouteYields>
      <iYield>0</iYield>
      <iYield>1</iYield>
      <iYield>0</iYield>
    </RouteYields>
  </RouteYieldChange>
</RouteYieldChanges>
```

<div style="padding:5em"></div>
