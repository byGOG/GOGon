@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT=DriverStoreExplorer.zip"
SET "NAME=DriverStoreExplorer"
TITLE %NAME%

REM Versiyon bilgisi alınıyor...
curl -sL https://github.com/lostindark/DriverStoreExplorer/releases/latest | findstr /C:"<title>Release DriverStore Explorer " > %temp%\version.txt
IF %ERRORLEVEL% NEQ 0 (
    ECHO Versiyon bilgisi alınamadı.
    EXIT /B %ERRORLEVEL%
)
FOR /F "tokens=5 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/lostindark/DriverStoreExplorer/releases/download/%VERSION%/DriverStoreExplorer.%VERSION%.zip"



ECHO ---------------------------------------------------
ECHO %NAME% kapatılıyor...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM Rapr.exe /F /T' -Verb RunAs -WindowStyle Hidden"
IF %ERRORLEVEL% NEQ 0 (
    ECHO %NAME% kapatma işlemi başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Klasör oluşturuluyor...
ECHO Klasör oluşturuluyor...
IF NOT EXIST "C:\Tools" (
    MKDIR C:\Tools
)
CD /D C:\Tools

ECHO %NAME%:%VERSION% indiriliyor...
curl -L -o %SYSTEMDRIVE%\Tools\%OUTPUT% "%URL%"
IF %ERRORLEVEL% NEQ 0 (
    ECHO İndirme başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM DriverStoreExplorer çıkarılıyor...
ECHO DriverStoreExplorer çıkarılıyor...
POWERSHELL -Command "Expand-Archive -Path %SYSTEMDRIVE%\Tools\DriverStoreExplorer.zip -DestinationPath %SYSTEMDRIVE%\Tools\DriverStoreExplorer -Force"
IF %ERRORLEVEL% NEQ 0 (
    ECHO DriverStoreExplorer.zip çıkarma başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Geçici dosyalar siliniyor...
ECHO Geçici dosyalar siliniyor...
DEL %temp%\version.txt
DEL %SYSTEMDRIVE%\Tools\DriverStoreExplorer.zip

REM Masaüstüne kısayol oluşturuluyor...
ECHO Masaüstüne kısayol oluşturuluyor...
POWERSHELL -Command "Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\DriverStoreExplorer.lnk %SYSTEMDRIVE%\Tools\DriverStoreExplorer\Rapr.exe' -WindowStyle Hidden -Verb RunAs -Wait"

ECHO Kurulum başarıyla tamamlandı! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------