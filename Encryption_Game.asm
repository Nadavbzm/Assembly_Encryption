;global    _start

;section   .text

jmp main
          
msg dw "Enter Text To Encrypt (15 Letters Max): $" ; Text To Print
msg2 dw "Enter Encyption Type:$"
ROT13 dw "1 - ROT3$"
TTA dw  "2 - Text To Ascii$" ; Text To Print         
game dw  "3 - To Try And Brake An Encryption On Your Own$" ; Text To Print 
string:	dw '$$$$$$$$$$$$$$$$'      
t2 dw "rnn bdpbfwfdfwgq vwktxeb vrq px vervlxu ph dbwqy ftx ognngjwqy fwkb$"
t3 dw "bvrq ftegdyt ftx vwktxe:$"
t4 dw "ngglwqy oge bwqynx nxffxe jgeub. ftxh rex rnmgbf uxowqwfxnh r ge w.$"
t5 dw "vgdqf tgj mrqh fwmxb xrvt bhmpgn rkkxreb wq ftx kdaanx. ftx mgbf oexcdxqf bhmpgn wb kegprpnh x. wf vgdnu rnbg px f, r, ge g, xbkxvwrnnh wo ftx vehkfgyerm wb orwenh btgef."
t6 dw "kxqvwn wq hgde ydxbbxb gixe ftx vwktxefxsf. ug fhkwvrn jgeu oerymxqfb bfref fg exixrn ftxmbxnixb? px kexkrexu fg xerbx rqu vtrqyx hgde ydxbbxb!$"
t7 dw "nggl oge exkxrfwqy nxffxe krffxeqb. ftxh mrh px vgmmgq nxffxe yegdkb bdvt rb ft, bt, ex, vt, fe, wqy, wgq, rqu xqf.$"
t8 dw "feh fg uxvwktxe fjg-, ftexx-, rqu ogde-nxffxe jgeub.$"
t9 dw "fjg-nxffxe jgeub rnmgbf rnjrhb trix gqx igjxn rqu gqx vgqbgqrqf. ftx owix mgbf vgmmgq fjg-nxffxe jgeub, wq geuxe go oexcdxqvh, rex go, fg, wq, wb, rqu wf.$"
t10 dw "ftx mgbf vgmmgq ftexx-nxffxe jgeub, wq geuxe go oexcdxqvh, rex ftx, rqu, oge, jrb, rqu twb.$"
t11 dw "ftx mgbf vgmmgq ogde-nxffxe jgeu wb ftrf. lxxk ftwb wq mwqu!$"
t12 dw "bvrq oge ugdpnx nxffxeb. ftxh rex mgbf nwlxnh fg px nn, ognngjxu wq oexcdxqvh ph xx, bb, gg, rqu ff (rqu gq fg nxbb vgmmgqnh bxxq ugdpnxb).$"
tmp dw '$' 
REM  db ?   ; Remainder 8-bit storate
QUOT db ?   ; Quotient  8-bit storage
COUNT db 0  ; Counts the stacks  
retadd dw 0

main:   

 ;Print msg
mov  dx, offset msg2
mov  ah, 9        
int  21h  

call newLine
                       
;Print msg
mov  dx, offset ROT13
mov  ah, 9        
int  21h
              
call newLIne

mov  dx, offset TTA
mov  ah, 9        
int  21h
              
call newLIne

mov  dx, offset game
mov  ah, 9        
int  21h
              
call newLIne


 
;get Option 
MOV AH,1
INT 21H 
cmp al, '1'
je r1 
cmp al, '2'
je r2
cmp al, '3'
je substitute
jne next

r1:
mov si, offset string     
call getStr
mov si, offset string 
rotate:     
     mov ax, [si]
     mov b.tmp, al
               
	cmp b.tmp, '$'
	jne continue2	
    jmp next
    
    continue2:	
    cmp b.tmp,91;check if upper or lower by ascii code 
    jl uppercase
    jb lowercase
    
    lowercase:
	sub tmp, 96
	mov ax, 0
	mov ax, tmp
	add ax, 3        
    mov dx, 0             
    mov bx, 26
    div bx
    mov tmp, dx
    mov al, b.tmp
    mov [si], al          
	add [si], 96
	jmp nxt
	uppercase:  
	sub tmp, 64
	mov ax, 0
	mov ax, tmp 
    add ax, 3
    mov dx, 0             
    mov bx, 26
    div bx
    mov tmp, dx
    mov al, b.tmp
    mov [si], al          
	add [si], 64
	
	nxt:
	inc si			; move the position
	loop rotate;		; Keep going (looping)     
 


r2:     
mov si, offset string     
call getStr
mov si, offset string     
TOAscii:
	cmp [si], '$'	
    jne nxt3
    jmp nxt
   
	nxt3:
	mov al, [si]
	call PRINT_AL_ASCII
	MOV dl, ' '
    MOV ah, 02h
    INT 21h
	inc si			; move the position
	loop TOAscii;		; Keep going (looping)     
 

next:
call newline
 ;Print msg
mov  dx, offset string
mov  ah, 9        
int  21h

mov si, offset string
call clearStr

jmp main 
ret 
 
      
getStr:
	mov ah, 01h
	int 21h			; Get input
	
	cmp al, 0Dh	;"if pressed nextline" 
	jne continue	; Quit if Carriage-return
    ret
    
    continue:	
	mov [si], al		; Put entered char in user name
	inc si			; move the position
	loop getStr;		; Keep going (looping)     
 

clearStr:
     mov ax, [si]
     mov b.tmp, al
               
	cmp b.tmp, '$'
	jne nxt2
	ret
	nxt2:
	mov [si], '$'
	inc si			; move the position
	loop rotate;		; Keep going (looping)     


newLine:
MOV dl, 10
MOV ah, 02h
INT 21h
MOV dl, 13
MOV ah, 02h
INT 21h 
ret
   
PRINT_AL_ASCII:
    mov ah, 0
    MOV DX, 0     ; Clear DX Register
    myLoop:  

        MOV DL, 10    ; Set Divisor to 10
        DIV DL        ; Divide AX by 10

        MOV REM, AH   ; Move Remainder into REM  Variable
        MOV QUOT, AL  ; Move Quotient  into QUOT Variable

        MOV AX, 0     ; Clear AX
        MOV AL, REM   ; Move REM to AL
        PUSH AX       ; Push AX to Stack
        INC COUNT     ; Increase Count by 1

        MOV AL, QUOT  ; Place Quotient Into AL
        MOV AH, 0     ; AH was altered, Zero it out

        CMP AL, 0     ; If No Quotient Remains we can exit 

    JNZ myLoop        ; Jump if NOT zero 

    myLoop2:  

        POP DX        ; Pop from the stack into DX

        ADD DX, '0'   ; To Ascii Char
        MOV AH, 02H   ; Print Char Command
        INT 21H       ; Call to DOS System

        DEC COUNT     ; Decrement COUNT
        CMP COUNT, 0  ; Compare COUNT to 0


    JNZ myLoop2    
    ret
    
    
substitute: 
pop retadd
call newline
mov  dx, offset t2
mov  ah, 9        
int  21h

mov  dx, offset t3
mov  ah, 9        
int  21h

mov  dx, offset t4
mov  ah, 9        
int  21h

mov  dx, offset t5
mov  ah, 9        
int  21h

mov  dx, offset t6
mov  ah, 9        
int  21h

mov  dx, offset t7
mov  ah, 9        
int  21h

mov  dx, offset t8
mov  ah, 9        
int  21h

mov  dx, offset t9
mov  ah, 9        
int  21h

mov  dx, offset t10
mov  ah, 9        
int  21h

mov  dx, offset t11
mov  ah, 9        
int  21h

mov  dx, offset t12
mov  ah, 9        
int  21h
push retadd   
ret
