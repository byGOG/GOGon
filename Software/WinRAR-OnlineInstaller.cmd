@echo off
setlocal
set "OUTPUT=WinRAR.exe"
set "NAME=WinRAR"
title %name% 

REM Check the version number
curl -s https://www.rarlab.com/ | findstr /C:"WinRAR and RAR " | findstr /V /C:"BETA" > %temp%\version.txt
for /F "tokens=4" %%G in (%temp%\version.txt) do set version=%%G
set version=%version:.=%

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set winrar_url=https://www.rarlab.com/rar/winrar-x64-%version%tr.exe
) else (
    set winrar_url=https://www.rarlab.com/rar/winrar-x32-%version%tr.exe
)

echo ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ WinRAR.exe" 2>NUL | FIND /I /N "WinRAR.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM WinRAR.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
	 curl -L -o %temp%\%OUTPUT% %winrar_url%

ECHO %name% YUKLENIYOR...
	 start /wait %temp%\%OUTPUT% /S

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 del %temp%\%OUTPUT%
	 del %temp%\version.txt

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
echo ---------------------------------------------------
