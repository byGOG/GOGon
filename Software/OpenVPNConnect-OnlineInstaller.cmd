@ECHO OFF
SET OUTPUT=OpenVPNConnect.msi
SET NAME=OpenVPN Connect
TITLE %NAME%

SET MY_URL="https://openvpn.net/downloads/openvpn-connect-v3-windows.msi"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
     POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM OpenVPNConnect.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
     CURL -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
     POWERSHELL; Start-Process cmd -ArgumentList '/c start /wait msiexec /i "%temp%\%output%" /quiet /norestart' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
     DEL %TEMP%\%OUTPUT%

ECHO %NAME% KAPATILIYOR...
     POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM OpenVPNConnect.exe /F /T' -Verb RunAs -WindowStyle Hidden"
     
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------