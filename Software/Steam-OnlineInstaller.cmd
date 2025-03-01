@ECHO OFF
SETLOCAL

SET OUTPUT=SteamSetup.exe
SET NAME=Steam
SET MY_URL="http://cdn.akamai.steamstatic.com/client/installer/SteamSetup.exe"

TITLE %NAME%

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Steam.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
	 START /wait %TEMP%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------