@echo off
setlocal
set output=7z.exe
set name=7-Zip

title %name%

REM VERSIYON NUMARASINI KONTROL ET
curl -s https://www.7-zip.org/ | findstr /C:"Download 7-Zip " | findstr /v /c:"beta" | findstr /v /c:"alpha" > %temp%\version.txt
for /F "tokens=3" %%G in (%temp%\version.txt) do set version=%%G
set version=%version:.=%

if "%PROCESSOR_ARCHITECTURE%"=="AMD64" (
    set zip_url=https://www.7-zip.org/a/7z%version%-x64.exe
) else (
    set zip_url=https://www.7-zip.org/a/7z%version%.exe
)

ECHO ---------------------------------------------------
TASKLIST /FI "IMAGENAME EQ 7zFM.exe" 2>NUL | FIND /I /N "7zFM.exe">NUL
IF "%ERRORLEVEL%"=="0" (
    ECHO %NAME% KAPATILIYOR...
    TASKKILL /IM 7zFM.exe /F /T
)

ECHO %name%:%version% INDIRILIYOR
curl -L -o %temp%\%output% %zip_url%

ECHO %name% YUKLENIYOR...
start /wait %temp%\%output% /S

ECHO AYARLAR YAPILANDIRILIYOR...
Reg.exe add "HKCU\Software\7-Zip\Options" /v "MenuIcons" /t REG_DWORD /d "1" /f
Reg.exe add "HKCU\Software\7-Zip\Options" /v "ContextMenu" /t REG_DWORD /d "16247" /f

ECHO GECICI DOSYALAR TEMIZLENIYOR...
del %temp%\%output%
del %temp%\version.txt

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
