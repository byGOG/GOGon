@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT=Wub.zip"
SET "NAME=Windows Update Blocker"
TITLE %NAME%

SET "URL=https://www.sordum.org/files/downloads.php?st-windows-update-blocker"

ECHO ---------------------------------------------------
REM Eski WindowsUpdateBlocker klasörü siliniyor...
IF EXIST "%SYSTEMDRIVE%\Tools\WindowsUpdateBlocker" (
    RMDIR /S /Q "%SYSTEMDRIVE%\Tools\WindowsUpdateBlocker"
)

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


REM Windows Update Blocker Tool çıkarılıyor...
ECHO Windows Update Blocker Tool çıkarılıyor...
POWERSHELL -Command "Expand-Archive -Path %SYSTEMDRIVE%\Tools\Wub.zip -DestinationPath %SYSTEMDRIVE%\Tools\ -Force"
IF %ERRORLEVEL% NEQ 0 (
    ECHO Wub.zip çıkarma başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Klasör adı değiştiriliyor...
ECHO Klasör adı değiştiriliyor...
REN "%SYSTEMDRIVE%\Tools\Wub" "WindowsUpdateBlocker"
IF %ERRORLEVEL% NEQ 0 (
    ECHO Klasör adı değiştirme başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Geçici dosyalar siliniyor...
ECHO Geçici dosyalar siliniyor...
DEL %SYSTEMDRIVE%\Tools\Wub.zip

REM WindowsUpdateBlocker baslatma
echo WindowsUpdateBlocker baslatiliyor...
start C:\Tools\WindowsUpdateBlocker\Wub_x64.exe

REM Masaustu kisayolu olusturma
echo Masaustu kisayolu olusturuluyor...
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = oWS.SpecialFolders("Desktop") ^& "\Tools.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Tools" >> %SCRIPT%
:: Simge dosyasını tanımla - Windows'un standart simgelerinden biri kullanılıyor
echo oLink.IconLocation = "C:\Windows\System32\SHELL32.dll,24" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

ECHO Kurulum başarıyla tamamlandı! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------