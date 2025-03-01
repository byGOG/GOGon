@ECHO OFF
SETLOCAL
SET "OUTPUT=VSCodeUserSetup.exe"
SET "NAME=Visual Studio Code"
TITLE %NAME%

REM Set the download URL based on the processor architecture
IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "URL=https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user"
) ELSE (
    SET "URL=https://code.visualstudio.com/sha/download?build=stable&os=win32-user"
)

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ Code.exe" 2>NUL | FIND /I /N "Code.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM Code.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %name% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /NORESTART /MERGETASKS="!runcode,desktopicon"

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------