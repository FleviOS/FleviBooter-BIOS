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

; DEFINITIONS
%define ENDL 0x0D, 0x0A

start:
    jmp main

puts:
    push si           ; Saving the unmodified registers
    push ax           ; Done.

.loop:                ; INTO THE LOOPAGONS!
    lodsb             ; Loads the thing.
    or al, al         ; Oring AL to AL and storing it in AL. (AL counter: 6)
    jz .done          ; Jumping through the Nulliverse for function.done.

    mov ah, 0x0E      ; E.
    mov bh, 0         ; Null Bicycle
    int 0x10          ; We are sorry to interrupt this CPU process to speak to Mr. BIOS

.done:
    pop ax            ; POP!
    pop si            ; Where the bubbles going?
    ret               ; RETurn to the cosmos!
    

main:                 ; Our starting point
    mov ax,0          ; Data segments
    mov ds,ax
    mov es,ax         ; Done!

    mov ss,ax         ; Stack setup time!
    mov sp,0x7C00     ; Stack setup complete!

    mov si, msg_hello ; Code <(Hello!)
    call puts         ; I'll puts this on the screen.


    hlt               ; EMERGENCY FOUND! ENABLE INSTANT CPU STOP!

.halt:                ; In case the CPU decides to unhsalt.
    jmp .halt         ; INFINITE LOOP

msg_hello: 'Hello the vast FOSS world to Flevi!', ENDL

times 510-($-$$) db 0 ; Padding galore!
db 055h               ; Special BIOS sign PART I!
db 0AAh               ; Special BIOS sign PART II!
