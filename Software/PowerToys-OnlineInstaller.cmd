@ECHO OFF
SETLOCAL
SET "OUTPUT=PowerToysSetup.exe"
SET "NAME=PowerToys"
TITLE %NAME%

curl -sL https://github.com/microsoft/PowerToys/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=4 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:v=%

SET "URL=https://github.com/microsoft/PowerToys/releases/download/v%VERSION%/PowerToysSetup-%VERSION%-x64.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM PowerToys.Settings.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM PowerToys.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /install /quiet /norestart
	 TIMEOUT /T 10 /NOBREAK >NUL

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
     DEL %TEMP%\version.txt

ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM PowerToys.Settings.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM PowerToys.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------