@ECHO OFF
SETLOCAL
SET "OUTPUT=BCUninstaller_setup.exe"
SET "NAME=Bulk Crap Uninstaller"
TITLE %NAME%

curl -sL https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=6 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://github.com/Klocman/Bulk-Crap-Uninstaller/releases/download/v%VERSION%/BCUninstaller_%VERSION%_setup.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
powershell -Command "if (Get-Process BCUninstaller -ErrorAction SilentlyContinue) { Start-Process taskkill -ArgumentList '/IM BCUninstaller.exe /F /T' -Verb RunAs -Wait }"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
	 DEL %TEMP%\version.txt
	 
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
