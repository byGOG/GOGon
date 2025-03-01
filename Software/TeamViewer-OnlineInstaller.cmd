@ECHO OFF
SETLOCAL
SET OUTPUT=TeamViewer.exe
SET NAME=TeamViewer
TITLE %NAME%

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET MY_URL=https://download.teamviewer.com/download/TeamViewer_Setup_x64.exe
) ELSE (
    SET MY_URL=https://download.teamviewer.com/download/TeamViewer_Setup.exe
)

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM TeamViewer.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
start /wait %TEMP%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------