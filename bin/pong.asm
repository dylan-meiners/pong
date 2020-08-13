#include "..\includes\ti84pce.inc"

   .assume ADL = 1
   .org userMem - 2
   .db tExtTok, tAsm84CeCmp

    di
    call _RunIndicOff
    call _ClrScrnFull

    call setup8bpp
    call setPalette
    call clearScreen
    call drawPaddles

MAIN_LOOP:
    call processKeys
    
    jp MAIN_LOOP



EXIT:
    pop hl              ;pop the stack pointer so we don't return to caller
    call _clrscrn
    ld a, lcdBpp16
    ld (mpLcdCtrl), a
    call _HomeUp
    call _drawstatusbar
    res OnInterrupt, (iy + onFlags)
    set graphDraw, (iy + graphFlags)
    ei
    ret

#include "..\includes\ks.inc"
#include "..\bin\routines.asm"
#include "..\bin\artist.asm"
#include "..\includes\paint.inc"

;vars
lpaddle:
    .dw 0
rpaddle:
    .dw 0