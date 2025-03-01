@ECHO OFF
SETLOCAL
SET "OUTPUT=AIMP-Installer.exe"
SET "NAME=AIMP"
TITLE %NAME%

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "URL=https://www.aimp.ru/?do=download.file&id=3"
) ELSE (
    SET "URL=https://www.aimp.ru/?do=download.file&id=4"
)

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ AIMP.exe" 2>NUL | FIND /I /N "AIMP.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM AIMP.exe /F /T
)

ECHO %NAME% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /SILENT /AUTO
	 
ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------