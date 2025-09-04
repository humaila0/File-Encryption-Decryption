dosseg
.model small
.stack 100h
.data
    inputFile db 'input.txt', 0        ; Input file name
    encryptedFile db 'output.txt', 0  ; Encrypted file name
    decryptedFile db 'decrypted.txt', 0 ; Decrypted file name
    key db 0                           ; XOR key entered by user
    fileHandleIn dw ?                  ; File handle for input file
    fileHandleOut dw ?                 ; File handle for output file
    buffer db 512 dup(0)               ; Buffer to read data (512 bytes at a time)
    bytesRead dw ?                     ; Number of bytes read

    msgEnterKey db 'Enter XOR key (single character): $'
    msgSuccessEncrypt db 13, 10, 'Encryption completed successfully!$', 13, 10, '$'
    msgSuccessDecrypt db 13, 10, 'Decryption completed successfully!$', 13, 10, '$'
    msgError db 13, 10, 'Error accessing file.$', 13, 10, '$'

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Prompt user for XOR key
    mov ah, 09h
    lea dx, msgEnterKey
    int 21h

    ; Get single character key
    mov ah, 01h
    int 21h
    mov key, al        ; Store the entered key

    ; Step 1: Encrypt input.txt to output.txt
    mov dx, offset inputFile
    call processFile
    mov dx, offset encryptedFile
    call setOutputFile
    call encryptDecrypt
    mov dx, offset msgSuccessEncrypt
    call displayMessage

    ; Step 2: Decrypt output.txt to decrypted.txt
    mov dx, offset encryptedFile
    call processFile
    mov dx, offset decryptedFile
    call setOutputFile
    call encryptDecrypt
    mov dx, offset msgSuccessDecrypt
    call displayMessage

    jmp exit

processFile proc
    ; Open input file
    mov ah, 3Dh        ; DOS open file
    mov al, 0          ; Open for read-only
    int 21h
    jc errorFile       ; Jump if error
    mov fileHandleIn, ax
    ret
processFile endp

setOutputFile proc
    ; Create output file
    mov ah, 3Ch        ; DOS create file
    mov cx, 0          ; Normal file attributes
    int 21h
    jc errorFile       ; Jump if error
    mov fileHandleOut, ax
    ret
setOutputFile endp

encryptDecrypt proc
readLoop:
    ; Read from input file
    mov ah, 3Fh        ; DOS read file
    mov bx, fileHandleIn
    lea dx, buffer
    mov cx, 512        ; Number of bytes to read (512 bytes at a time)
    int 21h
    jc errorFile
    mov bytesRead, ax
    cmp ax, 0          ; Check for end of file
    je closeFiles      ; Exit loop if end of file

    ; XOR encryption/decryption
    mov cx, bytesRead  ; Set counter for bytes read
    lea si, buffer     ; Buffer start
xorLoop:
    mov al, [si]       ; Load byte from buffer
    xor al, key        ; XOR with key
    mov [si], al       ; Write back to buffer
    inc si
    loop xorLoop

    ; Write to output file
    mov ah, 40h        ; DOS write file
    mov bx, fileHandleOut
    lea dx, buffer
    mov cx, bytesRead
    int 21h
    jc errorFile

    jmp readLoop       ; Repeat read/write loop

closeFiles:
    ; Close input file
    mov ah, 3Eh
    mov bx, fileHandleIn
    int 21h
    ; Close output file
    mov ah, 3Eh
    mov bx, fileHandleOut
    int 21h
    ret
encryptDecrypt endp

displayMessage proc
    ; Display a success or error message
    mov ah, 09h
    int 21h
    ret
displayMessage endp

errorFile:
    ; Error message
    mov dx, offset msgError
    call displayMessage
    jmp exit

exit:
    ; Exit program
    mov ah, 4Ch
    int 21h
main endp
end main
