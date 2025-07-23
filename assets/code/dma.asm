lorom

; This is a comment. Whee!
; Note that -ALL- of the addresses here are LoROM!
; NONE of them are absolute!

;$00/8994 A9 31       LDA #$31                A:0001 X:0000 Y:0005 D:0000 DB:00 S:03FD P:envMxdiZcHC:0398 VC:215 00 FL:65534
;$00/8996 20 75 98    JSR $9875  [$00:9875]   A:0031 X:0000 Y:0005 D:0000 DB:00 S:03FD P:envMxdizcHC:0414 VC:215 00 FL:65534

org $008994
  JSL MainFont
  NOP

;$00/91EB: A9 31        LDA #$31                  A:0001 X:0000 Y:0005 D:0000 DB:00 S:03FB P:envMxdiZc HC:100 VC:118
;$00/91ED: 20 75 98     JSR $9875 [$00:9875]      A:0031 X:0000 Y:0005 D:0000 DB:00 S:03FB P:envMxdizc HC:156 VC:118

org $0091EB
  JSL MainFont
  NOP


;$00/FA63: A9 0B        LDA #$0B                  A:0001 X:0000 Y:0005 D:0000 DB:00 S:03F9 P:envMxdiZc HC:1062 VC:009
;$00/FA65: 20 75 98     JSR $9875 [$00:9875]      A:000B X:0000 Y:0005 D:0000 DB:00 S:03F9 P:envMxdizc HC:1118 VC:009
org $FA63
  JSL MainFont2
  NOP

;$00/8FA6: A9 68        LDA #$68                  A:0080 X:1900 Y:0000 D:0000 DB:00 S:03FD P:eNvMxdizC HC:566 VC:231
;$00/8FA8: 20 75 98     JSR $9875 [$00:9875]      A:0068 X:1900 Y:0000 D:0000 DB:00 S:03FD P:envMxdizC HC:622 VC:231
org $8FA6
  JSL ChapterTitleFont
  NOP


org $8FAE
;$00/8FAE: 69 69        ADC #$69                  A:0000 X:0010 Y:0EF3 D:0000 DB:00 S:03FD P:envMxdiZc HC:604 VC:089
;$00/8FB0: 20 75 98     JSR $9875 [$00:9875]      A:0069 X:0010 Y:0EF3 D:0000 DB:00 S:03FD P:envMxdizc HC:660 VC:089
  JSL ChapterTitleTmaps
  NOP

;$00/8980: A9 8A        LDA #$8A                  A:0000 X:4000 Y:0000 D:0000 DB:00 S:03FD P:envMxdiZc HC:302 VC:038
;$00/8982: 20 75 98     JSR $9875 [$00:9875]      A:008A X:4000 Y:0000 D:0000 DB:00 S:03FD P:eNvMxdizc HC:358 VC:038
org $008980
  JSL TitleScreenGfx
  NOP

;$00/8985: A9 8B        LDA #$8B                  A:0001 X:0000 Y:1C15 D:0000 DB:00 S:03FD P:envMxdiZc HC:360 VC:104
;$00/8987: 20 75 98     JSR $9875 [$00:9875]      A:008B X:0000 Y:1C15 D:0000 DB:00 S:03FD P:eNvMxdizc HC:416 VC:104
org $008985
  JSL TitleScreenTmap
  NOP

;$00/90DA: A9 86        LDA #$86                  A:0080 X:1900 Y:0000 D:0000 DB:00 S:03FF P:eNvMxdizC HC:390 VC:231
;$00/90DC: 20 75 98     JSR $9875 [$00:9875]      A:0086 X:1900 Y:0000 D:0000 DB:00 S:03FF P:eNvMxdizC HC:446 VC:231
org $90DA
  JSL EndingGfx
  NOP


;$00/90DF: A9 87        LDA #$87                  A:0001 X:0000 Y:23EA D:0000 DB:00 S:03FF P:envMxdiZc HC:072 VC:168
;$00/90E1: 20 75 98     JSR $9875 [$00:9875]      A:0087 X:0000 Y:23EA D:0000 DB:00 S:03FF P:eNvMxdizc HC:128 VC:168
org $0090DF
  JSL EndingTmap
  NOP

org $1FF000
MainFont:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$70
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$80    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$18    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$10    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


MainFont2:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$60
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$80    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$18    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$10    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


ChapterTitleFont:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$70
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$90    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$18    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$20    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


ChapterTitleTmaps:
  PHA
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$68
  STA $2117
  
  PLA

  REP #$20
  AND #$00FF
  
  ASL A       ; 2
  ASL A       ; 4
  ASL A       ; 8
  XBA
  CLC
  ADC #$B000
  STA $4312
  
  
  SEP #$20

  ;LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  ;STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  ;LDA #$90    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
 ; STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$18    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$08    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


TitleScreenGfx:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$20
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$80    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$19    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$40    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


TitleScreenTmap:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$60
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$C0    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$19    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$08    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


EndingGfx:
  LDA #$01    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$18    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.
  LDA #$00
  STA $2116
  LDA #$20
  STA $2117

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$80    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$1A    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$80    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


EndingTmap:
  LDA #$00    ;$4300 is the DMA control register. Unless you're writing directly to vram,
  STA $4310   ;this should probably always be zero.

  LDA #$80    ;$4301 is the destination register. The upper address is assumed to be $21,
  STA $4311   ;so you're gonna have to figure out which of the $2100-$21FF registers you
              ;want to write to.

  LDA #$00    ;...in our case, since we're writing to WRAM ($7E:0000-$7F:FFFF), we need to
  STA $2181   ;use $2180. We store the address that $2180 goes to in $2181-$2183. I'm going
  LDA #$80    ;to leave these blank, but they're in standard pointer format. Of note is that
  STA $2182   ;bank $7E must be written as $00, and $7F must be written as $01.
  LDA #$00    ;So, if you were writing to $7F:9320 you'd write $20, $93, $01 in that order
  STA $2183   ;to $2181, $2182, and $2183 in that order.

  LDA #$00    ;These registers contain the address your read starts from. Since we're dealing
  STA $4312   ;with loroms, you need to remember how lorom addressing works, and you'll need
  LDA #$80    ;to convert the address of your new font ($FF000, right?) to a standard 24-bit
  STA $4313   ;LoROM pointer. I'll leave these blank as well.
  LDA #$1C    ;You should be able to fill them in yourself.
  STA $4314

  LDA #$00    ;$4305 and $4306 are the number of bytes you need to copy. Again, the order of
  STA $4315   ;the bytes is the same as before -- the high byte of your address comes LAST.
  LDA #$38    ;Notice that you can't exceed 64K in this. That's cuz of the bank boundaries.
  STA $4316   ;Don't try to copy more than 32K if you're dealing with loroms, either.
              ;Note that since you're not doing -addresses-, counting here starts from $0,
              ;not $8000, like lorom addresses would.

  LDA #$02    ;This register starts DMA! Note that there are 8 DMA channels that can be used
  STA $420B   ;if you want to do more than one DMA at a time (channels 0-7.) We're using
              ;Channel 0. If we wanted to use channel 1, we'd be writing to $431X instead of
              ;$430X. The same holds for the rest of the DMA channels.
              ;Note that writing a byte to $420B can start more than one channel at a time!
              ;Since we're writing #$01 to it (00000001 binary), we're starting channel 0.
              ;If we wrote #$02 (00000010 binary), we'd start channel 1.
              ;If we wrote #$03, we'd start channels 0 -and- 1!

  RTL         ;Kay, we're done!


