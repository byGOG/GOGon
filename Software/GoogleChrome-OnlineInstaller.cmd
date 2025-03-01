@echo off
set OUTPUT=ChromeSetup.msi
set NAME=Google Chrome

title %NAME%

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set MY_URL="https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
) else (
    set MY_URL="https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi"
)

echo ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM chrome.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
POWERSHELL; Start-Process cmd -ArgumentList '/c start /wait msiexec /i "%temp%\%output%" /quiet /norestart' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
del %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
echo ---------------------------------------------------