# QuickRGBDS
An RGBDS loader for Windows to compile your ACE payloads with a single drag n drop.


----


### How to use

Just drag and drop your .asm file on "Loader.bat". A ".hex" file will be generated, including your compiled HEX payload in text format.
For even easier use, you can create a shortcut of "Loader.bat" and drag your files on it.

### Warning
Never store your files into QuickRGBDS folder, since it always deletes both the .asm and .hex files after compilation. Make sure you load them from a different directory!

----

Refer to [this assembly script](https://github.com/M4n0zz/QuickRGBDS/blob/main/HowTo.asm) for a complete example.

----

If you need to transform a .map or a .sym file to an .inc one, you can give it a try with [this python script](https://github.com/M4n0zz/QuickRGBDS/blob/main/mapsymtoinc.py).

----

RGBDS binaries originally downloaded from [Official RGBDS](https://github.com/gbdev/rgbds) repo.
