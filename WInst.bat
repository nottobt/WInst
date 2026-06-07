:: SPDX-License-Identifier: GPL-2.0-or-later

:: Windows Installation Executable
:: Beta Release 0.6.2b

:: WInst - Windows Installation Executable
:: Copyright (C) NotToBT 2025, 2026.
::
:: This program is free software; you can redistribute it and/or modify
:: it under the terms of the GNU General Public License as published by
:: the Free Software Foundation; either version 2 of the License, or
:: (at your option) any later version.
::
:: This program is distributed in the hope that it will be useful,
:: but WITHOUT ANY WARRANTY; without even the implied warranty of
:: MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
:: GNU General Public License for more details.
::
:: You should have received a copy of the GNU General Public License along
:: with this program; if not, write to the Free Software Foundation, Inc.,
:: 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
::

:: Before executing this program:
:: WARNING: As this program is still in the Unstable and Beta phase (v0.6.2b Unstable), you should back up your data before proceeding. Not doing so will have a chance at LOSING your data.
:: Source code: ofc <https://github.com/nottobt/WInst>
:: Latest Update: 07-06-2025 9;45p.m MMT
@echo off
title WInst - V0.6.2b (Unstable)

:setargs
IF "%1"=="" GOTO MAINSETUP
IF /I "%1"=="--help" GOTO help_arg
IF /I "%1"=="/help" GOTO help_arg
IF /I "%1"=="-h"     GOTO help_arg
IF /I "%1"=="/WF" GOTO WFCode
IF /I "%1"=="-WF" GOTO WFCode
IF /I "%1"=="/WimFile" GOTO WFCode
IF /I "%1"=="--WimFile" GOTO WFCode
IF /I "%1"=="--Version" GOTO VERSIONINFO
IF /I "%1"=="/Version" GOTO VERSIONINFO
IF /I "%1"=="-V" GOTO VERSIONINFO
IF /I "%1"=="/V" GOTO VERSIONINFO


echo Unknown option: %1
GOTO help_arg
:WFCode
SET "WIMPATH=%2"
SET WFOPT=1
SHIFT
SHIFT
echo Set WIMPATH as "%WIMPATH%".
GOTO MAINSETUP

ENDLOCAL
:: NOTE TO DEVELOPER: Finish ASCII improvements.
:MAINSETUP
set VERSION="v6.0.2b"
set LICENSE="GPL V2"
set TEMPDIR="X:\Windows\Temp"
set ACTION=0
set BOOT_MODE=0
set DISK=0
set CONF1=0
set WIMPATH=0
set INDEX=0
set MANINPUT=0
set TDF=0
set Stamp=0
set ACTIONL=0
set OPTION=0

:: Time Handling (PRE-RUN STEP 1)
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "datetime=%%I"
set YYYY=%datetime:~0,4%
set MM=%datetime:~4,2%
set DD=%datetime:~6,2%

set "HH=%TIME: =0%""
set HH=%HH:~0,2%
set Min=%TIME:~3,2%
set Sec=%TIME:~6,2%

:FORMATINPUT
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /value') do set "dt=%%I"
set "Stamp=%dt:~0,4%-%dt:~4,2%-%dt:~6,2%_%dt:~8,2%%dt:~10,2%%dt:~12,2%"

echo The date/time formatting has been set as %Stamp%.

if %errorlevel%=="0" (
    echo Time and date formatting successful.
    echo Proceeding to next step of the setup...
    timeout 3 /NOBREAK <nul
    cls
    goto LOGGING
) else (
    echo Time and date formatting unsuccessful.
    echo Logging will be disabled by default.
    echo As logging will be disabled, you will not know about the setup that WInst applied.
    echo Proceeding to next step of the setup...
    timeout 3 /NOBREAK <nul
    echo Waiting for user input...
    pause <nul
    cls
    goto LOGGING
)

:: Configure Logging (PRE-RUN STEP 2)
:LOGGING
echo No logging? (YES/NO)
set /p ACTIONL="Confirmation: "
if "%ACTIONL:~0,1%"=="Y" (
    echo Logging will be disabled.
    timeout 2 /NOBREAK <nul
    set CONFIRM=NO
    goto ADTEST
)
echo Logging will be enabled.
timeout 2 /NOBREAK <nul
echo [%Stamp%] Logging System: Logging has started. > %TEMPDIR%\WinstLOGS.log
set CONFIRM=YES
goto ADTEST


:: ADMIN TEST (PRE-RUN STEP 3)
:ADTEST
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control" /v SystemStartOptions 2^>nul') do set "bootOpts=%%i"
echo %bootOpts% | find /i "MININT" >nul 2>&1
if %errorlevel% equ 0 (
    echo WInst has detected that the user is currently operating this program in Windows PE.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst has detected that the user is currently operating this program in Windows PE. >> WInstLOGS.log
    )
    echo The program will continue shortly...
    timeout 2 /NOBREAK <nul
    cls
    goto OPTION
) else (
    echo WInst has detected that the user is currently operating this program in the full version of Windows.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst has detected that the user is currently operating this program in the full version of Windows. >> WInstLOGS.log
    )
    echo The program will exit in a few moments, as WInst is only intended for use in the Windows PE Environment.
    timeout 6 /NOBREAK <nul
    exit /b
)

cls

:OPTION

echo.
echo  __      __  .___               __   
echo /  \    /  \ ^|   ^|  ____    ____/  ^|_ 
echo \   \/\/   / ^|   ^| /    \  /  _ \   __\
echo  \        /  ^|   ^|^|   ^|  \(  ^<_^) ^|  ^|  
echo   \__/\  /   ^|___^|^|___^|  / \____/^|__^|  
echo        \/             \/             
echo.
pause
echo Windows Installation Wizard (WInst) Version 0.6.2 BETA Unstable
echo.
echo Options:
echo ----------------------------------------------------------------------------------------------------
echo.
echo 1. Install Windows
echo.
echo 2. Exit
echo.
echo 3. Install Windows without deleting system files
echo.
echo 4. In development
echo.
echo ----------------------------------------------------------------------------------------------------
echo.
set /p ACTION="What action would you choose? "
if "%ACTION%"=="1" (
    echo Installation process will start in a few seconds. Please stay put.
    if /i "%CONFIRM%" equ "YES" ( 
  	  pause <nul
 	  cls
    ) else (
   	 echo [%STAMP%] The user has chosen option 1. >> WInstLOGS.log
    )
    timeout 3 /NOBREAK <nul
    cls
    goto INSTALLSTEP1
)
if "%ACTION%"=="2" (
    :OPTION1
    echo Exiting...
    timeout 1 /NOBREAK <nul
    echo Removing processes...
    if /i "%CONFIRM%" equ "YES" ( 
        pause <nul
        exit /b
    ) else (
        echo [%STAMP%] The user had exited. >> WInstLOGS.log
        timeout 2 /NOBREAK <nul
        exit /b
    )
)
if "%ACTION%"=="3" (
    echo Installation process will start in a bit...
    echo Please be patient. WInst is Generating crucial files.
    if /i "%CONFIRM%" equ "YES" ( 
       timeout 3 /NOBREAK <nul
       cls 
       goto INSTALLACTION3
    ) else (
    echo [%STAMP%] The user has chosen option 3.>> WInstLOGS.log
    timeout 3 /NOBREAK <nul
    cls
    goto INSTALLACTION3
    cls
    )
)       
echo Choose an option.
pause
cls
goto :OPTION

:INSTALLSTEP1
:: Step 1: UEFI/BIOS Confirmation

:: Detect Boot Mode
:BOOTMODEDECT
reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType | find /i "0x2" >nul
if %errorlevel% equ 0 (
    set BOOT_MODE=UEFI
) else (
    set BOOT_MODE=BIOS
)

if /i "%CONFIRM%" equ "YES" (
    if %BOOT_MODE%=="UEFI" (
        echo [%Stamp%] UEFI boot mode detected.
    ) else (
        echo [%Stamp%] BIOS (a.k.a Legacy) boot mode detected.
    )
)
echo Detected Boot Mode: %BOOT_MODE%
echo The installation wizard will continue in %BOOT_MODE%.
pause
cls
goto :PARTCRT

:: Part 2 - Partitioning (Revamped)
:PARTCRT
echo.
echo ------------------- DISKPART DISK UTILITY -----------------------
:DPDSS
:: The DiskPart Option
echo list disk | diskpart
goto DISKAYS

:DISKAYS

set /p DISK="Target Disk Index (e.g., 0): "

if not defined DISK goto PARTCRT

for /f "tokens=2 delims==" %%A in ('wmic diskdrive where index^=%DISK% get model /value 2^>nul') do set "SELECTED_MODEL=%%A"

cls
echo.
echo !!!!!!!!!!!!!!!!!!!!!!!!!!! WARNING !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo.
echo YOU HAVE SELECTED: Disk %DISK% (%SELECTED_MODEL%)
echo ALL DATA ON THIS DISK WILL BE PERMANENTLY ERASED.
echo.
echo Type "FORMAT" to confirm and proceed.
set /p CONF1="Confirmation: "
if /i "%CONF1%" neq "FORMAT" (
    echo.
    echo [ABORT] User cancelled format. As installing without formatting is impossible, The program will exit.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] The user has cancelled: Formatting. User will be exiting...
    )
    timeout 3 >nul
    cls
    exit /b
)
cls
echo Partitioning drive... Please be patient, this will take a long time as formatting a drive takes a long amount of time.
pause

if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] The user has chosen to format, Formatting will begin shortly.
)

if "%BOOT_MODE%"=="UEFI" (

:: DISKPART (-- UEFI --)
    echo Step 2: 1/2 Generating .txt script file...
    cd %TEMPDIR%
    echo select disk %DISK% > %TEMPDIR%/WInstTEMP.txt
    echo clean >> %TEMPDIR%/WInstTEMP.txt
    echo convert gpt >> %TEMPDIR%/WInstTEMP.txt
    echo create partition primary size=450 >> %TEMPDIR%/WInstTEMP.txt
    echo format quick fs=ntfs label="Recovery" >> %TEMPDIR%/WInstTEMP.txt
    echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> %TEMPDIR%/WInstTEMP.txt
    echo gpt attributes=0x8000000000000001 >> %TEMPDIR%/WInstTEMP.txt
    echo create partition efi size=100 >> %TEMPDIR%/WInstTEMP.txt
    echo format quick fs=fat32 label="System" >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter="S" >> %TEMPDIR%/WInstTEMP.txt
    echo create partition msr size=16 >> %TEMPDIR%/WInstTEMP.txt
    echo create partition primary >> %TEMPDIR%/WInstTEMP.txt
    echo format quick fs=ntfs label="Windows" >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter="W" >> %TEMPDIR%/WInstTEMP.txt
    echo exit >> %TEMPDIR%/WInstTEMP.txt
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst has finished generating critical files for Step 3. Type: UEFI/GPT partition scheme. >> WInstLOGS.log
    )   
) else (

    :: DISKPART (-- LEGACY --)
    echo select disk %DISK% > %TEMPDIR%/WInstTEMP.txt
    echo clean >> %TEMPDIR%/WInstTEMP.txt
    echo convert mbr >> %TEMPDIR%/WInstTEMP.txt
    echo create partition primary size=100 >> %TEMPDIR%/WInstTEMP.txt
    echo format quick fs=ntfs label="System" >> %TEMPDIR%/WInstTEMP.txt
    echo active >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter="S" >> %TEMPDIR%/WInstTEMP.txt
    echo create partition primary >> %TEMPDIR%/WInstTEMP.txt
    echo format quick fs=ntfs label="Windows" >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter="W" >> %TEMPDIR%/WInstTEMP.txt
    echo exit >> %TEMPDIR%/WInstTEMP.txt
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst has finished generating critical files for Step 3. Type: Legacy BIOS/MBR partition scheme. >> WInstLOGS.log
    )   
)
:: DISKPART SCRIPT Launch
echo Step 2/2: Launching .bat script file... (MAY TAKE A LONG TIME)
diskpart /s %TEMPDIR%/WInstTEMP.txt
if %errorlevel% neq 0 (
    echo Disk is non-existent.
    echo Please reinput disk number again.
    echo Part 2 will restart.
    timeout 2 /NOBREAK <nul
    goto PARTCRT
)
cls
if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] WInst has finished partitioning the drive. >> WInstLOGS.log
)   

:: Part 3: Windows IMG Installation
:WIMAPPLY
echo Part 3: Windows IMG Installation
echo If you know the place where Windows (the .wim or .esd ones) You should put it here.
echo You NEED to put the install.esd in the end of the file. (Example: X:\Example\Example)
echo WInst will open another instance of cmd to find the .esd file. Navigate using cd and dir.
echo WInst will attempt to find a install.esd or .wim file in all drives. Please be patient..
if %WFOPT%=="1" (
    echo Verifying if the source exists...
    if exist %WIMPATH% (
        echo The wimfile that was specified in the arguments was found.
        echo Skipping wimpath finding step...
        goto INDEX
    ) else (
    echo %WIMPATH% wasn't found.
    echo Proceeding...
    goto WIMFIND
    )
)
:WIMFIND
SET WIMPATH=
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W Y Z) DO (
    IF EXIST "%%i:\sources\install.wim" (
        SET WIMPATH=%%i:\sources\install.wim
        GOTO :FOUND
    )
    IF EXIST "%%i:\sources\install.esd" (
        SET WIMPATH=%%i:\sources\install.esd
        GOTO :FOUND
    )
)

:NOTFOUND
echo [ERROR] WInst cannot find install.wim or install.esd on any drive.
pause
goto WIMFIND

:FOUND
echo [SUCCESS] Found image at: %WIMPATH%

echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.

:INDEX
dism /Get-ImageInfo /ImageFile:%WIMPATH%
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst didn't find the index file as "valid". >> WInstLOGS.log
    )    
    echo you will have to reinput the manual directory of the windows installation media file.
    timeout 2 /NOBREAK <nul
) else (
    echo Index found.
    echo Proceeding...
    goto DISMPROC
)
cls
:DISMPROC
echo Extracting contents
echo Part 3: 1/1: Using DISM to apply the files from the .esd file...

dism /Apply-Image /ImageFile:%WIMPATH% /Index:%INDEX% /ApplyDir:W:\

if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] WInst has extracted the contents. If dism returned a error, it couldn't find the file or it ran into a problem. >> WInstLOGS.log
)    
cls
:: Part 4: bcdboot EFI initalisation
:BCDBTINIT
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot W:\Windows /s S: /f ALL
cls
if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] WInst has initalised critical boot configuration files. >> WInstLOGS.log
)    

:: Part 5: Installation completion
:SUMMARY
echo Installation complete.
if /i "%CONFIRM%" equ "YES" ( 
   echo [%STAMP%] WInst completed installation successfully. >> WInstLOGS.log
)
echo Summary:

echo  --------------------- PARITIONING -----------------------
echo.
echo Bios type: %BOOT_MODE%
echo Initalised Partitions:
if "%BOOT_MODE%"=="UEFI" ( 
    echo EFI Partition, Size 100MB
    echo MSR Parition, Size 16MB
    echo Recovery Partition, Size 450MB
    echo Primary/Windows Partition, Size depends on your drive.
) else (
    echo Primary/EFI Partition, Size 100MB
    echo Primary/Windows Partition, Size depends on your drive.
)
echo ------------------------ Windows Image Information ----------------------------
echo.
echo Applied using DISM
echo Index: %INDEX%
echo ImageDir=%WIMPATH%
echo Applied Directory: Main Drive (PRIMARY)
echo ---------------------------- BCDBOOT ----------------------------
echo.
echo Applied bcdboot type: ALL (Including UEFI and Legacy BIOS)
echo Taken system files from: Primary Partition/Windows
echo To: SYSTEM/EFI Partition
echo -------------------------------------------------------------------------------------------------
echo.
echo Installation complete. The system will reboot in approximately 35 seconds.
timeout 32 /NOBREAK <nul
wpeutil reboot

:INSTALLACTION3

:: Action - 3
:: Step 1: UEFI/BIOS Confirmation
:BOOTMODEDECTA3
reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType | findstr /i "0x2" >nul
if %errorlevel% equ 0 (
    set BOOT_MODE=UEFI
) else (
    set BOOT_MODE=BIOS
)

echo The BIOS mode is %BOOT_MODE%.
echo The program is inserting the boot mode to its database...
if /i "%CONFIRM%" equ "YES" ( 
   echo [%STAMP%] WInst has detected the system firmware type as %BOOT_MODE%. >> WInstLOGS.log
)
timeout 3 /NOBREAK <nul
goto PARTCRT2

:: Step 2: Partitioning

:PARTCRT2
echo Step 2: Partitions
echo Making partitions are easy, if you know how. 
echo Please insert your disk here:
echo -------------------- DISKPART DISK UTILITY -----------------------
:: The DiskPart Option
echo list disk | diskpart
goto DISKAYS2

:DISKAYS2

set /p DISK="Target Disk Index (e.g., 0): "

if not defined DISK goto PARTCRT

for /f "tokens=2 delims==" %%A in ('wmic diskdrive where index^=%DISK% get model /value 2^>nul') do set "SELECTED_MODEL=%%A"

cls
echo Type "CONFIRM" to confirm and proceed.
set /p CONF1="Confirmation: "
if /i "%CONF1%" neq "CONFIRM" (
    echo.
    echo [ABORT] User cancelled format. As installing without formatting is impossible, The program will exit.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] The user has cancelled: EFI formatting.. User will be exiting...
    )
    timeout 3 >nul
    cls
    exit /b
)

if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] The user has chosen disk %SELECTED_MODEL%, Formatting will begin shortly.
)

:: DISKPART
if "%BOOT_MODE%"=="UEFI" (
    echo Select Partition:
    diskpart lis vol
    set /p VOLUME="Volume: "
    echo WInst will use the selected volume as a EFI partition.
    pause    
    echo Step 1/2: The program will wipe ONLY the EFI partitions. The other partitions will stay untouched until later.
    echo sel vol %VOLUME% > %TEMPDIR%/WInstTEMP.txt
    echo format fs=fat32 quick label="System" >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter S >> %TEMPDIR%/WInstTEMP.txt
    echo exit >> %TEMPDIR%/WInstTEMP.txt
) else (
   echo Select Volume:
    diskpart lis vol
    set /p VOLUME="Volume: "
    echo WInst will use the selected volume as a EFI partition.
    pause   
    echo Step 1/2: The program will wipe ONLY the EFI partitions. The other partitions will stay untouched until later.    
    echo sel vol %VOLUME% > %TEMPDIR%/WInstTEMP.txt
    echo format fs=ntfs quick label="System" >> %TEMPDIR%/WInstTEMP.txt
    echo assign letter S >> %TEMPDIR%/WInstTEMP.txt
    echo exit >> %TEMPDIR%/WInstTEMP.txt
)

if /i "%CONFIRM%" equ "YES" ( 
   echo [%STAMP%] WInst has finished partitioning the system boot drive. >> WInstLOGS.log
)
echo Step 2/2: Executing .bat file
diskpart /s %TEMPDIR%/WInstTEMP.txt

echo Operation complete.
pause
cls
goto WIMAPPLY2

:: Part 3: Windows Image Application
:WIMAPPLY2
if %WFOPT%=="1" (
    echo Verifying if the source exists...
    if exist %WIMPATH% (
        echo The wimfile that was specified in the arguments was found.
        echo Skipping wimpath finding step...
        goto INDEX2
    ) else (
    echo %WIMPATH% wasn't found.
    echo Proceeding...
    goto WIMFIND2
    )
)
echo Part 3: Windows IMG Installation
echo If you know the place where Windows (the .wim or .esd ones) You should put it here.
echo You NEED to put the install.esd in the end of the file. (Example: X:\Example\Example)
echo WInst will open another instance of cmd to find the .esd file. Navigate using cd and dir.
echo WInst will attempt to find a install.esd or .wim file in all drives. Please be patient..
:WIMFIND2
SET WIMPATH=
FOR %%i IN (C D E F G H I J K L M N O P Q R S T U V W Y Z) DO (
    IF EXIST "%%i:\sources\install.wim" (
        SET WIMPATH=%%i:\sources\install.wim
        GOTO :FOUND2
    )
    IF EXIST "%%i:\sources\install.esd" (
        SET WIMPATH=%%i:\sources\install.esd
        GOTO :FOUND2
    )
)

:NOTFOUND2
echo [ERROR] WInst cannot find install.wim or install.esd on any drive.
pause
exit

:FOUND2
echo [SUCCESS] Found image at: %WIMPATH%

echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.
  
:INDEX2
dism /Get-ImageInfo /ImageFile:%WIMPATH%
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    if /i "%CONFIRM%" equ "YES" ( 
        echo [%STAMP%] WInst didn't find the index file as "valid". >> WInstLOGS.log
    )    
    echo you will have to reinput the manual directory of the windows installation media file.
    timeout 2 /NOBREAK <nul
) else (
    echo Index found.
    echo Proceeding...
    timeout 2 /NOBREAK <nul
)

dism /Apply-Image /ImageFile:%WIMPATH% /Index:%INDEX% /ApplyDir:W:\
echo Operation complete.
pause
cls
:: Part 4: bcdboot EFI initalisation
:BCDBTINIT2
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot W:\Windows /s S: /f ALL
cls
if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] WInst has initalised critical boot configuration files. >> WInstLOGS.log
)    

:: Part 5: Installation completion
:SUMMARY2
echo Installation complete.
if /i "%CONFIRM%" equ "YES" ( 
    echo [%STAMP%] WInst has finished installation. >> WInstLOGS.log
)    
echo Summary:

echo  --------------------- PARITIONING -----------------------
echo.
echo Bios type: %BOOT_MODE%
echo Initialised Partitions:
if "%BOOT_MODE%"=="UEFI" (
    echo EFI Partition, Size 100MB                                        - Formatted
    echo MSR Parition, Size 16MB                                          - Unchanged
    echo Recovery Partition, Size 450MB
    echo Primary/Windows Partition, Size depends on your drive.
) else (
    echo Primary/EFI Partition, Size 100MB
    echo Primary/Windows Partition, Size depends on your drive.
)
echo ------------------------ Windows Image Information ----------------------------
echo.
echo Applied using DISM
echo Index: %INDEX%
echo ImageDir=%WIMPATH%
echo Applied Directory: Main Drive (PRIMARY)
echo ---------------------------- BCDBOOT ----------------------------
echo.
echo Applied bcdboot type: ALL (Including UEFI and Legacy BIOS)
echo Taken system files from: Primary Partition/Windows
echo To: SYSTEM/EFI Partition
echo -------------------------------------------------------------------------------------------------
echo.
echo Installation complete. The system will reboot in approximately 35 seconds.
timeout 36 /NOBREAK <nul
wpeutil reboot

:help_arg
echo ------------------- Windows Installation Script ---------------------
echo Help screen
echo ---------------------------------------------------------------------
echo [-h] [--help] [/h] - Displays the help screen
echo {[-wf] [--wimfile] [/wf]} [path-to-WimFile] - Sets the %WIMFILE% variable during main setup
echo.
echo Examples:
echo winst -h
echo winst -wf "D:/sources/install.wim"
exit /b

:VERSIONINFO
echo Windows Installation Executable version V0.6.2b (Unstable)
echo Windows Batch Script used to install Windows without the restrictions of Microsoft's own installer.
echo Copyright (c) NotToBT 2025, 2026.
echo.
echo "License GPL V2: GNU GPL Version 2 or later <https://gnu.org/licenses/gpl-2.0.en.html>""
echo This is free software; you are free to change and redistribute it.
echo There is NO WARRANTY, to the extent permitted by law.
