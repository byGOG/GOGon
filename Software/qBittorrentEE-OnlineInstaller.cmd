@ECHO OFF
SETLOCAL
SET "OUTPUT=qBittorrentEnhancedEdition.exe"
SET "NAME=qBittorrent EE"
TITLE %NAME%

curl -sL https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=6 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://github.com/c0re100/qBittorrent-Enhanced-Edition/releases/download/release-%VERSION%/qbittorrent_enhanced_%VERSION%_x64_setup.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ qbittorrent.exe" 2>NUL | FIND /I /N "qbittorrent.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM qbittorrent.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    start /wait %TEMP%\%OUTPUT% /S
     
ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
    POWERSHELL; Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\qBittorrent %SYSTEMDRIVE%\PROGRA~1\qBittorrent\qBittorrent.exe' -WindowStyle Hidden -Verb RunAs -Wait
     
ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------