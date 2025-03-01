@ECHO off
SETLOCAL
SET "OUTPUT=VLCsetup.exe"
SET "NAME=VLC Media Player"
TITLE %NAME%

set "arch=win32"
if "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "arch=win64"

set "url=https://download.videolan.org/vlc/last/%arch%/"
for /f "tokens=2 delims=-" %%v in ('curl -s %url% ^| findstr /i "vlc-.*-%arch%.exe"') do set "version=%%v"

set "installerUrl=https://download.videolan.org/vlc/last/%arch%/vlc-%version%-%arch%.exe"

echo ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ vlc.exe" 2>NUL | FIND /I /N "vlc.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM vlc.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o "%TEMP%\%OUTPUT%" "%installerUrl%"

ECHO %NAME% YUKLENIYOR...
start /wait "" "%TEMP%\%OUTPUT%" /L=1055 /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
del /q "%TEMP%\%OUTPUT%"

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
echo ---------------------------------------------------