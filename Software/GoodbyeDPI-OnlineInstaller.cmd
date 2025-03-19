@ECHO OFF
SETLOCAL

SET "NAME=GoodbyeDPI"
SET "VERSION="
TITLE %NAME%

curl -sL https://github.com/ValdikSS/GoodbyeDPI/releases/latest | findstr /C:"GoodbyeDPI v" > %TEMP%\version.txt
FOR /F "tokens=6 delims=<> " %%G IN (%TEMP%\version.txt) DO SET "VERSION=%%G"
SET "VERSION=%VERSION:v=%"

SET "URL=https://github.com/ValdikSS/GoodbyeDPI/releases/download/%VERSION%/goodbyedpi-%VERSION%.zip"

ECHO ---------------------------------------------------
ECHO KLASOR OLUSTURULUYOR...
mkdir "%SYSTEMDRIVE%\Tools"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o "%SYSTEMDRIVE%\Tools\GoodbyeDPI.zip" "%URL%"

ECHO DOSYALAR CIKARILIYOR...
powershell -Command "Expand-Archive -LiteralPath '%SYSTEMDRIVE%\tools\GoodbyeDPI.zip' -DestinationPath '%SYSTEMDRIVE%\tools\' -Force"

ECHO KLASOR ADI DEGISTIRILIYOR...
for /d %%D in ("%SYSTEMDRIVE%\tools\goodbyedpi-*") do (
    move "%%D" "%SYSTEMDRIVE%\tools\GoodbyeDPI"
)

ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
set "BaseDir=%SystemDrive%\Tools"
POWERSHELL; Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\GoodbyeDPI %SYSTEMDRIVE%\Tools\GoodbyeDPI\2_any_country_dnsredir.cmd' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %SYSTEMDRIVE%\Tools\GoodbyeDPI.zip
DEL %TEMP%\version.txt

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------


