@ECHO OFF
SETLOCAL
SET "OUTPUT=ProtonVPN.exe"
SET "NAME=Proton VPN"
TITLE %NAME%

curl -sL https://github.com/ProtonVPN/win-app/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/ProtonVPN/win-app/releases/download/%VERSION%/ProtonVPN_v%VERSION%_x64.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ ProtonVPN.exe" 2>NUL | FIND /I /N "ProtonVPN.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM ProtonVPN.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %name% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------