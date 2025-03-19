@ECHO OFF
chcp 65001 >NUL
SET "OUTPUT10=WindowsMediaCreationTool10.exe"
SET "OUTPUT11=WindowsMediaCreationTool11.exe"
SET "NAME=Windows Media Creation Tool"
TITLE %NAME%

SET "URL10=https://go.microsoft.com/fwlink/?LinkId=2265055"
SET "URL11=https://go.microsoft.com/fwlink/?linkid=2156295"

ECHO ---------------------------------------------------
REM Klasör oluşturuluyor...
ECHO Klasör oluşturuluyor...
IF NOT EXIST "C:\Tools\WindowsMediaCreationTool" (
    MKDIR C:\Tools\WindowsMediaCreationTool
)
CD /D C:\Tools\WindowsMediaCreationTool

ECHO %NAME% indiriliyor...
curl -L -o %SYSTEMDRIVE%\Tools\WindowsMediaCreationTool\%OUTPUT10% "%URL10%"
IF %ERRORLEVEL% NEQ 0 (
    ECHO %OUTPUT10% indirilirken bir hata oluştu.
    EXIT /B 1
)
curl -L -o %SYSTEMDRIVE%\Tools\WindowsMediaCreationTool\%OUTPUT11% "%URL11%"
IF %ERRORLEVEL% NEQ 0 (
    ECHO %OUTPUT11% indirilirken bir hata oluştu.
    EXIT /B 1
)


ECHO Kurulum başarıyla tamamlandı! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------