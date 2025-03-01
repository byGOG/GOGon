@ECHO OFF
SETLOCAL

SET OUTPUT=SpotifyFullSetup.exe
SET NAME=Spotify
SET MY_URL=https://download.scdn.co/SpotifyFullSetup.exe

TITLE %NAME%

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ Spotify.exe" 2>NUL | FIND /I /N "Spotify.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM Spotify.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
	CURL -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
	START /wait %TEMP%\%OUTPUT% /silent
	 
ECHO GECICI DOSYALAR TEMIZLENIYOR...
	DEL %TEMP%\%OUTPUT%

TASKLIST /FI "IMAGENAME EQ Spotify.exe" 2>NUL | FIND /I /N "Spotify.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM Spotify.exe /F /T
)

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------