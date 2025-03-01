@ECHO OFF
SETLOCAL
SET "OUTPUT=idman-setup.exe"
SET "NAME=IDM"
TITLE %NAME%

set "URL=https://www.internetdownloadmanager.com/"

for /f "tokens=3 delims==>" %%a in (
  'curl -s "%URL%" ^| findstr /c:"Try IDM 30-days free trial"'
) do set "DOWNLOAD_URL=%%a"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ idman.exe" 2>NUL | FIND /I /N "idman.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM idman.exe /F /T
)
	 
ECHO %NAME% INDIRILIYOR:
	 curl -o "%TEMP%\%OUTPUT%" "%DOWNLOAD_URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /skipdlgs
	 TIMEOUT /T 15 /NOBREAK >NUL

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------