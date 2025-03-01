@ECHO OFF
SET "OUTPUT=WizTree.exe"
SET "NAME=WizTree"
TITLE %NAME%

SETLOCAL ENABLEDELAYEDEXPANSION
SET FOUND_VERSION=0

FOR /F "tokens=3 delims=<> " %%G IN ('curl -sL https://diskanalyzer.com/whats-new ^| findstr /C:"<h4>WizTree "') DO (
    IF !FOUND_VERSION! EQU 0 (
        SET VERSION=%%G
        SET FOUND_VERSION=1
    )
)
SET VERSION=%VERSION:.=_%
SET "URL=https://diskanalyzer.com/files/wiztree_%VERSION%_setup.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ WizTree64.exe" 2>NUL | FIND /I /N "WizTree64.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    powershell -Command "Start-Process cmd -ArgumentList '/c TASKKILL /IM WizTree64.exe /F /T' -WindowStyle Hidden -Verb RunAs -Wait"

)

ECHO %name%:%version% INDIRILIYOR
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %name% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
