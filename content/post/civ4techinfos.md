+++
date = "2018-05-21T14:56:45+09:00"
title = "Civ4TechInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
Civ4TechInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Technologies\CIV4TechInfos.xml{{</path>}}

にあります。

# 一方向性
技術は放棄を選択できないという特性があります。
技術で設定した事項は文明全体に恒久的な影響を及ぼすことに注意してください。

# 解説
## \<Civ4TechInfos\>
ルートタグです。名前空間として、`"x-schema:CIV4TechnologiesSchema.xml"`を指定します。

## \<TechInfo\>
このタグ1つが、技術の定義1つと対応しています。

以下\<TechInfo\>の中身です。

<!--more-->

### \<Type\>
この技術の技術キーを定義します。
他と被らなければなんでも構いませんが、TECH\_英語名 にするのが無難です。

値：技術キー

例：
\<Type\>TECH\_SCIENTIFIC\_METHOD\</Type\>

### \<Description\>
この技術の名称を指定します。

値：テキストキー

例：「科学的手法」
\<Description\>TXT\_KEY\_TECH\_SCIENTIFIC\_METHOD\</Description\>

### \<Civilopedia\>
この技術のシヴィロペディアに表示される文章を指定します。

値：テキストキー

例：
\<Civilopedia\>TXT\_KEY\_TECH\_SCIENTIFIC\_METHOD\_PEDIA\</Civilopedia>

### \<Help\>
この技術の追加の説明文を指定します。
XMLに指定した要素については、説明文はある程度自動生成されますが、
PythonやDLLにおいて直接拡張したときなどに利用します。

利用しない場合は、空タグにします。

値：テキストキー

例：
\<HELP /\>

### \<Strategy\>
この技術の短い説明文を指定します。
シドのヒントやシヴィロペディアに表示されます。

値：テキストキー

例：
\<Strategy\>TXT\_KEY\_TECH\_SCIENTIFIC\_METHOD\_STRATEGY\</Strategy\>

### \<Advisor\>
次に研究する技術を決めるポップアップにおいて、どの分類になるかを指定します。
推奨技術に選ばれたときや、担当相の表示をオンにしているときなどに表示されます。

値：アドバイザーキー

例：
\<Advisor\>ADVISOR\_SCIENCE\</Advisor\>

### \<iAIWeight\>
AIの技術評価値に対して、この技術の評価値に修正を与えます。
正負どちらの値も指定でき、この技術に対する評価値が一律その分だけ加算されます。

BtSでは、この属性を持つ技術はありません。

値：整数

例：
\<iAIWeight\>0\</iAIWeight\>

### \<iAITradeModifier\>
AIの取引評価値に対して、この技術の価値に対する修正率を指定します。
この値が高いほど、AIは技術交換時にこの技術の価値をより高くみるようになります。

BtSでは、いくつかの軍事技術に対して、`10`が設定されています。

値：整数

例：
\<iAITradeModifier\>0\</iAITradeModifier\>

### \<iCost\>
この技術の研究コストを指定します。
実際の必要ビーカーは難易度や既知率などの影響を受けます。

値：正の整数

例：
\<iCost\>2400\</iCost\>


### \<iAdvancedStartCost\>
先行スタートにおいて、この技術は本来の購入コストから
ここに指定した割合(単位：%)を掛けた金額で購入できます。
-1を指定した場合、このユニットは先行スタートで購入できません。

値：整数

例１：
\<iAdvancedStartCost\>100\</iAdvancedStartCost\>

例２：先行スタート時、本来の60%の価格で購入可能
\<iAdvancedStartCost\>60\</iAdvancedStartCost\>


### \<iAdvancedStartCostIncrease\>
先行スタートにおいて、この技術は購入するごとに
ここに指定した割合で(単位：%)購入コストが増加していきます。

BtSでは、この属性を持つ技術はありません。

値：整数

例：
\<iAdvancedStartCostIncrease\>0\</iAdvancedStartCostIncrease\>

### \<Era\>
この技術の属する時代を指定します。

値：[時代キー]({{<ref "keyichiran">}}#時代)

例：
\<Era\>ERA\_INDUSTRIAL\</Era\>

### \<FirstFreeUnitClass\>
この技術の一番乗りボーナスとして与えられるユニットを指定します。
この技術を世界で初めて取得したプレイヤーは、
ここに指定したクラスを自文明で分岐させたユニットを1体無償で受けとります。

一番乗りユニットを設定しない普通の技術の場合、NONEを指定します。

値：[ユニットクラスキー]({{<ref "keyichiran">}}#ユニット)

例１：
\<FirstFreeUnitClass\>NONE\</FirstFreeUnitClass\>

例２：最初に獲得したプレイヤーが大芸術家を取得
\<FirstFreeUnitClass\>UNITCLASS\_ARTIST\</FirstFreeUnitClass\>

### \<iFeatureProductionModifier\>
森林の伐採ハンマーを増やします。
この技術を取得済みの文明は、追加地形の除去により〈ハンマー〉を得る場合に、
その〈ハンマー〉が+n%されます。

とくに地形除去による〈ハンマー〉を増やさない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は数学です。

値：整数

例１：
\<iFeatureProductionModifier\>0\</iFeatureProductionModifier\>

例２：労働者の森林の伐採により〈ハンマー〉+50%
\<iFeatureProductionModifier\>50\</iFeatureProductionModifier\>

### \<iWorkerSpeedModifier\>
労働効率の修正率を指定します。
この技術を取得済みの文明は、労働者系のコマンドが+n%早く完了します。

とくに労働効率を補正しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ社会制度は蒸気機関です。

値：整数

例１：
\<iWorkerSpeedModifier\>0\</iWorkerSpeedModifier\>

例２：労働者の作業速度+50%
\<iWorkerSpeedModifier\>50\</iWorkerSpeedModifier\>

### \<iTradeRoutes\>
追加の交易路の本数を指定します。
この技術を取得済みの文明は、全都市にn本の追加の交易路が与えられます。

BtSでは、この属性を持つのは企業と通貨です。

値：整数

例１：
\<iTradeRoutes\>0\</iTradeRoutes\>

例２：全都市に交易路+1
\<iTradeRoutes\>1\</iTradeRoutes\>

### \<iHealth\>
この技術を取得済みの文明は、全都市に追加の〈衛生〉+nを得ます。

BtSでは、この属性を持つのは遺伝子工学と未来技術です。

値：整数

例１：
\<iHealth\>0\</iHealth\>

例２：全都市に〈衛生〉+3
\<iHealth\>3\</iHealth\>

### \<iHappiness\>
この技術を取得済みの文明は、全都市に追加の〈幸福〉+nを得ます。

BtSでは、この属性を持つのは遺伝子工学と未来技術です。

値：整数

例１：
\<iHappiness\>0\</iHappiness\>

例２：全都市に〈衛生〉+3
\<iHappiness\>3\</iHappiness\>

### \<iFirstFreeTechs\>
この技術の一番乗りボーナスとして与えられる無償の技術の数を指定します。
この技術を世界で初めて取得したプレイヤーは、
ここに指定した数だけ無償の技術を受けとります。

一番乗り技術を設定しない普通の技術の場合、0を指定します。

値：整数

例１：
\<iFirstFreeTechs\>0\</iFirstFreeTechs\>

例２：最初に獲得したプレイヤーが無償のテクノロジーを取得
\<iFirstFreeTechs\>1\</iFirstFreeTechs\>

### \<iAsset\>
この技術は、ここに指定した値だけスコアを増やします。

値：整数

例：
\<iAsset\>40\</iAsset\>

### \<iPower\>
この技術は、ここに指定した値だけ軍事力を増やします。

値：整数

例：
\<iPower\>0\</iPower\>

### \<bRepeat\>
この技術は、何度でも研究できるようになります。
ここに1を指定した場合、この技術を研究完了したとき、
取得時の数値の増減について処理をした後、研究をする前の状態までビーカーが減らされます。
結果として、数値の増減をする即時的効果は(ビーカーさえ注げば)何度でも受けられるようになり、
代わりに持っている間に常時発動する解禁系や前提系の効果は一切受けられなくなります。
とくに、この技術を前提とするツリー上で先にあたる技術があると
それは取得不可能になることに注意してください。

この機能を使わない場合、0を指定します。
BtSでは、この効果を持つ技術は未来技術です。

値：0か1

例：
\<bRepeat\>0\</bRepeat\>

### \<bTrade\>
この技術の取引可否を設定します。
ここに1を指定した場合、この技術は外交取引において取引可能になります。
BtSでは、未来技術を除く全技術で`1`です。

値：0か1

例：
\<bTrade\>1\</bTrade\>

### \<bDisable\>
研究不可にします。
ここに1を指定した場合、この技術は研究や取引によって取得することができなくなります。[^disabled]
BtSでは、全技術で`0`です。

[^disabled]: 初期技術に指定したり、プログラムによって強制的に取らせることはできます。

値：0か1

例：
\<bDisable\>0\</bDisable\>

### \<bGoodyTech\>
お菓子の小屋から出るようにします。
ここに1を指定した場合、この技術は部族集落の報酬テクノロジーとして選ばれる可能性があります。

値：0か1

例：
\<bGoodyTech\>0\</bGoodyTech\>

### \<bExtraWaterSeeFrom\>
水上視界を広げます。
ここに1を指定した場合、この技術を取得済みの文明では、水タイルの視界の高さが1つ上がります。
視界の仕様はWikiの[視線の通り方](https://civ4-wiki.club/index.php?ルールの詳細%2F視線の通り方)に詳しいので、そちらも参照してください。

この機能は、文明ごとにONになるかOFFになるかの2択です。重複はしません。
この技術ではこの機能を解禁しない場合、0を指定します。
BtSでは、この属性を持つ技術は光学です。

値：0か1

例：
\<bExtraWaterSeeFrom\>0\</bExtraWaterSeeFrom\>

### \<bMapCentering\>
ここに1を指定した場合、この技術を取得済みの文明では、世界地図が球体化します。

地図を球体化しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は暦です。

値：0か1

例：
\<bMapCentering\>0\</bMapCentering\>

### \<bMapVisible\>
ここに1を指定した場合、この技術を取得したとき、その文明は全世界の世界地図を得ます。

地図を明らかにしない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は人工衛星です。

値：0か1

例：
\<bMapVisible\>0\</bMapVisible\>

### \<bMapTrading\>
地図を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに地図を載せることができるようになります。

地図の取引を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は紙です。

値：0か1

例：
\<bMapTrading\>0\</bMapTrading\>

### \<bTechTrading\>
技術を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに技術を載せることができるようになります。

技術の取引を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術はアルファベットです。

値：0か1

例：
\<bTechTrading\>0\</bTechTrading\>

### \<bGoldTrading\>
金銭を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに ゴールド と ゴールド/ターン を載せることができるようになります。

金銭の取引を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は通貨です。

値：0か1

例：
\<bGoldTrading\>0\</bGoldTrading\>

### \<bOpenBordersTrading\>
相互通商条約を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに相互通商条約を載せることができるようになります。

相互通商条約を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は筆記です。

値：0か1

例：
\<bOpenBordersTrading\>0\</bOpenBordersTrading\>

### \<bDefensivePactTrading\>
防衛協定を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに防衛協定を載せることができるようになります。

防衛協定を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は職業軍人です。

値：0か1

例：
\<bDefensivePactTrading\>0\</bDefensivePactTrading\>

### \<bPermanentAllianceTrading\>
永久同盟を取引可能にします。
ここに1を指定した場合、そのゲームで永久同盟オプションがオンであり、
取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに永久同盟を載せることができるようになります。

永久同盟を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術はファシズムと共産主義です。

値：0か1

例：
\<bPermanentAllianceTrading\>0\</bPermanentAllianceTrading\>

### \<bVassalTrading\>
属国を取引可能にします。
ここに1を指定した場合、取引当事者のどちらかがこの技術を取得済みなら、
取引テーブルに属国を載せることができるようになります。

属国を解禁しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は封建制です。

値：0か1

例：
\<bVassalTrading\>0\</bVassalTrading\>

### \<bBridgeBuilding\>
河川に橋を架けます。
ここに1を指定した場合、この技術を取得済みの文明では、河川が道を分断しないようになります。
移動力に関しては、[移動力と地形コスト]({{<ref "movement">}}#道)のコラムも参照してください。

橋を架けない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は建築学です。

値：0か1

例：
\<bBridgeBuilding\>0\</bBridgeBuilding\>

### \<bIrrigation\>
灌漑を広げます。
ここに1を指定した場合、この技術を取得済みの文明では、
灌漑されているタイルが新たに灌漑元として扱われるようになります。
灌漑に関しては、[灌漑]({{<ref "irrigation">}})のコラムも参照してください。

灌漑を広げない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は官吏です。

値：0か1

例：
\<bIrrigation\>0\</bIrrigation\>

### \<bIgnoreIrrigation\>
灌漑がなくても農場をつくれるようにします。
ここに1を指定した場合、灌漑が必要な地形改善を灌漑なしで建設できるようになります。

灌漑を無視しない普通の技術の場合、0を指定します。
BtSでは、この属性を持つ技術は生物学です。

値：0か1

例：
\<bIgnoreIrrigation\>0\</bIgnoreIrrigation\>

### \<bWaterWork\>
ここに1を指定した場合、水タイルの出力を利用できるようになります。

値：0か1

例：
\<bWaterWork\>0\</bWaterWork\>

### \<iGridX\>
技術ツリー上での横位置を指定します。
[技術ツリー上の位置](#技術ツリー上の位置)も参照してください。

値：整数

例：
\<iGridX\>13\</iGridX\>

### \<iGridY\>
技術ツリー上での縦位置を指定します。
[技術ツリー上の位置](#技術ツリー上の位置)も参照してください。

値：整数

例：
\<iGridY\>9\</iGridY\>

### \<DomainExtraMoves\>
陸・海・空ごとに移動力を追加します。
ここに指定した各行動領域を持つユニットに、一律で移動力を追加します。

値：\<DomainExtraMove\>のリスト

{{% div class="subnote" %}}

\<DomainExtraMove\>は以下の2つのタグを含みます。

#### \<DomainType\>
ユニットの行動領域を指定します。
値：[行動領域キー]({{<ref "keyichiran">}}#行動領域)

#### \<iExtraMoves\>
その行動領域をもつユニットに追加する移動力を指定します。
値：整数

{{% /div %}}

特に移動力を追加しない普通の社会制度の場合、空タグにします。
BtSでは、この属性を持つのは冷蔵技術です。

例１：
\<DomainExtraMoves /\>

例２：海洋ユニットに移動力+1
``` txt
<DomainExtraMoves>
    <DomainExtraMove>
        <DomainType>DOMAIN_SEA</DomainType>
        <iExtraMoves>1</iExtraMoves>
    </DomainExtraMove>
</DomainExtraMoves>
```

### \<CommerceFlexible\>
〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉の各出力について、スライダーを解禁します。

値は\<iCommerce\>のリストで、上から順に〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
それぞれの\<iCommerce\>では0または1を指定します。
1を指定した商業出力について、スライダーが解禁されます。

通常、〈ゴールド〉〈ビーカー〉〈諜報〉のスライダーはゲーム開始時から解禁されているので、
3番目以外の\<iCommerce\>指定はとくに意味を成しません。
また、〈諜報〉のスライダーは、解禁された後いずれかの文明と接触していないと
表示されないことに注意してください。

\<iCommerce\>を途中で止めることもできます。その場合、指定しなかった分は0とみなされます。

例１：
\<CommerceFlexible /\>

例２：〈文化〉を調整可能
``` txt
<CommerceFlexible>
    <bFlexible>0</bFlexible>
    <bFlexible>0</bFlexible>
    <bFlexible>1</bFlexible>
</CommerceFlexible>
```

### \<TerrainTrades\>
指定した基本地形を交易経路として使用可能にします。

値：\<TerrainTrade\>のリスト

{{% div class="subnote" %}}

\<TerrainTrade\>は以下の2つのタグを含みます。

#### \<TerrainType\>
交易経路として使用可能にする基本地形を指定します。
値：[基本地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bTerrainTrade\>
1を指定します。

{{% /div %}}

特に交易経路を追加しない普通の社会制度の場合、空タグにします。
BtSでは、この属性を持つのは帆走(近海)と天文学(外洋)です。

例１：
\<TerrainTrades /\>

例２：外洋で〈交易〉が可能
``` txt
<TerrainTrades>
    <TerrainTrade>
        <TerrainType>TERRAIN_OCEAN</TerrainType>
        <bTerrainTrade>1</bTerrainTrade>
    </TerrainTrade>
</TerrainTrades>
```

### \<bRiverTrade\>
ここに1を指定した場合、文化圏外の川が交易経路として使用可能になります。

値：0か1

例：
\<bRiverTrade\>0\</bRiverTrade\>

### \<Flavors\>
この技術が持つフレーバーを指定します。
この指定と指導者の好むフレーバーが近いほど、
AI指導者はこの技術を優先して研究します。

例：
``` txt
<Flavors>
	<Flavor>
		<FlavorType>FLAVOR_PRODUCTION</FlavorType>
		<iFlavor>2</iFlavor>
	</Flavor>
	<Flavor>
		<FlavorType>FLAVOR_GOLD</FlavorType>
		<iFlavor>1</iFlavor>
	</Flavor>
	<Flavor>
		<FlavorType>FLAVOR_SCIENCE</FlavorType>
		<iFlavor>10</iFlavor>
	</Flavor>
</Flavors>
```

### \<OrPreReqs\>
前提技術を指定します。
この技術を研究するには、ここに指定した技術のうちいずれか1つが必要になります。
技術ツリー上では矢印で示されます。

値：[技術キー]({{<ref "keyichiran">}}#技術)のリスト
ここには技術キーを4つまで指定可能です。
(この値は GlobalDefines.xml の NUM_OR_TECH_PREREQS で変更可能です)

例：あとで

### \<AndPreReqs\>
追加の前提技術を指定します。
この技術を研究するには、ここに指定した技術すべてが追加で必要になります。
技術ツリー上では右上にアイコンで示されます。

値：[技術キー]({{<ref "keyichiran">}}#技術)のリスト
ここには技術キーを4つまで指定可能です。
(この値は GlobalDefines.xml の NUM_AND_TECH_PREREQS で変更可能です)

例：化学か天文学、さらに活版印刷が必要
``` txt
<OrPreReqs>
	<PrereqTech>TECH_CHEMISTRY</PrereqTech>
	<PrereqTech>TECH_ASTRONOMY</PrereqTech>
</OrPreReqs>
<AndPreReqs>
	<PrereqTech>TECH_PRINTING_PRESS</PrereqTech>
</AndPreReqs>
```

### \<Quote\>
格言を指定します。

値：テキストキー

例：
\<Quote\>TXT\_KEY\_TECH\_SCIENTIFIC\_METHOD\_QUOTE\</Quote\>

### \<Sound\>
技術取得時の効果音(ジングル+格言読み上げ)を指定します。

値：2Dサウンドスクリプトキー

MOD用にジングルのみの2Dサウンドスクリプトキーも用意されており、
`AS2D_TECH_GENERIC`を指定するとBtSのジングルからランダムに再生されます。

例：
\<Sound\>AS2D_TECH_SCIMETHOD\</Sound\>

### \<SoundMP\>
マルチプレイでの技術取得時の効果音(ジングル+技術名読み上げ)を指定します。

値：2Dサウンドスクリプトキー

MOD用にジングルのみの2Dサウンドスクリプトキーも用意されており、
`AS2D_TECH_GENERIC`を指定するとBtSのジングルからランダムに再生されます。

例：
\<SoundMP\>AS2D\_TECH\_MP\_SCIMETHOD\</SoundMP\>

### \<Button\>
この技術を表すボタン画像のファイル名を指定します。
技術ツリー・交渉テーブル・研究指定選択肢などで技術のアイコンとして使用されます。

値：\\Assets\\ からの相対ファイルパス

例：
\<Button\>,Art/Interface/Buttons/TechTree/Scientific Method.dds,Art/Interface/Buttons/TechTree_Atlas.dds,8,7\</Button\>

<div style="padding:5em"></div>

## 技術ツリー上の位置
![](/img/techTree.svg)
