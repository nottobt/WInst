@echo off
:: Windows Installation Executable
:: Beta Release 0.5.1b
:: By NotToBT - The single developer
:: Source code released at https://github.com/nottobt/WInst
:: Licensed under GPL v2.0

:: NOTE TO DEVELOPER: Finish ASCII improvements.
set TEMPDIR="X:\Windows\Temp"
set ACTION=0
set BOOT_MODE=0
set DISK=0
set CONF1=0
set IMGDIR=0
set INDEX=0
set MANINPUT=0

:: Pre-initalisation

set YYYY=%DATE:~10,4%
set MM=%DATE:~4,2%
set DD=%DATE:~7,2%
set HH=%TIME:~0,2%
set Min=%TIME:~3,2%
set Sec=%TIME:~6,2%

set Stamp="%YYYY%/%MM%/%DD%_%HH%%Min%%Sec%"
echo Timestamp: %Stamp%
cls

title WInst - V0.4.1b

:: Configure Logging
echo [%Stamp%] Logging System: Logging has started. > %TEMPDIR%\WinstLOGS.log
echo No logging? (YES/NO)   
set /p CONFIRM="Confirmation: "
if /i "%CONFIRM%" neq "YES" (
    echo Logging will be disabled.
    timeout 2 /NOBREAK <nul
    goto TANDC
)
echo Logging will be enabled.
timeout 2 /NOBREAK <nul
goto TANDC

:: WInst - Windows Installation Executable
:: Copyleft 2026 NotToBT
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

:: Find if user is in WinPE or normal Windows
for /f "tokens=3" %%i in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control" /v SystemStartOptions 2^>nul') do set "bootOpts=%%i"
echo %bootOpts% | find /i "MININT" >nul 2>&1
if %errorlevel% equ 0 (
    echo WInst has detected that the user is currently operating this program in Windows PE.
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] WInst has detected that the user is currently operating this program in Windows PE. >> WInstLOGS.log
    )
    echo The program will contiue shortly...
    timeout 2 /NOBREAK <nul
    cls
    goto TANDC
) else (
    echo WInst has detected that the user is currently operating this program in the full version of Windows.
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] WInst has detected that the user is currently operating this program in the full version of Windows. >> WInstLOGS.log
    )
    echo The program will exit in a few moments, as WInst is only intended for use in the Windows PE Environment.
    timeout 6 /NOBREAK <nul
    exit /b
)

cls
:TANDC
echo Read the terms, conditions and changelogs before running the program.
echo.
echo Welcome to Windows Installation Executable
echo Beta Release 0.4.1b
echo. 
echo ------------------------------------- TERMS AND CONDITIONS ------------------------------------
echo This command prompt SHOULD only be used in a place where the Windows Installation Image (install.esd or install.wim) is reachable.
echo WARNING: Do not use this program for destructive purposes. This is only for installing purposes. the creator, by which is not responsible for any damages caused by the reckless endangerment of such people.
echo 1. The steps will reinstall your system. By reading this, you should know that using this program without proper knowledge may destroy your system if used incorrectly.
echo 2. During step 2, the user shall not terminate the system until the process is finished. If so, the system may be inopreateable and may be destroyed.
echo.
echo ----------------------------------------------------------------------------------------------
echo Finished reading?
pause
cls
echo ------------------------------------- CHANGELOGS ----------------------------------------
echo Feb 2026 UPDATES
echo 0.1 - BETA version released
echo 0.4 - Major updates released
echo     - Step 3
echo            - Step 3 installs the system without overwriting user data.
echo            - Bug fixes
echo 0.4.1 - Major bug fixes
echo 0.5 - Logging
echo     - Minor bug fixes -
echo                       - Syntax errors in :OPTION
echo                       - Logging
echo                                - Fixed file extension (.txt > .log)
echo.
echo ---------------------------------------- IN DEVELOPMENT -------------------------------------------------
echo.
echo Major improvements -
echo                    - Major UI Improvements 
echo.
echo Step 4
echo ---------------------------------------------------------------------------------------------------------
echo MINOR UPDATES
echo 0.2 - Added file finders in Step 3
echo Bug Fixes
echo 0.3 - Added Terms and Conditions and changelogs
echo Bug fixes
echo 0.3.2 - Fixed a bug in the "FORMAT" confirmation that proceeded even if the user typed something else rather than FORMAT.
echo       - Improvements - Improved GUI a bit
echo 0.5.1 - Added a precaution before the terms and conditions that prevents the user from running the program in Full Windows.
echo       - Major bug fixes
echo 0.5.2 - Minor syntax errors fixed
echo Press any key to continue.
if /i "%CONFIRM%" neq "YES" (
    pause <nul
) else (
    echo [%STAMP%] The user has accepted the terms and conditions. >> WInstLOGS.log
)
pause <nul
cls

:OPTION
echo Options:
echo ----------------------------------------------------------------------------------------------------
echo.
echo Windows Installation WIzard (WInst) Version 0.5
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
    if /i "%CONFIRM%" neq "YES" (
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
    if /i "%CONFIRM%" neq "YES" (
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
    if /i "%CONFIRM%" neq "YES" (
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
reg query HKLM\System\CurrentControlSet\Control /v PEFirmwareType | findstr /i "0x2" >nul
if %errorlevel% equ 0 (
    set BOOT_MODE=UEFI
) else (
    set BOOT_MODE=BIOS
)

if /i "%CONFIRM%" neq "YES" (
    pause <nul
) else (
    echo [%STAMP%] The user has chosen option 3 >> WInstLOGS.log
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
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] The user had chosen to not format, thus marking the operation unfinished. WInst will exit. >> WInstLOGS.log
    )
    goto OPTION1
)    
cls
echo Partitioning drive... Please be patient, this will take a long time as formatting a drive takes a long amount of time.
pause

if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] The user has chosen to format, Formatting will begin shortly.
)

if "%BOOT_MODE%"=="UEFI" (

:: DISKPART (-- UEFI --)
    echo Step 2: 1/2 Generating .bat script file...
    cd %TEMPDIR%
    echo select disk %DISK% > WInstTEMP.txt
    echo clean >> WInstTEMP.txt
    echo convert gpt >> WInstTEMP.txt
    echo create partition primary size=450 >> WInstTEMP.txt
    echo format quick fs=ntfs label="Recovery" >> WInstTEMP.txt
    echo set id="de94bba4-06d1-4d40-a16a-bfd50179d6ac" >> WInstTEMP.txt
    echo gpt attributes=0x8000000000000001 >> WInstTEMP.txt
    echo create partition efi size=100 >> WInstTEMP.txt
    echo format quick fs=fat32 label="System" >> WInstTEMP.txt
    echo assign letter="S" >> WInstTEMP.txt
    echo create partition msr size=16 >> WInstTEMP.txt
    echo create partition primary >> WInstTEMP.txt
    echo format quick fs=ntfs label="Windows" >> WInstTEMP.txt
    echo assign letter="W" >> WInstTEMP.txt
    echo exit >> WInstTEMP.txt
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] WInst has finished generating critical files for Step 3. Type: UEFI/GPT partition scheme. >> WInstLOGS.log
    )   
) else (

    :: DISKPART (-- LEGACY --)
    echo select disk %DISK% > WInstTEMP.txt
    echo clean >> WInstTEMP.txt
    echo convert mbr >> WInstTEMP.txt
    echo create partition primary size=100 >> WInstTEMP.txt
    echo format quick fs=ntfs label="System" >> WInstTEMP.txt
    echo active >> WInstTEMP.txt
    echo assign letter="S" >> WInstTEMP.txt
    echo create partition primary >> WInstTEMP.txt
    echo format quick fs=ntfs label="Windows" >> WInstTEMP.txt
    echo assign letter="W" >> WInstTEMP.txt
    echo exit >> WInstTEMP.txt
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] WInst has finished generating critical files for Step 3. Type: Legacy BIOS/MBR partition scheme. >> WInstLOGS.log
    )   
)
:: DISKPART SCRIPT Launch
echo Step 2/2: Launching .bat script file... (MAY TAKE A LONG TIME)
diskpart /s X:\Windows\Temp\WInstTEMP.txt
if %errorlevel% neq 0 (
    echo Disk is non-existent.
    echo Please reinput disk bumbers again. 
    echo Part 2 will restart.
    timeout 2 /NOBREAK <nul
    goto PARTCRT
)
cls
if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] WInst has finished partitioning the drive. >> WInstLOGS.log
)   

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
        if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] .wim or .esd files not found. The user will have to input files manually. >> WInstLOGS.log
    )   
    :maninput
    echo AS the file wasn't found. you will have ot input the install.esd or .wim file manually.
    set /p maninput="File Directory: "
    goto INDEXINPUT
) else (
    echo Installation file found.
    echo Going to next step...
    timeout 2 /NOBREAK
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] Installation file found. >> WInstLOGS.log
    )   
    goto INDEXINPUT
)

:INDEXINPUT
if defined %maninput% (
    echo Already manually inputted. Moving to next step...
    timeout 2 /NOBREAK <nul
)
set /p IMGDIR="Image File: "
cls
echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.
if errorlevel neq 0 (
    echo File not found. Please input again.
    goto :maninput
) else (
    echo File found. Proceeding...
)    
dism /Get-ImageInfo /ImageFile:%IMGDIR%
:INDEX
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    if /i "%CONFIRM%" neq "YES" (
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

dism /Apply-Image /ImageFile:%IMGDIR% /Index:%INDEX% /ApplyDir:W:\

if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] WInst has extracted the contents. If dism returned a error, it couldn't find the file or it ran into a problem. >> WInstLOGS.log
)    
cls
:: Part 4: bcdboot EFI initalisation
:BCDBTINIT
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot W:\Windows /s S: /f ALL
cls
if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] WInst has initalised critical boot configuration files. >> WInstLOGS.log
)    

:: Part 5: Installation completion
:SUMMARY
echo Installation complete.
if /i "%CONFIRM%" neq "YES" (
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
if /i "%CONFIRM%" neq "YES" (
   echo [%STAMP%] WInst has detected the syetem firmware type as %BOOT_MODE%. >> WInstLOGS.log
)
timeout 3 /NOBREAK <nul
goto PARTCRTACTION3

:: Step 2: Partitioning

:PARTCRTACTION3
echo Step 2: Partitions
echo Making partitions are easy, if you know how. 
echo Please insert your disk here:
diskpart list disk
set /p DISK="Disk: "
if /i "%CONFIRM%" neq "YES" (
   echo [%STAMP%] The user has selected Disk %DISK%. >> WInstLOGS.log
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
    echo sel vol %VOLUME% > WInstTEMP.txt
    echo format fs=fat32 quick label="System" >> WInstTEMP.txt
    echo assign letter S >> WInstTEMP.txt
    echo exit >> WInstTEMP.txt
) else (
   echo Select Volume:
    diskpart list Volume
    set /p VOLUME="Volume: "
    echo WInst will use the selected volume as a EFI partition.
    pause   
    echo Step 1/2: The program will wipe ONLY the EFI partitions. The other partitions will stay untouched until later.    
    echo sel vol %VOLUME% > WInstTEMP.txt
    echo format fs=ntfs quick label="System" >> WInstTEMP.txt
    echo assign letter S >> WInstTEMP.txt
    echo exit >> WInstTEMP.txt
)

if /i "%CONFIRM%" neq "YES" (
   echo [%STAMP%] WInst has finished partitioning the system boot drive. >> WInstLOGS.log
)
echo Step 2/2: Executing .bat file
diskpart /s X:\Windows\Temp\WInstTEMP.txt

echo Operation complete.
pause
cls
goto WIMAPPLY2

:: Part 3: Windows Image Application
:WIMAPPLY2
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
        if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] .wim or .esd files not found. The user will have to input files manually. >> WInstLOGS.log
    )   
    :maninput
    echo AS the file wasn't found. you will have ot input the install.esd or .wim file manually.
    set /p maninput="File Directory: "
    goto INDEXINPUT
) else (
    echo Installation file found.
    echo Going to next step...
    timeout 2 /NOBREAK
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] Installation file found. >> WInstLOGS.log
    )   
    goto INDEXINPUT
)

:INDEXINPUT
if defined maninput (
    echo Already manually inputted. Moving to next step...
    timeout 2 /NOBREAK <nul
)
set /p IMGDIR="Image File: "
cls
echo If it is a valid .esd or .wim file, DISM will identify all the versions. WInst will allow you to choose between multiple versions of Windows.
if errorlevel neq 0 (
    echo File not found. Please input again.
    goto :maninput
) else (
    echo File found. Proceeding...
)    
dism /Get-ImageInfo /ImageFile:%IMGDIR%
:INDEX
set /p INDEX="Index: "
if %errorlevel% neq 0 (
    echo Index not found.
    echo Try again.
    if /i "%CONFIRM%" neq "YES" (
        echo [%STAMP%] WInst didn't find the index file as "valid". >> WInstLOGS.log
    )    
    echo you will have to reinput the manual directory of the windows installation media file.
    timeout 2 /NOBREAK <nul
) else (
    echo Index found.
    echo Proceeding...
    timeout 2 /NOBREAK <nul
)

dism /Apply-Image /ImageFile:%IMGDIR% /Index:%INDEX% /ApplyDir:W:\
echo Operation complete.
pause
cls

:: Part 4: bcdboot EFI initalisation
:BCDBTINIT
echo This part will initalise the EFI partition. This will take a short amount of time.
pause
bcdboot W:\Windows /s S: /f ALL
cls
if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] WInst has initalised critical boot configuration files. >> WInstLOGS.log
)    

:: Part 5: Installation completion
:SUMMARY
echo Installation complete.
if /i "%CONFIRM%" neq "YES" (
    echo [%STAMP%] WInst has finished installation. >> WInstLOGS.log
)    
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
