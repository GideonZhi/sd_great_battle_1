del .\gb1e.smc
copy .\gb1j.smc .\gb1e.smc

if not exist ".\build-tmp" mkdir .\build-tmp

superfamiconv.exe tiles --in-image .\assets\gfx\gb1j_title_orig.png --out-data .\build-tmp\title_gfx_e.bin --no-discard --no-flip --no-remap --bpp 8 --verbose
superfamiconv.exe tiles --in-image .\assets\gfx\ending_1.png --out-data .\build-tmp\ending_gfx_e_1.bin --no-discard --no-flip --no-remap --bpp 8 --verbose
superfamiconv.exe tiles --in-image .\assets\gfx\ending_2.png --out-data .\build-tmp\ending_gfx_e_2.bin --no-discard --no-flip --no-remap --bpp 8 --verbose

xkas .\assets\code\main.asm .\gb1e.smc

atlas .\gb1e.smc .\assets\txt\in_dlog.txt > .\assets\txt\_dlog.log
