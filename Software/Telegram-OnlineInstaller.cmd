@ECHO OFF
SET "OUTPUT=tsetup.exe"
SET "NAME=Telegram"

title %NAME%

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    SET MY_URL="https://telegram.org/dl/desktop/win64"
) else (
    SET MY_URL="https://telegram.org/dl/desktop/win"
)

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Telegram.exe /F /T' -Verb RunAs -WindowStyle Hidden"

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
	 START /wait %TEMP%\%OUTPUT% /Verysilent

ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------