@echo off
setlocal

REM Klasor olusturuluyor...
echo Klasor olusturuluyor...
if not exist "C:\Tools" (
    mkdir C:\Tools
)
cd C:\Tools

REM Windows Defender haric tutma
echo Windows Defender haric tutma islemi yapiliyor...
powershell -Command "Start-Process powershell -ArgumentList 'Add-MpPreference -ExclusionPath \"C:\Tools\dControl\"' -Verb RunAs -WindowStyle Hidden"

REM Dosyalari indirme
echo UnRAR.exe indiriliyor...
curl -L -o unrarw64.exe "https://www.rarlab.com/rar/unrarw64.exe"
if %errorlevel% neq 0 (
    echo unrarw64.exe indirme basarisiz oldu.
    exit /b %errorlevel%
)
echo dControl indiriliyor...
curl -L -o dControl.rar "https://drive.usercontent.google.com/download?id=1jxmKjN820qP_cLZLgbeBi-aP5DUbROle&export=download&confirm=t"
if %errorlevel% neq 0 (
    echo dControl.rar indirme basarisiz oldu.
    exit /b %errorlevel%
)

REM Unrar kurulum ve dosya cikarma
echo UnRAR cikartiliyor...
unrarw64.exe /S
if %errorlevel% neq 0 (
    echo Unrar kurulumu basarisiz oldu.
    exit /b %errorlevel%
)
echo dControl cikartiliyor...
unrar.exe e -o+ -p"sordum" dControl.rar "dControl\"
if %errorlevel% neq 0 (
    echo dControl.rar cikarma basarisiz oldu.
    exit /b %errorlevel%
)

REM Gecici dosyalari silme
echo Gecici dosyalar siliniyor...
del dControl.rar
del license.txt
del UnRAR.exe
del unrarw64.exe

REM dControl baslatma
echo dControl baslatiliyor...
start C:\Tools\dControl\dControl.exe

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

endlocal
echo Islem tamamlandi.