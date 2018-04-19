+++
date = "2017-05-15T12:00:00+09:00"
draft = false
title = "MMDモデルをCiv4上で動かしたい"
banner = "green"
categories = ["MMD_to_CIV4"]

+++

# この文章について
## これは何か

- Civ4上で動くユニットをちょっと作ってみようかと思った筆者の悪戦苦闘の記録第２章
- Civ4のModdingをやったことある人向け、ではありますが、XMLもPythonもDLLも出てきませんから、経験の有無はあまり関係ないです
- 動かしたいnifファイルは入手済みの人向けです、必ずしもMMDから取ったものでなくともよいと思いますが、少なくともゲーム上で正しく読み込めるユニット用nifファイルが必要です
- Blender・3Dモデリングの知識などない筆者の記録です、きっとみんなにもできるさ

## これは何でないか
- ぐりぐり自由に動かせるわけではありません。既存のユニットと同じ動きができるようになるだけです
- 指導者画面/都市改善に使用される3Dモデルのことは未調査
- 筆者は3Dモデルに精通していません。Blenderの機能をほんとうに最低限しか使っていません<small>誰か教えてください</small>
- この章では<small>面倒なので</small>保存するタイミングを指定していません。適宜作業が失われないよう保存してください
  
# 用意するもの
## Blender2.49b

<http://download.blender.org/release/Blender2.49b/>
blender-2.49b-windows.exeを取ってきて、インストールします。
インストーラを使用して、
Please Specify where you wish to install Blender's user data files.
の質問に対して、
Use the instllation directory(ie. location chosen to install blender.exe).
を選択する必要があります。(こうしないとPyFFIがBlenderを認識してくれないらしい)

## Python 2.6.6

<http://www.python.org/ftp/python/2.6.6/python-2.6.6.msi>
指示通りでOKです。

## PyFFI2.1.11
<http://sourceforge.net/projects/pyffi/files/pyffi/2.1.11/>
PyFFI-2.1.11.cefd181.win32.exeを取ってきてインストールします。
PyFFIのインストールはBlender・Pythonの後でなければいけません。
順番を守っていれば、インストールの途中でPython2.6とBlender2.4xが認識されているはずです。チェックが入っていることを確認して、次に進みます。

Blender Nif Scripts 2.5.9
<https://github.com/niftools/blender_nif_plugin/releases/tag/blender-2.5.9>
blender_nif_scripts-2.5.9.77b0815-windows.exeを取ってきて、普通にインストールします。

## NifSkope
<https://github.com/niftools/nifskope/releases>
NifSkopeはCiv4に関してはどのバージョンを使ってもだいたい同じです。好きなのを使いましょう。安定を求めるなら枯れている1.1.3を使うのが良いでしょう。

## モデル・元となるモデル
<https://www6.atwiki.jp/vpvpwiki/pages/458.html#id_45cf69b1>
この章の方法では、お目当てのモデルのほかに、ベースとなる元モデルが必要です。
ベースモデルは、できるだけ形状が同じで、させたい待機モーションや攻撃モーションが
目当てのものに近くて、civ4modに組み込んで動作確認が取れているものが望ましいです。
BtSのモデルそのままではどうもうまくImportできないので、
できればMODで使用実績のあるものの方が良いです。
というわけで、この文章ではモンテコア式布都を[前章](mmd_to_nif.html)にしたがってnif化したものを、
[東方叙事詩](http://wikiwiki.jp/tohojojisi/?FrontPage)のライフル兵fairy01をベースにして当てはめてみることにします。

# まずNifSkope
NifSkope上である程度お膳立てが必要です。

{{<img src="/img/nifskope0.png" width="450" height="400">}}

各NiTriShapeについて、選択状態であれば強調表示されますので大体どの部位を表しているのか名前をつけておきましょう。
目視ではわからなくても適当で構いません。日本語文字化け+連番のままですと後々どれがどれだかわからなくなって困るので、今のうちに準備しておくことが目的です。

ベースモデルを一緒に開きます。

{{<img src="/img/nifskope1.png" width="800" height="350">}}

ここのNiNodeをCopy Branchして、

{{<img src="/img/nifskope2.png" width="800" height="350">}}

ここのNiNodeにPaste Branchします。
これだけだと大きさがあっていないので足元に小さく布都が見えていますが、気にしないことにして、これでNifSkope上の準備は終わりです。

# Blender2.49bの準備
Blender2.49b(以下単にBlender)を起動すると、いつもの立方体が写っています。[X]で消してしまいます。(以下キーボード操作をこのように表記します。慣例に従って大文字で表記しますが、キーボードの刻印通りにキーを１回押すという意味です)
まず画面を整えましょう。

{{<img src="/img/blender_split_area.png" width="800" height="435">}}

境界を右クリックしてSplit Area

{{<img src="/img/blender_split_area2.png" width="800" height="435">}}

左クリックで確定します。

{{<img src="/img/blender_outliner.png" width="800" height="435">}}

Window TypeをOutlinerに変更します。

# BlenderにNifを取り込む
{{<img src="/img/blender_import_nif.png" width="800" height="435">}}
nifファイルをインポートします。
ファイル名を選択します。
{{<img src="/img/blender_import_nif2.png" width="800" height="435">}}

オプションはこんな感じです。
とくに、

Scale Correction: 10.00
Texture Search Paths: ddsのあるフォルダ
Merge Skelton Roots: on
Send Geometries To Bind Position: on
Send Detached Geometries To Node Position: on
Send Bones To Bind Position: on

を入れておくとよいと思います。

{{<img src="/img/blender_scale.png" width="800" height="435">}}

こんな感じになっていればOKです。

# Blender基本操作

この節ではBlender2.49bについて長々と説明しています。

## ウィンドウ

Blender2.49bはマウスカーソルが乗っているウィンドウが自動的にアクティブになる仕組みです。
キーボードの命令も、マウスが乗っているウィンドウにしか効きません。
一時的に出てくるプルダウンメニューやその他のメニュー・確認メッセージといったものすら例外ではなく、
マウスが離れると自動的にキャンセルされて消えてしまいます。
慣れていないとびっくりしますが、慌てずにコマンドを再実行しましょう。

## 視点移動と選択操作
マウスについて。3DView上では

- 左クリックは空間上にカーソル(注目点)を打つ**だけ**
- 中クリックやホイールコロコロは視点移動
- 右クリックは個別選択

が基本です。何かを選択したいと思ったときは、Blenderでは右クリックしないといけません。またこの右クリックの仕様上、右クリックでコンテクストメニューが出てくるということはありません。選択した対象に何かしたい場合、たいていはキーボードのキーを使うことになります。
中ボタンコロコロで拡大縮小、Shift+コロコロで上下移動、Ctrl+コロコロで左右移動します。
中ボタンドラッグで視点が回転、Shift+中ボタンドラッグで視点が平行移動します。これがあるので、コロコロでの視点移動はあまり出番がありません。
3DView内の選択は右クリックですが、Outlinerでは左クリックで選択できます。紛らわしい。でも対応する3DView内の要素も選択表示されます。便利。
Outliner上で目的のものを選択するのはとても便利なのでどんどん使いましょう。以前わざわざわかりやすいよう改名したのはこのためです。
どの選択方法でも、複数選択をするときはShiftを押しながらでできます。

テンキーについて。
テンキーではより精密な視点移動ができます。マウスでうまくいかないときはテンキーも使ってみましょう。

``` plain
  [Num1]で正面、[Num3]で右側面、[Num7]で真上に視点を戻せます。
  どこ見てるかわからなくなったとき特に有効ですのでこれで戻しましょう。
  [Num2][Num4][Num6][Num8]は上下左右に15°だけ視点を回転します。
  きっちり視点を合わせたいときにはマウス中ボタンよりこれらが便利で、例えば[Num3]→[Num6]6回で真後ろから見る、みたいなこともできます。
```

用語について。
いくつか用語を説明しなければいけません。<small>間違ってたら誰か教えてください</small>


Verticles: 頂点
:    すべては頂点から始まります。頂点がたくさん集まって立体をなしているのが3Dモデルなのです。

Face: 面
:    頂点が3つ集まって、三角形の面を構成します。ポリゴンとも呼びます。一般的なモデリングでは三角形でない(多角形ですらない)こともありますが、Civ4が扱うnifのバージョンでは対応していません。

Mesh: ひとまとまりの面
:    面を集めてある程度形ができたらそれをひとまとまりにして、メッシュと呼びます。メッシュはオブジェクトです。Object Modeで選択することができます。

Vertex Group: 頂点の集まり
:    Meshとは異なり、こちらは単純な頂点の集まりです。BoneとVertex Groupを関連付けることで、骨への肉付けを実現します。

Bone: 骨
:    動きを司る最小単位です。BoneにはVertex Groupを介してVerticlesが関連付けられていて、ちょうど肉付けされているような感覚で、骨を動かすと一緒に頂点や面がついてくる仕組みになっています。

Armature: 骨格
:    ひとつづきのBonesをアーマチュアと呼びます。人型であれば骨格全体のようなイメージです。アーマチュアはオブジェクトです。Object Modeで選択することができます。

Mode: モード
:    {{<img src="/img/blender_scale.png" width="800" height="435">}}
     画像の青の部分で切り替えます。何を選択しているかによって入れるモードが違うので注意しましょう。

Object Mode: オブジェクトのモード
:    <small>そのままか！</small>オブジェクトを選択したり、選択したオブジェクト全体に何かしたりします。

Edit Mode: 成形する
:    Meshを選択中、このモードに入ることができます。選択したMesh内の頂点・辺・面といったものに対して何かします。Vertex Groupに対する操作もここでできます。

Pose Mode: 動かす
:    Armatureを選択中、このモードに入ることができます。各Boneを動かすことで、実際にポーズを取らせることができます。この章では、ちゃんと肉がついてきているか確認する作業が主です。

Draw Type: 描画タイプ
:    {{<img src="/img/blender_scale.png" width="800" height="435">}}
     画像の緑の部分で切り替えます。こちらは表示の仕方、あるいはいろんな要素がある3Dモデルの中で何を重視して表示するか、を切り替えます。

Solid
:    {{<img src="/img/blender_solid.png" width="800" height="435">}}
     デフォルトはこのタイプです。張られている面をそのまま表示します。面そのものだけを表示するので、その面に貼られる画像は描画されませんが、その分形状を把握するのに向いています。この章での主力です。

Textured
:    {{<img src="/img/blender_textured.png" width="800" height="435">}}
     面に画像を貼った状態で表示されます。実際のゲームの表示と近いので、仕上げの調整に使えるかもしれません。細かい形状を把握するのに向いていないので、あまりこの章では出番がありません。

Wireframe
:    {{<img src="/img/blender_wireframe.png" width="800" height="435">}}
     面を取り払って、辺と頂点だけを表示します。余計なものがないので、細かく操作をするのに向いているほか、面がないので、solidでは面の後ろに隠れて見えないうしろ側の頂点のことも気にした編集ができる利点があります。


# 位置合わせ

{{<img src="/img/blender_scale.png" width="800" height="435">}}

さて、デフォルトではモードはObject Modeです。この図のように、布都の分のMeshを全部選択した状態にします。(Outlinerでやるほうがやりやすいと思います)
[S]\(Scale:大きさ)を押します。拡大縮小しているのが分かります。このような動かしている途中の状態では、左クリックで確定、右クリックでキャンセルになります。<small>なかなかややこしいです。</small>だいたい重なるように大きさを合わせてください。この時点では大体で構いません。肩のあたりが重なるような感じでよいです。
妖精にはいったん退いておいてもらいます。妖精の方のMeshを全部選択して、

{{<img src="/img/blender_grab.png" width="800" height="435">}}

[G]\(Grab/move:つかむ/移動)を押します。移動していくのが分かります。左クリックで確定、右クリックでキャンセルです。右上の方へ、さらに[Num3]の視点移動から奥の方に行かせます。

{{<img src="/img/blender_armature_view.png" width="800" height="435">}}

Armatureの表示を調整します。Armatureを選択して、Buttons PanelをEditingに切り替えます。
"Armature"のタブで、X-Ray(Armatureを常に最前面に表示)・Envelope(筆者はこの形が一番見やすいと思いましたが、OctahedronやStickなどを試してもいいと思います)・Names(Bone名を表示、超捗る)をオンにしておきます。
Outlinerの目のボタンでは、表示/非表示を切り替えることができます。これが邪魔で後ろにあるものがよく見えない！というときは遠慮なく視界から消えてもらいましょう。今回は弾エフェクト・羽のBoneには用がないので、最初から非表示にしています。

最後に、大きさをちゃんと合わせましょう。布都のMeshをすべて選択して[S]、Neckという名前のBoneと首がちょうど重なるように大きさを合わせておきます。


# Armatureに割り当てる
ArmatureとMeshの関係を設定します。
再び布都のMeshをすべて選択して、できたら次にArmatureを選択して(この例だとSoundを右クリックするのがやりやすかったです・**またArmatureを選択するのは最後でなければいけません、注意**)、
Ctrl+[P]を押します。

{{<img src="/img/jma_blender_parentto.png" width="800" height="435">}}

Armatureを選択します。

{{<img src="/img/jma_blender_nameg.png" width="800" height="435">}}

Name Groupsを選択します。しつこく何回も聞いてくるので、しつこく何回もName Groupsを選びます。

Meshがどこかに行ってしまいました。中ボタンドラッグで視点を回転して見てみると、

{{<img src="/img/jma_blender_shita.png" width="800" height="435">}}
下を向いてしまったようです。改めて布都のMeshを選択して(そのままだとArmatureも選択してしまっています、Armatureの選択を外してください)、
[R][x][-90]の順に入力すると、x軸(赤軸)を回転軸として-90°回転されて立ち上がってくれます。
視点を正面に戻せなくなったら、[Num1]のことを思い出してくださいね。

# ウェイトを塗る
実際の肉付けです。

## Edit Mode
Mesh1つだけを選択した状態でEdit Modeに入ってみましょう。(例ではBodyと名前を付けたMeshを選択しています)
そのMeshに属する頂点がすべて黄色く選択された状態になります。Edit Modeでは、ほかのMeshに属する頂点を操作することはできません。逆に、何か失敗しても影響はそのMesh内にとどまるということです。便利。
どこなのかわからない場合は、非表示を活用したり、Wireframeにしたりしてみましょう。

{{<img src="/img/jma_blender_bselect.png" width="800" height="435">}}

例では、服やスカートのMeshを非表示にしてしまっています。

Edit Modeでは、何か選択している状態で[A]で選択解除、何も選択していない状態で[A]で全選択になります。

選択範囲が分からなくなってしまったり、最初から選択をやり直したくなったときは落ち着いて[A]しましょう。

さて、頂点を選択してVertex Groupに割り当てたいのですが、1つ1つ選択していては大変すぎるので、範囲選択が欲しいところです。
というわけで、矩形選択は[B]です。さっきの画像は、それを使用して首の部分を選択しようとしている場面です。四角の枠の中に入っているすべての頂点を選択します。
もうひとつ、[B][B]と入力することで、丸型に選択する機能もあります。左ドラッグしている間、丸の中に入っているすべての頂点を選択します。中ドラッグしている間、丸の中に入っているすべての頂点を選択解除します。ホイールを回すことで、丸の大きさを自在に変えられるので、かなり便利です。
[B]や[B][B]による選択は、デフォルトで継続選択です。複数選択のためにShiftを押したままにする必要はありませんから、落ち着いて選択しましょう。また、いったん選択モードを抜けたとしても継続選択になります。視点の関係でよく見えなくなったら、落ち着いて右クリックで一度抜けて、視点を調整しましょう。

{{<img src="/img/jma_blender_neck.png" width="800" height="435">}}

首の頂点が選択できたら、ここのメニューからNeckを選んで、こっちのAssignを押します。

  ただし、Assignやその横のRemoveを押すときはよく確認してください。とくに目的のもの以外をうっかり選択してしまっての誤Assignは修正作業で地味に面倒を引き起こしてしまいます。

その下のSelectとDesel.(Deselect)は比較的安全です。NeckをSelectすると、Neckに割り当てられている頂点が追加で選択された状態になります。([A]を押してからでないと、Neckだけを選択した状態にはならないことに注意してください。SelectはNeckを「追加で」選択します。)
NeckをDeselectすると、Neckに割り当てられている頂点が選択範囲から外れます。SelectとDeselectを交互に押すと、Neckの部分が点いたり消えたりするのが分かると思います。
NeckにAssignすると、選択範囲の頂点がNeckに入ります。(選択範囲がNeckになるわけではないことに注意してください。あくまで選択範囲をNeckに追加するだけです。ほかの頂点もNeckに属していたなら、それらはそのまま残ります。)
NeckからRemoveすると、選択範囲の頂点がNeckから取り除かれます。(空っぽになるわけではないことに注意してください。あくまで今選択している頂点をNeckから取り除くだけです。)
SelectとDeselectはNeck→選択範囲への影響・AssignとRemoveは選択範囲→Neckへの影響だと考えましょう。

基本的にはこの作業をどこにも割り当てていない頂点がなくなるまでMeshの各部を適切なBone(と同名のVertex Group)に割り当てていくだけです。

fairy01では
- 顔・頭・髪→Head
- 首→Neck
- 上半身→Body
- 右肩～右ひじ→Rhand2
- 右ひじ～右手首→Rhand3
- 右手→Rhand4
- 腰→Weast
- 右下半身～右ひざ→Rleg2
- 右ひざ～右足首→Rleg3
- 右足→Rleg4

という割り当てになっているようです。

ベースが他の人型であったり、人型でなかったりして、どこをどう割り当ててよいか悩む場合、Pose ModeやWeight Paint Modeを使うとよいです。

## Pose Mode
Armatureを選択中、Pose Modeに入れます。Pose Mode中は、Boneを個別に選択できるようになり、各Boneを[G]で動かしたり[R]で回転したりできるようになります。もちろん、肉付けされている場合は、一緒についてきます。視点を引いてfairy01も見える状態で動かしてみることで同じように動いているかどうか確認することができます。左クリックで確定、右クリックでキャンセルです。

{{<img src="/img/jma_blender_nurinokoshi.png" width="800" height="435">}}

おっと！ついてくるはずの頂点がその場に居残っていますね。

{{<img src="/img/jma_blender_nokoshipoint.png" width="800" height="435">}}

視点を調整してWireframeに切り替えつつ、一度左クリックで確定して、左クリックのカーソルで目印をつけておいてから<small>この章での数少ない左クリックの見せ所！</small>、Alt+[G]で移動をもとの位置に戻します。

``` plain
    Pose Modeでの移動は、Alt+[G]でもとに戻せる。回転は、Alt+[R]でもとに戻せる。
```

Edit Modeに戻って、印のところにある頂点をLleg2にAssignしました。

{{<img src="/img/jma_blender_okleg.png" width="800" height="435">}}

ついてくるようになりました。

## Weight Paint Mode
{{<img src="/img/jma_blender_wp1.png" width="800" height="435">}}

Meshを選択してWeight Paintに入ると、Vertex Groupに割り当てられている部分を視覚的に見ることができます。<br>
Vertex Groupを切り替えながら眺めれば、元モデルではどうやって塗っているかだいたいわかることでしょう。<br>
とくにfairy01は各hand1や各leg1に割り当てがないこともここでわかってきます。

このモードで文字通り「塗る」こともできるのですが、結構塗り判定が雑で塗り残しを作りやすいうえ、「塗り」なので表面しか塗れず、うしろ側は回り込んで塗る必要があるなど、あまりうまくありません。それでも視認のしやすさは素晴らしいですし、逆に裏側は別のGroupで塗りたい、などの場合で逆に裏が塗れないことを利用できる場面もあります。
塗る方の詳しい説明はここでは省略します。Addで塗る、Subで消す、と思っておけばよいでしょう。

元がMMDモデルの場合、外から見えない部分まで作り込む目的でMeshが存在している場合があります。Texturedで確認して、完全に内側にあるようなら、Meshごと消してしまいましょう。例では、dorowaと命名したMeshは消してしまっています。

# 仕上げ
{{<img src="/img/jma_blender_deletef.png" width="800" height="435">}}

全部塗れたと思ったら、お世話になったベースのメッシュを[X]して、

{{<img src="/img/jma_blender_nifexport.png" width="800" height="435">}}

念のためObject Modeですべてのオブジェクトを表示状態にして[A]で全選択してから(しなくていいかも)、File-Export-NetImmerse/Gamebryo(.nif &amp; .kf &amp; .egm)から出力します。

{{<img src="/img/jma_blender_nifexport2.png" width="800" height="435">}}

ファイル名を指定した後にオプションが出るので、こんな感じで。とくに、
- Scale Correction: 10.00 (Importしたときと同じになっているか)
- Export Geometry Only
- Flatten Skin: off
- Export Skin Partition: off
- Civillization IV

になっているか確認しておきましょう。

{{<img src="/img/jma_blender_unweighted.png" width="800" height="435">}}

まだ塗り残しがあると怒られました。塗り残している頂点が自動で選択されているので、適切に修正しましょう。(ここで塗り残しが少なければ、そのままAssignすればよいですが、Meshのなかで複数箇所にわたっていると大変なので、Assignは慎重に。)
何事もなくメイン画面に戻ってこられて、指定したファイル名ができていれば成功です。それを組み込めばそのまま動きます。

# 最後もNifSkope
いきなりゲームで確認してもよいですが、いちおうNifSkope上でも動きを確認したいですね。

{{<img src="/img/jma_nifskope_attachkf.png" width="450" height="400">}}

ファイルを開いて、Spells-Animation-Attach.KF、fairy01で始まっているkfファイルをまとめて選択してしまいます。
成功していれば、再生ボタンやシークバーの近くに動きの種類が表示されていますので、伸びたり捻れたりしていないかチェックできます。

{{<img src="/img/jma_nifskope_kfm.png" width="450" height="400">}}

ファイル名を直したいなら、fairy01.kfmを開いて、KFMタブを出し、fairy01とある部分を片っ端からfutoに変えて、futo.kfmとして保存すればOKです。nifファイルや、kfファイルもその名前に合わせておくことを忘れずに。

# あそぶ
Civ4ArtDefines_Unit.xmlの<NIF\>と<SHADERNIF\>にnifファイル、<KFM\>にkfmファイルを指定してください。
Enjoy!
