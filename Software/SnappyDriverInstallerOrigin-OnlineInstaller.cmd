@ECHO OFF
SET "OUTPUT=SDIO.zip"
SET "NAME=Snappy Driver IO"
TITLE %NAME%

FOR /F "tokens=4 delims=>< " %%A IN ('powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (Invoke-WebRequest -Uri 'https://www.glenn.delahoy.com/snappy-driver-installer-origin/' -UseBasicParsing).Content" ^| findstr /I ".zip" ^| findstr /I "href"') DO (
    SET "DOWNLOAD_URL=%%A"
    IF NOT "%%A"=="href=" GOTO DOWNLOAD
)

:DOWNLOAD
ECHO %DOWNLOAD_URL% | findstr /I "http" >nul || SET "DOWNLOAD_URL=https://www.glenn.delahoy.com/snappy-driver-installer-origin/%DOWNLOAD_URL%"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
	POWERSHELL -Command "Start-Process powershell -ArgumentList 'Get-Process -Name SDIO_x64_* -ErrorAction SilentlyContinue | ForEach-Object { Stop-Process -Id $_.Id -Force }' -Verb RunAs -WindowStyle Hidden -Wait"

ECHO KLASOR OLUSTURULUYOR...
	mkdir "%SYSTEMDRIVE%\Tools"

ECHO %NAME% INDIRILIYOR...
	powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri '%DOWNLOAD_URL%' -OutFile '%SYSTEMDRIVE%\Tools\%OUTPUT%'"

ECHO DOSYALAR CIKARILIYOR...
	POWERSHELL Expand-Archive -LiteralPath '%SYSTEMDRIVE%\tools\%OUTPUT%' -DestinationPath "%SYSTEMDRIVE%\Tools\SnappyDriverInstallerOrigin" -Force

ECHO MASAUSTUNE KISAYOL OLUSTURULUYOR...
	FOR %%F IN ("%SYSTEMDRIVE%\Tools\SnappyDriverInstallerOrigin\SDIO_x64_*.exe") DO (
	    POWERSHELL -Command "$Shell=New-Object -COMObject WScript.Shell; $Shortcut=$Shell.CreateShortcut($Shell.SpecialFolders('Desktop') + '\Snappy Driver Installer Origin.lnk'); $Shortcut.TargetPath='%%F'; $Shortcut.WorkingDirectory='%SYSTEMDRIVE%\Tools\SnappyDriverInstallerOrigin'; $Shortcut.IconLocation='%%F,0'; $Shortcut.Save()"
	)

ECHO GECICI DOSYALAR TEMIZLENIYOR...
    DEL %SYSTEMDRIVE%\Tools\%OUTPUT%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------