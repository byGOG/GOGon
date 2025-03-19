@ECHO OFF
SET "OUTPUT=HandBrake.exe"
SET "NAME=HandBrake"
TITLE %NAME%

curl -sL https://github.com/HandBrake/HandBrake/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/HandBrake/HandBrake/releases/download/%VERSION%/HandBrake-%VERSION%-x86_64-Win_GUI.exe"

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ HandBrake.exe" 2>NUL | FIND /I /N "HandBrake.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM HandBrake.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
    curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    start /wait %TEMP%\%OUTPUT% /S /desktopshortcut /quicklaunchshortcut /startmenu

ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
    POWERSHELL; Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\HandBrake %SYSTEMDRIVE%\PROGRA~1\HandBrake\HandBrake.exe' -WindowStyle Hidden -Verb RunAs -Wait

ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%
    DEL %TEMP%\version*

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------