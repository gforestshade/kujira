+++
date = "2018-05-21T23:37:10+09:00"
title = "Civ4TraitInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
Civ4TraitInfos.xmlの各項目について説明しています。

このファイルはBtSでは更新されていません。BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Warlords(J)\Assets\XML\Civilizations\CIV4TraitInfos.xml{{</path>}}

にあります。

# 間違えやすい項目
建造物の倍速・建造物からの〈幸福〉は建造物のほうで指定します。
建造物のページの[\<ProductionTraits\>]({{<ref "civ4buildinginfos">}}#productiontraits)と[\<HappinessTraits\>]({{<ref "civ4buildinginfos">}}#happinesstraits)も参照してください。

# 内容

## \<Civ4TraitInfos\>
ルートタグです。名前空間として、`"x-schema:CIV4CivilizationsSchema.xml"`を指定します。

## \<TraitInfo\>
このタグ1つが、文明の定義1つと対応しています。

以下\<TraitInfo\>の中身です。

<!--more-->

### \<Type\>
この志向の志向キーを定義します。
他と被らなければなんでも構いませんが、TRAIT\_英語名 にするのが無難です。

値：志向キー

例：
\<Type\>TRAIT\_PROTECTIVE\</Type\>

### \<Description\>
この志向の名称を指定します。

値：テキストキー

例：「防衛志向」
\<Description\>TXT\_KEY\_TRAIT\_PROTECTIVE\</Description\>

### \<ShortDescription\>
この文明の略称を指定します。
英語版では3文字、日本語版では1文字の略称を指定します。

値：テキストキー

例：(日)「防」 (英)"Pro"
\<ShortDescription\>TXT\_KEY\_TRAIT\_PROTECTIVE\_SHORT\</ShortDescription\>

### \<iHealth\>
この志向を持つ指導者は、全都市に追加の〈衛生〉+nを得ます。

負の数を指定することもでき、その場合〈不衛生〉が追加されます。
BtSでは、この属性を持つのは拡張志向です。

値：整数

例１：
\<iHealth\>0\</iHealth\>

例２：全都市に〈衛生〉+2
\<iHealth\>2\</iHealth\>

### \<iHappiness\>
この志向を持つ指導者は、全都市に追加の〈満足〉+nを得ます。

負の数を指定することもでき、その場合〈不満〉が追加されます。
BtSでは、この属性を持つのはカリスマ志向です。

値：整数

例１：
\<iHappiness\>0\</iHappiness\>

例２：全都市に〈満足〉+1
\<iHappiness\>1\</iHappiness\>

### \<iMaxAnarchy\>
革命にかかるターン数を制限します。
ここに0以上の整数nを指定した場合、
この志向を持つ指導者は、無政府状態のターン数上限がnターンになります。
とくに`0`を指定したとき、無政府状態がなくなります。

無政府状態ターンに影響を及ぼさない普通の志向の場合、負の整数を指定します。

値：整数

例１：
\<iMaxAnarchy\>-1\</iMaxAnarchy\>

例２：無政府状態0ターン
\<iMaxAnarchy\>0\</iMaxAnarchy\>

### \<iUpkeepModifier\>
社会制度の維持費に対する修正率を指定します。
この志向を持つ指導者は、社会制度の維持費が+n%されます。

BtSでは、この志向を持つのは組織志向です。

値：整数

例１：
\<iUpkeepModifier\>0\</iUpkeepModifier\>

例２：社会制度の維持管理費-50%
\<iUpkeepModifier\>-50\</iUpkeepModifier\>

### \<iLevelExperienceModifier\>
ユニットのレベルアップに必要な経験値に対する修正率を指定します。
必要経験値については[用語集]({{<ref "glossary">}}#経験値)も参照してください。

BtSでは、この志向を持つのはカリスマ志向です。

値：整数

例１：
\<iLevelExperienceModifier\>0\</iLevelExperienceModifier\>

例２：レベルアップに必要な経験値-25%
\<iLevelExperienceModifier\>-25\</iLevelExperienceModifier\>

### \<iGreatPeopleRateModifier\>
全都市の偉人ポイントへの修正率を指定します。
この志向を持つ指導者の都市では偉人ポイントの産出が+n%されます。
負の値も指定できます。

特に偉人ポイントを割合で増やさない普通の志向の場合、0を指定します。
BtSでは、この属性を持つのは哲学志向です。

値：整数

例１：
\<iGreatPeopleRateModifier\>0\</iGreatPeopleRateModifier\>

例２：偉人出生率+100%
\<iGreatPeopleRateModifier\>100\</iGreatPeopleRateModifier\>


### \<iGreatGeneralRateModifier\>
大将軍ポイントへの修正率を指定します。
この志向を持つ指導者の都市では、
全ての戦闘において大将軍ポイントの産出が+n%されます。
負の値も指定できます。

特に大将軍ポイントを割合で増やさない普通の志向の場合、0を指定します。
BtSでは、この属性を持つのは帝国主義志向です。

値：整数

例１：
\<iGreatGeneralRateModifier\>0\</iGreatGeneralRateModifier\>

例２：大将軍出現確率+100%
\<iGreatGeneralRateModifier\>100\</iGreatGeneralRateModifier\>

### \<iDomesticGreatGeneralRateModifier\>
文化圏内の大将軍ポイントへの修正率を指定します。
この社会制度を採用している文明では、
自文化圏内で行われた戦闘において大将軍ポイントの産出が+n%されます。
負の値も指定できます。

特に大将軍ポイントを割合で増やさない普通の志向の場合、0を指定します。
BtSでは、この属性を持つ社会制度はありません。

値：整数

例１：
\<iDomesticGreatGeneralRateModifier\>0\</iDomesticGreatGeneralRateModifier\>

例２：文化圏内に大将軍が出現する確率+50%
\<iDomesticGreatGeneralRateModifier\>50\</iDomesticGreatGeneralRateModifier\>

### \<iMaxGlobalBuildingProductionModifier\>
世界遺産の建設〈ハンマー〉に対する修正率を指定します。

特に遺産を加速しない普通の志向の場合、0を指定します。
BtSでは、この属性を持つのは勤労志向です。

値：整数

例１：
\<iMaxGlobalBuildingProductionModifier\>0\</iMaxGlobalBuildingProductionModifier\>

例２：文化遺産の生産+50%
\<iMaxGlobalBuildingProductionModifier\>50\</iMaxGlobalBuildingProductionModifier\>

### \<iMaxTeamBuildingProductionModifier\>
チーム遺産の建設〈ハンマー〉に対する修正率を指定します。

特に遺産を加速しない普通の志向の場合、0を指定します。
BtSでは、この属性を持つのは勤労志向です。

遺産関係の3つの属性にすべて同じ値が指定されているときに限り、説明文から効果が省略されます。(文化遺産の生産+n%に統一されます)

値：整数

例１：
\<iMaxTeamBuildingProductionModifier\>0\</iMaxTeamBuildingProductionModifier\>

例２：チームの文化遺産の生産+50%
\<iMaxTeamBuildingProductionModifier\>50\</iMaxTeamBuildingProductionModifier\>

### \<iMaxPlayerBuildingProductionModifier\>
国家遺産の建設〈ハンマー〉に対する修正率を指定します。

特に遺産を加速しない普通の志向の場合、0を指定します。
BtSでは、この属性を持つのは勤労志向です。

遺産関係の3つの属性にすべて同じ値が指定されているときに限り、説明文から効果が省略されます。(文化遺産の生産+n%に統一されます)

値：整数

例１：
\<iMaxPlayerBuildingProductionModifier\>0\</iMaxPlayerBuildingProductionModifier\>

例２：国家遺産の生産+50%
\<iMaxPlayerBuildingProductionModifier\>50\</iMaxPlayerBuildingProductionModifier\>

### \<ExtraYieldThresholds\>
〈パン〉・〈ハンマー〉・〈コイン〉の生産を+1します。
〈パン〉・〈ハンマー〉・〈コイン〉のそれぞれに、
ここに指定した閾値以上を産出するタイルに対して、その産出値が+1されます。

値：\<iExtraYieldThreshold\>のリスト
　　上から〈パン〉・〈ハンマー〉・〈コイン〉を表します。

---

例１：
\<ExtraYieldThresholds /\>

---

例２：〈コイン〉2を産出するスクエアで〈コイン〉+1
``` txt
<ExtraYieldThresholds>
    <iExtraYieldThreshold>0</iExtraYieldThreshold>
    <iExtraYieldThreshold>0</iExtraYieldThreshold>
    <iExtraYieldThreshold>2</iExtraYieldThreshold>
</ExtraYieldThresholds>
```

---

例３：
〈パン〉5を産出するスクエアで〈パン〉+1
〈ハンマー〉4を産出するスクエアで〈ハンマー〉+1
〈コイン〉3を産出するスクエアで〈コイン〉+1
``` txt
<ExtraYieldThresholds>
    <iExtraYieldThreshold>5</iExtraYieldThreshold>
    <iExtraYieldThreshold>4</iExtraYieldThreshold>
    <iExtraYieldThreshold>3</iExtraYieldThreshold>
</ExtraYieldThresholds>
```

---

なお、指定できるのは閾値のみです。+1の部分を変更することはできませんし、
+1させる回数を変更することもできません。

### \<TradeYieldModifiers\>
交易路収入の〈パン〉・〈ハンマー〉・〈コイン〉への変化率を指定します。

都市にある各交易路はそれぞれ内部に交易路収入値をもちます。
BtSでは、交易路収入が産出するのは通常〈コイン〉の100%だけです。
ここの指定によって〈コイン〉を増やしたり、
〈パン〉や〈ハンマー〉を産出させたりできます。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ志向はありません。

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

### \<CommerceChanges\>
全都市の出力に、一律で〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を加えます。

どれも追加しない場合、空タグにします。
BtSでは、この属性を持つのは創造志向です。

値：\<iCommerce\>のリスト
　　上から〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<CommerceChanges /\>

例２：〈文化〉+2/都市
``` txt
<CommerceChanges>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>2</iCommerce>
</CommerceChanges>
```

なお、BtSではバグがあり、都市から〈ゴールド〉を産出させる志向を持った状態で都市を建設し「マップを再生成」すると〈ゴールド〉が積算してしまいます。注意してください。

### \<CommerceModifiers\>
全都市の〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉への修正率を指定します。

どれも修正しない場合、空タグにします。
BtSでは、この属性を持つ志向はありません。

値：\<iCommerce\>のリスト
　　上から〈ゴールド〉・〈ビーカー〉・〈文化〉・〈諜報〉を表します。
　　後ろの要素が必要なければ、省略しても構いません。

例１：
\<CommerceModifiers /\>

例２：〈諜報〉+25%
``` txt
<CommerceModifiers>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>0</iCommerce>
    <iCommerce>25</iCommerce>
</CommerceModifiers>
```

### \<FreePromotions\>
無償の昇進の種類を指定します。
ここでは、昇進の種類のみを指定します。[\<FreePromotionUnitCombats\>](#freepromotionunitcombats)で昇進を与える対象も併せて指定してください。

値：\<FreePromotion\>のリスト

{{% div class="subnote" %}}

\<FreePromotion\>は以下の2つのタグを含みます。

#### \<PromotionType\>
無償の昇進の種類を指定します。
値：[昇進キー]({{<ref "keyichiran">}}#昇進)

#### \<bFreePromotion\>
1を指定します。

{{% /div %}}

無償の昇進を与えない志向の場合、空タグにします。

例：あとで

### \<FreePromotionUnitCombats\>
無償の昇進を与えるユニットの種類を指定します。
ここでは、昇進を与える対象のみを指定します。[\<FreePromotions\>](#freepromotions)で昇進の種類も併せて指定してください。

値：\<FreePromotionUnitCombat\>のリスト

{{% div class="subnote" %}}

\<FreePromotionUnitCombat\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
昇進を与える兵科を指定します。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<bFreePromotionUnitCombat\>
1を指定します。

{{% /div %}}

無償の昇進を与えない志向の場合、空タグにします。

例１：
\<FreePromotions /\>
\<FreePromotionUnitCombats /\>

例２：無償でスキルを供与(都市駐留Ⅰ, 教練Ⅰ):弓兵ユニット, 火器ユニット
``` txt
<FreePromotions>
    <FreePromotion>
        <PromotionType>PROMOTION_CITY_GARRISON1</PromotionType>
        <bFreePromotion>1</bFreePromotion>
    </FreePromotion>
    <FreePromotion>
        <PromotionType>PROMOTION_DRILL1</PromotionType>
        <bFreePromotion>1</bFreePromotion>
    </FreePromotion>
</FreePromotions>
<FreePromotionUnitCombats>
    <FreePromotionUnitCombat>
        <UnitCombatType>UNITCOMBAT_ARCHER</UnitCombatType>
        <bFreePromotionUnitCombat>1</bFreePromotionUnitCombat>
    </FreePromotionUnitCombat>
    <FreePromotionUnitCombat>
        <UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
        <bFreePromotionUnitCombat>1</bFreePromotionUnitCombat>
    </FreePromotionUnitCombat>
</FreePromotionUnitCombats>
```

<div style="margin:5em"></div>
