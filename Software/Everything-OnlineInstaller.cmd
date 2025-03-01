@ECHO OFF
SETLOCAL
SET OUTPUT=Everything-Setup.exe
SET NAME=Everything
TITLE %NAME%

REM VERSIYON NUMARASINI KONTROL ET
curl -s https://www.voidtools.com/ | findstr /C:"Everything " > %TEMP%\version.txt
FOR /F "tokens=5 delims=<> " %%G IN (%TEMP%\version.txt) DO SET VERSION=%%G

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET MY_URL=https://www.voidtools.com/Everything-%VERSION%.x64-Setup.exe
) ELSE (
    SET MY_URL=https://www.voidtools.com/Everything-%VERSION%.x86-Setup.exe
)

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ Everything.exe" 2>NUL | FIND /I /N "Everything.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    powershell -Command "Start-Process cmd -ArgumentList '/c TASKKILL /IM Everything.exe /F /T' -WindowStyle Hidden -Verb RunAs -Wait"
)

ECHO %name%:%version% INDIRILIYOR
curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %name% YUKLENIYOR...
start /wait %TEMP%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------