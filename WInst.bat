@echo off
:: Windows Installation Executable
:: Beta Release 0.4.1b
:: By NotToBT - The single developer

:: NOTE TO DEVELOPER: Logging is unfinished. Finish the ASCII improvements (e.g ---------) and than proceed to logging.
set TEMPDIR="X:\Windows\Temp"
set ACTION=0
set BOOT_MODE=0
set DISK=0
set CONF1=0
set IMGDIR=0
set INDEX=0

:: Pre-initalisation

set YYYY=%DATE:~10,4%
set MM=%DATE:~4,2%
set DD=%DATE:~7,2%
set HH=%TIME:~0,2%
set Min=%TIME:~3,2%
set Sec=%TIME:~6,2%

set Stamp=%YYYY%-%MM%-%DD%_%HH%%Min%%Sec%
echo Timestamp: %Stamp%

title WInst - V0.4.1b

:: Configure Logging
//
echo [%Stamp%] Logging System: Logging has started. > %TEMPDIR%\WinstLOGS.log
echo No logging? (YES/NO)
set /p CONFIRM="Confirmation: "
if /i "%CONFIRM%"=="YES" (
    echo The program will only log errors.
    pause
    goto INTRO
) else (
    echo OK, Everything will be logged.
    pause
    goto INTRO
)
//
:: ------------------------------------------------------------------ UNFINISHED --------------------------------------------------------------------------------------- (Marked with //)

@echo off
:: WInst - Windows Installation Executable
:: Copyright (C) 2026 NotToBT
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

cls
echo Read the terms, conditions and changelogs before running the program.
echo.
echo Welcome to Windows Installation Executable
echo Beta Release 0.4.1b
echo. 
echo ------------------------------------- TERMS AND CONDITIONS ------------------------------------
echo DISCLAIMER: You should NOT use this unless you're a pre-tester or developer.
echo DO NOT USE this unless you're on a virtual machine. As it is in a Beta phase, this program will be restricted to developers who understand Windows PE logic only.
echo This command prompt SHOULD only be used in a place where the Windows Installation Image (install.esd or install.wim) is reachable.
echo WARNING: Do not use this program for destructive purposes. This is only for installing purposes. the creator, by which is not responsible for any damages caused by the reckless endangerment of such people.
echo 1. The steps will reinstall your system. By reading this, you should know that using this program without proper knowledge may destroy your system if used incorrectly.
echo 2. During step 2, the user shall not terminate the system until the process is finished. If so, the system may be inopreateable and may be destroyed.
echo.
echo ------------------------------------- CHANGELOGS ----------------------------------------
echo Feb 2026 UPDATES
echo 0.1 - BETA version released
echo 0.4 - Major updates released
echo     - Step 3
echo            - Step 3 installs the system without overwriting user data.
echo            - Bug fixes
echo 0.4.1 - Major bug fixes
echo ---------------------------------------- IN DEVELOPMENT -------------------------------------------------
echo 0.5 - Logging
echo     - Minor bug fixes -
echo                       - Syntax errors in :OPTION
echo Major improvements -
echo                    - Major UI Improvements 
echo ---------------------------------------------------------------------------------------------------------
echo MINOR UPDATES
echo 0.2 - Added file finders in Step 3
echo Bug Fixes
echo 0.3 - Added Terms and Conditions and changelogs
echo Bug fixes
echo 0.3.2 - Fixed a bug in the "FORMAT" confirmation that proceeded even if the user typed something else rather than FORMAT.
echo       - Improvements - Improved GUI a bit
echo Press any key to continue.
if /i "%CONFIRM%"=="YES" (
    pause <nul
) else (
    echo [%STAMP%] The user has accepted the terms and conditions. >> WInstLOGS.log
)
pause <nul
cls

:OPTION
echo Options:
echo ----------------------------------------------------------------------------------------------------
echo 1. Install Windows
echo.
echo 2. Exit
echo.
echo 3. Install Windows without deleting system files
echo.
echo 4. In development
echo ----------------------------------------------------------------------------------------------------
echo.
set /p ACTION="What action would you choose? "
if "%ACTION%"=="1" (
    echo Installation process will start in a few seconds. Please stay put.
    if /i "%CONFIRM%"=="YES" (
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
    if /i "%CONFIRM%"=="YES" (
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
    if /i "%CONFIRM%"=="YES" (
       timeout 3 /NOBREAK <nul
       cls 
       goto INSTALLACTION3
    ) else (
    echo [%STAMP%] The user has chosen option 3.>> WInstLOGS.log
    timeout 3 /NOBREAK <nul
    cls
    goto INSTALLACTION3
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
reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType | findstr /i "0x2" >nul
if %errorlevel% equ 0 (
    set BOOT_MODE=UEFI
) else (
    set BOOT_MODE=BIOS
)

if /i "%CONFIRM%"=="YES" (
    pause <nul
) else (
    echo [%STAMP%] The user has chosen option 3.>> WInstLOGS.log
    timeout 3 /NOBREAK <nul
    cls
    goto INSTALLACTION3
)    

echo Detected Boot Mode: %BOOT_MODE%
echo The installation wizard will continue in %BOOT_MODE%.
pause
cls
goto :PARTCRT

:: Part 2 - Partitioning
:PARTCRT
echo Step 2: Partitions
echo Making partitions are easy, if you know how. 
echo Please insert your disk here:
diskpart list disk
set /p DISK="Disk: "
echo ALL DATA WILL BE DELETED WHEN PARTITIONING. Are you sure?
echo Type "FORMAT" to partition the drive.
set /p CONF1="Confirmation: "
if "%CONF1%" neq "FORMAT" (
    echo If you don't format, The program will exit profusely.
    pause
    cls
    echo The user exited before executing the step: Step 1.
    echo The program will exit.
    pause
    goto OPTION1
)
cls
echo Partitioning drive... Please be patient, this will take a long time as formatting a drive takes a long amount of time.
pause

if "%BOOT_MODE%"=="UEFI" (

:: DISKPART (-- UEFI --)
    echo Step 2: 1/2 Generating .bat script file...
    cd %TEMPDIR%
    echo select disk %DISK% > WInstTEMP.bat
    echo clean >> WInstTEMP.bat
    echo convert gpt >> WInstTEMP.bat
    echo create partition primary size=450 >> WInstTEMP.bat
    echo format quick fs=ntfs label="Recovery" >> WInstTEMP.bat
    echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> WInstTEMP.bat
    echo gpt attributes=0x8000000000000001 >> WInstTEMP.bat
    echo create partition efi size=100 >> WInstTEMP.bat
    echo format quick fs=fat32 label="System" >> WInstTEMP.bat
    echo assign letter="S" >> WInstTEMP.bat
    echo create partition msr size=16 >> WInstTEMP.bat
    echo create partition primary >> WInstTEMP.bat
    echo format quick fs=ntfs label="Windows" >> WInstTEMP.bat
    echo assign letter="W" >> WInstTEMP.bat
    echo exit >> WInstTEMP.bat

) else (

    :: DISKPART (-- LEGACY --)
    echo select disk %DISK% > WInstTEMP.bat
    echo clean >> WInstTEMP.bat
    echo convert mbr >> WInstTEMP.bat
    echo create partition primary size=100 >> WInstTEMP.bat
    echo format quick fs=ntfs label="System" >> WInstTEMP.bat
    echo active >> WInstTEMP.bat
    echo assign letter="S" >> WInstTEMP.bat
    echo create partition primary >> WInstTEMP.bat
    echo format quick fs=ntfs label="Windows" >> WInstTEMP.bat
    echo assign letter="W" >> WInstTEMP.bat
    echo exit >> WInstTEMP.bat

)
:: DISKPART SCRIPT Launch
echo Step 2/2: Launching .bat script file... (MAY TAKE A LONG TIME)
diskpart /s X:\Windows\Temp\WInstTEMP.bat
cls

:: Part 3: Windows IMG Installation
:WIMAPPLY
echo Part 3: Windows IMG Installation
echo If you know the place where Windows (the .wim or .esd ones) You should put it here.
echo You NEED to put the install.esd in the end of the file. (Example: X:\Example\Example)
echo WInst will open another instance of cmd to find the .esd file. Navigate using cd and dir.
echo WInst will attempt to find a install.esd or .wim file in all drives. Please be patient..
where /r D:\ "install.esd"
where /r X:\ "install.esd"
where /r D:\ "install.wim"
where /r X:\ "install.wim"
if errorlevel neq 0 (
    echo File not found. You'll have to put the file's directory and name manually.
    goto MANINPUT 
) else (
    echo Installation file found.
    echo Going to next step...
    timeout 2 /NOBREAK
    goto INDEXINPUT
)
:INDEXINPUT
set /p IMGDIR="Image File: "
cls
echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.
dism /Get-ImageInfo /ImageFile:%IMGDIR%
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    goto INDEXINPUT
) else (
    echo Index found.
    echo Proceeding...
    goto DISMPROC
)
cls
:DISMPROC
echo Extracting contents
echo Part 3: 1/1: Using DISM to apply the files from the .esd file...

dism /Apply-Image /ImageFile:%IMGDIR% /Index:%INDEX% /ApplyDir:W:\
cls
:: Part 4: bcdboot EFI initalisation
:BCDBTINIT
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot W:\Windows /s S: /f ALL
cls

:: Part 5: Installation completion
:SUMMARY
echo Installation complete.

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
echo ImageDir=%IMGDIR%
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
timeout 3 /NOBREAK <nul
goto PARTCRTACTION3

:: Step 2: Partitioning

:PARTCRTACTION3
echo Step 2: Partitions
echo Making partitions are easy, if you know how. 
echo Please insert your disk here:
diskpart list disk
set /p DISK="Disk: "
echo ALL DATA WILL BE DELETED WHEN PARTITIONING. Are you sure?
echo Type "FORMAT" to partition the drive.
set /p CONF1="Confirmation: "
if /i "%CONF1%" neq "FORMAT" (
    echo If you don't format, The program will exit profusely.
    pause
    cls
    echo The user exited before executing the step: Step 1.
    echo The program will exit.
    pause
    goto OPTION1
)

echo The device will continue partitioning.
pause
cls
:: DISKPART
if (%BOOT_MODE%)=="UEFI" (
    echo Select Volume:
    diskpart list Volume
    set /p VOLUME="Volume: "
    echo WInst will use the selected volume as a EFI partition.
    pause    
    echo Step 1/2: The program will wipe ONLY the EFI partitions. The other partitions will stay untouched until later.
    echo sel vol %VOLUME% > WInstTEMP.bat
    echo format fs=fat32 quick label="System" >> WInstTEMP.bat
    echo assign letter S >> WInstTEMP.bat
    echo exit >> WInstTEMP.bat
) else (
   echo Select Volume:
    diskpart list Volume
    set /p VOLUME="Volume: "
    echo WInst will use the selected volume as a EFI partition.
    pause   
    echo Step 1/2: The program will wipe ONLY the EFI partitions. The other partitions will stay untouched until later.    
    echo sel vol %VOLUME% > WInstTEMP.bat
    echo format fs=ntfs quick label="System" >> WInstTEMP.bat
    echo assign letter S >> WInstTEMP.bat
    echo exit >> WInstTEMP.bat
)
echo Step 2/2: Executing .bat file
diskpart /s X:\Windows\Temp\WInstTEMP.bat

echo Operation complete.
pause
cls
goto IMGAPPLY

:: Part 3: Windows Image Application
:IMGAPPLY
echo Part 3: Windows IMG Installation
echo If you know the place where Windows (the .wim or .esd ones) You should put it here.
echo You NEED to put the install.esd in the end of the file. (Example: X:\Example\Example)
echo WInst will open another instance of cmd to find the .esd file. Navigate using cd and dir.
echo WInst will attempt to find a install.esd or .wim file in all drives. Please be patient..
where /r D:\ "install.esd"
where /r X:\ "install.esd"
where /r D:\ "install.wim"
where /r X:\ "install.wim"
if errorlevel neq 0 (
    echo File not found. You'll have to put the file's directory and name manually.
    goto MANINPUT 
) else (
    echo Installation file found.
    echo Going to next step...
    timeout 2 /NOBREAK
    goto INDEXINPUT
)
:MANINPUT
set /p IMGDIR="Image File: "
if exist %IMGDIR% (
    echo Image found.
    echo WInst will continue.
    pause
    cls
) else (
    echo Image not found.
    echo Try again.
    pause
    cls
    goto MANINPUT
)
cls

:INDEXINPUT
echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.
dism /Get-ImageInfo /ImageFile:%IMGDIR%
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    goto INDEXINPUT
) else (
    echo Index found.
    echo Proceeding...
    goto DISMPROC
)
cls
:DISMPROC
echo You will have to input the Primary Partition (The partition where Windows files reside)
echo Put the volume as ONE LETTER ONLY. (e.g C)
set /p MANPART="Partition: "
echo WInst will now use DISM to apply the install.wim or .esd image. DO not terminate the program during this Operation as it could corrupt your system.
pause
cls

dism /Apply-Image /ImageFile:%IMGDIR% /Index:%INDEX% /ApplyDir:%MANPART%:\
echo Operation complete.
pause
cls

:: Part 4: bcdboot EFI initalisation
:BCDBTINIT
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot %MANPART%:\Windows /s S: /f ALL
cls

:: Part 5: Installation completion
:SUMMARY
echo Installation complete.

echo Summary:

echo  --------------------- PARITIONING -----------------------
echo.
echo Bios type: %BOOT_MODE%
echo Initalised Partitions:
if "%BOOT_MODE%"=="UEFI" ( 
    echo EFI Partition, Size 100MB                                        - Unchanged
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
echo ImageDir=%IMGDIR%
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