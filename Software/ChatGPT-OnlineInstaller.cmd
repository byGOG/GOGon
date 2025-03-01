@ECHO OFF
SETLOCAL
SET "OUTPUT=ChatGPT.msi"
SET "NAME=ChatGPT"
TITLE %NAME% 

curl -sL https://github.com/lencx/ChatGPT/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=4 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://github.com/lencx/ChatGPT/releases/download/v%VERSION%/ChatGPT_%VERSION%_windows_x86_64.msi"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ ChatGPT.exe" 2>NUL | FIND /I /N "ChatGPT.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM ChatGPT.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
POWERSHELL; Start-Process cmd -ArgumentList '/c start /wait msiexec /i "%TEMP%\%OUTPUT%" /quiet /norestart' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------