@ECHO OFF
SET "NAME=Rufus"
SET "VERSION="
TITLE %NAME%

curl -sL https://rufus.ie/en/ | findstr /C:"rufus-" > %TEMP%\version.txt
FOR /F "tokens=7 delims=<> " %%G IN (%TEMP%\version.txt) DO SET "VERSION=%%G"
set version=%version:_arm64.exe=%
set version=%version:rufus-=%

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "URL=https://github.com/pbatard/rufus/releases/download/v%VERSION%/rufus-%VERSION%.exe"
) ELSE (
    SET "URL=https://github.com/pbatard/rufus/releases/download/v%VERSION%/rufus-%VERSION%_x86.exe"
)

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Rufus.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO KLASOR OLUSTURULUYOR...
mkdir "%SYSTEMDRIVE%\Tools\%NAME%"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o "%SYSTEMDRIVE%\Tools\%NAME%\%NAME%.exe" "%URL%"

ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
POWERSHELL Start-Process cmd -ArgumentList '/c mklink "%PUBLIC%\Desktop\Rufus" "%SYSTEMDRIVE%\Tools\Rufus\Rufus.exe"' -WindowStyle Hidden -Verb RunAs -Wait

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------