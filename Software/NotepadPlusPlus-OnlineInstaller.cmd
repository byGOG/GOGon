@ECHO OFF
SETLOCAL
SET OUTPUT=notepadplusplus.exe
SET NAME=Notepad++
TITLE %NAME%

REM Check the version number
curl -s https://notepad-plus-plus.org/ | findstr /C:"Current Version " > %TEMP%\version.txt
FOR /F "tokens=6-7 delims=<> " %%G IN (%TEMP%\version.txt) DO SET VERSION=%%G

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET MY_URL=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v%VERSION%/npp.%VERSION%.Installer.x64.exe
) ELSE (
    SET MY_URL=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v%VERSION%/npp.%VERSION%.Installer.exe
)

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ notepad++.exe" 2>NUL | FIND /I /N "notepad++.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM notepad++.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %name% YUKLENIYOR...
start /wait %TEMP%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
