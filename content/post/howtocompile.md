+++
date = "2018-02-04"
draft = true
title = "CvGameCoreDll.dllの作り方"
banner = ""
tags = ["C++", "コラム"]
comment = true
weight = 99
+++

# 筆者の環境
- Windows 10 64bit
- Civ4 BtS 3.19 パッケージ版

# 必要なもの

## Microsoft Visual C++ Toolkit 2003
http://kael.civfanatics.net/files/VCToolkitSetup.exe

## Multi Threading Librarires
http://kael.civfanatics.net/files/msvcrt.lib
http://kael.civfanatics.net/files/msvcprt.lib
C:\Program Files (x86)\Microsoft Visual C++ Toolkit 2003\lib にコピー

## Windows 7 SDK
http://download.microsoft.com/download/F/1/0/F10113F5-B750-4969-A255-274341AC6BCE/GRMSDKX_EN_DVD.iso
古いPSDK-x86.exeがWindows10でインストールできないようなので
新し目のSDKをISOからインストールする、64bit版はGRMSDKX_EN_DVD.iso

## MakeFile 2.3
https://forums.civfanatics.com/attachments/makefile_2-3-zip.367602/

# やってみる

MODSフォルダにsdk_testというフォルダを作る

sdk_testの中にsdkというフォルダとAssetsというフォルダを作る

C:\Program Files (x86)\CYBERFRONT\Sid Meier's Civilization 4(J)\Beyond the Sword(J)\CvGameCoreDLL\
の中にあるファイルとフォルダをsdkの中にコピーする

Makefileもsdkの中にコピーする

## かきかえる

``` makefile
TOOLKIT=$(PROGRAMFILES)\Microsoft Visual C++ Toolkit 2003
<<<<<<<<<< ここから
PSDK=C:\Program Files\Microsoft SDKs\Windows\v7.1
PATH=$(PATH);C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin
>>>>>>>>>> ここまで
## Uncomment to have newly compiled dlls copied to your mod's Assets directory
YOURMOD=..
```

``` makefile
#### INCLUDES ####
>>>>>>>>>> ここから
GLOBAL_INCS=/I"$(TOOLKIT)/include" /I"$(PSDK)/Include" /I"$(PSDK)/Include/mfc" /I"C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include"
<<<<<<<<<< ここまで
```

次の内容でbuild.batをつくり、sdkフォルダに入れる
```
@echo off
rem Microsoft SDK 7.1の場合
set NMAKE_BIN="C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\bin"
cd /d %~dp0

set TARGET=Release
%NMAKE_BIN%\nmake

pause
```

## 実行

build.batをダブルクリックして実行

Assetsの中にCvGameCoreDll.dllができている
