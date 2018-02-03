+++
date = "2017-12-30T12:04:00"
lastmod = "2018-01-30"
draft = false
title = "それからのPython 10"
banner = "photo_pink1"
tags = ["それからのPython", "講座"]
+++

# はじめに

- [その９]({{<ref "secondpy9.md">}})のつづき
- 簡単なスペルの仕組みをつくってみる
- ４部作のうちの４回目
- ついに各スペルの実装へ

# 湧き水

お待たせしました！個別のスペル処理です。まず湧き水を見てみましょう。
<!--more-->

```
class SpellWater(Spell):
    """湧き水"""
    
    def execute(self):
        """
        直下のタイルが自チームの砂漠なら平原に変化させる
        """

        caster_plot = self._caster.plot()
        DESERT = git("TERRAIN_DESERT")
        PLAINS = git("TERRAIN_PLAINS")
        
        if caster_plot.getTeam() == self._caster.getTeam() and caster_plot.getTerrainType() == DESERT:
            caster_plot.setTerrainType(PLAINS, True, True)
            return True
            

# スペル一覧に追加
SpellInfo.spells.append(SpellInfo("SPELL_WATER", SpellWater))
```

`class SpellWater(Spell):`で、Spellというクラスをベースにして
SpellWaterというクラスをつくっています。
これは継承という仕組みを用いています。
継承について詳しく知りたい方は、[付録]({{<ref "secondpy_ex2.md">}})を参照してください。
ざっくりいうと、さきほどの共通処理に加えて、
いまから個別処理を書きますよ、と宣言しています。

先ほど空呼びしていた`execute()`を実際に書いています。

`caster_plot.getTeam() == self._caster.getTeam()`で
詠唱者がいま立っているPlotのチームと、詠唱者自身の所属チームを比較しています。
右辺はわかりやすいと思いますが、
左辺は「詠唱者がいま立っているタイルは誰の領土か」ということを表しています。
左辺のチームと右辺のチームが同じであるということは、
「詠唱者がいま立っているタイルは詠唱者自身の所属チームの領土である」、
つまり「詠唱者は自領土のタイルの上にいる」ということを表します。

`caster_plot.getTerrainType() == DESERT`で
さらにそのタイルの地形idと砂漠のidとを比較しています。
「そのタイルが砂漠である」ことを表していますね。

`and`でその両方を満たすならば、
`caster_plot.setTerrainType(PLAINS, True, True)`
地形を平原のidに設定します。
そしてこの場合、スペルは成功したことになりますから、
`return True`で、共通処理の方に「エフェクト再生してもいいよ」と伝えます。

両方を満たすというわけではない場合、
そのまま`return`を迎えないままでメソッドが終了しています。
こういった場合、戻り値として`None`という値が呼び出し元に帰ります。
これは偽扱いになりますので、それを受け取った`cast()`はエフェクトを再生しません。
ただ、昇進を取ったことをなかったことにするわけではないので、
ただの無駄撃ちになります。これは[設計]({{<ref "secondpy7.md">}}#設計しよう)のときに定めた通りです。

そして最後に***クラス外で***、
`SpellInfo.spells.append(SpellInfo("SPELL_WATER", SpellWater))`
という文を実行しています。
まず`SpellInfo("SPELL_WATER", SpellWater)`の部分で
SpellInfoインスタンスを作成しています。
SpellInfoインスタンスは「名前」と「クラスオブジェクト」を保持するのでした。
`"SPELL_WATER"`と`SpellWater`クラスをここで指定しています。

このSpellInfoインスタンスを、`SpellInfo.spells`というリストに
(クラス変数なのでした)`append()`しています。
これで、気分としては「"SPELL_WATER"という名前で、
SpellWaterクラスに個別処理が書いてある、そういうスペルがあるよ」
と登録したような感じになります。

クラス外にこの処理を書くことにより、
処理はこのファイル(KujiraEventManager.py)が最初に読み込まれたとき
(おそらくCiv4の起動時)に実行されます。
Infoに登録する情報を名前とクラスだけに絞ったのもこのためです。
ゲームが始まっていなくてもInfoだけは読み込まれるようになります。
今回はやりませんが、スペルの情報もCivilopediaに載せたいと思ったときに
このことが重要になってきます。
Civilipediaはゲームの状況とは関係なく開けるからです。

これで、湧き水の処理とスペル一覧への登録ができました。

# 毒散布
土台をある程度ちゃんと書いたおかげで、
コピペは最小限で済ませつつ、スペルを増やせるようになっています。
毒散布を見てみましょう。

``` python
class SpellPoison(Spell):
    """毒散布"""
    
    def execute(self):
        """
        周囲1マスの敵対ユニットに『毒』を与える
        """

        POISONED = git("PROMOTION_POISONED")
        units = self.selectEnemyUnits(1)
        for unit in units:
            unit.setHasPromotion(POISONED, True)

        return True

SpellInfo.spells.append(SpellInfo("SPELL_POISON", SpellPoison))

```

湧き水と同様、Spellを継承して`execute()`の中に個別処理を書いていきます。
共通処理に書いてあるので、`units = self.selectEnemyUnits(1)`とするだけで
1マス圏内にいる敵対ユニットのリストが取れてきます。
(よく使う共通処理に名前が付けられる、一度書けば呼び出すだけでいい、など、関数の利点なのでした)

ですから、あとは`units`の中の各ユニットに対して
`unit.setHasPromotion(POISONED, True)`で昇進を付与するだけです。
あらかじめ`POISONED = git("PROMOTION_POISONED")`としたことで
`POISONED`の値は"PROMOTION_POISONED"の昇進idになっていますね。

そしてスペル一覧に登録します。名前は"SPELL\_POISON"にしましょう。
これで"PROMOTION\_"を頭につけたとき、"PROMOTION\_SPELL\_POISON"になるはずです。
発動用の昇進と同じ名前になりますね。

# 火炎幕
どんどん追加していきます。火炎幕です。
``` python
class SpellFire(Spell):
    """火炎幕"""
    
    def execute(self):
        """
        周囲1マスの敵対ユニットに10%のダメージを与える
        最大40%まで
        """

        i_damage = 10
        max_damage = 40
        caster_owner = self._caster.getOwner()
        units = self.selectEnemyUnits(1)
        
        for unit in units:
            if unit.getDamage() >= max_damage:
                continue
            
            damage = min(unit.getDamage() + i_damage, max_damage)
            unit.setDamage(damage, caster_owner)

        return True

SpellInfo.spells.append(SpellInfo("SPELL_FIRE", SpellFire))

```

さっきと対象は同じで周囲１マスの敵対ユニットです。
今度は昇進付与ではなく`unit.setDamage(damage, caster_owner)`としています。

これは文字通りダメージ値を上書きさせるメソッドです。
全てのユニットは(戦闘力とは別に)HPを持っていて、
最大HPは戦闘力にかかわらず100です。
そしてHPが100から減っているユニットは、
その割合に応じて戦闘力にペナルティを受けます。
例えば歩兵(戦闘力20)のHPが40にまで減っているとき、
その状態での戦闘力は 20 * 0.40 = 8 という計算になります。

しかし、Civ4内部表現ではHPという形ではなく、「ダメージ値」で表されています。
といっても難しいものではなく、「ダメージ値」は
100からどれくらいHPが減っているかを表す値です。
ダメージ値が10のときは残りHP90、ダメージ値が50のときは残りHP50、
ダメージ値が100に達するとHPがなくなってユニットは撃破された扱いになります。

今回はHPが6割を切らないようにしたいので、
ダメージ値が40を超えないように、40を超える値でダメージ値を上書きしてしまわないようにします。
そもそも現在のダメージ値が40以上になっているユニットは`continue`で飛ばします。
その上で、現在ダメージ値に10を足したものを新しいダメージ値として上書きしたいのですが、
このときも40を超えないように注意する必要があります。
現在ダメージ値は状況によっては35や39かもしれないからです。
そこで`min()`関数を使って40が上限になるように新しいダメージ値を得ます。
(`min()`関数による上限設定については、[付録]({{<ref "secondpy_ex2.md">}}#メソッド巡り)に詳しいです)
そうして求めた値`damage`でダメージ値を上書きします。

`setDamage()`には第１引数に新しいダメージ値、
第２引数に「誰によるダメージか」をプレイヤーidで指定しなければなりません。
あらかじめ詠唱者のオーナーのプレイヤーidを
`caster_owner`に代入しておいて、それを指定しています。

忘れずにスペル一覧に登録します。名前は"SPELL\_FIRE"にしましょう。
"PROMOTION\_"を頭につけたら"PROMOTION\_SPELL\_FIRE"になるはずです。
発動用の昇進と同じ名前になります。

# 昇進を取得したとき
ここまでの壮大な前振りを経て、ついにスペルを発動させる部分です。
昇進を取得したときのイベントを捕まえて、
適切なクラスの`cast()`メソッドを呼び出します。見てみましょう。

``` python
class MyEventManager(CvEventManager.CvEventManager, object):

    def onUnitPromoted(self, argsList):
        'Called when a unit is promoted'
        super(self.__class__, self).onUnitPromoted(argsList)
        pUnit, iPromotion = argsList
        ##########

        for spellinfo in SpellInfo.spells:
            iSpellPromo = git(spellinfo.getPromotionName())
            if iPromotion == iSpellPromo:
                SpellClass = spellinfo.getSpellClass()
                spell = SpellClass(pUnit)
                spell.cast()

```

`onUnitPromoted()`メソッドをオーバーライドします。
引数情報は`pUnit`が昇進を取得したユニットのインスタンス、
`iPromotion`が取得された昇進のidです。

そして、スペル一覧`SpellInfo.spells`をfor文で各要素巡回します。
ここにはスペル1種類につき1つのSpellInfoインスタンスが登録されているのでした。
つまり、`spellinfo`はなんらかのスペルのSpellInfoで、
`spellinfo.getPromotionName()`とすれば
そのスペルの(名前から生成した)昇進名が得られることになります。
それをさらに`gc.getInfoTypeForString()`に通せば
スペルに対応する昇進idが得られます。

もし、いまユニットが取得した昇進と、そのスペルの昇進名が一致すれば、
ユニットの発動しようとしたスペルは正にそのスペルだと特定できたことになります。
`spellinfo.getSpellClass()`からクラスオブジェクトを取得し、
(このオブジェクトはSpellWater・SpellPoison・SpellFireのうちの
いずれか１つ、昇進名からヒットしたものになっているはずです)
そのクラスのインスタンスを作成します。

その際に詠唱者を引数として渡しましょう。
これは共通部分のところでインスタンス変数として保存・活用されるのでした。
最後に`cast()`を呼び出します。
あとのことはここまで頑張って書いてきた共通処理が`execute()`を
適切に呼び出して、適切にエフェクトを出したり出さなかったりしてくれるはずです。

# ためす
というわけで、できました。お疲れさまでした。
起動して遊んでみましょう。

# おわりに
これで「それからのPython」シリーズも終わりです。
だいぶ基礎は見についてきましたが、まだまだいろいろなMODがあります。
是非自分でも作ってみてください。
