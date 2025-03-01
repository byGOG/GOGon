@ECHO OFF
SETLOCAL
SET "OUTPUT=Sandboxie-Plus.exe"
SET "NAME=Sandboxie"
TITLE %NAME%

curl -sL https://github.com/sandboxie-plus/Sandboxie/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=4 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

IF "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET "URL=https://github.com/sandboxie-plus/Sandboxie/releases/download/%VERSION%/Sandboxie-Plus-x64-%VERSION%.exe"
) ELSE (
    SET "URL=https://github.com/sandboxie-plus/Sandboxie/releases/download/%VERSION%/Sandboxie-Plus-x86-%VERSION%.exe"
)

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM SandMan.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
	 DEL %TEMP%\version.txt
	 
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------