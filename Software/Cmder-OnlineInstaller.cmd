@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT=Cmder.zip"
SET "NAME=Cmder"
TITLE %NAME%

REM Versiyon bilgisi alınıyor...
curl -sL https://github.com/cmderdev/cmder/releases/latest | findstr /C:"<title>Release " > %temp%\version.txt
IF %ERRORLEVEL% NEQ 0 (
    ECHO Versiyon bilgisi alınamadı.
    EXIT /B %ERRORLEVEL%
)
FOR /F "tokens=3 delims=<> " %%G IN (%temp%\version.txt) DO SET VERSION=%%G

SET "URL=https://github.com/cmderdev/cmder/releases/download/%VERSION%/Cmder.zip"

ECHO ---------------------------------------------------
ECHO %NAME% kapatılıyor...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM ConEmuC64.exe /F /T' -Verb RunAs -WindowStyle Hidden"
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

REM Cmder çıkarılıyor...
ECHO Cmder çıkarılıyor...
POWERSHELL -Command "Expand-Archive -Path %SYSTEMDRIVE%\Tools\Cmder.zip -DestinationPath %SYSTEMDRIVE%\Tools\Cmder -Force"
IF %ERRORLEVEL% NEQ 0 (
    ECHO Cmder.zip çıkarma başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Geçici dosyalar siliniyor...
ECHO Geçici dosyalar siliniyor...
DEL %temp%\version.txt
DEL %SYSTEMDRIVE%\Tools\Cmder.zip

REM Masaüstüne kısayol oluşturuluyor...
ECHO Masaüstüne kısayol oluşturuluyor...
POWERSHELL -Command "Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\Cmder.lnk %SYSTEMDRIVE%\Tools\Cmder\Cmder.exe' -WindowStyle Hidden -Verb RunAs -Wait"

ECHO Kurulum başarıyla tamamlandı! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------