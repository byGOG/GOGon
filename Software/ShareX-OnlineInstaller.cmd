@ECHO OFF
SETLOCAL
SET "OUTPUT=ShareX-setup.exe"
SET "NAME=ShareX"
TITLE %NAME%

curl -sL https://github.com/ShareX/ShareX/releases/latest | findstr /C:"ShareX " > %temp%\version.txt
FOR /F "tokens=6 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/ShareX/ShareX/releases/download/v%VERSION%/ShareX-%VERSION%-setup.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ ShareX.exe" 2>NUL | FIND /I /N "ShareX.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM ShareX.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
	curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	start /wait %TEMP%\%OUTPUT% /VERYSILENT /NORESTART /NORUN 

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------