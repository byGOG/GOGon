@ECHO OFF
SETLOCAL
SET "OUTPUT=K-Lite_Codec_Pack_Mega.exe"
SET "NAME=K-Lite Codec Pack Mega"
TITLE %NAME%

curl -s https://codecguide.com/features_mega.htm | findstr /C:"Contents of version " > %temp%\version.txt
FOR /F "tokens=12 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G
set version=%version:.=%
set version=%version::=%

SET "URL=https://files3.codecguide.com/K-Lite_Codec_Pack_%VERSION%_Mega.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ mpc-hc64.exe" 2>NUL | FIND /I /N "mpc-hc64.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM mpc-hc64.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
	 CURL -L -o %TEMP%\%OUTPUT% %URL%
	 
ECHO %NAME% YUKLENIYOR...
	 START /wait %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
	 
ECHO GECICI DOSYALAR TEMIZLENIYOR...
	 DEL %TEMP%\%OUTPUT%
	 DEL %TEMP%\version.txt
	 
ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------