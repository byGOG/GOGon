@ECHO OFF
SETLOCAL
SET "OUTPUT=WinScriptSetup.exe"
SET "NAME=WinScript"
TITLE %NAME%

curl -sL https://github.com/flick9000/winscript/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://github.com/flick9000/winscript/releases/download/v%VERSION%/winscript-installer.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
	 POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM WinScript.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
     DEL %TEMP%\version.txt

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------