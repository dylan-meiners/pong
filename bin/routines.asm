processKeys:
    call _GetCSC
    ;cp skEnter
    ;call z, drawPaddles
    cp skClear
    jp z, EXIT
    cp skDown
    call z, rpaddledown
    cp skUp
    call z, rpaddleup
    cp skAlpha
    call z, lpaddledown
    cp sk2nd
    call z, lpaddleup
    ret

;bc = b * c
;ans in hl
;destroys: de, hl, bc
multiply8bit:
    ld hl, 0        ;result starts at 0
    inc b
    dec b
    ret z
    inc c
    dec c
    ret z           ;0 checks
    push bc         ;save b * c
    ld b, 0         ;c is saved
    push bc
    pop de          ;ld de, bc
    pop bc          ;restore b (c doesn't matter)
multiply8bitloop:
    add hl, de
    djnz multiply8bitloop       ;until b is 0, add de (originally c) to hl
    ret

;16 bit in de
;8 bit in b
;result in hl
;only checks if b is 0
multiply16bit8bit:
    ld hl, 0
    inc b
    dec b
    ret z           ;ret if acc is zero
multiply16bit8bitloop:
    add hl, de
    djnz multiply16bit8bitloop
    ret

drawPaddles:
    ld h, 0
    ld l, 0
    call drawPaddle
    ld h, 1
    ld l, 0
    call drawPaddle
    ret
;drawPaddle:
;if h is 0 then draw left, otherwise right
;if l is 0 then draw black, otherwise white
drawPaddle:
    inc h
    dec h
    push hl                 ;save params
    jp z, drawPaddleLeft    ;if h is 0, draw left
drawPaddleRight:            ;otherwise draw right
    ld hl, rpaddle
    jp drawPaddleMult       ;make sure not to load left after loading right
drawPaddleLeft:
    ld hl, lpaddle
drawPaddleMult:
    ld de, lcdWidth
    ld b, (hl)
    call multiply16bit8bit
    push hl
    pop bc                  ;result is now in bc
    pop hl                  ;restore params
    inc h
    dec h
    push hl                 ;save params
    jp z, drawPaddleLeftOffset  ;if h is 0, apply left offset
drawPaddleRightOffset:      ;otherwise apply right offset
    ld hl, lcdWidth - 25
    jp drawPaddleOffset     ;make sure not to load left offset after loading right offset
drawPaddleLeftOffset:
    ld hl, 25
drawPaddleOffset:
    add hl, bc
    push hl
    pop bc
    pop hl                  ;restore params
    inc l
    dec l
    jp z, drawPaddleWhite
drawPaddleBlack:
    ld hl, sPaddleBlack
    jp drawPaddleDraw
drawPaddleWhite:
    ld hl, sPaddle
drawPaddleDraw:
    call drawSprite
    ret

drawBall:
    ret

lpaddledown:
    ld de, lpaddle
    ld a, (de)
    add a, 30
    cp a, lcdHeight
    ret z
    ld h, 0
    ld l, 1             ;draw black
    call drawPaddle
    ld de, lpaddle
    ld a, (de)
    add a, 30
    ld (de), a          ;save new position
    ld hl, 0
    call drawPaddle
    ret
lpaddleup:
    ld de, lpaddle
    ld a, (de)
    inc a
    dec a
    ret z
    ld h, 0
    ld l, 1             ;draw black
    call drawPaddle
    ld de, lpaddle
    ld a, (de)
    sub 30
    ld (de), a          ;save new position
    ld hl, 0
    call drawPaddle
    ret
rpaddledown:
    ld de, rpaddle
    ld a, (de)
    add a, 30
    cp a, lcdHeight
    ret z
    ld h, 1
    ld l, 1             ;draw black
    call drawPaddle
    ld de, rpaddle
    ld a, (de)
    add a, 30
    ld (de), a          ;save new position
    ld h, 1
    ld l, 0
    call drawPaddle
    ret
rpaddleup:
    ld de, rpaddle
    ld a, (de)
    inc a
    dec a
    ret z
    ld h, 1
    ld l, 1             ;draw black
    call drawPaddle
    ld de, rpaddle
    ld a, (de)
    sub 30
    ld (de), a          ;save new position
    ld h, 1
    ld l, 0
    call drawPaddle
    ret