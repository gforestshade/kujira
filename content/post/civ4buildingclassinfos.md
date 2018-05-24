+++
date = "2018-05-22"
title = "CIV4BuildingClassInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4BuildingClassInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Buildings\CIV4BuildingClassInfos.xml{{</path>}}

にあります。

# 遺産と建造物
遺産も一般建造物も、XML上ではどちらも建造物です。
違うのは、このファイルで指定する建造数制限だけで、
遺産ができることは一般建造物でもできますし、
(遺産並みの強力な効果を持ち、完成ムービーを持つ一般建造物をつくる など)　
逆に一般建造物ができることは遺産にもできます。
(遺産のUBをつくる など)　

# 各タグの説明
## \<Civ4BuildingClassInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4BuildingsSchema.xml"`を指定します。

## \<BuildingClassInfo\>
このタグ1つが、建造物クラスの定義1つと対応しています。

以下\<BuildingClassInfo\>の中身です。

<!--more-->


### \<Type\>
この建造物クラスの建造物クラスキーを定義します。
他と被らなければなんでも構いませんが、BUILDINGCLASS\_英語名 にするのが無難です。

値：建造物クラスキー

例：
\<Type\>BUILDINGCLASS\_CASTLE\</Type\>

### \<Description\>
この建造物クラスの名前を指定します。

値：テキストキー

例：「城」
\<Description\>TXT\_KEY\_BUILDING\_CASTLE\</Description\>

### \<iMaxGlobalInstances\>
この建造物クラスを世界遺産として指定します。
ここに正の整数nを指定した場合、この建造物クラスは(UBも含めて)全世界合計でn個まで建設することができます。

この建造物クラスが世界遺産ではない場合、`-1`を指定します。

例１：
\<iMaxGlobalInstances\>-1\</iMaxGlobalInstances\>

例２：世界遺産(1個まで)
\<iMaxGlobalInstances\>1\</iMaxGlobalInstances\>

### \<iMaxTeamInstances\>
この建造物クラスをチーム遺産として指定します。
ここに正の整数nを指定した場合、この建造物クラスは(UBも含めて)同じチーム内で合計n個まで建設することができます。

この建造物クラスがチーム遺産ではない場合、`-1`を指定します。
BtSには、チーム遺産として指定されている建造物クラスはありません。

例１：
\<iMaxTeamInstances\>-1\</iMaxTeamInstances\>

例２：チーム遺産(1個まで)
\<iMaxTeamInstances\>1\</iMaxTeamInstances\>

### \<iMaxPlayerInstances\>
この建造物クラスを国家遺産として指定します。
ここに正の整数nを指定した場合、この建造物クラスはひとつの文明の中で合計n個まで建設することができます。

この建造物クラスが国家遺産ではない場合、`-1`を指定します。

例１：
\<iMaxPlayerInstances\>-1\</iMaxPlayerInstances\>

例２：国家遺産(1個まで)
\<iMaxPlayerInstances\>1\</iMaxPlayerInstances\>

### \<iExtraPlayerInstances\>
遺産を建て替えられるようにします。
ここに正の整数nを指定した場合、建造数上限に達していても、
さらにn個の都市でこの建造物クラスの生産をすることができるようになり、
生産完了時に文明内にある同じクラスの遺産は除去されます。

この機能を使わない場合、0を指定します。
この機能を使う場合、通常は国家遺産の建造数上限を設定したうえで、ここに1を指定します。
BtSでは、この属性を持つ建造物クラスは宮殿です。

値：整数

例１：
\<iExtraPlayerInstances\>0\</iExtraPlayerInstances\>

例２：(宮殿のように建て替え可能にする)
\<iExtraPlayerInstances\>1\</iExtraPlayerInstances\>

### \<bNoLimit\>
1都市に建てられる遺産の数にカウントされないようにします。
たとえばBtSでは非OCC時に1都市に建てられる国家遺産の数は2までですが、
ここに1が指定された国家遺産はその数にカウントされなくなります。

この機能を使わない場合、0を指定します。
BtSでは、この属性を持つの建造物クラスは宮殿です。

値：0か1

例：
\<bNoLimit\>0\</bNoLimit\>

### \<bMonument\>
そのままでは特に効果はありません。
あとでPythonにおいて、ここにどちらが指定されているか読み取ることはできます。

値：0か1

例：
\<bMonument\>0\</bMonument\>

### \<DefaultBuilding\>
この建造物クラスのデフォルトの分岐先である建造物を指定します。

値：建造物キー

例：
\<DefaultBuilding\>BUILDING\_CASTLE\</DefaultBuilding\>

### \<VictoryThresholds\>
ゲームの勝利に貢献する建造物クラスとして指定します。
その勝利を達成するための条件の1つとして、
この建造物クラスに属する建造物をn個保有することが必要になります。

値：\<VictoryThreshold\>のリスト

{{% div class="subnote" %}}

\<VictoryThreshold\>は以下の2つのタグを含みます。

#### \<VictoryType\>
この建造物クラスが貢献する勝利条件です。
値：[勝利条件キー]({{<ref "keyichiran">}}#勝利条件)

#### \<iThreshold\>
必要数を指定します。
値：整数

{{% /div %}}

普通の建造物の場合、空タグにします。

例１：
\<VictoryThresholds\>

例２：宇宙勝利のためにこの建造物クラスが1つ必要
``` txt
<VictoryThresholds>
    <VictoryThreshold>
        <VictoryType>VICTORY_SPACE_RACE</VictoryType>
        <iThreshold>1</iThreshold>
    </VictoryThreshold>
</VictoryThresholds>
```
