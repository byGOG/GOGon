@ECHO OFF
SETLOCAL
SET "OUTPUT=StremioSetup.exe"
SET "NAME=Stremio"
TITLE %NAME%

SET "URL=https://www.strem.io/download?four=4"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ stremio.exe" 2>NUL | FIND /I /N "stremio.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM stremio.exe /F /T
)

ECHO %NAME% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    start /wait %TEMP%\%OUTPUT% /S
     
ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------