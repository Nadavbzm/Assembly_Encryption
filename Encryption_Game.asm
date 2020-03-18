;global    _start

;section   .text

jmp start
          
msg dw "Enter Text To Encrypt (15 Letters Max): $" ; Text To Print
msg2 dw "Enter Encyption Type:$"
ROT13 dw "1 - ROT3$"
TTA dw  "2 - Text To Ascii$" ; Text To Print         
game dw  "3 - To Try And Brake An Encryption On Your Own$" ; Text To Print     
clear_option dw  "4 - To Clear screen$" ; Text To Print
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
hintmsg dw "Press 'h' for hint, 'a' for answer, 'm' to go back to menu",'$'
hintCount db 0 
ansmsg1 dw "All substitution ciphers can be cracked by using the following tips$"
ansmsg2 dw "scan through the cipher:"
ansmsg3 dw " looking for single letter words. They are almost definitely a or i.$"
ansmsg4 dw "Count how many times each symbol appears in the puzzle. The most frequent symbol is probably e. it could also be t, a, or O, especially if the cryptogram is fairly short.$"
ansmsg5 dw "Pencil in your guesses over the ciphertext. Do typical word fragments start to reveal themselves? Be prepared to erase and change your guesses!$"
ansmsg6 dw "Look for repeating letter patterns. They may be common letter groups such as TH, SH, RE, CH, TR, ING, ION, and ENT.$"
ansmsg7 dw "Try to decipher two-, three-, and four-letter words.$"
ansmsg8 dw "Two-letter words almost always have one vowel and one consonant. The five most common two-letter words, in order of frequency, are OF, TO, IN, IS, and IT.$"
ansmsg9 dw "The most common three-letter words, in order of frequency, are THE, AND, FOR, WAS, and HIS.$"
ansmsg10 dw "The most common four-letter word is THAT. keep this in mind!"
ansmsg11 dw "Scan for double letters. They are most likely to be LL, followed in frequency by EE, SS, OO, and TT (and on to less commonly seen doubles)$"
   

guide dw "This Cipher is Called a substitution cipher, it is called a substitution $"
guide1 dw "cipher because each letter of the alphabet is replaced with a different letter, Such as a = b. g = z ... $"
guide2 dw "In this program you will get a coded text and have to decode it.$"
guide3 dw "You have 4 hints to make your job easier. Good Luck!$"

   
hint1 dw "r = e$"
hint2 dw "f = o$"
hint3 dw "t = f$"
hint4 dw "k = l$"

hintLeft1 dw "You Have $" 
hintLeft2 dw " Hints Left!$"

rotate_menue1 dw "1 - Encrypt$"     
rotate_menue2 dw "2 - Decrypt$" 
tmp dw '$' 
REM  db ?   ; Remainder 8-bit storate
QUOT db ?   ; Quotient  8-bit storage
COUNT db 0  ; Counts the stacks  
retadd dw 0  
retadd_subs dw 0
startMsg  dw "00000    00    0  0000000  0000000   0     0   0000000  0000000 $" ; Text To Print
startMsg1 dw "0        0 0   0  0        0      0   0   0    0     0     0     $" ; Text To Print
startMsg2 dw "00000    0  0  0  0        0 00000     0 0     0000000     0$" ; Text To Print  
startMsg3 dw "0        0   0 0  0        0      0     0      0           0       $" ; Text To Print
startMsg4 dw "00000    0    00  0000000  0      0     0      0           0     $" ; Text To Print
pressAnyKey dw "Press any key to continue...$" ; Text To Print
credit dw "Encryption Game, By Nadav Ben Tzur$"
intro dw "In this game you will be able to encrypt and decrypt text into different cipher.$"
intro2 dw "do this by selecting option from the menu$"  

start:        
mov  dx, offset startMsg
mov  ah, 9        
int  21h  

call newLine  

mov  dx, offset startMsg1
mov  ah, 9        
int  21h  

call newLine  

mov  dx, offset startMsg2
mov  ah, 9        
int  21h  

call newLine
mov  dx, offset startMsg3
mov  ah, 9        
int  21h  

call newLine  

mov  dx, offset startMsg4
mov  ah, 9        
int  21h 

call newLine
call newLine  
call newLine
mov  dx, offset credit
mov  ah, 9        
int  21h  

call newLine
  
call newLine  
 
call newLine
mov  dx, offset intro
mov  ah, 9        
int  21h  

call newLine  


mov  dx, offset intro2
mov  ah, 9        
int  21h  

call newLine  
call newLine  

mov  dx, offset pressAnyKey
mov  ah, 9        
int  21h  

call newLine  

MOV AH,1 ; get  Key
INT 21H 


;clear screen  
pusha
mov ah, 0x00
mov al, 0x03
int 0x10
popa

   
main:   

mov hintCount, 0
mov si, offset string
call clearStr


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

mov  dx, offset clear_option
mov  ah, 9        
int  21h
              
call newLIne 
 
;get Option 
MOV AH,1
INT 21H 
cmp al, '1'
je rotate_options
cmp al, '2'
je Ascii_options
cmp al, '3'
je substitute_options
cmp al, '4'
je clear_screen
jne next

rotate_options:
call newLIne

mov  dx, offset rotate_menue1
mov  ah, 9        
int  21h
              
call newLIne

mov  dx, offset rotate_menue2
mov  ah, 9        
int  21h
              
call newLIne 
;get Option 
MOV AH,1
INT 21H 
cmp al, '1'
je r3Enc
cmp al, '2'
je r3Dec

r3Enc:
call newline
call encRot3
jmp next

r3Dec:
call newline
call decRot3
jmp next

Ascii_options:     
call newline
call encAscii
jmp next

substitute_options:
call subs
jmp next


clear_screen:
;clear screen  
pusha
mov ah, 0x00
mov al, 0x03
int 0x10
popa

next:
call newline
 ;Print msg
mov  dx, offset string
mov  ah, 9        
int  21h

mov si, offset string
call clearStr
call newline
jmp main 
ret 


      
proc getStr
	mov ah, 01h
	int 21h			; Get input
	
	cmp al, 0Dh	;"if pressed nextline" 
	jne continue	; Quit if Carriage-return
    ret
    
    continue:	
	mov [si], al		; Put entered char in user name
	inc si			; move the position
	loop getStr;		; Keep going (looping)     
 

proc clearStr     
    lp:
     mov ax, [si]
     mov b.tmp, al        
	cmp b.tmp, '$'
	jne nxt2
	ret
	nxt2:
	mov [si], '$'
	inc si			; move the position
	jmp lp		; Keep going (looping)     


proc newLine
MOV dl, 10
MOV ah, 02h
INT 21h
MOV dl, 13
MOV ah, 02h
INT 21h 
ret
   
proc PRINT_AL_ASCII
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
    
proc encRot3
mov si, offset string     
call getStr
mov si, offset string 
rotate:     
     mov ax, [si]
     mov b.tmp, al
               
	cmp b.tmp, '$'
	jne continue2	
    call newLine
    ret
    
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
    mov bx, 27
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
    mov bx, 27
    div bx
    mov tmp, dx
    mov al, b.tmp
    mov [si], al          
	add [si], 64
	
	nxt:
	inc si			; move the position
	loop rotate;		; Keep going (looping)     
 

proc decRot3
mov si, offset string     
call getStr
mov si, offset string 
rotate2:     
     mov ax, [si]
     mov b.tmp, al
               
	cmp b.tmp, '$'
	jne continueDec
	call newLine	
    ret
    
    continueDec:	
    cmp b.tmp,91;check if upper or lower by ascii code 
    jl uppercase2
    jb lowercase2
    
    lowercase2:
	sub tmp, 96
	mov ax, 0
	mov ax, tmp
	sub ax, 3        
    mov dx, 0             
    mov bx, 26
    div bx
    mov tmp, dx
    mov al, b.tmp
    mov [si], al          
	add [si], 96
	jmp nxt_Dec
	uppercase2:  
	sub tmp, 64
	mov ax, 0
	mov ax, tmp 
    sub ax, 3
    mov dx, 0             
    mov bx, 26
    div bx
    mov tmp, dx
    mov al, b.tmp
    mov [si], al          
	add [si], 64
	
	nxt_Dec:
	inc si			; move the position
	loop rotate2;		; Keep going (looping)     
             
proc encAscii
mov si, offset string     
call getStr
mov si, offset string     
TOAscii:
	cmp [si], '$'	
    jne nxt3
    ret
   
	nxt3:
	mov al, [si]
	call PRINT_AL_ASCII
	MOV dl, ' '
    MOV ah, 02h
    INT 21h
	inc si			; move the position
	loop TOAscii;		; Keep going (looping)     
	

proc print_ans 
pop retadd
call newline
mov  dx, offset ansmsg1
mov  ah, 9        
int  21h

mov  dx, offset ansmsg2
mov  ah, 9        
int  21h

mov  dx, offset ansmsg3
mov  ah, 9        
int  21h

mov  dx, offset ansmsg4
mov  ah, 9        
int  21h

mov  dx, offset ansmsg5
mov  ah, 9        
int  21h

mov  dx, offset ansmsg6
mov  ah, 9        
int  21h

mov  dx, offset ansmsg7
mov  ah, 9        
int  21h

mov  dx, offset ansmsg8
mov  ah, 9        
int  21h

mov  dx, offset ansmsg9
mov  ah, 9        
int  21h

mov  dx, offset ansmsg10
mov  ah, 9        
int  21h

mov  dx, offset ansmsg11
mov  ah, 9        
int  21h
push retadd   
ret



proc print_guide 
pop retadd
call newline
mov  dx, offset guide
mov  ah, 9        
int  21h

mov  dx, offset guide1
mov  ah, 9        
int  21h

mov  dx, offset guide2
mov  ah, 9        
int  21h

mov  dx, offset guide3
mov  ah, 9        
int  21h
push retadd   
ret


proc subs
pop retadd_subs
call print_guide  
call newLine
call newline

call print_substitute

call newLine
getHints:  
call newline
mov  dx, offset hintmsg
mov  ah, 9        
int  21h  
call newline 

call newLine

mov  dx, offset hintLeft1
mov  ah, 9        
int  21h  

MOV dl, 4  ;max four hints
sub dl, HintCount ;getting hints left
add dl, 48 ;for ascii code of nuber
MOV ah, 02h
INT 21h   ;print


mov  dx, offset hintLeft2
mov  ah, 9        
int  21h  
call newline

;input
MOV AH,1
INT 21H 

cmp al, 'm' ;skip 
jne n
jmp exit
n:
cmp al, 'a' ;print ans
jne hints?
call print_ans
jmp exit
hints?: 
cmp al, 'h' ;print hint   
jne getHints
je hint_option

hint_option:
call newline
cmp hintCount, 0
je one 
cmp hintCount, 1
je two
cmp hintCount, 2
je three
cmp hintCount, 3
je four
jmp exit

one:
mov  dx, offset hint1
mov  ah, 9        
int  21h  
call newline
inc hintCount
jmp getHints
two:
mov  dx, offset hint2
mov  ah, 9        
int  21h  
call newline
inc hintCount 
jmp getHints
three:        
mov  dx, offset hint3
mov  ah, 9        
int  21h  
call newline
inc hintCount
jmp getHints
four:
mov  dx, offset hint4
mov  ah, 9        
int  21h  
call newline
inc hintCount
jmp getHints
exit:
call newline
 ;Print msg
mov  dx, offset string
mov  ah, 9        
int  21h

mov si, offset string
call clearStr
mov hintCount, 0
push retadd_subs 
ret    


print_substitute: 
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