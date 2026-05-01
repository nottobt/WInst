
WInst is basically a program (Developed in Windows Batch) that is designed to install Windows without the limitations of Microsoft or specific system requirements that are just nonsense. It does so by
utilising embedded system programs (e,g Diskpart, dism, bcdboot, etc) in order to install the opreating system properly. 

Usage

WInst has two modes, install while overriding user files and install while presvering system files. It does so by ONLY wiping the specific partition used to make the system boot, and it also only overrides
broken/old system fiules without transferring them to a new folder, like on a hidden folder, also known as windows.old. 

Its usually used in the Windows PE mode, and it has a precauction when you mistakenly run it in full windows mode - it exits prematurely.

It has a feature that automatically guides you when installing the system.
WARNING: Please do so in a VM. This is the ubstable branch, and the creator is NOT repsponsible for the damages caused by reckless usage.
