lorom


;$00/B3AE: A2 8A 17     LDX #$178A                A:0003 X:000A Y:9B03 D:0000 DB:15 S:03F8 P:envMxdizc HC:052 VC:235
;$00/B3B1: A0 00 00     LDY #$0000                A:0003 X:178A Y:9B03 D:0000 DB:15 S:03F8 P:envMxdizc HC:116 VC:235
;$00/B3B4: A9 16        LDA #$16                  A:0003 X:178A Y:0000 D:0000 DB:15 S:03F8 P:envMxdiZc HC:180 VC:235

org $00B3AE
  ;line length limit
  LDX #$1786
  LDY #$0000
  LDA #$1C


;$00/B413: A9 97        LDA #$97                  A:00FF X:18B8 Y:1838 D:0000 DB:00 S:03F5 P:eNvMxdizc HC:1190 VC:245
;$00/B415: A0 16 00     LDY #$0016                A:0097 X:18B8 Y:1838 D:0000 DB:00 S:03F5 P:eNvMxdizc HC:1246 VC:245
;$00/B418: A2 4A 18     LDX #$184A                A:0097 X:18B8 Y:0016 D:0000 DB:00 S:03F5 P:envMxdizc HC:1310 VC:245
org $B413
  LDA #$97
  LDY #$001A
  LDX #$1846

;$00/B41E: A9 97        LDA #$97                  A:0097 X:1876 Y:0000 D:0000 DB:00 S:03F5 P:envMxdiZc HC:540 VC:248
;$00/B420: A0 16 00     LDY #$0016                A:0097 X:1876 Y:0000 D:0000 DB:00 S:03F5 P:eNvMxdizc HC:596 VC:248
;$00/B423: A2 8A 18     LDX #$188A                A:0097 X:1876 Y:0016 D:0000 DB:00 S:03F5 P:envMxdizc HC:660 VC:248
org $B41E
  LDA #$97
  LDY #$001A
  LDX #$1886

;$00/B42B: A2 8A 18     LDX #$188A                A:0097 X:18BA Y:004E D:0000 DB:15 S:03F8 P:envMxdizc HC:914 VC:251
org $00B42B
  LDX #$1886



;$00/B3F7: A2 8A 18     LDX #$188A                A:0002 X:17BA Y:001A D:0000 DB:15 S:03F8 P:envMxdizc HC:1048 VC:234
;$00/B3FA: 3A           DEC A                     A:0002 X:188A Y:001A D:0000 DB:15 S:03F8 P:envMxdizc HC:1112 VC:234
;$00/B3FB: F0 B7        BEQ $B7 [$B3B4]           A:0001 X:188A Y:001A D:0000 DB:15 S:03F8 P:envMxdizc HC:1166 VC:234
;$00/B3FD: A2 0A 18     LDX #$180A                A:0001 X:188A Y:001A D:0000 DB:15 S:03F8 P:envMxdizc HC:1222 VC:234
org $B3F7
  LDX #$1886

org $B3FD
  LDX #$1806
