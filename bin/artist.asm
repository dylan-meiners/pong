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
    call drawSprite
    ret

;hl = sprite
;bc = xy
drawSprite:
    push hl         ;save sprite
    ld hl, vRam     ;set start of ram
    mlt bc          ;get offset ((x, y) position)
    add hl, bc      ;add offset to ram
    push hl
    pop de          ;de becomes position
    pop hl          ;restore sprite
    inc hl          ;move to number of rows def
    ld b, (hl)      ;load number of rows into b
    push bc         ;save this for later (row loop counter)
    dec hl          ;move to number of cols def
    ld b, 0         ;lower byte of b should be 0
    ld c, (hl)      ;load number of times to loop for cols into lower byte of bc
    push bc
    pop af          ;af = bc
    inc hl
    inc hl          ;move hl to first byte of first col
row_loop:
    push af         ;apparently af is changed in the ldir somewhere... so save it
    push af
    pop bc          ;bc = af
    ldir            ;loop through each pixel in col and copy to hl (should be vRam)
    pop af          ;restore af after ldir changes it I guess...
    ;get ready for next loop
    push hl         ;save hl (sprite pixel pointer)
    ;start positioning for next col pass.  We have to move hl, which points to the vRam,
    ;to the correct position forward "lcdWidth - number of cols" pixels
    ld hl, lcdWidth
    push af
    pop bc          ;bc = af
    and a           ;reset carry
    sbc hl, bc      ;hl = hl - bc
    add hl, de      ;add our current vRam pos to the number required
    push hl         ;to get us to the right pos in the next line
    pop de          ;and save it in de
    ;restore stuff
    push bc
    pop af          ;reload bc into af after doing the opposite before
    pop hl          ;restore hl (sprite pixel pointer)
    ;end positioning for next col pass
    pop bc          ;restore bc (outer loop (row) counter)
    dec b
    push bc         ;save this for later (row loop counter)
    jr nz, row_loop
    pop bc
    ret