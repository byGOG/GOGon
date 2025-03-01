@ECHO OFF
SETLOCAL
SET "OUTPUT_32=Java-Installer-32.exe"
SET "OUTPUT_64=Java-Installer-64.exe"
SET "NAME=Java"
TITLE %NAME%

ECHO ---------------------------------------------------
ECHO %NAME%:%VERSION% INDIRILIYOR...
curl -L -o %TEMP%\%OUTPUT_32% "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251407_0d8f12bc927a4e2c9f8568ca567db4ee"
curl -L -o %TEMP%\%OUTPUT_64% "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=251408_0d8f12bc927a4e2c9f8568ca567db4ee"

ECHO %NAME% YUKLENIYOR...
start /wait %TEMP%\%OUTPUT_32% /s
start /wait %TEMP%\%OUTPUT_64% /s

ECHO GECICI DOSYALAR TEMIZLENIYOR...
DEL %TEMP%\%OUTPUT_32%
DEL %TEMP%\%OUTPUT_64%

ECHO KURULUM BASARIYLA TAMAMLANDI! BY GOG [SORDUM.NET]
ECHO ---------------------------------------------------
