+++
date = "2017-12-20"
draft = true
title = "コラム：BuildingType"
banner = "green"
tags = ["コラム"]
+++

『ゲームの内部表現の直訳』→「日本語での意訳」

『BuildingTypeの15番』→「水道橋」
番号ひとつにつき、建造物の***種類***(Type)ひとつが割り当てられています。

『BuildingTypeの16番』→「ハマム(水道橋のオスマントルコUB)」
『BuildingTypeの17番』→「バライ(水道橋のクメールUB)」
たとえUBであろうとも、違う建造物なら違う番号になります。

『BuildingTypeの30番』→「工場」
『BuildingTypeの37番』→「モニュメント」
『BuildingTypeの45番』→「大学」
順番は内部での単なる通し番号であり、とくに何かの順に並んでいるということはありません。

『BuildingTypeの110番』→「オックスフォード大学」
『BuildingTypeの127番』→「チチェン・イッツァ」
遺産も建造物です。建造条件が一般のものとは少し違うだけです。
建造物であるからには当然番号も振られています。

『ある都市にBuildingTypeの15番が1つ存在している』
→「その都市に水道橋が建設済みである」
工場やその他の建造物はあるかもしれないし、ないかもしれません。

『ある都市にBuildingTypeの15番が1つ、30番が1つ存在している』
→「その都市に水道橋と工場が建設済みである」
その他の建造物はあるかもしれないし、ないかもしれません。

『ある都市にBuildingTypeの15番が0つ存在している』
→「その都市に水道橋はない」
その他の建造物はあるかもしれないし、ないかもしれません。
とくに、水道橋UBについてもあるかもしれないし、ないかもしれません。
16番や17番について調べていませんから、これだけではわかりません。

『ある都市にBuildingTypeの15番が0つ、16番が1つ存在している』
→「その都市に水道橋はなく、ハマムはある)」
その他の建造物は(略)

『ある都市で全てのBuildingTypeについて調べたところ、37番だけが1つ、他のあらゆる番号では0つだった』
→「その都市にはモニュメントのみが建設されていて、他の建造物はない」
新都市建設後、人口２で緊急生産でもしたのでしょうか。

『ある都市ではBuildingTypeの110番を建設できない』
→「その都市では、オックスフォード大学を建造できない」
教育が未開発か、大学の数が足りないか、もう他の都市にオックスフォード大学が建設済みか、
あるいはその都市の国家遺産数がもう上限に達しているか、
(上限を2つだと決めつけるのはバグになります。OCCでは異なるからです。)
どの理由かはわかりませんが、とにかくその都市で建造を始めることはできません。

『`gc.getInfoTypeForString('BUILDING_BANK')`』
→「XMLキーBUILDING_BANKに対応するBuildingTypeを取得する」
この場合は銀行なので63が得られます。
