@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT=DefenderExclusionTool.zip"
SET "NAME=Defender Exclusion Tool"
TITLE %NAME%

SET "URL=https://www.sordum.org/files/downloads.php?defender-exclusion-tool"

ECHO ---------------------------------------------------
REM Eski WindowsUpdateBlocker klasörü siliniyor...
IF EXIST "%SYSTEMDRIVE%\Tools\DefenderExclusionTool" (
    RMDIR /S /Q "%SYSTEMDRIVE%\Tools\DefenderExclusionTool"
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


REM Defender Exclusion Tool çıkarılıyor...
ECHO Defender Exclusion Tool çıkarılıyor...
POWERSHELL -Command "Expand-Archive -Path %SYSTEMDRIVE%\Tools\DefenderExclusionTool.zip -DestinationPath %SYSTEMDRIVE%\Tools\ -Force"
IF %ERRORLEVEL% NEQ 0 (
    ECHO DefenderExclusionTool.zip çıkarma başarısız oldu.
    EXIT /B %ERRORLEVEL%
)

REM Klasör ismi değiştiriliyor...
ECHO Klasör ismi değiştiriliyor...
FOR /D %%D IN ("%SYSTEMDRIVE%\Tools\ExcTool*") DO REN "%%D" "DefenderExclusionTool"

REM Geçici dosyalar siliniyor...
ECHO Geçici dosyalar siliniyor...
DEL %SYSTEMDRIVE%\Tools\DefenderExclusionTool.zip

REM DefenderExclusionTool baslatma
echo DefenderExclusionTool baslatiliyor...
start C:\Tools\DefenderExclusionTool\ExcTool.exe

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