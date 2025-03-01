@ECHO OFF
SETLOCAL
SET OUTPUT=AnyDesk.exe
SET NAME=AnyDesk
TITLE %NAME%

SET MY_URL="https://download.anydesk.com/AnyDesk.exe"

ECHO ---------------------------------------------------
ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
POWERSHELL; Start-Process cmd -ArgumentList '/c %TEMP%\AnyDesk.exe --install "%SYSTEMDRIVE%\PROGRA~2\AnyDesk" --silent --create-shortcuts --create-desktop-icon --remove-first' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
