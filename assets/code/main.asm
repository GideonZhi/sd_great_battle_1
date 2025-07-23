lorom

org $188000
;Expand ROM
  padbyte $FF : pad $208000

org $008C36
  incbin ./assets/bin/title_spritemap.bin

org $188000
  incbin ./assets/gfx/font.bin
  incbin ./assets/gfx/chapter_title_font.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin
  incbin ./assets/bin/blank_tmap.bin

org $198000
  incbin ./assets/gfx/title_gfx_j.bin
  incbin ./assets/bin/title_tmap_e.bin
org $198000
    incbin ./build-tmp/title_gfx_e.bin

org $1A8000
  incbin ./assets/gfx/ending_gfx_j.bin
org $1A8000
    incbin ./build-tmp/ending_gfx_e_1.bin
    incbin ./build-tmp/ending_gfx_e_2.bin
  
org $1C8000
  incbin ./assets/bin/ending_tmap.bin

  incsrc ./assets/code/intro.asm  
  incsrc ./assets/code/dma.asm
  incsrc ./assets/code/intro_expand.asm
  incsrc ./assets/code/dlog_text_expand.asm
  incsrc ./assets/code/text_speed.asm
