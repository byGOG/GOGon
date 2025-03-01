@ECHO OFF
SET "OUTPUT=TabbyTerminal.exe"
SET "NAME=Tabby Terminal"
TITLE %NAME%

curl -sL https://github.com/Eugeny/tabby/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
SET version=%version:v=%

SET "URL=https://github.com/Eugeny/tabby/releases/download/v%VERSION%/tabby-%VERSION%-setup-x64.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
    POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Tabby.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /S /allusers

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------