@ECHO OFF
SETLOCAL

SET "NAME=Office Tool Plus"
SET "VERSION="
TITLE %NAME%

curl -sL https://github.com/YerongAI/Office-Tool/releases/latest | findstr /C:"Office Tool Plus v" > %TEMP%\version.txt
FOR /F "tokens=8 delims=<> " %%G IN (%TEMP%\version.txt) DO SET "VERSION=%%G"

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "URL=https://github.com/YerongAI/Office-Tool/releases/download/%VERSION%/Office_Tool_%VERSION%_x64.zip"
) ELSE (
    SET "URL=https://github.com/YerongAI/Office-Tool/releases/download/%VERSION%/Office_Tool_%VERSION%_x86.zip"
)

ECHO ---------------------------------------------------
ECHO KLASOR OLUSTURULUYOR...
mkdir "%SYSTEMDRIVE%\Tools"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o "%SYSTEMDRIVE%\Tools\Office_Tool.zip" "%URL%"

ECHO DOSYALAR CIKARILIYOR...
powershell Expand-Archive -LiteralPath '%SYSTEMDRIVE%\Tools\Office_Tool.zip' -DestinationPath "%SYSTEMDRIVE%\Tools" -Force

ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
powershell -Command "Start-Process -FilePath 'cmd.exe' -ArgumentList '/c mklink \"%PUBLIC%\Desktop\Office Tool Plus\" \"%SYSTEMDRIVE%\Tools\Office Tool\Office Tool Plus.exe\"' -Verb RunAs -Wait"

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %SYSTEMDRIVE%\Tools\Office_Tool.zip
DEL %TEMP%\version.txt

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------


