# QuickRGBDS
An RGBDS wrapper for Windows to compile your ACE payloads with a single drag n drop.


----


### How to use

Simply drag and drop your .asm file (it should be located in a different folder) onto Loader.bat. This will generate a .hex file containing your compiled HEX payload in text format.
For even easier access, you can create a shortcut to Loader.bat and drag your .asm files onto the shortcut instead.


### Warning
Never store your files inside QuickRGBDS folder. It always deletes both the .asm and .hex files after compilation, so make sure you load them from a different directory!

----

### New to RGBDS?

See [HowTo.asm](https://github.com/M4n0zz/QuickRGBDS/blob/main/HowTo.asm) for a minimal example on how to create an ACE payload!

----

If you need to convert a .map or .sym file into an .inc file, you can use [this python script](https://github.com/M4n0zz/QuickRGBDS/blob/main/mapsymtoinc.py).
Just place the .map or .sym file and the Python script in the same folder, then run the script to generate the .inc file.

----

RGBDS binaries originally downloaded from [Official RGBDS](https://github.com/gbdev/rgbds) repo.
