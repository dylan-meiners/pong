start_palette_def:
    .dw 0       ;black lower byte
    .dw $FFFF   ;white
    .dw $7C00
end_palette_def:

sPaddle:
    .db 2, 15   ;2px x 15px
    .db 2, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1
    .db 1, 1