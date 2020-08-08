;deleted: a
setup8bpp:
    ld a, lcdBpp8 ;8 bits per pixel, in BRG mode (idek why and I cant figure out how to make it RGB ¯\_(ツ)_/¯)
    ld (mpLcdCtrl), a
    ret

;deleted: hl, de, bc
setPalette:
    ld hl, start_palette_def
    ld de, mpLcdPalette
    ld bc, end_palette_def - start_palette_def
    ldir
    ret

;deleted: hl, de, bc
clearScreen:
    ld hl, vRam
    ld (hl), BLACK
    push hl
    pop de
    inc de
    ld bc, lcdWidth * lcdHeight
    ldir
    ret

drawPaddles:
    ld hl, sPaddle
    ld bc, 50 * lcdWidth + 50
    call drawSprite
    ret

;will break if tries to draw outside of screen bounds
;hl = sprite
;bc = vRam offset
drawSprite:
    push hl         ;save sprite
    ld hl, vRam     ;set start of ram
    add hl, bc      ;add offset to ram
    push hl
    pop de          ;de becomes position
    pop hl          ;restore sprite
    ld b, (hl)      ;load MSB of rows to MSB of bc
    inc hl          ;point to LSB of rows
    ld c, (hl)      ;load LSB of rows to LSB of bc
    push bc         ;save this for later (row loop counter)
    inc hl          ;move to number of cols def
    ld b, (hl)      ;load MSB of cols to MSB of bc
    inc hl          ;point to LSB of cols
    ld c, (hl)      ;load LSB of cols to LSB of bc
    push bc         ;af = bc number of cols in first loop
    inc hl          ;move hl to first byte of first col
row_loop:
    pop af          ;restore cols
    push af         ;apparently af is changed in the ldir somewhere... so keep it saved
    push af
    pop bc          ;bc = af number of cols
    ldir            ;loop through each pixel in col and copy to hl (should be vRam)
    pop af          ;restore af after ldir changes it I guess... af = number of cols
    ;get ready for next loop
    push hl         ;save hl (sprite pixel pointer)
    ;start positioning for next col pass.  We have to move hl, which points to the vRam,
    ;to the correct position forward "lcdWidth - number of cols" pixels
    ld hl, lcdWidth
    push af
    pop bc          ;bc = af number of cols
    xor a           ;reset carry and set a to 0
    sbc hl, bc      ;hl = hl - bc
    add hl, de      ;add our current vRam pos to the number required to get us to the right pos in the next line
    push hl
    pop de          ;and save it in de
    ;restore stuff
    push bc
    pop af          ;restore cols
    pop hl          ;restore hl (sprite pixel pointer)
    ;end positioning for next col pass
    pop bc          ;restore bc (outer loop (row) counter)
    dec bc
    push bc         ;save this for later (row loop counter)
    push af         ;save cols
    ld a, b
    or c            ;check if bc is 0
    jp nz, row_loop
    pop af
    pop bc
    ret