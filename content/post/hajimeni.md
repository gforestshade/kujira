+++
date = "2018-01-27"
draft = false
title = "はじめに"
banner = "kujira_paleblue"
categories = ["目次"]
tags = ["はじめに"]
comment = true
weight = 99
+++

このサイトは、Civ4のMOD開発情報を発信していくブログです。

主に、いままで日本語情報が少なかったPython、SDK、グラフィック、サウンドなどの
MODを作る際の情報を筆者の備忘録がわりに書き留めています。

MODを作りたい人向けの情報であり、MODで遊んだり導入したりしたい人向けではないことを
あらかじめご了承ください。

# 講座シリーズ
はじめてPythonを触る人向けの講座風コンテンツです。
PythonでもMODやりたいけどどこからはじめたらいいかよくわからない......
という方はここから読むことをお勧めします。

## 第１期シリーズ・はじめてのPythonMOD
順番に読んでいけばPythonMODに入門できる、そんな内容を目指しました。

- [その１]({{<ref "getstarted1">}})
PythonでMOD作成する準備 ～ 図書館自動建設
- [その２]({{<ref "getstarted2">}})
えこひいき図書館・首都だけ/マリだけ・if文・Player・CivilizationInfo
- [その３]({{<ref "getstarted3">}})
防衛志向・ユニット生成・関数の使い方/作り方
- [その４]({{<ref "getstarted4">}})
取得済み技術・and/or/else
- [その５]({{<ref "getstarted5">}})
ダン強化・都市上にいる全ユニットに昇進・for文
- [その６]({{<ref "getstarted6">}})
XMLで新しい建造物を作る
- [その７]({{<ref "getstarted7">}})
草原化・マップのラップ・Map・Plot・リストとforの応用

## 第２期シリーズ・それからのPython
もっと欲張りたい人のための、中級編です。

- [その１]({{<ref "secondpy1">}})
ゲーム画面にメッセージ表示・変数と値・型・Unicode文字列
- [その２]({{<ref "secondpy2">}})
年代の表示・フォーマット文字列・抽象化
- [その３]({{<ref "secondpy3">}})
クラス・メソッド・インスタンス・コンストラクタ
- [その４]({{<ref "secondpy4">}})
クラスの利用・ゲームの要素を操作する方法
- [その５]({{<ref "secondpy5">}})
毎ターン・駐留したユニット・変数のスコープ
- [その６]({{<ref "secondpy6">}})
PyPlayer・複数ファイル・モジュール・文明の持つ全ユニット
- [その７]({{<ref "secondpy7">}})
昇進の作成
- [その８]({{<ref "secondpy8">}})
オブジェクト・リスト操作・リスト内包表記・ジェネレータ式
- [その９]({{<ref "secondpy9">}})
クラス変数・リストの連結・filter()
- [その10]({{<ref "secondpy10">}})
スペル完成

# XML詳説シリーズ
XMLを1ファイルずつ取り上げ、各タグの役割について解説する辞書的コンテンツです。

- [XMLキー一覧]({{<ref "keyichiran">}})
XMLキーだけを一覧にしたものです。簡易的な調べものにどうぞ。
- [ユニットクラス]({{<ref "civ4unitclassinfos">}})
- [ユニット]({{<ref "civ4unitinfos">}})
- [建造物クラス]({{<ref "civ4buildingclassinfos">}})
- [建造物]({{<ref "civ4buildinginfos">}})
- [技術]({{<ref "civ4techinfos">}})
- [指導者]({{<ref "civ4leaderheadinfos">}})
- [文明]({{<ref "civ4civilizationinfos">}})
- [社会制度]({{<ref "civ4civicinfos">}})
- [志向]({{<ref "civ4traitinfos">}})
- [昇進]({{<ref "civ4promotioninfos">}})
- [プロジェクト]({{<ref "civ4projectinfos">}})
- [難易度]({{<ref "civ4handicapinfo">}})
- [資源]({{<ref "civ4bonusinfos">}})
- [地形改善]({{<ref "civ4improvementinfos">}})

# C++シリーズ
CvGameCoreDll.dllとか使って、なんかします。

- [Windows10でDLL開発環境]({{<ref "howtocompiledoc">}})

# MMD to Civ4 プロジェクト
なんとかもっといろいろなユニットをシド星に召喚できないかと
試行錯誤していくプロジェクトです。

- [モデルの変換]({{<ref "mmd_to_nif">}})
- [リギング]({{<ref "nifanimation">}})
