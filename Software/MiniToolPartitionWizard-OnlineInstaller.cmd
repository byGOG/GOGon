@ECHO OFF
SET "OUTPUT=MiniToolPartitionWizard.exe"
SET "NAME=MiniTool Partition Wizard"
TITLE %NAME%

SET "URL=https://cdn2.minitool.com/?p=pw&e=pw-free-offline"

ECHO ---------------------------------------------------
ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM partitionwizard.exe /F /T' -Verb RunAs -WindowStyle Hidden"

FOR /D %%D IN ("%ProgramFiles%\MiniTool Partition Wizard*") DO (
    IF EXIST "%%D\unins000.exe" (
        ECHO %NAME% KALDIRILIYOR...
        "%%D\unins000.exe" /VERYSILENT
    )
)

ECHO %NAME% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT% "%URL%"

ECHO %NAME% YUKLENIYOR...
START /WAIT %TEMP%\%OUTPUT% /allusers /VERYSILENT /NOFORCECLOSEAPPLICATIONS

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT%

ECHO %NAME% KAPATILIYOR...
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM msedge.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM zen.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM chrome.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM brave.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM firefox.exe /F /T' -Verb RunAs -WindowStyle Hidden"
POWERSHELL -Command "Start-Process cmd -Args '/c TASKKILL /IM partitionwizard.exe /F /T' -Verb RunAs -WindowStyle Hidden"
reg add "HKCU\Software\MiniTool Software Limited\MiniTool Partition Wizard" /v "00cfb691-7786-46e4-a4af-7e2cb0eb10c5" /t REG_DWORD /d 2 /f

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------