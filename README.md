# QuickRGBDS
An RGBDS wrapper for Windows to compile your ACE payloads with a single drag n drop.


----

### Installation

Make sure you have the latest Microsoft Visual C++ Redistributable package installed.
Unzip all files and put them in the same folder.

----

### How to use

Simply drag and drop your .asm files onto Loader.bat. It will generate a .hex file containing the compiled HEX payload in text format.
For even easier access, you can create a shortcut of Loader.bat and drag files on this instead.


### Warning
Never store your files inside QuickRGBDS folder. It always deletes both the .asm and .hex files after compilation, so make sure you compile them from a different directory!

----

### New to RGBDS?

First of all you need a nice editor edit your payloads inside an .asm file. [Notepad++](https://notepad-plus-plus.org/downloads/) is recommended for this job, as well as a dark [theme](https://github.com/M4n0zz/QuickRGBDS/tree/main/npp%20themes) for Z80 Assembly (trust me your eyes will thank you later on). For a minimal example on how to create an ACE payload, see [HowTo.asm](https://github.com/M4n0zz/QuickRGBDS/blob/main/HowTo.asm)!

For more advanced scripts you can take a look at my collection of [Generation 1 Pokemon payloads](https://github.com/M4n0zz/Gen1PokeScripts).

----

If you need to convert a .map or .sym file into an .inc file, you can use [this python script](https://github.com/M4n0zz/QuickRGBDS/blob/main/mapsymtoinc.py).
Just place the .map or .sym file and the Python script in the same folder, then run the script to generate the .inc file.

----

RGBDS binaries originally downloaded from [Official RGBDS](https://github.com/gbdev/rgbds) repo.
