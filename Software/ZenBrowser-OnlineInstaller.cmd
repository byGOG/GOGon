@ECHO OFF
SET "OUTPUT=ZenBrowser.exe"
SET "NAME=Zen Browser"
TITLE %NAME%

curl -sL https://github.com/zen-browser/desktop/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=6 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G


SET URL="https://github.com/zen-browser/desktop/releases/download/%VERSION%/zen.installer.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM zen.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
start /wait %TEMP%\%OUTPUT% -ms /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
