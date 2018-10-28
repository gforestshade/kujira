+++
date = "2018-10-29T05:45:30+09:00"
title = "CIV4GameSpeedInfo.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4GameSpeedInfo.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\GameInfo\CIV4GameSpeedInfo.xml{{</path>}}

にあります。

## \<Civ4GameSpeedInfo\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4GameInfoSchema.xml"`を指定します。

## \<GameSpeedInfo\>
このタグ1つが、ゲーム速度の定義1つと対応しています。

以下\<GameSpeedInfo\>の中身です。

<!--more-->

### \<Type\>
このゲーム速度のゲーム速度キーを定義します。
他と被らなければなんでも構いませんが、GAMESPEED\_英語名 にするのが無難です。

値：ゲーム速度キー

例：
\<Type\>GAMESPEED\_MARATHON\</Type\>

### \<Description\>
このゲーム速度の名前を指定します。

値：テキストキー

例：「マラソン」
\<Description\>TXT\_KEY\_GAMESPEED\_MARATHON\</Description\>


### \<Help\>
このゲーム速度の説明文を指定します。

値：テキストキー

例：「極度に時間の掛かるこのゲーム速度では、それぞれの時代が、ほぼ通常のゲーム１回分に値します。」
\<Help\>TXT\_KEY\_GAMESPEED\_MARATHON\_HELP\</Help\>

### \<iGrowthPercent\>
このゲーム速度のとき、都市が成長するために必要な〈パン〉の備蓄量が通常のn%になります。
値が大きいほど都市の人口が増えるのにターン数がかかるようになり、
値が小さいほど少ないターン数で都市の人口が増えるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iGrowthPercent\>300\</iGrowthPercent\>

### \<iTrainPercent\>
このゲーム速度のとき、ユニットを生産するのにかかる〈ハンマー〉コストが通常のn%になります。
値が大きいほどユニットを生産するのにターン数がかかるようになり、
値が小さいほど少ないターン数でユニットを生産できるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iTrainPercent\>200\</iTrainPercent\>

### \<iConstructPercent\>
このゲーム速度のとき、建造物を生産するのにかかる〈ハンマー〉コストが通常のn%になります。
値が大きいほど建造物を生産するのにターン数がかかるようになり、
値が小さいほど少ないターン数で建造物を生産できるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iConstructPercent\>300\</iConstructPercent\>

### \<iCreatePercent\>
このゲーム速度のとき、プロジェクトを生産するのにかかる〈ハンマー〉コストが通常のn%になります。
値が大きいほどプロジェクトを生産するのにターン数がかかるようになり、
値が小さいほど少ないターン数でプロジェクトを生産できるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iCreatePercent\>300\</iCreatePercent\>

### \<iResearchPercent\>
このゲーム速度のとき、技術を研究するのにかかる〈ビーカー〉コストが通常のn%になります。
値が大きいほど技術を研究するのにターン数がかかるようになり、
値が小さいほど少ないターン数で技術を研究できるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iResearchPercent\>300\</iResearchPercent\>

### \<iBuildPercent\>
このゲーム速度のとき、地形改善を建設するのにかかる時間が通常のn%になります。
値が大きいほど地形改善を建設するのにターン数がかかるようになり、
値が小さいほど少ないターン数で地形改善を建設できるようになります。
BtSの「普通」では100です。

値：整数

例：
\<iBuildPercent\>300\</iBuildPercent\>

### \<iImprovementPercent\>
このゲーム速度のとき、地形改善が成長するのにかかる時間が通常のn%になります。
値が大きいほど地形改善が成長するのにターン数がかかるようになり、
値が小さいほど少ないターン数で地形改善が成長するようになります。
BtSの「普通」では100です。

値：整数

例：
\<iImprovementPercent\>300\</iImprovementPercent\>

### \<iGreatPeoplePercent\>
このゲーム速度のとき、偉人が誕生するのに必要な偉人ポイントが通常のn%になります。
値が大きいほど偉人が誕生するのにターン数がかかるようになり、
値が小さいほど少ないターン数で偉人が誕生するようになります。
BtSの「普通」では100です。

値：整数

例：
\<iGreatPeoplePercent\>300\</iGreatPeoplePercent\>

### \<iCulturePercent\>
BtSでは陳腐化しました。ゲーム速度による都市の文化レベルの指定は、
こちらではなく CIV4CultureLevelInfo.xml にあります。

例：
\<iCulturePercent\>300\</iCulturePercent\>

### \<iAnarchyPercent\>
このゲーム速度のとき、無政府状態の時間が通常のn%になります。
値が大きいほど社会制度や国教の変更にターン数がかかるようになり、
値が小さいほど少ないターン数で社会制度や国教の変更ができるようになります。[^anarchy]
BtSの「普通」では100です。

[^anarchy]: とはいえ、志向で指定されない限り、革命には必ず1ターン以上かかります。速いゲーム速度ではここを小さくすることになるでしょうが、効果は限定的になるでしょう。

値：整数

例：
\<iAnarchyPercent\>200\</iAnarchyPercent\>

### \<iBarbPercent\>
このゲーム速度のとき、蛮族が沸くのにかかる時間が通常のn%になります。
値が大きいほど蛮族ユニットや蛮族都市が自然発生するのにターン数がかかるようになり、
値が小さいほど少ないターン数で蛮族ユニットや蛮族都市が自然発生するようになります。
BtSの「普通」では100です。

値：整数

例：
\<iBarbPercent\>400\</iBarbPercent\>

### \<iFeatureProductionPercent\>
このゲーム速度のとき、伐採することで得られる〈ハンマー〉が通常のn%になります。
伐採にもターン数補正がかかるため、そのままではターン当たりの伐採ハンマーが目減りしてしまいます。
それを防ぐため、通常は[\<iBuildPercent\>](ibuildpercent)と同じ値を指定します。

値：整数

例：
\<iFeatureProductionPercent\>300\</iFeatureProductionPercent\>

### \<iUnitDiscoverPercent\>
このゲーム速度のとき、偉人を電球消費したときに得られる〈ビーカー〉が通常のn%になります。
必要偉人Pにもターン数補正がかかるため、そのままではターン当たりの偉人由来ビーカーが目減りしてしまいます。
それを防ぐため、通常は[\<iGreatPeoplePercent\>](igreatPeoplepercent)と同じ値を指定します。

値：整数

例：
\<iUnitDiscoverPercent\>300\</iUnitDiscoverPercent\>

### \<iUnitHurryPercent\>
このゲーム速度のとき、偉人[^unithurry]に緊急生産させたときに得られる〈ハンマー〉が通常のn%になります。
必要偉人Pにもターン数補正がかかるため、そのままではターン当たりの偉人由来ハンマーが目減りしてしまいます。
それを防ぐため、通常は[\<iGreatPeoplePercent\>](igreatPeoplepercent)と同じ値を指定します。

[^unithurry]: 通常は大技術者

値：整数

例：
\<iUnitHurryPercent\>300\</iUnitHurryPercent\>

### \<iUnitTradePercent\>
このゲーム速度のとき、偉人[^unittrade]に通商ミッションをさせたときに得られる〈ゴールド〉が通常のn%になります。
必要偉人Pにもターン数補正がかかるため、そのままではターン当たりの偉人由来ゴールドが目減りしてしまいます。
それを防ぐため、通常は[\<iGreatPeoplePercent\>](igreatPeoplepercent)と同じ値を指定します。

[^unittrade]: 通常は大商人

値：整数

例：
\<iUnitTradePercent\>300\</iUnitTradePercent\>

### \<iUnitGreatWorkPercent\>
このゲーム速度のとき、偉人[^unitgw]に偉大な作品を完成させたときに得られる〈文化〉が通常のn%になります。
必要偉人Pにもターン数補正がかかるため、そのままではターン当たりの偉人由来文化力が目減りしてしまいます。
それを防ぐため、通常は[\<iGreatPeoplePercent\>](igreatPeoplepercent)と同じ値を指定します。

[^unitgw]: 通常は大商人

値：整数

例：
\<iUnitGreatWorkPercent\>300\</iUnitGreatWorkPercent\>

### \<iGoldenAgePercent\>
このゲーム速度のとき、黄金期の継続時間が通常のn%になります。

値：整数

例：
\<iGoldenAgePercent\>200\</iGoldenAgePercent\>

### \<iHurryPercent\>
緊急生産コストが通常のn%になります。
緊急生産に必要な人口や金銭にもターン数補正がかかるため、そのままではターン当たりの緊急生産力が目減りしてしまいます。
それを防ぐため、通常は 10000 / [\<iGrowthPercent\>](igrowthpercent) の値を指定します。

値：整数

例：
\<iHurryPercent\>33\</iHurryPercent\>

### \<iHurryConscriptAngerPercent\>
奴隷や徴兵による〈不満〉の継続時間が通常のn%になります。

値：整数

例：
\<iHurryConscriptAngerPercent\>300\</iHurryConscriptAngerPercent\>

### \<iInflationPercent\>
インフレによる維持費が通常のn%になります。
値が大きいほどインフレが進行するのにターン数がかかるようになり、
値が小さいほど少ないターン数でインフレが進行するようになります。
BtSの「普通」では30です。

値：整数

例：
\<iInflationPercent\>10\</iInflationPercent\>

### \<iInflationOffset\>
インフレ発生開始までのターン数を指定します。
値が大きいほどインフレが始まるのにターン数がかかるようになり、
値が小さいほど少ないターン数でインフレが始まるようになります。
BtSの「普通」では-90です。

値：整数

例：
\<iInflationOffset\>-270\</iInflationOffset\>

### \<iVictoryDelayPercent\>
宇宙船到達までの待ち時間と、議案を提出するまでの期間が通常のn%になります。

値：整数

例：
\<iVictoryDelayPercent\>300\</iVictoryDelayPercent\>

### \<GameTurnInfos\>
1ターンに何年、あるいは何か月経つかの指定をします。
各\<GameTurnInfo\>を上から順に適用していきます。
最後の\<GameTurnInfo\>が終了したターンに、時間勝利の判定をします。

値：\<GameTurnInfo\>のリスト

{{% div class="subnote" %}}

\<GameTurnInfo\>は以下の2つのタグを含みます。

#### \<iMonthIncrement\>
1ターンごとに何か月経つかを指定します。
値：整数

#### \<iTurnsPerIncrement\>
この指定を何ターン続けるかを指定します。
値：整数

{{% /div %}}

例１：1ターン40年を75ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>480</iMonthIncrement>
    <iTurnsPerIncrement>75</iTurnsPerIncrement>
</GameTurnInfo>
```

例２：1ターン25年を60ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>300</iMonthIncrement>
    <iTurnsPerIncrement>60</iTurnsPerIncrement>
</GameTurnInfo>
```

例３：1ターン20年を25ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>240</iMonthIncrement>
    <iTurnsPerIncrement>25</iTurnsPerIncrement>
</GameTurnInfo>
```

例４：1ターン10年を50ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>120</iMonthIncrement>
    <iTurnsPerIncrement>50</iTurnsPerIncrement>
</GameTurnInfo>
```

例４：1ターン5年を60ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>60</iMonthIncrement>
    <iTurnsPerIncrement>60</iTurnsPerIncrement>
</GameTurnInfo>
```

例４：1ターン2年を50ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>24</iMonthIncrement>
    <iTurnsPerIncrement>50</iTurnsPerIncrement>
</GameTurnInfo>
```

例４：1ターン1年を120ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>12</iMonthIncrement>
    <iTurnsPerIncrement>120</iTurnsPerIncrement>
</GameTurnInfo>
```

例４：1ターン6か月を60ターン
``` txt
<GameTurnInfo>
    <iMonthIncrement>6</iMonthIncrement>
    <iTurnsPerIncrement>60</iTurnsPerIncrement>
</GameTurnInfo>
```

<div style="padding:5em"></div>
