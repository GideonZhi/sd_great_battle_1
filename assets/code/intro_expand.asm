lorom


;$00/92B1: A2 0C 16     LDX #$160C                A:0002 X:0002 Y:990E D:0000 DB:15 S:03F8 P:eNvMxdizc HC:940 VC:021
;$00/92B4: 86 1C        STX $1C [$00:001C]        A:0002 X:160C Y:990E D:0000 DB:15 S:03F8 P:envMxdizc HC:1004 VC:021
;$00/92B6: A0 00 00     LDY #$0000                A:0002 X:160C Y:990E D:0000 DB:15 S:03F8 P:envMxdizc HC:1076 VC:021
;$00/92B9: C2 20        REP #$20                  A:0002 X:160C Y:0000 D:0000 DB:15 S:03F8 P:envMxdiZc HC:1140 VC:021
;$00/92BB: A5 1C        LDA $1C [$00:001C]        A:0002 X:160C Y:0000 D:0000 DB:15 S:03F8 P:envmxdiZc HC:1202 VC:021
;$00/92BD: 18           CLC                       A:160C X:160C Y:0000 D:0000 DB:15 S:03F8 P:envmxdizc HC:1274 VC:021
;$00/92BE: 69 80 00     ADC #$0080                A:160C X:160C Y:0000 D:0000 DB:15 S:03F8 P:envmxdizc HC:1328 VC:021
;$00/92C1: 85 1C        STA $1C [$00:001C]        A:168C X:160C Y:0000 D:0000 DB:15 S:03F8 P:envmxdizc HC:1392 VC:021
;$00/92C3: E2 20        SEP #$20                  A:168C X:160C Y:0000 D:0000 DB:15 S:03F8 P:envmxdizc HC:096 VC:022
;$00/92C5: AA           TAX                       A:168C X:160C Y:0000 D:0000 DB:15 S:03F8 P:envMxdizc HC:158 VC:022
;$00/92C6: A9 00        LDA #$00                  A:168C X:168C Y:0000 D:0000 DB:15 S:03F8 P:envMxdizc HC:212 VC:022
;$00/92C8: EB           XBA                       A:1600 X:168C Y:0000 D:0000 DB:15 S:03F8 P:envMxdiZc HC:268 VC:022
;$00/92C9: A9 14        LDA #$14                  A:0016 X:168C Y:0000 D:0000 DB:15 S:03F8 P:envMxdizc HC:328 VC:022
;$00/92CB: 85 02        STA $02 [$00:0002]        A:0014 X:168C Y:0000 D:0000 DB:15 S:03F8 P:envMxdizc HC:384 VC:022

org $0092B1
  ;Tilemap start position
  LDX #$1584

org $0092C9
  ;line length limit
  LDA #$1D