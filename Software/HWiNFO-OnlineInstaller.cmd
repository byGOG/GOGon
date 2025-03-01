@ECHO OFF
SET "OUTPUT=HWiNFO.exe"
SET "NAME=HWiNFO"
TITLE %NAME% 

curl -sL https://sourceforge.net/projects/hwinfo/files/Windows_Installer/ | findstr /C:"hwi64_" > %temp%\version.txt
FOR /F "tokens=2 delims=_" %%G IN (%temp%\version.txt) DO SET VERSION=%%G
SET VERSION=%VERSION:~0,3%

SET "URL=https://sourceforge.net/projects/hwinfo/files/Windows_Installer/hwi64_%VERSION%.exe"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
powershell -Command "if (Get-Process HWiNFO64 -ErrorAction SilentlyContinue) { Start-Process taskkill -ArgumentList '/IM HWiNFO64.exe /F /T' -Verb RunAs -Wait }"

ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
    START /WAIT %TEMP%\%OUTPUT% /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
	
ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
    SET "TARGET=%ProgramFiles%\HWiNFO64\HWiNFO64.exe"
    SET "SHORTCUT=%USERPROFILE%\Desktop\HWiNFO 64.lnk"
    powershell -Command "$ws = New-Object -ComObject WScript.Shell; $s = $ws.CreateShortcut('%SHORTCUT%'); $s.TargetPath = '%TARGET%'; $s.Save()"

ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %TEMP%\%OUTPUT%
    DEL %TEMP%\version*
    powershell -Command "if (Get-Process HWiNFO64 -ErrorAction SilentlyContinue) { Start-Process taskkill -ArgumentList '/IM HWiNFO64.exe /F /T' -Verb RunAs -Wait }"

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------