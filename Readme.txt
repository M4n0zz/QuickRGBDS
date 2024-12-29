
**Assemble the Code with RGBDS:**

Open your terminal or command prompt, navigate to the directory containing `os.asm`, and run the following commands:


# Step 1: Assemble the code into an object file (.o)
rgbasm -o o.o o.asm

# Step 2: Link the object file to create a Game Boy ROM (.gb)
rgblink -o o.gb o.o

# Step 3: Convert to Hex
xxd -p o.gb > o.hex

# Step 4: Split and remove unesseary zeros
splitter.bat o.hex
