;    ______         _ ___            __         
;   / __/ /__ _  __(_) _ )___  ___  / /____ ____
;  / _// / -_) |/ / / _  / _ \/ _ \/ __/ -_) __/
; /_/ /_/\__/|___/_/____/\___/\___/\__/\__/_/   
; _____  _  ____   ____ 
; | () )| |/ () \ (_ (_`  The FleviOS Bootloader
; |_()_)|_|\____/.__)__)  for BIOS-based systems
;
; Writen by Mimmeer in 2025; Guided with nanobyte's
; OS Tutorial on YouTube

org 0x7C00            ; Where we start
bits 16               ; This is real mode (16-bits) right now.


main:                 ; Our starting point
    mov ax,0          ; Data segments
    mov ds,ax
    mov es,ax         ; Done!

    mov ss,ax         ; Stack setup time!
    mov p,0x7C00
    hlt               ; Instant CPU stop

.halt:                ; In case the CPU decides to unhalt.
    jmp .halt         ; INFINITE LOOP

times 510-($-$$) db 0 ; Padding galore!
db 055h             ; Special BIOS sign PART I!
db 0AAh             ; Special BIOS sign PART II!
