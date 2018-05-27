+++
date = "2018-05-25T14:27:55+09:00"
title = "CIV4PromotionInfos.xml"
banner = "photo_ice1"
categories = ["XML"]
toc = "目次"
+++

# はじめに
CIV4PromotionInfos.xmlの各項目について説明しています。

BtSパッケージ版では

{{<path>}}C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\Assets\XML\Units\CIV4PromotionInfos.xml{{</path>}}

にあります。

## \<Civ4PromotionInfos\>
ルートタグです。名前空間として、`xmlns="x-schema:CIV4UnitSchema.xml"`を指定します。

## \<PromotionInfo\>
このタグ1つが、昇進の定義1つと対応しています。

以下\<PromotionInfo\>の中身です。

<!--more-->


### \<Type\>
この昇進の昇進キーを定義します。
他と被らなければなんでも構いませんが、PROMOTION\_英語名 にするのが無難です。

値：昇進キー

例：
\<Type\>PROMOTION\_INTERCEPTION1\</Type\>

### \<Description\>
この昇進の名前を指定します。

値：テキストキー

例：「迎撃Ⅰ」
\<Description\>TXT\_KEY\_PROMOTION\_INTERCEPTION1\</Description\>

### \<Sound\>
人間プレイヤーがこの昇進を取得させた時に再生される効果音を指定します。

BtSでは、全昇進で`AS2D_IF_LEVELUP`です。

値：2Dサウンドスクリプトキー

例：
\<Sound\>AS2D\_IF\_LEVELUP\</Sound\>

### \<LayerAnimationPath\>
人間プレイヤーがこの昇進を取得させた時に再生されるアニメーションを指定します。

BtSでは、全昇進で`NONE`です。

値：アニメーションパスキー

例：
\<LayerAnimationPath\>NONE\</LayerAnimationPath\>

### \<PromotionPrereq\>
この昇進を取得するために追加で必要となる昇進を指定します。

値：[昇進キー]({{<ref "keyichiran">}}#昇進)

例：あとで

### \<PromotionPrereqOr1\>
前提昇進を指定します。

値：[昇進キー]({{<ref "keyichiran">}}#昇進)

例：あとで

### \<PromotionPrereqOr2\>
前提昇進を指定します。

値：[昇進キー]({{<ref "keyichiran">}}#昇進)

\<PromotionPrereq\>と\<PromotionPrereqOr1\>と\<PromotionPrereqOr2\>の3つをあわせて、
前提の昇進を指定します。指定の仕方によって条件が変わります。

3つとも未指定
:    この昇進は前提なしでいきなり取れる昇進になります。
(戦闘Ⅰなど)

\<PromotionPrereqOr1\>のみ指定
:    この昇進を取得するには\<PromotionPrereqOr1\>の昇進が必要になります。
(戦闘Ⅰ→戦闘Ⅱなど)

\<PromotionPrereq\>のみ指定
:    この昇進を取得するには\<PromotionPrereq\>の昇進が必要になります。
1つ上の表記と同じ効果ですが、BtSではこちらの表記はもっぱら
大将軍のマーカー昇進を前提とする場合に使用されています。
(ウォーロードが指揮→リーダーシップなど)

\<PromotionPrereqOr1\>と\<PromotionPrereqOr2\>を指定
:    この昇進を取得するには\<PromotionPrereqOr1\>と\<PromotionPrereqOr2\>のどちらかの昇進が必要になります。
(戦闘Ⅰか教練Ⅰ→急襲など)

\<PromotionPrereq\>と\<PromotionPrereqOr1\>を指定
:    この昇進を取得するには、\<PromotionPrereq\>と\<PromotionPrereqOr1\>の両方の昇進が必要になります。
(ウォーロードが指揮＋衛生兵Ⅱ→衛生兵Ⅲなど)

\<PromotionPrereq\>と\<PromotionPrereqOr1\>と\<PromotionPrereqOr2\>をすべて指定
:    この昇進を取得するには、\<PromotionPrereq\>がまず必要で、
そのうえで\<PromotionPrereqOr1\>か\<PromotionPrereqOr2\>のどちらかの昇進が必要になります。
(BtSでの例なし)

---

例１：
\<PromotionPrereq\>NONE\</PromotionPrereq\>
\<PromotionPrereqOr1\>NONE\</PromotionPrereqOr1\>
\<PromotionPrereqOr2\>NONE\</PromotionPrereqOr2\>

---

例２：戦闘Ⅰが必要
\<PromotionPrereq\>NONE\</PromotionPrereq\>
\<PromotionPrereqOr1\>PROMOTION\_COMBAT1\</PromotionPrereqOr1\>
\<PromotionPrereqOr2\>NONE\</PromotionPrereqOr2\>

---

例３：戦闘Ⅰか教練Ⅰが必要
\<PromotionPrereq\>NONE\</PromotionPrereq\>
\<PromotionPrereqOr1\>PROMOTION\_COMBAT1\</PromotionPrereqOr1\>
\<PromotionPrereqOr2\>PROMOTION\_DRILL1\</PromotionPrereqOr2\>

---

例４：戦闘Ⅱと教練Ⅱが必要
\<PromotionPrereq\>PROMOTION\_COMBAT2\</PromotionPrereq\>
\<PromotionPrereqOr1\>PROMOTION\_DRILL2\</PromotionPrereqOr1\>
\<PromotionPrereqOr2\>NONE\</PromotionPrereqOr2\>

### \<TechPrereq\>
前提技術を指定します。

技術による制限を設けない普通の昇進の場合、NONEを指定します。
BtSでは、この属性を持つ昇進は急襲(火薬)・電撃戦(軍事科学)・特別奇襲(軍事科学)です。

値：[技術キー]({{<ref "keyichiran">}}#技術)

例１：
\<TechPrereq\>NONE\</TechPrereq\>

例２：軍事科学が必要
\<TechPrereq\>TECH\_MILITARY\_SCIENCE\</TechPrereq\>

### \<StateReligionPrereq\>
前提宗教を指定します。
ここに指定した宗教を国教に制定している間だけ、
この昇進を取得することができるようになります。[^sr]

[^sr]: この制限は、昇進を取得する時点の国教のみを参照します。ユニットの生産された都市にそれが布教されている必要はありませんし、一度取ったら国境を変えても昇進は残ります。

国教による制限を設けない普通の昇進の場合、NONEを指定します。
BtSでは、この属性を持つ昇進はありません。

例１：
\<StateReligionPrereq\>NONE\</StateReligionPrereq\>

例２：ユダヤ教が必要
\<StateReligionPrereq\>RELIGION_JUDAISM\</StateReligionPrereq\>

### \<bLeader\>
大将軍専用昇進にします。
ここに1を指定した場合、この昇進は大将軍をユニットに合流させることでしか付与できないようになります。
実際に使用する際は、大将軍ユニットの[\<LeaderPromotion\>]({{<ref "civ4unitinfos">}}#leaderpromotion)にもこの昇進の昇進キーを指定してください。

BtSでは、この属性を持つ昇進はウォーロードが指揮のみです。

値：0か1

例：
\<bLeader\>0\</bLeader\>

### \<bBlitz\>
電撃戦効果を与えます。
ユニットは通常1ターンに1回しか攻撃できませんが、
ここに1を指定した場合、この昇進を持つユニットは移動力が残っている限り何度でも攻撃できるようになります。

この属性を持つ昇進は、防御専用ユニットに取得させることはできません。

BtSでは、この属性を持つ昇進は電撃戦です。

値：0か1

例：
\<bBlitz\>0\</bBlitz\>

### \<bAmphib\>
上陸ペナルティを無効にします。
ここに1を指定した場合、この昇進を持つユニットは水タイルから陸タイルを攻撃しても
上陸ペナルティを受けなくなります。

この属性を持つ昇進は、防御専用ユニットに取得させることはできません。

BtSでは、この属性を持つ昇進は水陸両用です。

値：0か1

例：
\<bAmphib\>0\</bAmphib\>

### \<bRiver\>
渡河ペナルティを無効にします。
ここに1を指定した場合、この昇進を持つユニットは川を挟んで攻撃しても
渡河ペナルティを受けなくなります。

この属性を持つ昇進は、防御専用ユニットに取得させることはできません。

BtSでは、この属性を持つ昇進は水陸両用です。

値：0か1

例：
\<bRiver\>0\</bRiver\>

### \<bEnemyRoute\>
特別奇襲効果を与えます。
ここに1を指定した場合、この昇進を持つユニットは
敵対領地にある道によって地形コストの減少を受けられるようになります。

BtSでは、この属性を持つ昇進は特別奇襲です。

値：0か1

例：
\<bEnemyRoute\>0\</bEnemyRoute\>

### \<bAlwaysHeal\>
毎ターン回復判定を受けられるようにします。
ユニットは通常そのターンに移動していなかった場合のみ回復判定が生じますが、
ここに1を指定した場合、この昇進を持つユニットは
移動したかどうかに関係なく毎ターン回復判定が生じるようになります。

BtSでは、この属性を持つ昇進は行軍です。

値：0か1

例：
\<bAlwaysHeal\>0\</bAlwaysHeal\>

### \<bHillsDoubleMove\>
丘陵をより速く移動できるようにします。
ここに1を指定した場合、この昇進を持つユニットは
丘陵の地形コストを半減して計算します。

BtSでは、この属性を持つ昇進はゲリラⅡです。

値：0か1

例：
\<bHillsDoubleMove\>0\</bHillsDoubleMove\>

### \<bImmuneToFirstStrikes\>
敵の先制攻撃を無効化します。
ここに1を指定した場合、この昇進を持つユニットは戦闘する際
敵ユニットの先制攻撃属性をすべて無効にします。

BtSでは、この属性を持つ昇進は側面攻撃Ⅱです。

値：0か1

例：
\<bImmuneToFirstStrikes\>0\</bImmuneToFirstStrikes\>

### \<iVisibilityChange\>
視界を加算します。
ここに正の整数nを指定した場合、この昇進を持つユニットは
さらにnタイル先までを見通せるようになります。
負の数も指定でき、その場合視界は狭まります。

とくに視界を増やさない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は歩哨です。

値：整数

例：
\<iVisibilityChange\>0\</iVisibilityChange\>

### \<iMovesChange\>
移動力を加算します。
ここに正の整数nを指定した場合、この昇進を持つユニットは移動力が+nされます。
負の数も指定できます。

とくに移動力を増やさない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は航海術Ⅰ・航海術Ⅱ・士気です。

値：整数

例：
\<iMovesChange\>0\</iMovesChange\>

### \<iMoveDiscountChange\>
難地形を移動しやすくします。
ここに正の整数nを指定した場合、この昇進を持つユニットは地形コストが-nされます。
正の指定で減算されることに注意してください。
負の数も指定でき、その場合は加算されます。

この機能を使わない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は機動力です。

値：整数

例：
\<iMoveDiscountChange\>0\</iMoveDiscountChange\>

### \<iAirRangeChange\>
[航空射程または間接攻撃範囲]({{<ref "civ4unitinfos">}}#iairrange)を追加します。
ここに正の整数nを指定した場合、この昇進を持つユニットは航空射程が+nされます。
仮に航空ユニット以外にこの昇進を取得することを許可した場合、間接攻撃範囲の増加になります。

とくに行動範囲を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は行動範囲Ⅰ・行動範囲Ⅱです。

値：整数

例：
\<iAirRangeChange\>0\</iAirRangeChange\>

### \<iInterceptChange\>
[迎撃成功率と空戦のダメージ係数]({{<ref "civ4unitinfos">}}#iinterceptionprobability)を追加します。
ここに正の整数nを指定した場合、この昇進を持つユニットは迎撃成功率が+n%されます。

この属性を持つ昇進は、迎撃成功率がすでに設定されているユニットにのみ取得させることができます。

とくに対空性能を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は迎撃Ⅰ・迎撃Ⅱです。

値：整数

例：
\<iInterceptChange\>10\</iInterceptChange\>

### \<iEvasionChange\>
迎撃回避率を+n%追加します。

とくに迎撃回避を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はエースのみです。

値：整数

例：
\<iEvasionChange\>0\</iEvasionChange\>

### \<iWithdrawalChange\>
撤退率を+n%追加します。

この属性を持つ昇進は、防御専用ユニットに取得させることはできません。

とくに撤退率を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はゲリラⅢ・側面攻撃Ⅰ・側面攻撃Ⅱ・戦術です。

値：整数

例：
\<iWithdrawalChange\>0\</iWithdrawalChange\>

### \<iCargoChange\>
積載量を+n追加します。

ユニットの元の積載量が0でも(ほかの前提を満たしていれば)
この属性を持つ昇進を取得することができます。
そうした場合そのユニットは貨物輸送ができるようになります。

とくに積載を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はありません。

値：整数

例：
\<iCargoChange\>0\</iCargoChange\>

### \<iCollateralDamageChange\>
[副次的損害の威力係数]({{<ref "civ4unitinfos">}}#icollateraldamage)を+n%追加します。

この属性を持つ昇進は、防御専用ユニットに取得させることはできません。
この属性を持つ昇進は、[副次的損害を与えることができる]({{<ref "civ4unitinfos">}}#icollateraldamagemaxunits)ユニットにのみ取得させることができます。

とくに副次的損害を強化しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は弾幕Ⅰ・弾幕Ⅱ・弾幕Ⅲです。

値：整数

例：
\<iCollateralDamageChange\>0\</iCollateralDamageChange\>

### \<iBombardRateChange\>
[都市に対する砲撃ダメージ]({{<ref "civ4unitinfos">}}#ibombardrate)を+n%追加します。

ユニットの元の都市砲撃力が0でも(ほかの前提を満たしていれば)
この属性を持つ昇進を取得することができます。
そうした場合そのユニットは都市砲撃ができるようになります。

文化防御削りを強化しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は精密攻撃です。

値：整数

例：
\<iBombardRateChange\>0\</iBombardRateChange\>

### \<iFirstStrikesChange\>
先制攻撃をn回追加します。

値：整数

例：
\<iFirstStrikesChange\>0\</iFirstStrikesChange\>

### \<iChanceFirstStrikesChange\>
先制攻撃の機会をn回追加します。

値：整数

例：
\<iChanceFirstStrikesChange\>0\</iChanceFirstStrikesChange\>

### \<iEnemyHealChange\>
敵領土での回復量を+n%追加します。
ユニットは戦争中の敵文明の領土内で回復判定を迎えたとき[^heal]には通常5%回復しますが、
(この基本値はGlobalDefines.xmlのENEMY\_HEAL\_RATEで変更可能です)
この昇進を持つユニットは追加で+n%回復します。

[^heal]: 回復判定は移動せずにターンを終了した場合にのみ発生します。

負の数を指定することもできます。
基本回復量を超える負の数を指定するとHPが減るようにもできます。

敵領土での回復量を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は戦闘Ⅴです。

値：整数

例：
\<iEnemyHealChange\>0\</iEnemyHealChange\>

### \<iNeutralHealChange\>
中立地帯での回復量を+n%追加します。
ユニットは敵領土でも友好領土でもない場所で回復判定を迎えたとき[^heal]には通常10%回復しますが、
(この基本値はGlobalDefines.xmlのNEUTRAL\_HEAL\_RATEで変更可能です)
この昇進を持つユニットは追加で+n%回復します。

負の数を指定することもできます。
基本回復量を超える負の数を指定するとHPが減るようにもできます。

中立地帯での回復量を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は戦闘Ⅳです。

値：整数

例：
\<iNeutralHealChange\>0\</iNeutralHealChange\>

### \<iFriendlyHealChange\>
友好領土での回復量を+n%追加します。
ユニットは自文明、属国、チームメイトのいずれかの領土で回復判定を迎えたとき[^heal]には通常15%回復しますが、
(この基本値はGlobalDefines.xmlのFRIENDLY\_HEAL\_RATEで変更可能です)
この昇進を持つユニットは追加で+n%回復します。

負の数を指定することもできます。
基本回復量を超える負の数を指定するとHPが減るようにもできます。

友好領土での回復量を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はありません。

値：整数

例：
\<iFriendlyHealChange\>0\</iFriendlyHealChange\>

### \<iSameTileHealChange\>
同タイルのユニットの回復量を+n%追加します。
この昇進を持つユニットと同じタイルにいるユニットが回復判定を迎えたとき[^notmyheal1]、
そのユニットは追加で+n%回復します。

[^notmyheal1]: 自分が回復判定を迎えている必要はありません。ただし自分も回復判定を迎えていれば、この効果は自身にも及びます。

ここに負の数を指定することはできません。
同じユニットにこの属性を複数取得させる場合、効果は累積します。
この属性を持つユニットが同スタック内に複数いる場合は、
一番大きい効果を持つユニットが優先され、ユニット間で累積はされません。

他人の回復量を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は衛生兵Ⅰ・衛生兵Ⅲ・レンジャーⅢです。

値：整数

例：
\<iSameTileHealChange\>0\</iSameTileHealChange\>

### \<iAdjacentTileHealChange\>
隣接タイルのユニットの回復量を+n%追加します。
この昇進を持つユニットと隣接したタイルにいるユニットが回復判定を迎えたとき[^notmyheal2]、
そのユニットは追加で+n%回復します。

[^notmyheal2]: 自分が回復判定を迎えている必要はありません。

ここに負の数を指定することはできません。
同じユニットにこの属性を複数取得させる場合、効果は累積します。
この属性を持つユニットが同スタック内に複数いる場合は、
一番大きい効果を持つユニットが優先され、ユニット間で累積はされません。

他人の回復量を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は衛生兵Ⅱ・衛生兵Ⅲです。

値：整数

例：
\<iAdjacentTileHealChange\>0\</iAdjacentTileHealChange\>

### \<iCombatPercent\>
戦闘力を+n%します。

値：整数

例：
\<iCombatPercent\>0\</iCombatPercent\>

### \<iCityAttack\>
都市攻撃修正率を+n%します。

値：整数

例：
\<iCityAttack\>0\</iCityAttack\>

### \<iCityDefense\>
都市防御修正率を+n%します。

値：整数

例：
\<iCityDefense\>0\</iCityDefense\>

### \<iHillsAttack\>
丘陵攻撃修正率を+n%します。

値：整数

例：
\<iHillsAttack\>0\</iHillsAttack\>

### \<iHillsDefense\>
丘陵防御修正率を+n%します。

値：整数

例：
\<iHillsDefense\>0\</iHillsDefense\>

### \<iKamikazePercent\>
攻撃後に消滅する特攻ユニットにします。
ここに正の整数nを指定した場合、この昇進を持つユニットは
戦闘力に+n%の修正を受ける代わりに攻撃後に消滅するようになります。

値：整数

例：
\<iKamikazePercent\>0\</iKamikazePercent\>

### \<iRevoltProtection\>
反乱を直接抑制する能力を与えます。
ここに正の整数nを指定した場合、この昇進を持つユニットが駐留する都市は
都市の反乱率が-n%されます。

この効果はユニットの治安維持能力とは別で計算されます。
この効果を持つユニットが同じ都市に複数いる場合、
一番大きい効果を持つユニットが優先されます。

この機能を使わない場合、0を指定します。
BtSでは、この属性を持つ昇進はありません。

値：整数

例１：
\<iRevoltProtection\>0\</iRevoltProtection\>

例２：駐留している都市の暴動発生確率が100%低下
\<iRevoltProtection\>100\</iRevoltProtection\>

### \<iCollateralDamageProtection\>
副次的損害を軽減します。
ここに正の整数nを指定した場合、この昇進を持つユニットは
副次的損害によって受ける最終的なダメージが-n%されます。

とくに副次的損害を軽減しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進は教練Ⅱ・教練Ⅳです。

値：整数

例：
\<iCollateralDamageProtection\>0\</iCollateralDamageProtection\>

### \<iPillageChange\>
改善を略奪して得られる〈ゴールド〉に対する修正率を指定します。

とくに略奪金を追加しない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はありません。

値：整数

例１：
\<iPillageChange\>0\</iPillageChange\>

例２：+100%の〈ゴールド〉を略奪によって獲得
\<iPillageChange\>100\</iPillageChange\>

### \<iUpgradeDiscount\>
アップグレード費を割合で減らします。
この昇進を持つユニットは、別の兵科へアップグレードする際の〈ゴールド〉が-n%されます。

とくにアップグレード費を減らさない普通の昇進の場合、0を指定します。
BtSでは、この属性を持つ昇進はウォーロードが指揮です。

同じユニットがこの属性を持つ昇進を複数取得すると効果が重複しますが、
-100%を超えても重複するため、その場合はアップグレード費がマイナスになります。
その状態でアップグレードを実行すると逆に〈ゴールド〉を得ることになります。

例１：
\<iUpgradeDiscount\>0\</iUpgradeDiscount\>

例２：無償アップグレード
\<iUpgradeDiscount\>100\</iUpgradeDiscount\>

### \<TerrainAttacks\>
対[基本地形]({{<ref "keyichiran">}}#基本地形)攻撃の戦闘力修正を指定します。
この昇進を持つユニットがここに指定した基本地形にいる敵ユニットを攻撃するとき、
+n%の戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はありません。

値：\<TerrainAttack\>のリスト

{{% div class="subnote" %}}

\<TerrainAttack\>は以下の2つのタグを含みます。

#### \<TerrainType\>
修正を与える基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<iTerrainAttack\>
その基本地形を攻撃するときの戦闘力修正率を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<TerrainAttacks /\>

例２：+100% 氷土攻撃
``` plain
<TerrainAttacks>
    <TerrainAttack>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <iTerrainAttack>100</iTerrainAttack>
    </TerrainAttack>
</TerrainAttacks>
```


### \<TerrainDefenses\>
[基本地形]({{<ref "keyichiran">}}#基本地形)防御の戦闘力修正を指定します。
この昇進を持つユニットがここに指定した基本地形にいる状態で敵ユニットから攻撃されるとき、
+n%の戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はありません。

値：\<TerrainDefense\>のリスト

{{% div class="subnote" %}}

\<TerrainDefense\>は以下の2つのタグを含みます。

#### \<TerrainType\>
修正を与える基本地形を指定します。
値：[地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<iTerrainDefense\>
その基本地形で防御するときの戦闘力修正率を指定します。(単位：%)
値：整数

{{% /div %}}


例１：
\<TerrainDefenses /\>

例２：ツンドラによる防御力+50%
```plain
<TerrainDefenses>
    <TerrainDefense>
        <TerrainType>TERRAIN_TUNDRA</TerrainType>
        <iTerrainDefense>50</iTerrainDefense>
    </TerrainDefense>
</TerrainDefenses>
```

### \<FeatureAttacks\>
対[追加地形]({{<ref "keyichiran">}}#追加地形)攻撃の戦闘力修正を指定します。
この昇進を持つユニットがここに指定した追加地形にいる敵ユニットを攻撃するとき、
+n%の戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はレンジャーⅢです。

値：\<FeatureAttack\>のリスト

{{% div class="subnote" %}}

\<FeatureAttack\>は以下の2つのタグを含みます。

#### \<FeatureType\>
修正を与える追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<iFeatureAttack\>
その追加地形を攻撃するときの戦闘力修正率を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<FeatureAttacks /\>

例２：+50% 森林攻撃、+50% ジャングル攻撃
``` plain
<FeatureAttacks>
    <FeatureAttack>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <iFeatureAttack>50</iFeatureAttack>
    </FeatureAttack>
    <FeatureAttack>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <iFeatureAttack>50</iFeatureAttack>
    </FeatureAttack>
</FeatureAttacks>
```

### \<FeatureDefenses\>
[追加地形]({{<ref "keyichiran">}}#追加地形)防御の戦闘力修正を指定します。
この昇進を持つユニットがここに指定した追加地形にいる状態で敵ユニットから攻撃されるとき、
+n%の戦闘力修正を受けます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はレンジャーⅠ・レンジャーⅡです。

値：\<FeatureDefense\>のリスト

{{% div class="subnote" %}}

\<FeatureDefense\>は以下の2つのタグを含みます。

#### \<FeatureType\>
修正を与える追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<iFeatureDefense\>
その追加地形で防御するときの戦闘力修正率を指定します。(単位：%)
値：整数

{{% /div %}}


例１：
\<FeatureDefenses /\>

例２：森林による防御力+20%、ジャングルによる防御力+20%
```plain
<FeatureDefenses>
    <FeatureDefense>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <iFeatureDefense>20</iFeatureDefense>
    </FeatureDefense>
    <FeatureDefense>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <iFeatureDefense>20</iFeatureDefense>
    </FeatureDefense>
</FeatureDefenses>
```

### \<UnitCombatMods\>
兵科ごとの戦闘力修正を指定します。
この昇進を持つユニットは、指定された特定の兵科と戦闘する際、
+n%の戦闘力修正を受けます。

この機能を使わない場合、空タグにします。

値：\<UnitCombatMod\>のリスト

{{% div class="subnote" %}}

\<UnitCombatMod\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
修正を与える兵科を指定します。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<iUnitCombatMod\>
その兵科と戦闘するときの戦闘力修正率を指定します。(単位：%)
値：整数

{{% /div %}}

例１：
\<UnitCombatMods /\>

例２：対白兵+25%
``` plain
<UnitCombatMods>
    <UnitCombatMod>
        <UnitCombatType>UNITCOMBAT_MELEE</UnitCombatType>
        <iUnitCombatMod>25</iUnitCombatMod>
    </UnitCombatMod>
</UnitCombatMods>
```

### \<DomainMods\>
行動領域ごとの戦闘力修正を指定します。
この昇進を持つユニットが、指定された行動領域のユニットと戦闘する際、
+n%の戦闘力修正を得ます。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はありません。

値：\<DomainMod\>のリスト

{{% div class="subnote" %}}

\<DomainMod\>は以下の2つのタグを含みます。

#### \<DomainType\>
修正を与える行動領域を指定します。
値：[ユニット領域キー]({{<ref "keyichiran">}}#行動領域)

#### \<iDomainMod\>
その行動領域を持つユニットに対しての戦闘力修正率を指定します。(単位：%)
値：整数
{{% /div %}}


例１：
\<DomainMods /\>

例２：海洋ユニットに対して-50%
``` plain
<DomainMods>
    <DomainMod>
        <DomainType>DOMAIN_SEA</DomainType>
        <iDomainMod>-50</iDomainMod>
    </DomainMod>
</DomainMods>
```

### \<TerrainDoubleMoves\>
特定の[基本地形]({{<ref "keyichiran">}}#基本地形)をより速く移動できるようにします。
この昇進を持つユニットは、ここに指定された各地形の地形コストを半減して計算します。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はありません。

値：\<TerrainDoubleMove\>のリスト

{{% div class="subnote" %}}

\<TerrainDoubleMove\>は以下の2つのタグを含みます。

#### \<TerrainType\>
地形コストを半減する基本地形を指定します。
値：[基本地形キー]({{<ref "keyichiran">}}#基本地形)

#### \<bTerrainDoubleMove\>
1を指定します。
{{% /div %}}


例１：
\<TerrainDoubleMoves /\>

例２：氷土の移動力2倍
``` txt
<TerrainDoubleMoves>
    <TerrainDoubleMove>
        <TerrainType>TERRAIN_SNOW</TerrainType>
        <bTerrainDoubleMove>1</bTerrainDoubleMove>
    </TerrainDoubleMove>
</TerrainDoubleMoves>
```


### \<FeatureDoubleMoves\>
特定の[追加地形]({{<ref "keyichiran">}}#追加地形)をより速く移動できるようにします。
この昇進を持つユニットは、ここに指定された各地形の地形コストを半減して計算します。

この機能を使わない場合、空タグにします。
BtSでは、この属性を持つ昇進はレンジャーⅡです。

値：\<FeatureDoubleMove\>のリスト

{{% div class="subnote" %}}

\<FeatureDoubleMove\>は以下の2つのタグを含みます。

#### \<FeatureType\>
地形コストを半減する追加地形を指定します。
値：[追加地形キー]({{<ref "keyichiran">}}#追加地形)

#### \<bFeatureDoubleMove\>
1を指定します。
{{% /div %}}


例１：
\<FeatureDoubleMoves /\>

例２：森林・ジャングルの移動力2倍
``` txt
<FeatureDoubleMoves>
    <FeatureDoubleMove>
        <FeatureType>FEATURE_JUNGLE</FeatureType>
        <bFeatureDoubleMove>1</bFeatureDoubleMove>
    </FeatureDoubleMove>
    <FeatureDoubleMove>
        <FeatureType>FEATURE_FOREST</FeatureType>
        <bFeatureDoubleMove>1</bFeatureDoubleMove>
    </FeatureDoubleMove>
</FeatureDoubleMoves>
```

### \<UnitCombats\>
この昇進を取らせる兵科を指定します。
ここに指定されたユニット戦闘タイプをもつユニットのみが、
この昇進をレベルアップで取得できるようになります。[^uc]

[^uc]: これは取得条件の1つにすぎません。実際に取得するにはそのユニットがすべての取得条件を満たしている必要があります。

ここを空タグにすると、この昇進は取得できなくなります。
全ユニットを対象とする場合は、すべてのユニット戦闘タイプを並べて記述してください。

値：\<UnitCombat\>のリスト

{{% div class="subnote" %}}

\<UnitCombat\>は以下の2つのタグを含みます。

#### \<UnitCombatType\>
取得を許可する兵科を指定します。
値：[ユニット戦闘タイプキー]({{<ref "keyichiran">}}#兵科)

#### \<bUnitCombat\>
1を指定します。
{{% /div %}}


例：取得可能兵科として航空ユニットと火器ユニットを指定する
``` txt
<UnitCombats>
    <UnitCombat>
        <UnitCombatType>UNITCOMBAT_AIR</UnitCombatType>
        <bUnitCombat>1</bUnitCombat>
    </UnitCombat>
    <UnitCombat>
        <UnitCombatType>UNITCOMBAT_GUN</UnitCombatType>
        <bUnitCombat>1</bUnitCombat>
    </UnitCombat>
</UnitCombats>
```


### \<HotKey\>
この昇進を取得するショートカットキーを定義します。

BtSでは、この属性を持つ昇進はありません。

値：キーボードキー

例：あとで

### \<bAltDown\>
1を指定した場合、この昇進を取得するショートカットキーにAltキーを追加します。

値：0か1

例：あとで

### \<bShiftDown\>
1を指定した場合、この昇進を取得するショートカットキーにShiftキーを追加します。

値：0か1

例：あとで

### \<bCtrlDown\>
1を指定した場合、この昇進を取得するショートカットキーにCtrlキーを追加します。

値：0か1

例：ショートカットキーなし
\<HotKey /\>
\<bAltDown\>0\</bAltDown\>
\<bShiftDown\>0\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>

例：\<W\>
\<HotKey\>KB_W\<HotKey\>
\<bAltDown\>0\</bAltDown\>
\<bShiftDown\>0\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>

例：\<Shift+Alt+W\>
\<HotKey\>KB_W\<HotKey\>
\<bAltDown\>1\</bAltDown\>
\<bShiftDown\>1\</bShiftDown\>
\<bCtrlDown\>0\</bCtrlDown\>

### \<iHotKeyPriority\>
ショートカットキーの優先度を指定します。
ショートカットキーが被ってしまったとき、
ここに指定した値が大きいほうが優先されます。

例：
\<iHotKeyPriority\>0\</iHotKeyPriority\>

### \<Button\>
この昇進を表すボタン画像のファイル名を指定します。
昇進のアイコンとして使用されます。

値：\\Assets\\ からの相対ファイルパス

例：
\<Button\>,Art/Interface/Buttons/TechTree/Corporation.dds,Art/Interface/Buttons/Beyond_the_Sword_Atlas.dds,3,15\</Button\>

<div style="padding:5em"></div>
