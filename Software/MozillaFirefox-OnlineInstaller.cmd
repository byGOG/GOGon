@echo off
set output=FirefoxSetup.exe
set name=Mozilla Firefox

title %name%

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set zip_url="https://download.mozilla.org/?product=firefox-latest&os=win64&lang=tr"
) else (
    set zip_url="https://download.mozilla.org/?product=firefox-latest&os=win&lang=tr"
)

echo ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM firefox.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %temp%\%output% %zip_url%

ECHO %NAME% YUKLENIYOR...
start /wait %temp%\%output% -ms /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
del %temp%\%output%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
echo ---------------------------------------------------
