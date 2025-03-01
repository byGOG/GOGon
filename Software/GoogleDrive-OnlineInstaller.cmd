@ECHO OFF
SET "OUTPUT=GoogleDrive.exe"
SET "NAME=Google Drive"
TITLE %NAME%

SET MY_URL=https://dl.google.com/drive-file-stream/GoogleDriveSetup.exe

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ GoogleDriveFS.exe" 2>NUL | FIND /I /N "GoogleDriveFS.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM GoogleDriveFS.exe /F /T
)

ECHO %NAME%:%VERSION% INDIRILIYOR...
     curl -L -o %TEMP%\%OUTPUT% %MY_URL%

ECHO %NAME% YUKLENIYOR...
     start /wait %TEMP%\%OUTPUT% --silent --desktop_shortcut --skip_launch_new --gsuite_shortcuts=false

ECHO GECICI DOSYALAR TEMIZLENIYOR...
     DEL %TEMP%\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------