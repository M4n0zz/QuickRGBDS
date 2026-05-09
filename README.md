# QuickRGBDS
An RGBDS wrapper for Windows and Linux to quickly compile GB Z80 ACE payloads to HEX.

----

## Windows
### Installation

Make sure you have the latest Microsoft Visual C++ Redistributable package installed.
Unzip all files and put them in the same folder.

### How to use

Simply drag and drop your .asm files onto Loader.bat. It will generate a .hex file containing the compiled HEX payload in text format.
For even easier access, you can create a shortcut of Loader.bat and drag files on this instead.

### Warning
In Windows version, never store your files inside QuickRGBDS folder. It always deletes both the .asm and .hex files after compilation, so make sure you compile them from a different directory!

----

## Linux
### Installation

Unzip all files and put them in the same folder. Make sure xxd, rgbasm and rgblink are executable with `chmod +x xxd rgbasm rgblink`.

### How to use

Use terminal to run: `compile.sh [-h] <payload.asm>` and get your payload compiled to .hex file. Using `h` prints Help.

### Warning
In Linux version, `payload.asm` must be in the same directory as `compile.sh`.



---

### New to RGBDS?

First, you need a nice editor to manage your payloads inside an .asm file.
- For Windows, [Notepad++](https://notepad-plus-plus.org/downloads/) is recommended, as well as a dark [theme](https://github.com/M4n0zz/QuickRGBDS/tree/main/npp%20themes) for Z80 Assembly (trust me your eyes will thank you later on).
- For Linux, [VSCodium](https://vscodium.com/) is recommended.

For a minimal example on how to create an ACE payload, see [HowTo.asm](https://github.com/M4n0zz/QuickRGBDS/blob/main/HowTo.asm)!

For more advanced scripts you can take a look at [Generation 1 Pokemon payload collection](https://github.com/M4n0zz/Gen1PokeScripts).

----

If you need to convert a .map or .sym file into an .inc file, you can use [this python script](https://github.com/M4n0zz/QuickRGBDS/blob/main/mapsymtoinc.py).
Just place the .map or .sym file and the Python script in the same folder, then run the script to generate the .inc file.

----

- RGBDS binaries originally downloaded from [Official RGBDS](https://github.com/gbdev/rgbds) repo.
- xxd binary originally downloaded from [Official xxd](https://github.com/ckormanyos/xxd) repo.
