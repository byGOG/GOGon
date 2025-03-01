@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT=SysinternalsSuite.zip"
SET "NAME=Sys internals Suite"
TITLE %NAME%

SET "URL=https://download.sysinternals.com/files/SysinternalsSuite.zip"

ECHO ---------------------------------------------------
REM Klasör oluşturuluyor...
ECHO Klasör oluşturuluyor...
IF NOT EXIST "C:\Tools" (
    MKDIR C:\Tools
)
CD /D C:\Tools

ECHO %NAME% indiriliyor...
curl -L -o %SYSTEMDRIVE%\Tools\%OUTPUT% "%URL%"
IF %ERRORLEVEL% NEQ 0 (
    ECHO İndirme başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM SysinternalsSuite çıkarılıyor...
ECHO SysinternalsSuite çıkarılıyor...
POWERSHELL -Command "Expand-Archive -Path %SYSTEMDRIVE%\Tools\SysinternalsSuite.zip -DestinationPath %SYSTEMDRIVE%\Tools\SysinternalsSuite -Force"
IF %ERRORLEVEL% NEQ 0 (
    ECHO SysinternalsSuite.zip çıkarma başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Geçici dosyalar siliniyor...
ECHO Geçici dosyalar siliniyor...
DEL %SYSTEMDRIVE%\Tools\SysinternalsSuite.zip

REM Masaüstüne kısayol oluşturuluyor...
ECHO Masaüstüne kısayol oluşturuluyor...
POWERSHELL -Command "Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\Autoruns.lnk %SYSTEMDRIVE%\Tools\SysinternalsSuite\Autoruns64.exe' -WindowStyle Hidden -Verb RunAs -Wait"
POWERSHELL -Command "Start-Process cmd -ArgumentList '/c mklink %PUBLIC%\Desktop\ProcessExplorer.lnk %SYSTEMDRIVE%\Tools\SysinternalsSuite\procexp64.exe' -WindowStyle Hidden -Verb RunAs -Wait"

ECHO Kurulum başarıyla tamamlandı! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------