paddles_mem_start:
    .dw 1               ;direction (0 is down, 1 is stop, 2 is up)  left paddle
    .dw 1               ;direction                                  right paddle
    .dw lcdHeight / 2   ;start position                             left paddle
    .dw lcdHeight / 2   ;start position                             right paddle
paddles_mem_stop: