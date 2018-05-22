+++
date = "2018-05-16T01:16:00+09:00"
title = "Civ4CivicInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
Civ4CivicInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\GameInfo\CIV4CivicInfos.xml{{</path>}}

にあります。


# 間違えやすい設定項目
- 指導者の好む社会制度の設定は、各指導者のところにあります。

# 解説
## \<Civ4CivicInfos\>
ルートタグです。名前空間として、`"x-schema:CIV4GameInfoSchema.xml"`を指定します。

## \<CivicInfo\>
このタグ1つが、社会制度の定義1つと対応しています。

以下\<CivicInfo\>の中身です。

<!--more-->

### \<CivicOptionType\>
この社会制度が属する体制を指定します。

値：[体制キー]({{<ref "keyichiran">}}#社会制度)

例：
\<CivicOptionType\>CIVICOPTION\_GOVERNMENT\</CivicOptionType\>

### \<Type\>
この社会制度の社会制度キーを定義します。
他と被らなければなんでも構いませんが、CIVIC\_英語名 にするのが無難です。

値：社会制度キー

例：
\<Type\>CIVIC\_UNIVERSAL\_SUFFRAGE\</Type\>

### \<Description\>
この社会制度の名称を指定します。

値：テキストキー

例：「普通選挙」
\<Description\>TXT\_KEY\_CIVIC\_UNIVERSAL\_SUFFRAGE\</Description\>

### \<Civilopedia\>
この文明のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_CIVIC\_UNIVERSAL\_SUFFRAGE\_PEDIA\</Civilopedia\>

### \<Strategy\>
この社会制度の短い説明文を指定します。
シドのヒントやシヴィロペディアに表示されます。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_CIVIC\_UNIVERSAL\_SUFFRAGE\_STRATEGY\</Strategy\>

### \<Button\>
この社会制度を表すボタン画像のファイル名を指定します。
外交担当相や外交画面に表示されます。

値：\\Assets\\ からの相対ファイルパス

例：
\<Button\>,Art/Interface/Buttons/Civics/Universal\_Sufferage.dds,Art/Interface/Buttons/Civics\_Civilizations\_Religions\_Atlas.dds,8,3\</Button\>

### \<TechPrereq\>
この社会制度を採用するために必要な技術を指定します。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例：
\<TechPrereq\>TECH\_DEMOCRACY\</TechPrereq\>

### \<iAnarchyLength\>
この社会制度に変更するときの変更コストを指定します。
この値が高いほど、***他の制度からこの制度に***変更するときの無政府状態が長くなります。

BtSでは、全ての社会制度で`1`です。

値：正の整数

例：
\<iAnarchyLength\>1\</iAnarchyLength\>

### \<Upkeep\>
社会制度の維持維持費を指定します。

値：次のいずれか
<p class="ml-4" markdown="1">なし：`NONE`
低額：`UPKEEP_LOW`
中程度：`UPKEEP_MEDIUM`
高額：`UPKEEP_HIGH`</p>

例：
\<Upkeep\>UPKEEP\_MEDIUM\</Upkeep\>

### \<iAIWeight\>
AIの社会制度評価値に対して、この社会制度の評価値に修正を与えます。
正負どちらの値も指定でき、この社会制度に対する評価値が一律その分だけ加算されます。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iAIWeight\>0\</iAIWeight\>

### \<iGreatPeopleRateModifier\>
全都市の偉人ポイントへの修正率を指定します。
この社会制度を採用している文明では偉人ポイントの産出が+n%されます。
負の値も指定できます。

特に偉人ポイントを割合で増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iGreatPeopleRateModifier\>0\</iGreatPeopleRateModifier\>

### \<iGreatGeneralRateModifier\>
大将軍ポイントへの修正率を指定します。
この社会制度を採用している文明では、
全ての戦闘において大将軍ポイントの産出が+n%されます。
負の値も指定できます。

特に大将軍ポイントを割合で増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iGreatGeneralRateModifier\>0\</iGreatGeneralRateModifier\>

### \<iDomesticGreatGeneralRateModifier\>
文化圏内の大将軍ポイントへの修正率を指定します。
この社会制度を採用している文明では、
自文化圏内で行われた戦闘において大将軍ポイントの産出が+n%されます。
負の値も指定できます。

特に大将軍ポイントを割合で増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iDomesticGreatGeneralRateModifier\>0\</iDomesticGreatGeneralRateModifier\>

### \<iStateReligionGreatPeopleRateModifier\>
国教が布教されている都市への偉人ポイント修正率を指定します。
この社会制度を採用している文明で、国教と同じ宗教が布教されている都市では、
偉人ポイントの産出が+n%されます。
負の値も指定できます。

特に偉人ポイントを割合で増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は平和主義です。

値：整数

例１：
\<iStateReligionGreatPeopleRateModifier\>0\</iStateReligionGreatPeopleRateModifier\>

例２：国教をもつ都市で偉人の出生率+100%
\<iStateReligionGreatPeopleRateModifier\>100\</iStateReligionGreatPeopleRateModifier\>

### \<iDistanceMaintenanceModifier\>
都市維持費のうち、距離由来の部分に対する修正率を指定します。
この社会制度を採用している文明では、距離による都市維持費が+n%されます。

とくに維持費を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は国有化です。

値：整数

例１：
\<iDistanceMaintenanceModifier\>0\</iDistanceMaintenanceModifier\>

例２：地方維持費なし
\<iDistanceMaintenanceModifier\>-100\</iDistanceMaintenanceModifier\>

### \<iNumCitiesMaintenanceModifier\>
都市維持費のうち、都市数由来の部分に対する修正率を指定します。
この社会制度を採用している文明では、都市数による都市維持費が+n%されます。

とくに維持費を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iNumCitiesMaintenanceModifier\>0\</iNumCitiesMaintenanceModifier\>

### \<iCorporationMaintenanceModifier\>
都市維持費のうち、企業由来の部分に対する修正率を指定します。
この社会制度を採用している文明では、企業による都市維持費が+n%されます。

とくに維持費を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は自由市場です。

値：整数

例１：
\<iCorporationMaintenanceModifier\>0\</iCorporationMaintenanceModifier\>

例２：企業の維持費-25%
\<iCorporationMaintenanceModifier\>-25\</iCorporationMaintenanceModifier\>

### \<iExtraHealth\>
全都市に追加する衛生/不衛生を指定します。
この社会制度を採用している文明では、全都市で〈衛生〉が+nされます。

負の値を指定することもでき、その場合は〈不衛生〉が加算されます。
とくに〈衛生〉も〈不衛生〉も増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は環境保護主義です。

値：整数

例１：
\<iExtraHealth\>0\</iExtraHealth\>

例２：全ての都市で〈衛生〉+6
\<iExtraHealth\>6\</iExtraHealth\>

### \<iFreeExperience\>
追加の経験値を指定します。
この社会制度を採用している文明で生産されるユニットは、
ここに指定された分の経験値を追加で得ます。

とくに経験値を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は主従制のみです。

値：整数

例１：
\<iFreeExperience\>0\</iFreeExperience\>

例２：新ユニットが経験値+2ポイントを取得
\<iFreeExperience\>2\</iFreeExperience\>

### \<iWorkerSpeedModifier\>
労働効率の修正率を指定します。
この社会制度を採用している間、労働者系のコマンドが+n%早く完了します。

とくに労働効率を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は農奴制です。

値：整数

例１：
\<iWorkerSpeedModifier\>0\</iWorkerSpeedModifier\>

例２：労働者の作業速度+50%
\<iWorkerSpeedModifier\>50\</iWorkerSpeedModifier\>

### \<iImprovementUpgradeRateModifier\>
地形改善の成長率に対する修正率を指定します。
この社会制度を採用している間、すべての成長する地形改善は+n%早く成長します。
すべての成長する地形改善が対象であり、改善ごとに異なる成長率を
設定することはできないことに注意してください。

とくに改善の成長を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は奴隷解放です。

値：整数

例１：
\<iImprovementUpgradeRateModifier\>0\</iImprovementUpgradeRateModifier\>

例２：成長率増加+100%
\<iImprovementUpgradeRateModifier\>100\</iImprovementUpgradeRateModifier\>

### \<iMilitaryProductionModifier\>
[軍事ユニット]({{<ref "civ4unitinfos">}}#bmilitaryproduction)を生産するときの〈ハンマー〉に対する修正率を指定します。

とくに軍事ユニット生産に修正を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は警察国家のみです。

値：整数

例１：
\<iMilitaryProductionModifier\>0\</iMilitaryProductionModifier\>

例２：軍事ユニット生産+25%
\<iMilitaryProductionModifier\>25\</iMilitaryProductionModifier\>

### \<iBaseFreeUnits\>
追加のユニット無料枠(加算分)を指定します。
この値が高いほど、ユニット維持費が安くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくにユニット無料枠を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は主従制です。

値：整数

例：
\<iBaseFreeUnits\>0\</iBaseFreeUnits\>

### \<iBaseFreeMilitaryUnits\>
追加の軍事ユニット無料枠(加算分)を指定します。
この値が高いほど、ユニット維持費が安くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくに軍事ユニット無料枠を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iBaseFreeMilitaryUnits\>0\</iBaseFreeMilitaryUnits\>

### \<iFreeUnitsPopulationPercent\>
ユニット無料枠の人口係数を指定します。
この値が高いほど、大国においてユニット維持費が安くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくにユニット無料枠を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は主従制です。

値：整数

例：
\<iFreeUnitsPopulationPercent\>0\</iFreeUnitsPopulationPercent\>

### \<iFreeMilitaryUnitsPopulationPercent\>
軍事ユニット無料枠の人口係数を指定します。
この値が高いほど、大国においてユニット維持費が安くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくに軍事ユニット無料枠を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iFreeMilitaryUnitsPopulationPercent\>0\</iFreeMilitaryUnitsPopulationPercent\>

### \<iGoldPerUnit\>
ユニット維持費係数を指定します。
この値が高いほど、ユニット維持費が高くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくにユニット維持費を重くしない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iGoldPerUnit\>0\</iGoldPerUnit\>

### \<iGoldPerMilitaryUnit\>
軍事ユニット維持費係数を指定します。
この値が高いほど、ユニット維持費が高くなります。

計算式のどこに算入されるかについては、[こちら]({{<ref "glossary">}}#ユニット維持費)を参照してください。

とくにユニット維持費を重くしない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は平和主義です。

値：整数

例：
\<iGoldPerMilitaryUnit\>0\</iGoldPerMilitaryUnit\>

### \<iHappyPerMilitaryUnit\>
都市に駐留する軍事ユニットから〈幸福〉を発生させます。
この社会制度を採用している間、都市に駐留する軍事ユニット1つにつき〈幸福〉+nを得ます。

この効果を使わない場合、0を指定します。
BtSでは、この属性を持つ社会制度は世襲政治です。

負の値を指定することもできます。その場合、〈不幸〉を産出します。

値：整数

例１：
\<iHappyPerMilitaryUnit\>0\</iHappyPerMilitaryUnit\>

例２：都市に駐留する軍事ユニット1つにつき、〈幸福〉+1
\<iHappyPerMilitaryUnit\>1\</iHappyPerMilitaryUnit\>

### \<bMilitaryFoodProduction\>
軍事ユニット生産時に余剰食料を用います。

通常、余った〈パン〉は都市に蓄積され、人口増加に使用されます。
労働者と開拓者の生産時は例外で、余った〈パン〉も〈ハンマー〉に変換されて
生産に使用されるようになります。

ここに1を指定すると、その対象が軍事ユニット全体まで広がります。
通常より早く軍事ユニットを生産することができますが、その間都市は成長できなくなります。

この効果を使わない場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：0か1

例１：
\<bMilitaryFoodProduction\>0\</bMilitaryFoodProduction\>

例２：〈パン〉によって生産される軍事ユニット
\<bMilitaryFoodProduction\>1\</bMilitaryFoodProduction\>

### \<iMaxConscript\>
徴兵を有効化します。
この社会制度を採用している文明では、1ターンに追加でn回の徴兵ができるようになります。
実際の徴兵回数はマップサイズの影響を受けます。

とくに徴兵回数を増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例１：
\<iMaxConscript\>0\</iMaxConscript\>

例２：1ターンにつき3ユニットを各都市で徴兵可能
\<iMaxConscript\>3\</iMaxConscript\>

### \<bNoUnhealthyPopulation\>
ここに1を指定する場合、全都市で人口による不衛生がなくなります。

BtSでは、この属性を持つ社会制度はありません。

値：0か1

例：
\<bNoUnhealthyPopulation\>0\</bNoUnhealthyPopulation\>

### \<iExpInBorderModifier\>
自文化圏内で戦闘をしたときの経験値に対する修正率を指定します。
この社会制度を採用していて、自文化圏内の戦闘により経験値を獲得する場合、
経験値に+n%の補正を得ます。

BtSでは、この属性を持つ社会制度はありません。

値：整数

例：
\<iExpInBorderModifier\>0\</iExpInBorderModifier\>

### \<bBuildingOnlyHealthy\>
ここに1を指定する場合、全都市で建造物による不衛生がなくなります。

BtSでは、この属性を持つ社会制度はありません。

値：0か1

例：
\<bBuildingOnlyHealthy\>0\</bBuildingOnlyHealthy\>

### \<iLargestCityHappiness\>
大都市に〈幸福〉を与えます。
この社会制度を採用している間、人口の多い方から5都市[^worldlargest]に〈幸福〉+nします。

[^worldlargest]: マップサイズ標準の場合。マップサイズにより変動します。

負の値を指定することもでき、その場合〈不幸〉を産出します。
とくに大都市の幸福を増やさない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は代議制です。

値：整数

例１：
\<iLargestCityHappiness\>0\</iLargestCityHappiness\>

例２：大きさで上位5都市の〈幸福〉+3
\<iLargestCityHappiness\>3\</iLargestCityHappiness\>

### \<iWarWearinessModifier\>
厭戦感情に対する修正率を指定します。
この社会制度を採用している間、厭戦感情が+n%されます。
負の値を指定することもできます。

とくに厭戦感情を補正しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は警察国家です。

値：整数

例１：
\<iWarWearinessModifier\>0\</iWarWearinessModifier\>

例２：厭戦感情-50%
\<iWarWearinessModifier\>-50%\</iWarWearinessModifier\>

### \<iFreeSpecialist\>
無償の専門家を与えます。
この社会制度を採用している間、全都市にn人の無償の専門家が与えられます。
この属性では、プレイヤーがどの専門家に割り当てるかを決定します。

とくに無償の専門家を提供しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は重商主義です。

値：整数

例：
\<iFreeSpecialist\>0\</iFreeSpecialist\>

### \<iTradeRoutes\>
追加の交易路の本数を指定します。
この社会制度を採用している間、全都市にn本の追加の交易路が与えられます。

ここに負の値を指定することはできますが、
交易路の総本数が負の値になることは想定されていないため、
そうならないように注意を払うべきです。
実験したところでは、総本数が負の値になっても0本であるかのようにふるまいますが、
想定外の動作であることに注意してください。

値：整数

例：
\<iTradeRoutes\>0\</iTradeRoutes\>

### \<bNoForeignTrade\>
他文明との交易路収入を無効にします。
ここに1を指定する場合、この社会制度を採用している間、
属国でない他文明との交易路収入が無効になります。
(自国同士か属国の都市の交易路収入のみが有効になります)

とくに対外交易路を制限しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は重商主義です。

値：0か1

例１：
\<bNoForeignTrade\>0\</bNoForeignTrade\>

例２：対外交易路なし
\<bNoForeignTrade\>1\</bNoForeignTrade\>

### \<bNoCorporations\>
企業を無効化します。
ここに1を指定する場合、この社会制度を採用している間、
本社の創始、支店の出店ができなくなり、
本社と支店の産出と維持費がなくなります。

とくに企業を無効化しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は国有化です。

値：0か1

例１：
\<bNoCorporations\>0\</bNoCorporations\>

例２：企業の無効化
\<bNoCorporations\>1\</bNoCorporations\>

### \<bNoForeignCorporations\>
外国企業を無効化します。
ここに1を指定する場合、この社会制度を採用している間、
外国に本社を持つ支店の出店ができなくなり、
すでにある支店も産出と維持費がなくなります。

とくに外国企業を無効化しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は重商主義です。

値：0か1

例１：
\<bNoForeignCorporations\>0\</bNoForeignCorporations\>

例１：外国企業の無効化
\<bNoForeignCorporations\>1\</bNoForeignCorporations\>

### \<iCivicPercentAnger\>
この社会制度を採用していない文明に〈不満〉をもたらします。
この値が高いほど、より大きな〈不満〉が発生します。
この社会制度を採用していない文明は、全都市に以下の〈不満〉が発生します。

**不満** = \<iCivicPercentAnger\> * \[各都市の人口\] * \[世界中でこの社会制度を採用している文明の数\] / 1000

値：整数

例：
\<iCivicPercentAnger\>0\</iCivicPercentAnger\>

例：1人口・採用1文明あたり〈不満〉+0.4
\<iCivicPercentAnger\>400\</iCivicPercentAnger\>

### \<bStateReligion\>
国教の制定を許可します。
ここに1を指定した社会制度を採用している間のみ、プレイヤーは国教を制定することができます。

BtSでは、宗教制度に属する社会制度のうち、信教の自由を除いた残り4つの社会制度がこの属性を持ちます。
プレイヤーは同じ体制のうちのいずれかの社会制度は採用しなければなりませんから、
結果として信教の自由以外を採用している間は国教が制定できることになります。

同じ体制の中に1を指定している社会制度があるにもかかわらず、ここに０を指定した場合、
シヴィロペディアなどの説明文に「国教なし」と表示されます。

値：0か1

例：
\<bStateReligion\>0\</bStateReligion\>

### \<bNoNonStateReligionSpread\>
国教でない宗教の布教を禁止します。
ここに1を指定した場合、この社会制度を採用している文明の都市には
採用している国教と同じ宗教のみが布教でき、
それ以外の宗教は自然伝搬・宣教師・イベントを問わず布教できなくなります。

BtSでは、この属性を持つ社会制度は神権政治です。

値：0か1

例：
\<bNoNonStateReligionSpread\>0\</bNoNonStateReligionSpread\>

### \<iStateReligionHappiness\>
国教からの追加の〈幸福〉を指定します。
この社会制度を採用している文明の都市に国教が布教されているなら、
その宗教は追加で〈幸福〉を`+n`産出します。

負の数を指定でき、その場合は〈不満〉を産出します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例１：
\<iStateReligionHappiness\>0\</iStateReligionHappiness\>

例２：国教から〈幸福〉+2
\<iStateReligionHappiness\>2\</iStateReligionHappiness\>

### \<iNonStateReligionHappiness\>
国教でない宗教からの追加の〈幸福〉を指定します。
この社会制度を採用している文明の都市に布教されている宗教は、
それが国教でないなら、追加で〈幸福〉を`+n`産出します。

負の数を指定でき、その場合は〈不満〉を産出します。
BtSでは、この属性を持つ社会制度は信教の自由です。

同じ社会制度の中で[\<bStateReligion\>](#bstatereligion)により国教の制定を許可した場合の表示にはバグがあり、
社会制度の欄にはめちゃくちゃな値が表示されますが、実際の〈幸福〉は正常に処理されます。

値：整数

例１：
\<iNonStateReligionHappiness\>0\</iNonStateReligionHappiness\>

例２：国教でない宗教1つにつき〈幸福〉+1
\<iNonStateReligionHappiness\>1\</iNonStateReligionHappiness\>

### \<iStateReligionUnitProductionModifier\>
国教からのユニット生産修正率を指定します。
この社会制度を採用している文明の都市に国教が布教されているなら、
ユニットを生産するための〈ハンマー〉が`+n%`されます。

とくにユニットを加速しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例１：
\<iStateReligionUnitProductionModifier\>0\</iStateReligionUnitProductionModifier\>

例２：国教を持つ都市で、ユニットの生産速度が+50%向上
\<iStateReligionUnitProductionModifier\>50\</iStateReligionUnitProductionModifier\>

### \<iStateReligionBuildingProductionModifier\>
国教からの建造物生産修正率を指定します。
この社会制度を採用している文明の都市に国教が布教されているなら、
建造物を生産するための〈ハンマー〉が`+n%`されます。

とくに建造物を加速しない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は宗教の組織化です。

例１：
\<iStateReligionBuildingProductionModifier\>0\</iStateReligionBuildingProductionModifier\>

例２：国教を持つ都市で、建造物の建設速度が+25%向上
\<iStateReligionBuildingProductionModifier\>25\</iStateReligionBuildingProductionModifier\>

### \<iStateReligionFreeExperience\>
国教からの追加の経験値を指定します。
この社会制度を採用している文明の都市に国教が布教されているなら、
その都市で新しく生産されたユニットに追加で経験値が`n`与えられます。

とくに経験値を与えない普通の社会制度の場合、0を指定します。
BtSでは、この属性を持つ社会制度は神権政治です。

例１：
\<iStateReligionFreeExperience\>0\</iStateReligionFreeExperience\>

例２：国教を持つ都市で経験値+2ポイント
\<iStateReligionFreeExperience\>2\</iStateReligionFreeExperience\>

### \<YieldModifiers\>
全都市の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ社会制度は国有化です。

値：\<iYield\>のリスト
　　上から〈パン〉・〈ハンマー〉・〈コイン〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<YieldModifiers /\>

例２：+10%〈パン〉, +25%〈ハンマー〉, +50%〈コイン〉 (全都市で) 
``` txt
<YieldModifiers>
    <iYield>10</iYield>
    <iYield>25</iYield>
    <iYield>50</iYield>
</YieldModifiers>
```

### \<CapitalYieldModifiers\>
首都の〈パン〉・〈ハンマー〉・〈コイン〉への修正率を指定します。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ社会制度は官僚制です。

値：\<iYield\>のリスト
　　上から〈パン〉・〈ハンマー〉・〈コイン〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<CapitalYieldModifiers /\>

例２：+50%〈ハンマー〉, +50%〈コイン〉 (首都で)
``` txt
<CapitalYieldModifiers>
    <iYield>0</iYield>
    <iYield>50</iYield>
    <iYield>50</iYield>
</CapitalYieldModifiers>
```

### \<TradeYieldModifiers\>
交易路収入の〈パン〉・〈ハンマー〉・〈コイン〉への変化率を指定します。

都市にある各交易路はそれぞれ内部に交易路収入値をもちます。
BtSでは、交易路収入が産出するのは通常〈コイン〉の100%だけです。
ここの指定によって〈コイン〉を増やしたり、
〈パン〉や〈ハンマー〉を産出させたりできます。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ社会制度はありません。

値：\<iYield\>のリスト
　　上から〈パン〉・〈ハンマー〉・〈コイン〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<TradeYieldModifiers /\>

例２：交易路により〈パン〉+10%, 〈ハンマー〉+10%, 〈コイン〉+30%
``` txt
<TradeYieldModifiers>
    <iYield>10</iYield>
    <iYield>10</iYield>
    <iYield>30</iYield>
</TradeYieldModifiers>
```

なお、BtSでは表示にバグがあり、+10%と表示されるべきところで+10と表示されてしまいます。注意してください。

### \<CommerceModifiers\>
全都市の〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への修正率を指定します。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ社会制度は国民国家(諜報+25%)・表現の自由(文化+100%)・信教の自由(ビーカー+10%)です。

値：\<iCommerce\>のリスト
　　上から〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<CommerceModifiers /\>

例２：+25%〈諜報〉 (全都市で)
``` txt
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>25</iCommerce>
</CommerceModifiers>
```

例３：+100%〈文化〉 (全都市で)
``` txt
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>100</iCommerce>
</CommerceModifiers>
```

### \<CapitalCommerceModifiers\>
首都の〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への修正率を指定します。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ社会制度はありません。

値：\<iCommerce\>のリスト
　　上から〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<CapitalCommerceModifiers /\>

例２：+10%〈ゴールド〉, +20%〈ビーカー〉, +30%〈文化〉, +40%〈諜報〉 (首都で)
``` txt
<CapitalCommerceModifiers>
    <iCommerce>10</iCommerce>
    <iCommerce>20</iCommerce>
    <iCommerce>30</iCommerce>
    <iCommerce>40</iCommerce>
</CapitalCommerceModifiers>
 ```

### \<SpecialistExtraCommerces\>
専門家の出力に、一律で〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を加えます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ社会制度は代議制です。

値：\<iCommerce\>のリスト
　　上から〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<SpecialistExtraCommerces /\>

例２：+3〈ビーカー〉 (専門家1人につき)
``` txt
<SpecialistExtraCommerces>
    <iCommerce>0</iCommerce>
    <iCommerce>3</iCommerce>
    <iCommerce>0</iCommerce>
</SpecialistExtraCommerces>
```

### \<Hurrys\>
緊急生産を解禁します。
この社会制度を採用している間、ここに指定した種類の各緊急生産を都市で実行できるようになります。

値：\<Hurry\>のリスト

{{% div class="subnote" %}}

\<Hurry\>は以下の2つのタグを含みます。

#### \<HurryType\>
解禁する緊急生産の種類を指定します。

値：次のいずれか

- 人口消費：`HURRY_POPULATION`
- 金銭消費：`HURRY_GOLD`

#### \<bHurry\>
1を指定します。

{{% /div %}}

特に緊急生産を解禁しない普通の社会制度の場合、空タグにします。
BtSでは、この属性を持つのは奴隷制と普通選挙です。

例１：
\<Hurrys /\>

例２：ゴールド消費と引き換えに緊急生産が可能
``` txt
<Hurrys>
    <Hurry>
        <HurryType>HURRY_GOLD</HurryType>
        <bHurry>1</bHurry>
    </Hurry>
</Hurrys>
```

### \<SpecialBuildingNotRequireds\>
僧院がなくても宣教師を生産できるようにします。
ここに指定した特定の特殊建造物タイプに属する建造物が、
ユニットの前提建造物として指定されている場合、
この社会制度を採用している間は前者の建造物がなくても後者のユニットを作成することが可能になります。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つのは宗教の組織化です。

例１：
\<SpecialBuildingNotRequireds /\>

例２：「特殊建造物タイプ『僧院』に属する建造物」を前提とするユニットについて、建造物なしでユニットを生産できる
``` txt
<SpecialBuildingNotRequireds>
    <SpecialBuildingNotRequired>
        <SpecialBuildingType>SPECIALBUILDING_MONASTERY</SpecialBuildingType>
        <bNotRequired>1</bNotRequired>
    </SpecialBuildingNotRequired>
</SpecialBuildingNotRequireds>
```

### \<SpecialistValids\>
専門家の雇用枠を解放します。
この社会制度を採用している間、ここに指定した各専門家を全都市で無制限に雇用することができるようになります。

値：\<SpecialistValid\>のリスト

{{% div class="subnote" %}}

\<SpecialistValid\>は以下の2つのタグを含みます。

#### \<SpecialistType\>
雇用枠を解放する専門家の種類を指定します。

値：[専門家キー]({{<ref "keyichiran">}}#専門家)

#### \<bVaild\>
1を指定します。

{{% /div %}}

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ社会制度はカースト制です。

例１：
\<SpecialistValids /\>

例２：制限なし - 芸術家,科学者,商人
``` txt
<SpecialistValids>
    <SpecialistValid>
        <SpecialistType>SPECIALIST_ARTIST</SpecialistType>
        <bValid>1</bValid>
    </SpecialistValid>
    <SpecialistValid>
        <SpecialistType>SPECIALIST_SCIENTIST</SpecialistType>
        <bValid>1</bValid>
    </SpecialistValid>
    <SpecialistValid>
        <SpecialistType>SPECIALIST_MERCHANT</SpecialistType>
        <bValid>1</bValid>
    </SpecialistValid>
</SpecialistValids>
```

### \<BuildingHappinessChanges\>
建造物から追加の〈幸福〉を発生させます。

値：\<BuildingHappinessChange\>のリスト

{{% div class="subnote" %}}

\<BuildingHappinessChange\>は以下の2つのタグを含みます。

#### \<BuildingType\>
追加の〈幸福〉を産出させる建造物の種類をクラスで指定します。
値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

#### \<iHappinessChange\>
追加する〈幸福〉の数を指定します。
負の数も指定でき、その場合は〈不満〉を産出します。
値：整数

{{% /div %}}

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ社会制度は国民国家です。

例１：
\<BuildingHappinessChanges /\>

例２：兵舎により〈幸福〉+2
``` txt
<BuildingHappinessChanges>
    <BuildingHappinessChange>
        <BuildingType>BUILDINGCLASS_BARRACKS</BuildingType>
        <iHappinessChange>2</iHappinessChange>
    </BuildingHappinessChange>
</BuildingHappinessChanges>
```

### \<BuildingHealthChanges\>
建造物から追加の〈不衛生〉を発生させます。

値：\<BuildingHealthChange\>のリスト

{{% div class="subnote" %}}

\<BuildingHealthChange\>は以下の2つのタグを含みます。

#### \<BuildingType\>
追加の〈衛生〉を産出させる建造物の種類をクラスで指定します。
値：[建造物クラスキー]({{<ref "keyichiran">}}#建造物)

#### \<iHealthChange\>
追加する〈衛生〉の数を指定します。
負の数も指定でき、その場合は〈不衛生〉を産出します。
値：整数

{{% /div %}}

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ社会制度は環境保護主義です。

例１：
\<BuildingHealthChanges /\>

例２：公共交通機関により〈衛生〉+2
``` txt
<BuildingHealthChanges>
    <BuildingHealthChange>
        <BuildingType>BUILDINGCLASS_PUBLIC_TRANSPORTATION</BuildingType>
        <iHealthChange>2</iHealthChange>
    </BuildingHealthChange>
</BuildingHealthChanges>
```

### \<FeatureHappinessChanges\>
追加地形から追加の〈幸福〉を発生させます。
この社会制度を採用している間、ここに指定した追加地形のタイルを都市圏内にもつ都市は、
その種類のタイル1つにつき〈幸福〉を追加で`+n`だけ得ます。

値：\<FeatureHappinessChange\>のリスト

{{% div class="subnote" %}}

\<FeatureHappinessChange\>は以下の2つのタグを含みます。

#### \<FeatureType\>
追加の〈幸福〉を産出させる追加地形の種類を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<iHappinessChange\>
追加する〈幸福〉の数を指定します。
負の数も指定でき、その場合は〈不満〉を産出します。
値：整数

{{% /div %}}

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ社会制度はありません。

例１：
\<FeatureHappinessChanges /\>

例２：次の場所で〈幸福〉+3: オアシス
``` txt
<FeatureHappinessChanges>
    <FeatureHappinessChange>
        <FeatureType>FEATURE_OASIS</FeatureType>
        <iHappinessChange>3</iHappinessChange>
    </FeatureHappinessChange>
</FeatureHappinessChanges>
```

### \<ImprovementYieldChanges\>
地形改善から追加の〈パン〉・〈ハンマー〉・〈コイン〉を得ます。

値：\<ImprovementYieldChange\>のリスト

{{% div class="subnote" %}}

\<ImprovementYieldChange\>は以下の2つのタグを含みます。

#### \<ImprovementType\>
追加の産出を得させる地形改善の種類を指定します。
値：[地形改善キー]({{<ref "keyichiran">}}#地形改善)

#### \<iHappinessChange\>
値：\<iYield\>のリスト
　　上から〈パン〉・〈ハンマー〉・〈コイン〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

{{% /div %}}

改善にとくに追加しない普通の社会制度の場合、空タグにします。
BtSでは、この属性を持つ社会制度は普通選挙・表現の自由・カースト制・国有化・環境保護主義です。


例１：
\<ImprovementYieldChanges /\>

例２：次のものより〈ハンマー〉+1: 町
``` txt
<ImprovementYieldChanges>
    <ImprovementYieldChange>
        <ImprovementType>IMPROVEMENT_TOWN</ImprovementType>
        <ImprovementYields>
            <iYield>0</iYield>
            <iYield>1</iYield>
            <iYield>0</iYield>
        </ImprovementYields>
    </ImprovementYieldChange>
</ImprovementYieldChanges>
```

### \<WeLoveTheKing\>
感謝祭のテキストを指定します。
BtSでは政治体制に属する社会制度に設定されていますが、MODではそれに限りません。

値：テキストキー

例：「大統領感謝祭」
\<WeLoveTheKing\>TXT\_KEY\_CIVIC\_WE\_LOVE\_PRESIDENT\</WeLoveTheKing\>

