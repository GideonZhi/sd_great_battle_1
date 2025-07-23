# SD The Great Battle English Translation

## Requirements
* Note that the build script is a Windows `.bat` file, and the utilities needed to run the build are (generally) also Windows executables.
* Japanese copy of the ROM, file named `gb1j.smc` placed into the root of the project.
* `superfamiconv` utility. Get it here: https://github.com/Optiroc/SuperFamiconv
* Script insertion utility `Atlas`. Get it here: https://github.com/stevemonaco/Atlas
* `xkas v0.06` cross assembler. Get it here: https://romhack.ing/database/content/entry/etNw5JQBNs8FWu0CS5Cm/xkas
* Hex editor and/or tile editor and/or debugging emulator and/or text editor of your choice. I recommend:
  * 010 or Windhex for hex editors
  * yy-chr for tile editing
  * Mesen for your emulator
  * sublimetext or notepad++ for your text editor
Note that I keep copies of all my utilities for each project in that project's folder. If you have `xkas`, `superfamiconv`, and `atlas` placed somewhere globally-accessible and can run them from a commandline without having to input a path to them, the build script should work fine, but worst 

## Building
* run `build.bat`
* Check terminal output for errors/warnings/information.
* Check `assets\txt\_dlog.log` for Atlas errors.

## The actual build process
If you're curious, this is what happens:
* Existing copy of translated ROM is deleted and overwritten by a fresh, unmodified Japanese copy
* `build-tmp` directory is created if it doesn't exist
* `superfamiconv.exe` is called to transform `.\assets\gfx\*.png` into binary data in the build-tmp directory
* `xkas.exe` is called to assemble `.\assets\code\main.asm`, which has cascading `.inc` directives for the various source code, graphics, and binaries relevant to different parts of the translation
* `atlas.exe` is run to insert the game's script (`.\assets\txt\in_dlog.txt`) into the game.

## Editing files
The game's text is stored in `.\assets\txt\in_dlog.txt`. Edit then follow [Building](#Building)
* Graphics are stored in the various pngs and binaries in `.\assets\gfx\`. You'll need a tile editor for anything that isn't a png.
* Graphics layouts (tilemaps) are stored in the various `.bin` files in `.assets\bin\`.
* Assembly code is, predictably, stored in `.\assets\code\`. Edit with a text editor of your choice.
