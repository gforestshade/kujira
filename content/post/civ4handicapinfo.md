+++
date = "2018-06-03T18:54:07+09:00"
title = "CIV4HandicapInfo.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4HandicapInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\GameInfo\CIV4HandicapInfos.xml{{</path>}}

にあります。

# 難易度の影響範囲
<em class="handicap-player">各プレイヤー向け設定値</em>
実は、難易度は人間・AI問わずすべてのプレイヤーに設定されています。
初期〈幸福〉や〈衛生〉などは、すべてのプレイヤーが、自分自身に設定されている難易度を参照します。
通常、AIプレイヤーの難易度は貴族で固定です。(これはGlobalDefines.xmlのSTANDARD_HANDICAPで変更可能です)
例：
難易度が高いほど自分の維持費が上昇する

<em class="handicap-game">ゲーム全体向け設定値</em>
すべての人間プレイヤーの難易度を平均したものが「ゲーム全体の難易度」として設定されます。
(通常、「ゲーム全体の難易度」を直接確認することはできませんが、
 シングルゲームなら人間プレイヤーが1人なので、
 その人間プレイヤーが選んだ難易度がゲーム全体の難易度と一致します。)

AIプレイヤーや蛮族に作用する設定は、この「ゲーム全体の難易度」の設定値を参照します。
例：
ゲーム全体の難易度(=人間が選択した難易度)が高いほどAIがユニット作成コストに割引を得る


# 各タグの説明
## \<Civ4HandicapInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4GameInfoSchema.xml"`を指定します。

## \<HandicapInfo\>
このタグ1つが、難易度の定義1つと対応しています。

以下\<HandicapInfo\>の中身です。

<!--more-->


### \<Type\>
この難易度の難易度キーを定義します。
他と被らなければなんでも構いませんが、HANDICAP\_英語名 にするのが無難です。

値：プロジェクトキー

例：
\<Type\>HANDICAP\_DEITY\</Type\>

### \<Description\>
この難易度の名前を指定します。

値：テキストキー

例：「天帝」
\<Description\>TXT\_KEY\_HANDICAP\_DEITY\</Description\>

### \<Help\>
この難易度の説明を指定します。

値：テキストキー

例：「フハハハ!　せいぜい頑張るんだな！」
\<Help\>TXT\_KEY\_HANDICAP\_DEITY\_HELP\</Help\>

### \<iFreeWinsVsBarbs\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが蛮族[^barb]に無条件に勝利できる回数を指定します。

[^barb]: 蛮族文明に所属しているすべてのユニットが対象になります。蛮族ユニットのほか、野生動物も対象となることに注意してください。

値：整数

例：
\<iFreeWinsVsBarbs\>0\</iFreeWinsVsBarbs\>

### \<iAnimalAttackProb\>
<em class="handicap-player">各プレイヤー向け設定値</em>
隣接した野生動物がこの難易度を選択したプレイヤーのユニットに攻撃してくる確率を指定します。(単位:%)

値：0~100までの整数

例：
\<iAnimalAttackProb\>90\</iAnimalAttackProb\>

### \<iStartingLocPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、初期位置決定処理で人間プレイヤーの順番がいつ回ってくるかを指定します。
この値が高いほど、順番が後に回ることになり、AIに神立地を取られる確率がほんの少し上がります。

値：0~100までの整数

例：
\<iStartingLocPercent\>90\</iStartingLocPercent\>

### \<iAdvancedStartPointsMod\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが成長済みスタートで受け取るポイントの倍率を指定します。

値：0~100までの整数

例：(本来の75%になる)
\<iAdvancedStartPointsMod\>75\</iAdvancedStartPointsMod\>

### \<iGold\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが受け取る初期〈ゴールド〉の量を指定します。

BtSでは、全難易度で`0`です。

値：整数

例：
\<iGold\>0\</iGold\>

### \<iFreeUnits\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが支払う、ユニット維持費の無料枠を指定します。
この値が高いほど、ユニット維持費が減ります。

値：整数

例：
\<iFreeUnits\>1\</iFreeUnits\>

### \<iUnitCostPercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、ユニット維持費がn%になります。
この値が高いほど、ユニット維持費が増えます。

値：整数

例：(本来の100%になる)
\<iUnitCostPercent\>100\</iUnitCostPercent\>

### \<iResearchPercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが、技術を取得するために必要なビーカーの倍率を指定します。
この値が高いほど、研究が重くなります。

値：整数

例：(本来の130%になる)
\<iResearchPercent\>130\</iResearchPercent\>

### \<iDistanceMaintenancePercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、距離維持費がn%になります。
この値が高いほど、維持費が高くなります。

値：整数

例：(本来の100%になる)
\<iDistanceMaintenancePercent\>100\</iDistanceMaintenancePercent\>

### \<iNumCitiesMaintenancePercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、都市数維持費がn%になります。
この値が高いほど、維持費が高くなります。

値：整数

例：(本来の100%になる)
\<iNumCitiesMaintenancePercent\>100\</iNumCitiesMaintenancePercent\>

### \<iMaxNumCitiesMaintenance\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが支払う、都市数維持費の上限を指定します。
この値が高いほど、維持費が高くなります。

値：整数

例：
\<iMaxNumCitiesMaintenance\>8\</iMaxNumCitiesMaintenance\>

### \<iColonyMaintenancePercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、植民地維持費がn%になります。
この値が高いほど、維持費が高くなります。

値：整数

例：(本来の150%になる)
\<iColonyMaintenancePercent\>150\</iColonyMaintenancePercent\>

### \<iMaxColonyMaintenance\>
<em class="handicap-player">各プレイヤー向け設定値</em>
植民地維持費の上限割合を指定します。
ここに正の整数nを指定した場合、この難易度を選択したプレイヤーが支払う植民地維持費は、
距離維持費のn%を上限とするようになります。

この値が高いほど、維持費が高くなります。
BtSでは、全難易度で`200`です。

値：整数

例：(距離維持費の200%を上限とする)
\<iMaxColonyMaintenance\>200\</iMaxColonyMaintenance\>

### \<iCorporationMaintenancePercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、企業維持費がn%になります。
この値が高いほど、維持費が高くなります。

値：整数

例：(本来の150%になる)
\<iCorporationMaintenancePercent\>150\</iCorporationMaintenancePercent\>

### \<iCivicUpkeepPercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、社会制度維持費がn%になります。
この値が高いほど、維持費が高くなります。

値：整数

例：(本来の100%になる)
\<iCivicUpkeepPercent\>100\</iCivicUpkeepPercent\>

### \<iInflationPercent\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、インフレーションがn%になります。
この値が高いほど、時代が下るほど加速度的に維持費が高くなります。

値：整数

例：(維持費のインフレが本来の100%になる)
\<iInflationPercent\>100\</iInflationPercent\>

### \<iHealthBonus\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが得る、初期〈衛生〉の量を指定します。

値：整数

例：初期〈衛生〉+2
\<iHealthBonus\>2\</iHealthBonus\>

### \<iHappyBonus\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーが得る、初期〈幸福〉の量を指定します。

値：整数

例：初期〈幸福〉+4
\<iHappyBonus\>4\</iHappyBonus\>

### \<iAttitudeChange\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
すべてのプレイヤーは、他のすべてのプレイヤーに対する外交態度に、
この値だけ修正を得ます。(この態度補正は非表示です)

この値が低いほど、人間-AI・AI-AI間を問わず一律で機嫌を取りにくくなります。

値：整数

例：
\<iAttitudeChange\>-1\</iAttitudeChange\>

### \<iNoTechTradeModifier\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
すべてのAIプレイヤーは、[進みすぎ制限数]({{<ref "civ4leaderheadinfos">}}#inotechtradethreshold)にこの倍率だけ修正を得ます。

値：0~100までの整数

例：(本来の20%の個数で進みすぎに引っかかる)
\<iNoTechTradeModifier\>20\</iNoTechTradeModifier\>

### \<iTechTradeKnownModifier\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
すべてのAIプレイヤーは、[秘密主義度]({{<ref "civ4leaderheadinfos">}}#itechtradeknownpercent)に+n%だけ修正を受けます。

値：整数

例：
\<iTechTradeKnownModifier\>0\</iTechTradeKnownModifier\>

### \<iUnownedTilesPerGameAnimal\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
誰の視界にも入っていない陸タイルnマスごとに1体の野生動物が自然沸きします。
この値が低いほど、野生動物が多く沸きます。

値：整数

例：
\<iUnownedTilesPerGameAnimal\>20\</iUnownedTilesPerGameAnimal\>

### \<iUnownedTilesPerBarbarianUnit\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
誰の視界にも入っていない陸タイルnマスごとに1体の蛮族ユニットが自然沸きします。
この値が低いほど、蛮族が多く沸きます。

値：整数

例：
\<iUnownedTilesPerBarbarianUnit\>25\</iUnownedTilesPerBarbarianUnit\>

### \<iUnownedWaterTilesPerBarbarianUnit\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
誰の視界にも入っていない水タイルnマスごとに1つの蛮族船が自然沸きします。
この値が低いほど、蛮族船が多く沸きます。

値：整数

例：
\<iUnownedWaterTilesPerBarbarianUnit\>250\</iUnownedWaterTilesPerBarbarianUnit\>

### \<iUnownedTilesPerBarbarianCity\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
誰の視界にも入っていない陸タイルnマスごとに1つの蛮族都市が自然建設されます。
この値が低いほど、蛮族都市が多く沸きます。

値：整数

例：
\<iUnownedTilesPerBarbarianCity\>80\</iUnownedTilesPerBarbarianCity\>

### \<iBarbarianCreationTurnsElapsed\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
ゲーム開始からnターンが経過するまでは、蛮族は自然沸きしません。
この値が低いほど、蛮族が多く沸きます。

値：整数

例：
\<iBarbarianCreationTurnsElapsed\>10\</iBarbarianCreationTurnsElapsed\>

### \<iBarbarianCityCreationTurnsElapsed\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
ゲーム開始からnターンが経過するまでは、蛮族都市は自然建設されません。
この値が低いほど、蛮族都市が多く沸きます。

値：整数

例：
\<iBarbarianCityCreationTurnsElapsed\>15\</iBarbarianCityCreationTurnsElapsed\>

### \<iBarbarianCityCreationProb\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
蛮族都市の自然建設判定では、最後にn%のダイスロールをして、
成功したときのみ蛮族都市が実際に自然建設されますが、
ここでその確率を指定します。
この値が高いほど、蛮族都市が多く沸きます。

値：0~100までの整数

例：
\<iBarbarianCityCreationProb\>8\</iBarbarianCityCreationProb\>

### \<iAnimalBonus\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
動物ユニットは、人間プレイヤー配下のユニットとの戦闘で+n%の修正を受けます。

この修正は動物ユニットの方に与えられます。
したがって、BtSでは0または負の数です。

値：整数

例：
\<iAnimalBonus\>0\</iAnimalBonus\>

### \<iBarbarianBonus\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
蛮族ユニットは、人間プレイヤー配下のユニットとの戦闘で+n%の修正を受けます。

この修正は蛮族ユニットの方に与えられます。
したがって、BtSでは0または負の数です。

値：整数

例：
\<iBarbarianBonus\>0\</iBarbarianBonus\>

### \<iAIAnimalBonus\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
動物ユニットは、AIプレイヤー配下のユニットとの戦闘で+n%の修正を受けます。

この修正は動物ユニットの方に与えられます。
BtSでは、全難易度で`-40`です。

値：整数

例：
\<iAIAnimalBonus\>-40\</iAIAnimalBonus\>

### \<iAIBarbarianBonus\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
蛮族ユニットは、AIプレイヤー配下のユニットとの戦闘で+n%の修正を受けます。

この修正は蛮族ユニットの方に与えられます。
BtSでは、全難易度で`-25`です。

値：整数

例：
\<iAIBarbarianBonus\>-25\</iAIBarbarianBonus\>

### \<iStartingDefenseUnits\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、
ゲーム開始時に[初期防衛兵種]({{<ref "glossary">}}#初期防衛兵種)のユニットをここに指定した数だけ受けとります。

値：整数

例：
\<iStartingDefenseUnits\>0\</iStartingDefenseUnits\>

### \<iStartingWorkerUnits\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、
ゲーム開始時に労働者ユニットをここに指定した数だけ受けとります。

値：整数

例：
\<iStartingWorkerUnits\>0\</iStartingWorkerUnits\>

### \<iStartingExploreUnits\>
<em class="handicap-player">各プレイヤー向け設定値</em>
この難易度を選択したプレイヤーは、
ゲーム開始時に[初期探索兵種]({{<ref "glossary">}}#初期探索兵種)のユニットをここに指定した数だけ受けとります。

値：整数

例：
\<iStartingExploreUnits\>0\</iStartingExploreUnits\>

### \<iAIStartingUnitMultiplier\>
<em class="handicap-game">ゲーム全体向け設定値</em>
AIに追加で与えられる開拓者の数を指定します。
全てのプレイヤーはゲーム開始時に[文明ごとに規定された初期ユニットセット]({{<ref "civ4civilizationinfos">}}#freeunitclasses)を1セット受け取りますが、
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは初期ユニットセットをさらに追加でnセット受け取ります。

BtSでは、文明固有の初期ユニットセットは全文明共通で開拓者1体です。

値：整数

例：
\<iAIStartingUnitMultiplier\>1\</iAIStartingUnitMultiplier\>

### \<iAIStartingDefenseUnits\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーはゲーム開始時に[初期防衛兵種]({{<ref "glossary">}}#初期防衛兵種)のユニットをさらに追加でn体受けとります。

値：整数

例：
\<iAIStartingDefenseUnits\>4\</iAIStartingDefenseUnits\>

### \<iAIStartingWorkerUnits\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーはゲーム開始時に労働者ユニットをここに指定した数だけ受けとります。

値：整数

例：
\<iAIStartingWorkerUnits\>1\</iAIStartingWorkerUnits\>

### \<iAIStartingExploreUnits\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーはゲーム開始時に[初期探索兵種]({{<ref "glossary">}}#初期探索兵種)のユニットをさらに追加でn体受けとります。

値：整数

例：
\<iAIStartingExploreUnits\>1\</iAIStartingExploreUnits\>

### \<iBarbarianDefenders\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
蛮族都市が自然建設された際に[初期防衛兵種]({{<ref "glossary">}}#初期防衛兵種)のユニットがn体生成されるようになります。

値：整数

例：(新しい蛮族都市に4体の弓兵を無償で提供)
\<iBarbarianDefenders\>4\</iBarbarianDefenders\>

### \<iAIDeclareWarProb\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のときの、
AIプレイヤーの戦争準備判定倍率を指定します。

BtSでは、貴族以上の全難易度で`100`です。

値：0~100までの整数

例１：
\<iAIDeclareWarProb\>100\</iAIDeclareWarProb\>

例２：(戦争を企図する確率が本来の25%になる=75%の確率でAIは無条件に戦争を思いとどまる)
\<iAIDeclareWarProb\>25\</iAIDeclareWarProb\>

### \<iAIWorkRateModifier\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは配下の労働者の作業効率に+n%の修正を得ます。

値：整数

例：(AIの労働効率+100%)
\<iAIWorkRateModifier\>100\</iAIWorkRateModifier\>

### \<iAIGrowthPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーの都市が次の人口に成長するまでに必要な貯蔵食糧数の倍率を指定します。

値：整数

例：(AIの都市の成長に必要な食料が本来の80%になる)
\<iAIGrowthPercent\>80\</iAIGrowthPercent\>

### \<iAITrainPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界ユニット以外のユニットを作成するための〈ハンマー〉がn%になります。

値：整数

例：(AIのユニット作成コストが本来の60%になる)
\<iAITrainPercent\>60\</iAITrainPercent\>

### \<iAIWorldTrainPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界ユニットを作成するための〈ハンマー〉がn%になります。

BtSでは、貴族以上の全難易度で`100`です。

値：整数

例：(AIの世界ユニット作成コストが本来の100%になる)
\<iAIWorldTrainPercent\>100\</iAIWorldTrainPercent\>

### \<iAIConstructPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界遺産以外の建造物を作成するための〈ハンマー〉がn%になります。

値：整数

例：(AIの建造物作成コストが本来の60%になる)
\<iAIConstructPercent\>60\</iAIConstructPercent\>

### \<iAIWorldConstructPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界遺産を作成するための〈ハンマー〉がn%になります。

BtSでは、貴族以上の全難易度で`100`です。

値：整数

例：(AIの世界遺産作成コストが本来の100%になる)
\<iAIWorldConstructPercent\>100\</iAIWorldConstructPercent\>

### \<iAICreatePercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界プロジェクト以外のプロジェクトを作成するための〈ハンマー〉がn%になります。

値：整数

例：(AIのプロジェクト作成コストが本来の60%になる)
\<iAICreatePercent\>60\</iAICreatePercent\>

### \<iAIWorldCreatePercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは世界プロジェクトを作成するための〈ハンマー〉がn%になります。

BtSでは、貴族以上の全難易度で`100`です。

値：整数

例：(AIの世界プロジェクト作成コストが本来の100%になる)
\<iAIWorldCreatePercent\>100\</iAIWorldCreatePercent\>

### \<iAICivicUpkeepPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーが支払う社会制度維持費がn%になります。

値：整数

例：(AIの社会制度維持費が本来の60%になる)
\<iAICivicUpkeepPercent\>60\</iAICivicUpkeepPercent\>

### \<iAIUnitCostPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーが支払うユニット維持費がn%になります。

値：整数

例：(AIのユニット維持費が本来の60%になる)
\<iAIUnitCostPercent\>60\</iAIUnitCostPercent\>

### \<iAIUnitSupplyPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーが支払うユニット補給費がn%になります。

値：整数

例：(AIのユニット補給費が本来の50%になる)
\<iAIUnitSupplyPercent\>50\</iAIUnitSupplyPercent\>

### \<iAIUnitUpgradePercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーが支払うアップグレード費がn%になります。

値：整数

例：(AIのアップグレード費が本来の50%になる)
\<iAIUnitUpgradePercent\>50\</iAIUnitUpgradePercent\>

### \<iAIInflationPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーのインフレーションがn%になります。

値：整数

例：(AIの維持費のインフレが本来の80%になる)
\<iAIInflationPercent\>80\</iAIInflationPercent\>

### \<iAIWarWearinessPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーの厭戦感情がn%になります。

値：整数

例：(AIの厭戦感情が本来の80%になる)
\<iAIWarWearinessPercent\>50\</iAIWarWearinessPercent\>

### \<iAIPerEraModifier\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーは1つ時代が進むごとに以下のコストに(乗算で)n%の修正を受けます。

- ユニット生産コスト
- 建造物生産コスト
- プロジェクト生産コスト
- ユニット維持費
- ユニット補給費
- インフレーション
- 厭戦感情
- 公民維持費
- 人口増加効率
- アップグレード費

たとえば、天帝AI(設定値:-5)がルネサンス時代(4番目の時代)にいるとき、
上の全てのコストが-20%の修正を受けます。
なお、世界遺産・世界プロジェクト・世界ユニットのコストもこの属性の影響を受けます。

値：整数

例：(1つ時代が進むごとにいろいろなコストが-5%)
\<iAIPerEraModifier\>-5\</iAIPerEraModifier\>

### \<iAIAdvancedStartPercent\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーが成長済みスタート時に受け取るポイントがn%になります。

値：整数

例：(初期ポイントが本来の170%になる)
\<iAIAdvancedStartPercent\>170\</iAIAdvancedStartPercent\>

### \<Goodies\>
<em class="handicap-game">ゲーム全体向け設定値</em>
部族集落のイベント振り分けを指定します。
ゲーム全体の難易度がこの難易度のとき、
部族集落の結果イベントはここに列挙されている中から等確率で選ばれます。

値：[部族集落タイプキー]({{<ref "keyichiran">}}#部族集落)のリスト

例：
``` txt
<Goodies>
    <GoodyType>GOODY_LOW_GOLD</GoodyType>
    <GoodyType>GOODY_LOW_GOLD</GoodyType>
    <GoodyType>GOODY_LOW_GOLD</GoodyType>
    <GoodyType>GOODY_LOW_GOLD</GoodyType>
    <GoodyType>GOODY_LOW_GOLD</GoodyType>
    <GoodyType>GOODY_MAP</GoodyType>
    <GoodyType>GOODY_WARRIOR</GoodyType>
    <GoodyType>GOODY_SCOUT</GoodyType>
    <GoodyType>GOODY_EXPERIENCE</GoodyType>
    <GoodyType>GOODY_HEALING</GoodyType>
    <GoodyType>GOODY_TECH</GoodyType>
    <GoodyType>GOODY_TECH</GoodyType>
    <GoodyType>GOODY_BARBARIANS_WEAK</GoodyType>
    <GoodyType>GOODY_BARBARIANS_WEAK</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
    <GoodyType>GOODY_BARBARIANS_STRONG</GoodyType>
</Goodies>
```

### \<FreeTechs\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
人間・AI問わず全てのプレイヤーはここに指定された技術を初期技術として獲得します。


値：\<FreeTech\>のリスト

{{% div class="subnote" %}}

\<FreeTech\>は以下の2つのタグを含みます。

#### \<TechType\>
全員に持たせる初期技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

#### \<bFreeTech\>
1を指定します。
{{% /div %}}


例１：
\<FreeTechs /\>

例２：(全員に初期技術:車輪・農業・採鉱)
``` txt
<FreeTechs>
    <FreeTech>
        <TechType>TECH_THE_WHEEL</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_AGRICULTURE</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_MINING</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
</FreeTechs>
```

### \<AIFreeTechs\>
<em class="handicap-game">ゲーム全体向け設定値</em>
ゲーム全体の難易度がこの難易度のとき、
AIプレイヤーはここに指定された技術を初期技術として獲得します。


値：\<FreeTech\>のリスト

{{% div class="subnote" %}}

\<FreeTech\>は以下の2つのタグを含みます。

#### \<TechType\>
AIに持たせる初期技術を指定します。
値：[技術キー]({{<ref "keyichiran">}}#技術)

#### \<bFreeTech\>
1を指定します。
{{% /div %}}


例１：
\<AIFreeTechs /\>

例２：(AIに初期技術:車輪・農業・狩猟・弓術)
``` txt
<AIFreeTechs>
    <FreeTech>
        <TechType>TECH_THE_WHEEL</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_AGRICULTURE</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_HUNTING</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
    <FreeTech>
        <TechType>TECH_ARCHERY</TechType>
        <bFreeTech>1</bFreeTech>
    </FreeTech>
</AIFreeTechs>
```

<div style="padding:5em"></div>
