start:
    di
    call _RunIndicOff
    call _ClrScrnFull
    ret

processKeys:
    call _GetCSC
    cp skEnter
    call z, drawPaddles
    cp skClear
    jp z, EXIT
    ret