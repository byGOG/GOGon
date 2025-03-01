@ECHO OFF
SETLOCAL
SET "OUTPUT=Bitwarden-Installer.exe"
SET "NAME=Bitwarden"
TITLE %NAME%

SET "URL=https://vault.bitwarden.com/download/?app=desktop&platform=windows"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ Bitwarden.exe" 2>NUL | FIND /I /N "Bitwarden.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM Bitwarden.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %name% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /S
	 
ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------