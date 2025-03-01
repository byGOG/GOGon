@ECHO OFF
SET "OUTPUT=DropboxInstaller.exe"
SET "NAME=Dropbox"
TITLE %NAME%

SET MY_URL="https://www.dropbox.com/download?os=win&plat=win"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
     POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Dropbox.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
     CURL -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
     start /wait %TEMP%\%OUTPUT% /NOLAUNCH 

ECHO GECICI DOSYALAR TEMIZLENIYOR...
     DEL %TEMP%\%OUTPUT%
     
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------