@ECHO OFF
SET "OUTPUT=UniGetUI.Installer.exe"
SET "NAME=UniGetUI"
TITLE %NAME%

SET "URL=https://github.com/marticliment/UniGetUI/releases/latest/download/UniGetUI.Installer.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM UniGetUI.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
	 start /wait %TEMP%\%OUTPUT% /NoAutoStart /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP- 

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
	 
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------