@ECHO OFF
SETLOCAL
SET "OUTPUT=CopyQ-setup.exe"
SET "NAME=CopyQ"
TITLE %NAME%

curl -sL https://github.com/hluk/CopyQ/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/hluk/CopyQ/releases/download/v%VERSION%/copyq-%VERSION%-setup.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ copyq.exe" 2>NUL | FIND /I /N "copyq.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM copyq.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- /TASKS="desktopicon,quicklaunchicon"

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
