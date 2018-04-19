+++
date = "2017-12-30T12:01:00"
lastmod = "2018-01-30"
draft = false
title = "それからのPython 7"
banner = "photo_pink1"
categories = ["Python"]
tags = ["それからのPython", "講座"]
+++

# はじめに

- [その６]({{<ref "secondpy6.md">}})のつづき
- 簡単なスペルの仕組みをつくってみる
- ４部作のうちの１回目・XML編

# 設計しよう
実際のMODの例として、簡単なスペルをつくっていきたいと思います。
簡単のために、以下の仕様でつくることにします。

- スペルと昇進を1対1で対応させる
- 発動条件は昇進を取得したとき一回きりとする
- スペル昇進を取れるのは火器ユニットとする
- 具体的なスペル効果は以下の3種類とする
- 湧き水：砂漠が平原に変化する
- 毒散布：周囲1マスの敵対ユニットに弱体化昇進『毒』(戦闘力-20%)を与える
- 火炎幕：周囲1マスの敵対ユニットに最大HPの10%のダメージを与える
ただしこれによって最大HPの60%を切ることはないようにする
- 湧き水において砂漠以外で発動したときは不発になるが、昇進は戻ってこないようにする

<!--more-->

# 新しい昇進を作る
「湧き水」・「毒散布」・「火炎幕」の発動用の独自昇進と、
毒散布で付与する用の「毒」の昇進をXMLで追加していきます。
編集するのは "Assets\\XML\\Units\\CIV4PromotionInfos.xml" です。

元のファイルはパッケージ日本語版の場合
"C:\\Program Files (x86)\\CYBERFRONT\\Sid Meier's Civilization 4(J)\\Beyond the Sword(J)\\Assets\\XML\\Units\\Civ4PromotionInfos.xml"
にあります。[^1]

[^1]: Steam版の場合 "C:\\Program Files (x86)\\Steam\\SteamApps\\common\\Sid Meier's Civilization IV Beyond the Sword\\Beyond the Sword\\Assets\\XML\\Units\\Civ4PromotionInfos.xml"

今回のMOD名は`kujira_promospell`にするので、
フォルダ階層を作ってxmlファイルをコピーし、下のようにします。

``` plain
└─kujira_promospell
    └─Assets
        └─XML
            └─Units
                 └─CIV4PromotionInfos.xml
```

CIV4PromotionInfos.xmlの中身を編集していきます。
\<PromotionInfo\>から\</PromotionInfo\>までの100行弱が昇進1つ分になっています。
ものすごくたくさん設定項目がありますが、
今回は「それ自体は全く何の効果もない」昇進をつくります。
それでもまだ１から作成するのは分量的に大変ですので、
戦闘術Ⅰ:"PROMOTION_COMBAT1"をベースにして、戦闘力+10%を取り除く方法を採ります。

↓ここから
{{<img src="/img/promospell_editpromotion1.png" width="400" height="1600">}}
↑ここまでを選択・コピーして...

↓一番下に貼り付けます。
{{<img src="/img/promospell_editpromotion2.png" width="400" height="700">}}

↓こうなります。
{{<img src="/img/promospell_editpromotion3.png" width="400" height="700">}}

テキストエディタでXMLを編集する場合、適宜空行をつくっても構いません。
むしろ空行があるほうが、オリジナルとMODの境目が分かりやすくなってよいでしょう。

## 湧き水

\<Type\>と\<Discription\>を湧き水用のキーに変更します。
``` xml
			<Type>PROMOTION_SPELL_WATER</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_WATER</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_WATER_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
```
ついでに\<Help\>というタグを新しくつくっています。
このタグがあると、自動生成された説明文に追加の説明をつけることができます。
(ここではキーをつくるだけです。あとでText\フォルダに文章を書き込みます)

さらについでに、\<Sound\>をAS2D\_POSITIVE\_DINKに変更します。
昇進を取ったときの音を変更することで、スペルの発動音のかわりにします。

----

\<iCombatPercent\>を0にして、戦闘力+10%をなかったことにします。
``` xml
			<iCombatPercent>0</iCombatPercent>
```

----

この昇進を火器ユニット専用にします。
\<UnitCombats\>から\</UnitCombats\>までの38行分を消去して、
かわりに下記のように火器ユニットのみにします。
``` xml
			<UnitCombats>
				<UnitCombat>
					<UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
					<bUnitCombat>1</bUnitCombat>
				</UnitCombat>
			</UnitCombats>
```

----

このままでは昇進のボタン画像が戦闘術Ⅰのものと同じままになってしまい紛らわしいので、
預言者のボタン画像に変更します。
``` xml

			<Button>,Art/Interface/Buttons/Units/GreatProphet.dds,Art/Interface/Buttons/Unit_Resource_Atlas.dds,5,1</Button>

```
これで湧き水発動用の「何もしない」昇進は完成です。

## 毒散布・火炎幕

この湧き水昇進をもう2つコピペして3つの「何もしない」昇進をつくりましょう。
2番目と3番目をそれぞれ毒散布と火炎幕にします。

----

2番目のかたまりの\<Type\>\<Discription\>\<Help\>を毒散布用にします。
WATERをPOISONに変えています。
``` xml
			<Type>PROMOTION_SPELL_POISON</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_POISON</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_POISON_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
```

----

3番目のかたまりの\<Type\>\<Discription\>\<Help\>を火炎幕用にします。
WATERをFIREに変えています。
``` xml
			<Type>PROMOTION_SPELL_FIRE</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_FIRE</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_FIRE_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
```

## 毒

毒散布によって相手に付与される「毒」の昇進も忘れずつくります。
何もしない3つの昇進のいずれかをもう1つコピペして、
\<Type\>と\<Description\>を変更し、***\<Help\>を消します。***
``` xml
			<Type>PROMOTION_POISONED</Type>
			<Description>TXT_KEY_PROMOTION_POISONED</Description>
			<Sound>AS2D_POSITIVE_DINK</Sound>
```

----

「毒」には実際に戦闘力-20%の効果を持たせますから、
自動生成された説明文で十分だからです。
早速戦闘力-20%にします。
``` xml
			<iCombatPercent>-20</iCombatPercent>
```

----

この昇進を経験値で取得できないようにします。
方法はいろいろありますが、今回は\<UnitCombats\>を空にして、
昇進を取得できるユニット戦闘タイプをなくしてしまいます。
\<UnitCombats\>から\</UnitCombats\>までを消去して、
かわりに下のように入力します。
```
			<UnitCombats />
```
これはXMLの空タグといって、中身が空だということを表します。

----

これで、毒ができました。
全部でどんな感じになったかは長いので章末に移動しました。[おまけ](#おまけ)をご覧ください。

この時点でとりあえず火器ユニットが発動用昇進を取得できるようになっているはずです。
ゲームを起動して適当な火器ユニットをワールドビルダーで作成し、経験値を与えて、
取得できるかどうか試してみましょう。
この時点でゲームの起動に失敗したり、発動用昇進が表示されなかったり、
逆に毒が表示されたりしてしまう場合にはCIV4PromotionInfos.xmlの
記述が間違っています。もう一度見直してみましょう。

# Text

動作テストしたとき、TXT\_KEY\_PROMOTION\_SPELL\_WATERなどのキーが
そのまま表示されてしまっていたので、それに対応する日本語を埋めていきましょう。

Assets\\XML\\Text\\Text_Kujira.xml を作成します。
``` plain
└─kujira_promospell
    └─Assets
        └─XML
            ├─Units
            │   └─CIV4PromotionInfos.xml
            │
            └─Text
                 └─Text_Kujira.xml
```

Text_Kujira.xmlの中身はこのようにします。
``` xml
<?xml version="1.0" encoding="shift_jis"?>
<!-- edited with XMLSPY v2004 rel. 2 U (http://www.xmlspy.com) by lcollins (Firaxis Games) -->
<Civ4GameText xmlns="http://www.firaxis.com">
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_WATER</Tag>
    <English>Spring Water</English>
    <French>湧き水</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>湧き水</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_WATER_HELP</Tag>
    <English>[ICON_BULLET]Change this tile into Plains if it is Desart</English>
    <French>[ICON_BULLET]自領土の砂漠で発動すると平原に変化する</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>[ICON_BULLET]自領土の砂漠で発動すると平原に変化する</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_POISON</Tag>
    <English>Spray Poison</English>
    <French>毒散布</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>毒散布</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_POISON_HELP</Tag>
    <English>[ICON_BULLET]Give a promotion "Poisioned" to enemy units around a tile</English>
    <French>[ICON_BULLET]周囲1マスの敵対ユニットに 昇進：毒 を与える</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>[ICON_BULLET]周囲1マスの敵対ユニットに 昇進：毒 を与える</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_FIRE</Tag>
    <English>Fire Curten</English>
    <French>火炎幕</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>火炎幕</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_SPELL_FIRE_HELP</Tag>
    <English>[ICON_BULLET]Inflict 20% damage to enemy units around a tile</English>
    <French>[ICON_BULLET]周囲1マスの敵対ユニットに10%のダメージを与える</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>[ICON_BULLET]周囲1マスの敵対ユニットに10%のダメージを与える</Japanese>
  </TEXT>
  
  <TEXT>
    <Tag>TXT_KEY_PROMOTION_POISONED</Tag>
    <English>Poisoned</English>
    <French>毒</French>
    <German />
    <Italian />
    <Spanish />
    <Japanese>毒</Japanese>
  </TEXT>
  
</Civ4GameText>
```

\<Japanese\>タグで日本語パッケージ版、
\<French\>タグでSteam版＋日本語化パッチ、
その他の言語タグで各言語版で表示されるようになります。

これで、「それっぽいことが書いてあるけれど、実際には何もしない昇進」が3つと、
戦闘力-20%の効果を持つ昇進ができました。

ゲームを起動して、説明文が表示されるか確かめましょう。
「毒」は取得する方法がまだないので、それ以外の3つに対して確かめます。

{{<img src="/img/civss_promospell_test1.png">}}
いいですね！

[その８につづく]({{<ref "secondpy8.md">}})

# おまけ
## CIV4PromotionInfos.xmlの追加分の全文

``` xml
		<PromotionInfo>
			<Type>PROMOTION_SPELL_WATER</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_WATER</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_WATER_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
			<LayerAnimationPath>NONE</LayerAnimationPath>
			<PromotionPrereq>NONE</PromotionPrereq>
			<PromotionPrereqOr1>NONE</PromotionPrereqOr1>
			<PromotionPrereqOr2>NONE</PromotionPrereqOr2>
			<TechPrereq>NONE</TechPrereq>
			<StateReligionPrereq>NONE</StateReligionPrereq>
			<bLeader>0</bLeader>
			<bBlitz>0</bBlitz>
			<bAmphib>0</bAmphib>
			<bRiver>0</bRiver>
			<bEnemyRoute>0</bEnemyRoute>
			<bAlwaysHeal>0</bAlwaysHeal>
			<bHillsDoubleMove>0</bHillsDoubleMove>
			<bImmuneToFirstStrikes>0</bImmuneToFirstStrikes>
			<iVisibilityChange>0</iVisibilityChange>
			<iMovesChange>0</iMovesChange>
			<iMoveDiscountChange>0</iMoveDiscountChange>
			<iAirRangeChange>0</iAirRangeChange>
			<iInterceptChange>0</iInterceptChange>
			<iEvasionChange>0</iEvasionChange>
			<iWithdrawalChange>0</iWithdrawalChange>
			<iCargoChange>0</iCargoChange>
			<iCollateralDamageChange>0</iCollateralDamageChange>
			<iBombardRateChange>0</iBombardRateChange>
			<iFirstStrikesChange>0</iFirstStrikesChange>
			<iChanceFirstStrikesChange>0</iChanceFirstStrikesChange>
			<iEnemyHealChange>0</iEnemyHealChange>
			<iNeutralHealChange>0</iNeutralHealChange>
			<iFriendlyHealChange>0</iFriendlyHealChange>
			<iSameTileHealChange>0</iSameTileHealChange>
			<iAdjacentTileHealChange>0</iAdjacentTileHealChange>
			<iCombatPercent>0</iCombatPercent>
			<iCityAttack>0</iCityAttack>
			<iCityDefense>0</iCityDefense>
			<iHillsAttack>0</iHillsAttack>
			<iHillsDefense>0</iHillsDefense>
			<iKamikazePercent>0</iKamikazePercent>
			<iRevoltProtection>0</iRevoltProtection>
			<iCollateralDamageProtection>0</iCollateralDamageProtection>
			<iPillageChange>0</iPillageChange>
			<iUpgradeDiscount>0</iUpgradeDiscount>
			<iExperiencePercent>0</iExperiencePercent>
			<TerrainAttacks/>
			<TerrainDefenses/>
			<FeatureAttacks/>
			<FeatureDefenses/>
			<UnitCombatMods/>
			<DomainMods/>
			<TerrainDoubleMoves/>
			<FeatureDoubleMoves/>
			<UnitCombats>
				<UnitCombat>
					<UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
					<bUnitCombat>1</bUnitCombat>
				</UnitCombat>
			</UnitCombats>
			<HotKey/>
			<bAltDown>0</bAltDown>
			<bShiftDown>0</bShiftDown>
			<bCtrlDown>0</bCtrlDown>
			<iHotKeyPriority>0</iHotKeyPriority>
			<Button>,Art/Interface/Buttons/Units/GreatProphet.dds,Art/Interface/Buttons/Unit_Resource_Atlas.dds,5,1</Button>
		</PromotionInfo>

		<PromotionInfo>
			<Type>PROMOTION_SPELL_POISON</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_POISON</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_POISON_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
			<LayerAnimationPath>NONE</LayerAnimationPath>
			<PromotionPrereq>NONE</PromotionPrereq>
			<PromotionPrereqOr1>NONE</PromotionPrereqOr1>
			<PromotionPrereqOr2>NONE</PromotionPrereqOr2>
			<TechPrereq>NONE</TechPrereq>
			<StateReligionPrereq>NONE</StateReligionPrereq>
			<bLeader>0</bLeader>
			<bBlitz>0</bBlitz>
			<bAmphib>0</bAmphib>
			<bRiver>0</bRiver>
			<bEnemyRoute>0</bEnemyRoute>
			<bAlwaysHeal>0</bAlwaysHeal>
			<bHillsDoubleMove>0</bHillsDoubleMove>
			<bImmuneToFirstStrikes>0</bImmuneToFirstStrikes>
			<iVisibilityChange>0</iVisibilityChange>
			<iMovesChange>0</iMovesChange>
			<iMoveDiscountChange>0</iMoveDiscountChange>
			<iAirRangeChange>0</iAirRangeChange>
			<iInterceptChange>0</iInterceptChange>
			<iEvasionChange>0</iEvasionChange>
			<iWithdrawalChange>0</iWithdrawalChange>
			<iCargoChange>0</iCargoChange>
			<iCollateralDamageChange>0</iCollateralDamageChange>
			<iBombardRateChange>0</iBombardRateChange>
			<iFirstStrikesChange>0</iFirstStrikesChange>
			<iChanceFirstStrikesChange>0</iChanceFirstStrikesChange>
			<iEnemyHealChange>0</iEnemyHealChange>
			<iNeutralHealChange>0</iNeutralHealChange>
			<iFriendlyHealChange>0</iFriendlyHealChange>
			<iSameTileHealChange>0</iSameTileHealChange>
			<iAdjacentTileHealChange>0</iAdjacentTileHealChange>
			<iCombatPercent>0</iCombatPercent>
			<iCityAttack>0</iCityAttack>
			<iCityDefense>0</iCityDefense>
			<iHillsAttack>0</iHillsAttack>
			<iHillsDefense>0</iHillsDefense>
			<iKamikazePercent>0</iKamikazePercent>
			<iRevoltProtection>0</iRevoltProtection>
			<iCollateralDamageProtection>0</iCollateralDamageProtection>
			<iPillageChange>0</iPillageChange>
			<iUpgradeDiscount>0</iUpgradeDiscount>
			<iExperiencePercent>0</iExperiencePercent>
			<TerrainAttacks/>
			<TerrainDefenses/>
			<FeatureAttacks/>
			<FeatureDefenses/>
			<UnitCombatMods/>
			<DomainMods/>
			<TerrainDoubleMoves/>
			<FeatureDoubleMoves/>
			<UnitCombats>
				<UnitCombat>
					<UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
					<bUnitCombat>1</bUnitCombat>
				</UnitCombat>
			</UnitCombats>
			<HotKey/>
			<bAltDown>0</bAltDown>
			<bShiftDown>0</bShiftDown>
			<bCtrlDown>0</bCtrlDown>
			<iHotKeyPriority>0</iHotKeyPriority>
			<Button>,Art/Interface/Buttons/Units/GreatProphet.dds,Art/Interface/Buttons/Unit_Resource_Atlas.dds,5,1</Button>
		</PromotionInfo>
		
		<PromotionInfo>
			<Type>PROMOTION_SPELL_FIRE</Type>
			<Description>TXT_KEY_PROMOTION_SPELL_FIRE</Description>
			<Help>TXT_KEY_PROMOTION_SPELL_FIRE_HELP</Help>
			<Sound>AS2D_POSITIVE_DINK</Sound>
			<LayerAnimationPath>NONE</LayerAnimationPath>
			<PromotionPrereq>NONE</PromotionPrereq>
			<PromotionPrereqOr1>NONE</PromotionPrereqOr1>
			<PromotionPrereqOr2>NONE</PromotionPrereqOr2>
			<TechPrereq>NONE</TechPrereq>
			<StateReligionPrereq>NONE</StateReligionPrereq>
			<bLeader>0</bLeader>
			<bBlitz>0</bBlitz>
			<bAmphib>0</bAmphib>
			<bRiver>0</bRiver>
			<bEnemyRoute>0</bEnemyRoute>
			<bAlwaysHeal>0</bAlwaysHeal>
			<bHillsDoubleMove>0</bHillsDoubleMove>
			<bImmuneToFirstStrikes>0</bImmuneToFirstStrikes>
			<iVisibilityChange>0</iVisibilityChange>
			<iMovesChange>0</iMovesChange>
			<iMoveDiscountChange>0</iMoveDiscountChange>
			<iAirRangeChange>0</iAirRangeChange>
			<iInterceptChange>0</iInterceptChange>
			<iEvasionChange>0</iEvasionChange>
			<iWithdrawalChange>0</iWithdrawalChange>
			<iCargoChange>0</iCargoChange>
			<iCollateralDamageChange>0</iCollateralDamageChange>
			<iBombardRateChange>0</iBombardRateChange>
			<iFirstStrikesChange>0</iFirstStrikesChange>
			<iChanceFirstStrikesChange>0</iChanceFirstStrikesChange>
			<iEnemyHealChange>0</iEnemyHealChange>
			<iNeutralHealChange>0</iNeutralHealChange>
			<iFriendlyHealChange>0</iFriendlyHealChange>
			<iSameTileHealChange>0</iSameTileHealChange>
			<iAdjacentTileHealChange>0</iAdjacentTileHealChange>
			<iCombatPercent>0</iCombatPercent>
			<iCityAttack>0</iCityAttack>
			<iCityDefense>0</iCityDefense>
			<iHillsAttack>0</iHillsAttack>
			<iHillsDefense>0</iHillsDefense>
			<iKamikazePercent>0</iKamikazePercent>
			<iRevoltProtection>0</iRevoltProtection>
			<iCollateralDamageProtection>0</iCollateralDamageProtection>
			<iPillageChange>0</iPillageChange>
			<iUpgradeDiscount>0</iUpgradeDiscount>
			<iExperiencePercent>0</iExperiencePercent>
			<TerrainAttacks/>
			<TerrainDefenses/>
			<FeatureAttacks/>
			<FeatureDefenses/>
			<UnitCombatMods/>
			<DomainMods/>
			<TerrainDoubleMoves/>
			<FeatureDoubleMoves/>
			<UnitCombats>
				<UnitCombat>
					<UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
					<bUnitCombat>1</bUnitCombat>
				</UnitCombat>
			</UnitCombats>
			<HotKey/>
			<bAltDown>0</bAltDown>
			<bShiftDown>0</bShiftDown>
			<bCtrlDown>0</bCtrlDown>
			<iHotKeyPriority>0</iHotKeyPriority>
			<Button>,Art/Interface/Buttons/Units/GreatProphet.dds,Art/Interface/Buttons/Unit_Resource_Atlas.dds,5,1</Button>
		</PromotionInfo>

		<PromotionInfo>
			<Type>PROMOTION_POISONED</Type>
			<Description>TXT_KEY_PROMOTION_POISONED</Description>
			<Sound>AS2D_POSITIVE_DINK</Sound>
			<LayerAnimationPath>NONE</LayerAnimationPath>
			<PromotionPrereq>NONE</PromotionPrereq>
			<PromotionPrereqOr1>NONE</PromotionPrereqOr1>
			<PromotionPrereqOr2>NONE</PromotionPrereqOr2>
			<TechPrereq>NONE</TechPrereq>
			<StateReligionPrereq>NONE</StateReligionPrereq>
			<bLeader>0</bLeader>
			<bBlitz>0</bBlitz>
			<bAmphib>0</bAmphib>
			<bRiver>0</bRiver>
			<bEnemyRoute>0</bEnemyRoute>
			<bAlwaysHeal>0</bAlwaysHeal>
			<bHillsDoubleMove>0</bHillsDoubleMove>
			<bImmuneToFirstStrikes>0</bImmuneToFirstStrikes>
			<iVisibilityChange>0</iVisibilityChange>
			<iMovesChange>0</iMovesChange>
			<iMoveDiscountChange>0</iMoveDiscountChange>
			<iAirRangeChange>0</iAirRangeChange>
			<iInterceptChange>0</iInterceptChange>
			<iEvasionChange>0</iEvasionChange>
			<iWithdrawalChange>0</iWithdrawalChange>
			<iCargoChange>0</iCargoChange>
			<iCollateralDamageChange>0</iCollateralDamageChange>
			<iBombardRateChange>0</iBombardRateChange>
			<iFirstStrikesChange>0</iFirstStrikesChange>
			<iChanceFirstStrikesChange>0</iChanceFirstStrikesChange>
			<iEnemyHealChange>0</iEnemyHealChange>
			<iNeutralHealChange>0</iNeutralHealChange>
			<iFriendlyHealChange>0</iFriendlyHealChange>
			<iSameTileHealChange>0</iSameTileHealChange>
			<iAdjacentTileHealChange>0</iAdjacentTileHealChange>
			<iCombatPercent>-20</iCombatPercent>
			<iCityAttack>0</iCityAttack>
			<iCityDefense>0</iCityDefense>
			<iHillsAttack>0</iHillsAttack>
			<iHillsDefense>0</iHillsDefense>
			<iKamikazePercent>0</iKamikazePercent>
			<iRevoltProtection>0</iRevoltProtection>
			<iCollateralDamageProtection>0</iCollateralDamageProtection>
			<iPillageChange>0</iPillageChange>
			<iUpgradeDiscount>0</iUpgradeDiscount>
			<iExperiencePercent>0</iExperiencePercent>
			<TerrainAttacks/>
			<TerrainDefenses/>
			<FeatureAttacks/>
			<FeatureDefenses/>
			<UnitCombatMods/>
			<DomainMods/>
			<TerrainDoubleMoves/>
			<FeatureDoubleMoves/>
			<UnitCombats />
			<HotKey/>
			<bAltDown>0</bAltDown>
			<bShiftDown>0</bShiftDown>
			<bCtrlDown>0</bCtrlDown>
			<iHotKeyPriority>0</iHotKeyPriority>
			<Button>,Art/Interface/Buttons/Units/GreatProphet.dds,Art/Interface/Buttons/Unit_Resource_Atlas.dds,5,1</Button>
		</PromotionInfo>
```
