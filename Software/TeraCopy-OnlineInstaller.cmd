@ECHO OFF
SET "OUTPUT=TeraCopy.exe"
SET "NAME=TeraCopy"
TITLE %NAME%

SET "URL=https://www.codesector.com/files/teracopy.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ TeraCopy.exe" 2>NUL | FIND /I /N "TeraCopy.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM TeraCopy.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %name% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /exenoui /exenoupdates /qn /norestart

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------