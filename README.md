
WInst is basically a program (Developed in Windows Batch) that is designed to install Windows without the limitations of Microsoft or specific system requirements that are just nonsense. It does so by
utilising embedded system programs (e,g Diskpart, dism, bcdboot, etc) in order to install the opreating system properly. 

Usage

WInst has two modes, install while overriding user files and install while presvering system files. It does so by ONLY wiping the specific partition used to make the system boot, and it also only overrides
broken/old system fiules without transferring them to a new folder, like on a hidden folder, also known as windows.old. 

Its usually used in the Windows PE mode, and it has a precauction when you mistakenly run it in full windows mode - it exits prematurely.
Disk management section is being added in the ":DISKMGMT" header, which guides you to manage your disks, partition and more. this is upcoming, so DO NOT USE IT.
It has a feature that automatically guides you when installing the system.
WARNING: Please do so in a VM. This is the unstable branch, and the creator is NOT responsible for the damages caused by reckless usage.
The creator, NotToBT, is hereby NOT responsible by the damages caused by using it. Under the GPL, Version 2 or later's sections 11 and 12. The user is assumed as "compliant to the risks of the project." Unless the damages are agreed or required by law, the creator is not liable for the data loss or any damages. To see the full information, see the license text (GPL) provided in the main branch. <LICENSE>
