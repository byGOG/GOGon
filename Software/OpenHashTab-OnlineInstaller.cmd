@ECHO OFF
SET "OUTPUT=OpenHashTab.exe"
SET "NAME=OpenHashTab"
TITLE %NAME%

curl -sL https://github.com/namazso/OpenHashTab/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=4 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/namazso/OpenHashTab/releases/download/%VERSION%/OpenHashTab_setup.exe"

ECHO ---------------------------------------------------
ECHO %NAME%:%VERSION% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    start /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART
      
ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%
    DEL %TEMP%\version*

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------

