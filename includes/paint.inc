start_palette_def:
    .dw 0       ;black lower byte
    .dw $FFFF   ;white
end_palette_def:

;height and width are in big-endian because when they are loaded into a 32 bit
;register they swap for regular little-endian
sPaddle:
    .db 0, 30, 0, 5
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1
    .db 1, 1, 1, 1, 1

sPaddleBlack:
    .db 0, 30, 0, 5
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0
    .db 0, 0, 0, 0, 0

sBall:
    .db 0, 4, 0, 4
    .db 1, 1, 1, 1
    .db 1, 1, 1, 1
    .db 1, 1, 1, 1
    .db 1, 1, 1, 1