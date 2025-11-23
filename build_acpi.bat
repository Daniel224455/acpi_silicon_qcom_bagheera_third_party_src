@REM Copyright (c) 2010, 2013 Qualcomm Technologies Inc. All rights reserved.
@REM

@ECHO OFF

:: Make Error level to zero at the begining 
ver >nul

if /I "%~1"=="" (
    goto HELP
)

if /I not "%~3"=="" (
    goto HELP
)

:: ACPI_BUILD_OUTPUT is where the tables will be created. It can be specified on the command line or
:: in an environment variable. The command line has precedence. If no value is given, a default is used.
::
:: Use the command line if specified.
set ACPI_BUILD_OUTPUT=
if /I not "%~2"=="" (
    set ACPI_BUILD_OUTPUT=%~2%
)

set VARIANT=%1
set SOC=%VARIANT:~0,4%
set TEMP_SOC=%SOC%
set DEVICE_TYPE=%VARIANT:~-2,2%
set PLATFORMVARIANT=%VARIANT:~5,-3%

if "%SOC%"=="Comm" (
echo EXITING
GOTO EXIT
)
if /I "%DEVICE_TYPE%"=="wp" (
set DEVICE_TYPE=WP
)

if /I "%DEVICE_TYPE%"=="wa" (
set DEVICE_TYPE=WA
)

if "%QCPLATFORM%"=="8996" (
call:8996
GOTO EXIT
)

call:%SOC%
GOTO EXIT 

:8916
	call:buildVariantFunc %SOC%_%PLATFORMVARIANT%_%DEVICE_TYPE%
GOTO EXIT

:8016
	SET SOC=8916
	call:buildVariantFunc %TEMP_SOC%_%PLATFORMVARIANT%_%DEVICE_TYPE%
GOTO EXIT

:HELP
ECHO.
ECHO. Usage: "build_acpi <platform name> [output folder]"
ECHO. Platform_name: 
ECHO. 	8916:		8016_SBC_WP
ECHO. When using build all, It will build 
ECHO. e.g. build_acpi.bat 8994_MTP_WP
ECHO. 
ECHO. 
ECHO. If [output folder] specified, the tables will be created in 'output folder'. Don't specify output folder name incase of BUILDALL
ECHO. Otherwise they will be created in ".\TABLES\<platform name>"


:Exit
EXIT /B 

:Error
EXIT /B ERRORLEVEL

REM GOTO:EOF

::----------------------------------------------------------------------------------------------
::-- Function section starts here
::----------------------------------------------------------------------------------------------


:buildVariantFunc
SETLOCAL
:: The target for which we are building - SURF, FLUID or QRDC.
set VARIANT=%1
set ORIGVARIANT=%1

:: The folder that contains this batch file
set WORKSPACE=%CD%
:: The folder in which an output folder will be created
set TABLES=%WORKSPACE%\TABLES
set BIN=%WORKSPACE%\bin
:: Product type, WA or WP. Used for macropreprocessing
set PRODTYPE=%VARIANT:~-2,2%
:: Location of supporting binaries
if /I "%ORIGVARIANT:~-8,5%" =="_TEST" (
    set VARIANT=%VARIANT:~0,-8%%VARIANT:~-3%
)
:: Intermediate build ouput folder
set BLDFLDR=%WORKSPACE%\TEMP\ACPI\%TEMP_SOC%\%ORIGVARIANT%
set PREPROCESS=%BLDFLDR%\PREPROCESS

echo %ACPI_BUILD_OUTPUT%
:: Use an environment variable if specified
if /I "%ACPI_BUILD_OUTPUT%"=="" (
    set ACPI_BUILD_OUTPUT=%TABLES%\%TEMP_SOC%\%ORIGVARIANT%
)


if not exist %ACPI_BUILD_OUTPUT% (
    mkdir %ACPI_BUILD_OUTPUT%
)

if not exist %WORKSPACE%\%SOC%\%VARIANT% (
    echo.
    echo.
    echo ERROR: %WORKSPACE%\%SOC%\%VARIANT% doesn't exist!
    GOTO:EOF
)

if not exist %BLDFLDR% (
    mkdir %BLDFLDR%
)

del /q %BLDFLDR%\*

if not exist %PREPROCESS% (
	mkdir %PREPROCESS%
)

:: Ensure the MS arm compiler gets picked up
Setlocal EnableDelayedExpansion
IF EXIST !VCINSTALLDIR!bin\x86_ARM\cl.exe (
    set path=!VCINSTALLDIR!bin\x86_ARM;!path!
 ) ELSE ( 
    set path=!WDKContentRoot!\bin\x86\arm;!path!
 )

cl > NUL 2>&1

if ERRORLEVEL 9009 if not ERRORLEVEL 9010 ( 
    echo.
    echo.
    echo ERROR: This script requires the MSFT EA ARM compiler.
    echo        Please add it to your path.
    GOTO:EOF
)

"!WDKContentRoot!\Tools\x64\ACPIVerify\asl.exe" > NUL 2>&1

if ERRORLEVEL 9009 if not ERRORLEVEL 9010 ( 
    echo.
    echo.
    echo ERROR: This script requires the MSFT EA ASL compiler.
    echo        Please add it to your path.
    GOTO:EOF
)

   
IF /I "%VARIANT:~-3%" =="_WA" (
                        set FAT_FILE=FAT16_256MB.bin
                    ) ELSE (
                        set FAT_FILE=fat.bin
                    )

copy /y %BIN%\%FAT_FILE% %ACPI_BUILD_OUTPUT%\fat16.bin >NUL
        if NOT ERRORLEVEL 0 GOTO:EOF
	if ERRORLEVEL 1 GOTO:EOF
attrib -r %ACPI_BUILD_OUTPUT%\fat16.bin

REM COPY all files to PREPROCESS folder
if exist %WORKSPACE%\%SOC%\%VARIANT%\PARENTS (
for /f %%b in (%WORKSPACE%\%SOC%\%VARIANT%\PARENTS) do (
    echo copy /y %WORKSPACE%\%%b\* %PREPROCESS% > NUL
    copy /y %WORKSPACE%\%%b\* %PREPROCESS% > NUL
)
)
copy /y %WORKSPACE%\%SOC%\%VARIANT%\* %PREPROCESS% > NUL

if exist %WORKSPACE%\%SOC%\%VARIANT%\Testdev\testdev.asl (
      copy /y %WORKSPACE%\%SOC%\%VARIANT%\Testdev\testdev.asl %PREPROCESS%\
)

::Preproces Macros in asl files
call :preprocess_macros
:: Ensure the MS arm compiler gets picked up again since env was reset due to msbuild
Setlocal EnableDelayedExpansion
IF EXIST !VCINSTALLDIR!bin\x86_ARM\cl.exe (
    set path=!VCINSTALLDIR!bin\x86_ARM;!path!
 ) ELSE ( 
    set path=!WDKContentRoot!\bin\x86\arm;!path!
 )

cl > NUL 2>&1

if ERRORLEVEL 9009 if not ERRORLEVEL 9010 ( 
    echo.
    echo.
    echo ERROR: This script requires the MSFT EA ARM compiler.
    echo        Please add it to your path.
    GOTO:EOF
)

"!WDKContentRoot!\Tools\x64\ACPIVerify\asl.exe" > NUL 2>&1

if ERRORLEVEL 9009 if not ERRORLEVEL 9010 ( 
    echo.
    echo.
    echo ERROR: This script requires the MSFT EA ASL compiler.
    echo        Please add it to your path.
    GOTO:EOF
) 
 
:: NUL out testdev.asl if build is not for test
if /I NOT "%ORIGVARIANT:~-8,5%" =="_TEST" (
    copy /y nul %BLDFLDR%\testdev.asl
)

pushd %BLDFLDR% >NUL

if exist %BLDFLDR%\pep.asl2 (
      cl /nologo /WX /EP /C %BLDFLDR%\pep.asl2 > %BLDFLDR%\pep.asl
      if NOT ERRORLEVEL 0 GOTO:EOF
      if ERRORLEVEL 1 GOTO:EOF
)

for /f %%b in ('dir /b %BLDFLDR%\dsdt.asl') do (
    if not "%%~xb"==".aslc" (
        echo %%b
        "!WDKContentRoot!\Tools\x64\ACPIVerify\asl.exe" /nologo /Fo="%ACPI_BUILD_OUTPUT%\%%~nb.aml" "%BLDFLDR%\%%~nb.asl"
        if NOT ERRORLEVEL 0 GOTO:EOF
	if ERRORLEVEL 1 GOTO:EOF
        %BIN%\cpfatfs.exe %ACPI_BUILD_OUTPUT%\fat16.bin ACPI "%ACPI_BUILD_OUTPUT%\%%~nb.aml" >NUL 2>&1
        if NOT ERRORLEVEL 0 GOTO:EOF
	if ERRORLEVEL 1 GOTO:EOF
    )
)
popd >NUL

for /f %%a in ('dir /b %BLDFLDR%\*.aslc') do (
    cl /nologo /Fo%BLDFLDR%\%%~na.obj /WX /c /TC /I%WORKSPACE%\inc /I%WORKSPACE%\inc\%SOC% %BLDFLDR%\%%~na.aslc
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
    link /DLL /MACHINE:ARM /NODEFAULTLIB /NOENTRY /NOLOGO /OUT:%BLDFLDR%\%%~na.dll %BLDFLDR%\%%~na.obj	
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
    %BIN%\acpi_extract.exe %BLDFLDR%\%%~na.dll %ACPI_BUILD_OUTPUT%\%%~na.acpi 
    if NOT ERRORLEVEL 0 GOTO:EOF
	if ERRORLEVEL 1 GOTO:EOF
    %BIN%\cpfatfs.exe %ACPI_BUILD_OUTPUT%\fat16.bin ACPI %ACPI_BUILD_OUTPUT%\%%~na.acpi >NUL 2>&1
    if NOT ERRORLEVEL 0 GOTO:EOF
    if ERRORLEVEL 1 GOTO:EOF
)


rem Injecting logo1.bmp in to the root of fat16.bin
if exist %WORKSPACE%\src\bgrt_logo\logo1.bmp %BIN%\cpfatfs.exe %ACPI_BUILD_OUTPUT%\fat16.bin %WORKSPACE%\src\bgrt_logo\logo1.bmp
rem On WP platforms inject logo2.bmp in to fat16.bin as well.
if NOT x%VARIANT:WP=%==x%VARIANT% if exist %WORKSPACE%\src\bgrt_logo\logo2.bmp %BIN%\cpfatfs.exe %ACPI_BUILD_OUTPUT%\fat16.bin %WORKSPACE%\src\bgrt_logo\logo2.bmp


rem Add UEFI_CFG.txt
for /f %%c in ('dir /b %BLDFLDR%') do (
    if "%%c"=="uefi_cfg.txt" (
    copy /Y %BLDFLDR%\%%c %ACPI_BUILD_OUTPUT%\%%c
    %BIN%\cpfatfs.exe %ACPI_BUILD_OUTPUT%\fat16.bin %ACPI_BUILD_OUTPUT%\%%c >NUL 2>&1
    echo %%c   
    if ERRORLEVEL 1 GOTO:EOF
    )
)

echo.
echo.
echo ACPI tables built in folder: %ACPI_BUILD_OUTPUT%
ENDLOCAL
GOTO:EOF

:preprocess_macros
msbuild macro_preprocessor.vcxproj /p:ProdType=%PRODTYPE% /p:QCPlatform=%SOC% /p:InputFolder=%PREPROCESS% /p:OutputFolder=%BLDFLDR% /t:PrintLog;Preprocess /l:FileLogger,Microsoft.Build;logfile=macro_preprocess.log;verbosity=diagnostic 
if ERRORLEVEL 1 (
	echo Error while preprocessing macros in asl files. Please see 'macro_preprocess.log'
	echo.
	goto :EOF
)
 
echo.

for /f %%i in ('dir /b %PREPROCESS%') do (
	if "%%~xi" neq ".asl" (
		move %PREPROCESS%\%%i %BLDFLDR%
	)
)

:: move %PREPROCESS%\*.aslc %BLDFLDR%
:: move %PREPROCESS%\PARENTS %BLDFLDR%
:: del /q %PREPROCESS%\*
:: rmdir %PREPROCESS%

goto :EOF

