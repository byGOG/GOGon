@ECHO OFF
SET "OUTPUT=BleachBit.exe"
SET "NAME=BleachBit"
TITLE %NAME%

curl -sL https://github.com/bleachbit/bleachbit/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://download.bleachbit.org/BleachBit-%VERSION%-setup.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
powershell -Command "if (Get-Process bleachbit -ErrorAction SilentlyContinue) { Start-Process taskkill -ArgumentList '/IM bleachbit.exe /F /T' -Verb RunAs -Wait }"

ECHO %NAME%:%VERSION% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    powershell -Command "Start-Process '%TEMP%\%OUTPUT%' -ArgumentList '/S', '/allusers' -Verb RunAs -Wait"
      
ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%
    DEL %TEMP%\version*

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------

