@echo off
for /f "tokens=4-5 delims=. " %%i in ('ver') do set VERSION=%%i.%%j
if "%version%" == "10.0" (
	echo.
	echo                                 ...
	echo                              ......
	echo            ...  ....ii1111111111111
	echo     ....ii1111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
 	echo.
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo 11111111111111  1111111111111111111
	echo  1111111111111  1111111111111111111
	echo   111111``*::*  1111111111111111111
	echo                   '"*:1111111111111
	echo.
) else if "%version%" == "6.3" (
	echo OS: Windows 8.1
) else if "%version%" == "6.2" (
	echo "OS: Windows 8"
) else if "%version%" == "6.1" (
	echo Windows 7
) else if "%version%" == "6.0" (
	echo Windows Vista
)

echo ------------------------- SYSTEM INFO -------------------------
echo.
for /f "usebackq tokens=1,2 delims==" %%f in ('wmic.exe os get name^,version /format:list') do 2>NUL set "%%f=%%j"
echo OS:                  %name%
for /f "tokens=2 delims==" %%f in ('wmic.exe os get version /value ^| find "="') do set "OSVERSION=%%f"
echo Version:             %OSVERSION%
echo Computer Name:       %COMPUTERNAME%
for /f "tokens=2 delims==" %%f in ('wmic.exe computersystem get model /value ^| find "="') do set "MODEL=%%f"
echo Computer Model:      %MODEL%
for /f "tokens=2 delims==" %%f in ('wmic.exe bios get version /value ^| find "="') do set "FIRMWAREVERSION=%FIRMWAREVERSION% %%f"
echo Firmware Version:    %FIRMWAREVERSION%
echo.
echo --------------- PROCESSOR ---------------
echo.
for /f "tokens=2 delims==" %%f in ('wmic.exe cpu get name /value ^| find "="') do set "CPUNAME=%%f"
echo Processor:           %CPUNAME%
echo Architecture:        %PROCESSOR_ARCHITECTURE%
for /f "tokens=2 delims==" %%f in ('wmic.exe cpu get numberofcores /value ^| find "="') do set "CPUCORES=%%f"
echo No. of Cores:        %CPUCORES%
for /f "tokens=2 delims==" %%f in ('wmic.exe bios get name /value ^| find "="') do set "FIRMWAREVERSION=%%f"
for /f "tokens=2 delims==" %%f in ('wmic.exe cpu get manufacturer /value ^| find "="') do set "CPUMANUFACTURER=%%f"
echo Manufacturer:        %CPUMANUFACTURER%
for /f "tokens=2 delims==" %%f in ('wmic.exe cpu get socketdesignation /value ^| find "="') do set "CPUPLUG=%%f"
echo Plug:                %CPUPLUG%
for /f "tokens=2 delims==" %%f in ('wmic.exe cpu get deviceid /value ^| find "="') do set "CPUDEVICE=%%f"
echo Device ID:           %CPUDEVICE%
echo.
echo --------------- GRAPHICS PROCESSOR ---------------
echo.
for /f "tokens=2 delims==" %%f in ('wmic.exe PATH win32_VideoController GET name /value ^| find "="') do set "GPUNAME=%%f"
echo Graphics Processor:  %GPUNAME%
for /f "tokens=2 delims==" %%f in ('wmic.exe PATH Win32_videocontroller GET AdapterRAM /value ^| find "="') do set "GPURAM=%%f"
echo Memory:              %GPURAM% Bytes
for /f "tokens=2 delims==" %%f in ('wmic.exe PATH Win32_videocontroller GET driverversion /value ^| find "="') do set "GPUDRIVER=%%f"
echo Driver Version:      %GPUDRIVER%
for /f "tokens=2 delims==" %%f in ('wmic.exe PATH Win32_videocontroller GET pnpdeviceid /value ^| find "="') do set "GPUDEVICE=%%f"
echo Device ID:           "%GPUDEVICE%"
echo.
echo *NOTE: If multiple graphics cards are installed, the above information is applicable for primary graphics adapter only.
echo.
pause
