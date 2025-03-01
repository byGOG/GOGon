@echo off
setlocal

REM Klasor olusturuluyor...
echo Klasor olusturuluyor...
if not exist "C:\Tools" (
    mkdir C:\Tools
)
cd C:\Tools

REM Dosyalari indirme
echo Dns Jumper indiriliyor...
curl -L -o DnsJumper.zip "https://www.sordum.org/files/downloads.php?dns-jumper"
if %errorlevel% neq 0 (
    echo DnsJumper.zip indirme basarisiz oldu.
    exit /b %errorlevel%
)

REM Dns Jumper cikartiliyor...
echo Dns Jumper cikartiliyor...
powershell -Command "Expand-Archive -Path DnsJumper.zip -DestinationPath C:\Tools -Force"
if %errorlevel% neq 0 (
    echo DnsJumper.zip cikarma basarisiz oldu.
    exit /b %errorlevel%
)

REM Gecici dosyalari silme
echo Gecici dosyalar siliniyor...
del DnsJumper.zip

REM Dns Jumper baslatma
echo Dns Jumper baslatiliyor...
start C:\Tools\DnsJumper\DnsJumper.exe

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

echo Islem tamamlandi.
endlocal