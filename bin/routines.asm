processKeys:
    call _GetCSC
    cp skEnter
    call z, drawPaddles
    cp skClear
    jp z, EXIT
    ret

;bc = b * c
;ans in hl
;destroys: de, hl, bc
multiply:
    ld hl, 0
    push bc
    ld b, 0
    push bc
    pop de
    pop bc
loop:
    add hl, de
    jr nz, loop
    ret