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

; FAT12 HEADER
jmp short start
nop
bdb_oem:                   db 'MSWIN4.1' ; Drive 'OEM' (8 bytes)
bdb_bytes_per_sector:      dw 512
bdb_sectors_per_cluster:   db 1
bdb_reserved_sectors:      dw 1
bdb_fat_count:             db 2
bdb_dir_entries_count:     dw 0E0h
bdb_total_sectors:         dw 2880        ; 2880hKB * 512 = 1.44MB; hKB = half KiloBytes
bdb_media_descriptor_type: db 0F0h        ; 3.5"
bdb_sectors_per_fat:       dw 9
bdb_sectors_per_track:     dw 18
bdb_heads:                 dw 2
bdb_hidden_sectors:        dd 0
bdb_large_sector_count:    dd 0

; EXTENDED BOOT RECORD
ebr_drive_number:          db 0                  ; 0x00 = Floppy Disk, 0x80 = Hard Drive, Kinda useless
                           db 0                  ; UNKNOWN RESERVED VALUE
abr_signiture:             db 29h                ; DO NOT CHANGE
ebr_volume_id:             db 12h, 34h, 56h, 78h ; Anything field
ebr_volume_label:          db 'FLEVI DEV  '      ; Space-padded, 11 bytes
ebr_system_id:             db 'FAT12   '         ; Space-padded, 8 bytes

; Back to ASM code

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
    jmp .loop         ; Falling backwards to line 25.

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

.halt:                ; In case the CPU decides to unhalt.
    jmp .halt         ; INFINITE LOOP

msg_hello: db 'FleviBooter (16-bit real mode)', ENDL, 0

times 510-($-$$) db 0 ; Padding galore!
db 055h               ; Special BIOS sign PART I!
db 0AAh               ; Special BIOS sign PART II!
