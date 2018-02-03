+++
date = "2017-08-06"
lastmod = "2018-01-28"
draft = false
title = "はじめてのPythonMOD 6"
banner = "photo_yellow"
tags = ["はじめてのPythonMOD", "せつめい"]
+++

# はじめに

- [その５]({{<ref "getstarted5.md">}})のつづき
- XMLとPythonの合わせ技・XML編
- あくまでPythonのチュートリアルなので、XMLの詳しい話にはあまり踏み入りません

# 構想
これまでは既存の動作を変更してばかりでした。
Pythonでしかできない効果を持った新しい建造物を作りましょう！
とりあえず"いつもの"を作ります。
``` plain
└─kujira_fert
    └─Assets
        └─Python
            ├─KujiraEventManager.py
            │
            └─Entrypoints
                 └─CvEventInterface.py
```

<!--more-->

# XML
新しい建造物を追加します。
編集するのは`CIV4BuildingClassInfos.xml`と`CIV4BuildingInfos.xml`です。
C:\\Program Files (x86)\\CYBERFRONT\\Sid Meier's Civilization 4(J)\\Beyond the Sword(J)\\Assets\\XML\\Buildings
[^1]から同じフォルダ階層にコピーします。

[^1]: パッケージ版の場合。Steam版の場合は"C:Program Files (x86)\\Steam\\SteamApps\\common\\Sid Meier's Civilization IV Beyond the Sword\\Beyond the Sword\\Assets\\XML\\Buildings"

ここまででファイル構成はこうなっているはずです。
``` plain
└─kujira_fert
    └─Assets
        ├─Python
        │  ├─KujiraEventManager.py
        │  │
        │  └─Entrypoints
        │      └─CvEventInterface.py
        │
        └─XML
            └─Buildings
                ├─CIV4BuildingClassInfos.xml
                └─CIV4BuildingInfos.xml

```

## ちょっとだけXMLの話
[キー一覧](https://civ4-wiki.club/index.php?MOD%2F%E4%BD%9C%E6%88%90%E6%83%85%E5%A0%B1%2F%E3%82%AD%E3%83%BC%E4%B8%80%E8%A6%A7)を見ていただくとわかりやすいのですが、
建造物の種類一つ一つに**BuildingType**、
UBどうしをひとまとめにしたものに**BuildingClassType**が割り当てられています。
例えばストーンヘンジで各都市に無償で供給されるのは、
正確には「BUILDING\_OBELISKという建造物」ではなく、
「BUILDINGCLASS\_OBELISKに属する建造物のうち、その文明に合ったもの」なのです。
(ですから、例えばアメリカ先住民がストヘンを建てると
ちゃんとトーテムポールが配置されるのですね)

UBが存在しない建造物であっても自分一人をメンバーとした**BuildingClass**が必ずあります。
というより、**Building**を作るときに所属先である**BuildingClass**を自己申告するタグがあり、
それは省略できません。
なのでオレオレ建造物を追加するときは、
(その**Building**ひとつだけを含む予定の)**BuildingClass**と、
(その**BuildingClass**に所属する)**Building**本体とを
一緒に作ってあげなければいけません。

## CIV4BuildingClassInfos.xml
というわけで`CIV4BuildingClassInfos.xml`の

↓ここに

{{<img src="/img/kujira_fert_00.png" width="400" height="800">}}

↓こんな感じのを追加しておきます。
``` xml
		<BuildingClassInfo>
			<Type>BUILDINGCLASS_FERTILIZE_SHRINE</Type>
			<Description>TXT_KEY_FERTIRIZE_SHRINE</Description>
			<iMaxGlobalInstances>-1</iMaxGlobalInstances>
			<iMaxTeamInstances>-1</iMaxTeamInstances>
			<iMaxPlayerInstances>-1</iMaxPlayerInstances>
			<iExtraPlayerInstances>0</iExtraPlayerInstances>
			<bNoLimit>0</bNoLimit>
			<bMonument>0</bMonument>
			<DefaultBuilding>BUILDING_FERTILIZE_SHRINE</DefaultBuilding>
			<VictoryThresholds/>
		</BuildingClassInfo>
```

## CIV4BuildingInfos.xml

`CIV4BuildingInfos.xml`はタグが多すぎて１からでは無理なのでBUILDING\_RECYCLING\_CENTERを元に改変することにして、

↓ここから
{{<img src="/img/kujira_fert_01.png" width="400" height="1600">}}
↑ここまでを

↓ここに貼り付けます。

{{<img src="/img/kujira_fert_02.png" width="400" height="800">}}

<br><br>

そのあと、貼り付けた部分の一部を修正していきます。
``` xml
			<BuildingClass>BUILDINGCLASS_FERTILIZE_SHRINE</BuildingClass>
			<Type>BUILDING_FERTILIZE_SHRINE</Type>
			<SpecialBuildingType>NONE</SpecialBuildingType>
			<Description>TXT_KEY_BUILDING_FERTILIZE_SHRINE</Description>
			<Civilopedia>TXT_KEY_BUILDING_FERTILIZE_SHRINE_PEDIA</Civilopedia>
			<Strategy>TXT_KEY_BUILDING_FERTILIZE_SHRINE_STRATEGY</Strategy>
```
↑`<BuildingClass>`と`<Type>`を指定、それから各種テキストキーをそれっぽい名前にしておいて、

``` xml
			<Help>TXT_KEY_BUILDING_FERTILIZE_SHRINE_HELP</Help>
```
↑`<Help>`というタグを追加しておきます。

``` xml
			<PrereqTech>TECH_BIOLOGY</PrereqTech>
```
↑解禁技術を生物学にして、

``` xml
			<iCost>10</iCost>
```
↑(開発中の一時的な措置として)ハンマーを軽くしておいて、

``` xml
			<bBuildingOnlyHealthy>0</bBuildingOnlyHealthy>
```
↑人口からの不衛生なしを解除して、

``` xml
			<iHappiness>-10</iHappiness>
```
↑不幸+10にしてみました。

全部でどんな感じになったかは長いので章末に移動しました。[おまけ](#おまけ)をご覧ください。

この時点で生物学解禁の不幸を+10生む建造物ができているはずです。
ゲームを起動して、シヴィロペディアを見るなり、
WBで生物学を取って建ててみるなりしてみましょう。
もちろん、まだテキストキーの内容を定義していませんので、
生の`TXT_KEY_...`が出てきますが、
定義していない以上当然のことなので、気にしないことにしましょう。

## Text
XML\\Text\\ に適当な名前のファイルを作ります。
今回は`Text_Kujira.xml`という名前にしましょう。
フォルダ構成はこうなりました。
``` plain
└─kujira_fert
    └─Assets
        ├─Python
        │  ├─ KujiraEventManager.py
        │  │
        │  └─Entrypoints
        │      └─CvEventInterface.py
        │
        └─XML
            ├─Buildings
            │  ├─CIV4BuildingClassInfos.xml
            │  └─CIV4BuildingInfos.xml
            │
            └─Text
                └─Text_Kujira.xml
```


`Text_Kujira.xml`の中身はこのようにします...
``` xml
<?xml version="1.0" encoding="Shift_JIS"?>
<Civ4GameText xmlns="http://www.firaxis.com">
	<TEXT>
		<Tag>TXT_KEY_BUILDING_FERTILIZE_SHRINE</Tag>
		<English>Fartilize Shrine</English>
		<French>肥沃化の神殿</French>
		<German />
		<Italian />
		<Spanish />
		<Japanese>肥沃化の神殿</Japanese>
	</TEXT>
	<TEXT>
		<Tag>TXT_KEY_BUILDING_FERTILIZE_SHRINE_PEDIA</Tag>
		<English>Fartilize Shrine's Pedia</English>
		<French>肥沃化の神殿は適当に考えた例題用の建造物です。</French>
		<German />
		<Italian />
		<Spanish />
		<Japanese>肥沃化の神殿は適当に考えた例題用の建造物です。</Japanese>
	</TEXT>
	<TEXT>
		<Tag>TXT_KEY_BUILDING_FERTILIZE_SHRINE_STRATEGY</Tag>
		<English>Fartilize Shrine changes terrain in city area into glass in return for 10 unhappiness.</English>
		<French>この先10もの不幸を背負う代わりに、都市圏内のタイルを即座に草原にします。</French>
		<German />
		<Italian />
		<Spanish />
		<Japanese>この先10もの不幸を背負う代わりに、都市圏内のタイルを即座に草原にします。</Japanese>
	</TEXT>
	<TEXT>
		<Tag>TXT_KEY_BUILDING_FERTILIZE_SHRINE_HELP</Tag>
		<English>[ICON_BULLET]Fartilize Shrine changes terrain in city area into glass.</English>
		<French>[ICON_BULLET]完成時都市圏内のタイルを即座に草原にする</French>
		<German />
		<Italian />
		<Spanish />
		<Japanese>[ICON_BULLET]完成時都市圏内のタイルを即座に草原にする</Japanese>
	</TEXT>
</Civ4GameText>
```
こんな感じでしょうか。

この時点で生物学解禁の不幸を+10生む、説明にもそれっぽいことが書いてあるけれど実際には草原化などしない(書いていませんからね)そんな <s>詐欺</s> 建造物ができているはずです。
起動して、いろいろ遊んでみましょう。

## ためす is 大事
こうして一歩進むごとにいちいち動作確認するのは重要です。
もしPythonをいじっていない今の状態でエラーが出るのなら、
XMLにまずいところがあるはずです。
もし一度目のお願いに従って動作確認をしていただいていて、
その時点では正しく動いていたなら、
いまいじった`Text_Kujira.xml`が必ずおかしいということになるはずです。
動作確認を怠れば怠るほど、どこが間違っているかの探索すべき範囲は
無制限に広くなっていき、
最悪どうにもこうにもならなくなり、すべてを捨てて最初から書きなおす、
なんてことになることもあります。
***ためす is 大事。***

# つづく
XMLには深入りしないと言ったものの、変更するのと比べて新しく作るのは結構大変でした。
そのせいで字数が多くなり過ぎたので、
[その７]({{<ref "getstarted7.md">}})へ続きます。

# おまけ
## CIV4BuildingInfos.xml追加分の全文
```
		<BuildingInfo>
			<BuildingClass>BUILDINGCLASS_FERTILIZE_SHRINE</BuildingClass>
			<Type>BUILDING_FERTILIZE_SHRINE</Type>
			<SpecialBuildingType>NONE</SpecialBuildingType>
			<Description>TXT_KEY_BUILDING_FERTILIZE_SHRINE</Description>
			<Civilopedia>TXT_KEY_BUILDING_FERTILIZE_SHRINE_PEDIA</Civilopedia>
			<Strategy>TXT_KEY_BUILDING_FERTILIZE_SHRINE_STRATEGY</Strategy>
			<Help>TXT_KEY_BUILDING_FERTILIZE_SHRINE_HELP</Help>
			<Advisor>ADVISOR_GROWTH</Advisor>
			<ArtDefineTag>ART_DEF_BUILDING_RECYCLING_CENTER</ArtDefineTag>
			<MovieDefineTag>NONE</MovieDefineTag>
			<HolyCity>NONE</HolyCity>
			<ReligionType>NONE</ReligionType>
			<StateReligion>NONE</StateReligion>
			<bStateReligion>0</bStateReligion>
			<PrereqReligion>NONE</PrereqReligion>
			<PrereqCorporation>NONE</PrereqCorporation>
			<FoundsCorporation>NONE</FoundsCorporation>
			<GlobalReligionCommerce>NONE</GlobalReligionCommerce>
			<GlobalCorporationCommerce>NONE</GlobalCorporationCommerce>
			<VictoryPrereq>NONE</VictoryPrereq>
			<FreeStartEra>NONE</FreeStartEra>
			<MaxStartEra>NONE</MaxStartEra>
			<ObsoleteTech>NONE</ObsoleteTech>
			<PrereqTech>TECH_BIOLOGY</PrereqTech>
			<TechTypes/>
			<Bonus>NONE</Bonus>
			<PrereqBonuses/>
			<ProductionTraits/>
			<HappinessTraits/>
			<NoBonus>NONE</NoBonus>
			<PowerBonus>NONE</PowerBonus>
			<FreeBonus>NONE</FreeBonus>
			<iNumFreeBonuses>0</iNumFreeBonuses>
			<FreeBuilding>NONE</FreeBuilding>
			<FreePromotion>NONE</FreePromotion>
			<CivicOption>NONE</CivicOption>
			<GreatPeopleUnitClass>NONE</GreatPeopleUnitClass>
			<iGreatPeopleRateChange>0</iGreatPeopleRateChange>
			<iHurryAngerModifier>0</iHurryAngerModifier>
			<bBorderObstacle>0</bBorderObstacle>
			<bTeamShare>0</bTeamShare>
			<bWater>0</bWater>
			<bRiver>0</bRiver>
			<bPower>0</bPower>
			<bDirtyPower>0</bDirtyPower>
			<bAreaCleanPower>0</bAreaCleanPower>
			<DiploVoteType>NONE</DiploVoteType>
			<bForceTeamVoteEligible>0</bForceTeamVoteEligible>
			<bCapital>0</bCapital>
			<bGovernmentCenter>0</bGovernmentCenter>
			<bGoldenAge>0</bGoldenAge>
			<bAllowsNukes>0</bAllowsNukes>
			<bMapCentering>0</bMapCentering>
			<bNoUnhappiness>0</bNoUnhappiness>
			<bNoUnhealthyPopulation>0</bNoUnhealthyPopulation>
			<bBuildingOnlyHealthy>0</bBuildingOnlyHealthy>
			<bNeverCapture>0</bNeverCapture>
			<bNukeImmune>0</bNukeImmune>
			<bPrereqReligion>0</bPrereqReligion>
			<bCenterInCity>0</bCenterInCity>
			<iAIWeight>0</iAIWeight>
			<iCost>10</iCost>
			<iHurryCostModifier>0</iHurryCostModifier>
			<iAdvancedStartCost>100</iAdvancedStartCost>
			<iAdvancedStartCostIncrease>0</iAdvancedStartCostIncrease>
			<iMinAreaSize>-1</iMinAreaSize>
			<iConquestProb>66</iConquestProb>
			<iCitiesPrereq>0</iCitiesPrereq>
			<iTeamsPrereq>0</iTeamsPrereq>
			<iLevelPrereq>0</iLevelPrereq>
			<iMinLatitude>0</iMinLatitude>
			<iMaxLatitude>90</iMaxLatitude>
			<iGreatPeopleRateModifier>0</iGreatPeopleRateModifier>
			<iGreatGeneralRateModifier>0</iGreatGeneralRateModifier>
			<iDomesticGreatGeneralRateModifier>0</iDomesticGreatGeneralRateModifier>
			<iGlobalGreatPeopleRateModifier>0</iGlobalGreatPeopleRateModifier>
			<iAnarchyModifier>0</iAnarchyModifier>
			<iGoldenAgeModifier>0</iGoldenAgeModifier>
			<iGlobalHurryModifier>0</iGlobalHurryModifier>
			<iExperience>0</iExperience>
			<iGlobalExperience>0</iGlobalExperience>
			<iFoodKept>0</iFoodKept>
			<iAirlift>0</iAirlift>
			<iAirModifier>0</iAirModifier>
			<iAirUnitCapacity>0</iAirUnitCapacity>
			<iNukeModifier>0</iNukeModifier>
			<iNukeExplosionRand>0</iNukeExplosionRand>
			<iFreeSpecialist>0</iFreeSpecialist>
			<iAreaFreeSpecialist>0</iAreaFreeSpecialist>
			<iGlobalFreeSpecialist>0</iGlobalFreeSpecialist>
			<iMaintenanceModifier>0</iMaintenanceModifier>
			<iWarWearinessModifier>0</iWarWearinessModifier>
			<iGlobalWarWearinessModifier>0</iGlobalWarWearinessModifier>
			<iEnemyWarWearinessModifier>0</iEnemyWarWearinessModifier>
			<iHealRateChange>0</iHealRateChange>
			<iHealth>0</iHealth>
			<iAreaHealth>0</iAreaHealth>
			<iGlobalHealth>0</iGlobalHealth>
			<iHappiness>-10</iHappiness>
			<iAreaHappiness>0</iAreaHappiness>
			<iGlobalHappiness>0</iGlobalHappiness>
			<iStateReligionHappiness>0</iStateReligionHappiness>
			<iWorkerSpeedModifier>0</iWorkerSpeedModifier>
			<iMilitaryProductionModifier>0</iMilitaryProductionModifier>
			<iSpaceProductionModifier>0</iSpaceProductionModifier>
			<iGlobalSpaceProductionModifier>0</iGlobalSpaceProductionModifier>
			<iTradeRoutes>0</iTradeRoutes>
			<iCoastalTradeRoutes>0</iCoastalTradeRoutes>
			<iGlobalTradeRoutes>0</iGlobalTradeRoutes>
			<iTradeRouteModifier>0</iTradeRouteModifier>
			<iForeignTradeRouteModifier>0</iForeignTradeRouteModifier>
			<iGlobalPopulationChange>0</iGlobalPopulationChange>
			<iFreeTechs>0</iFreeTechs>
			<iDefense>0</iDefense>
			<iBombardDefense>0</iBombardDefense>
			<iAllCityDefense>0</iAllCityDefense>
			<iEspionageDefense>0</iEspionageDefense>
			<iAsset>6</iAsset>
			<iPower>0</iPower>
			<fVisibilityPriority>1.0</fVisibilityPriority>
			<SeaPlotYieldChanges/>
			<RiverPlotYieldChanges/>
			<GlobalSeaPlotYieldChanges/>
			<YieldChanges/>
			<CommerceChanges/>
			<ObsoleteSafeCommerceChanges/>
			<CommerceChangeDoubleTimes/>
			<CommerceModifiers/>
			<GlobalCommerceModifiers/>
			<SpecialistExtraCommerces/>
			<StateReligionCommerces/>
			<CommerceHappinesses/>
			<ReligionChanges/>
			<SpecialistCounts/>
			<FreeSpecialistCounts/>
			<CommerceFlexibles/>
			<CommerceChangeOriginalOwners/>
			<ConstructSound>AS2D_BUILD_RECYCLING_CENTER</ConstructSound>
			<BonusHealthChanges/>
			<BonusHappinessChanges/>
			<BonusProductionModifiers/>
			<UnitCombatFreeExperiences/>
			<DomainFreeExperiences/>
			<DomainProductionModifiers/>
			<BuildingHappinessChanges/>
			<PrereqBuildingClasses/>
			<BuildingClassNeededs/>
			<SpecialistYieldChanges/>
			<BonusYieldModifiers/>
			<ImprovementFreeSpecialists/>
			<Flavors>
				<Flavor>
					<FlavorType>FLAVOR_GROWTH</FlavorType>
					<iFlavor>10</iFlavor>
				</Flavor>
			</Flavors>
			<HotKey/>
			<bAltDown>0</bAltDown>
			<bShiftDown>0</bShiftDown>
			<bCtrlDown>0</bCtrlDown>
			<iHotKeyPriority>0</iHotKeyPriority>
		</BuildingInfo>
```

