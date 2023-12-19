data SEGMENT
    mess1 db "Please input your number(must be interger in decimal format form 1- 100)!!!:$"
    mess2 db "Your number is larger,please try again:$"
    mess3 db "Your number is smaller,please try again:$"
    mess4 db "BingGO!!!^-^!!!$"
    mess5 db " Out of limitation!!$"
    mess6 db " Already close!!"
    a dw ?

    
data ENDS

code SEGMENT
    assume cs:code,ds:data

begin:
    mov ax,data
    mov ds,ax
    mov ah,9
    mov dx,offset mess1
    int 21h

    MOV AH,02h  
    MOV DL,0ah
    INT 21h
    MOV DL,0dh
    INT 21h

    ; 生成随机数种子
    MOV AH, 2Ch
    INT 21h
    MOV al, dh
    MOV ah, 0
    MOV a, ax

l0:
    MOV AH, 1    ; 输入十进制数
    INT 21h
    CMP AL, 0dh
    JZ l4
    CMP AL, 48
    JB exit
    CMP AL, 57
    JA exit
    AND AL, 0fh
    MOV AH, 0
    XCHG AX, BX
    MOV CX, 10
    MUL CX
    ADD BX, AX
    CMP BX, 0    ; 检查输入值是否小于0
    JB l5
    CMP BX, 60  ; 检查输入值是否大于60
    JA l5
    
    JMP l0  
   
l4:
    MOV AH, 02h
    MOV DL, 0ah
    INT 21h
    MOV DL, 0dh
    INT 21h

    cmp bx, a   ; 输入值与随机数比较
    JB l1        ; 小于       
    JA l2        ; 大于
    JZ l3        ; 等于

l1:
    mov ah, 9
    mov dx, offset mess3
    int 21h
    MOV AH, 02h
    MOV DL, 0ah
    INT 21h
    MOV DL, 0dh
    INT 21h
    mov ax, 0
    mov bx, 0
    jmp l0

l2:
    mov ah, 9
    mov dx, offset mess2
    int 21h
    MOV AH, 02h
    MOV DL, 0ah
    INT 21h
    MOV DL, 0dh
    INT 21h
    mov ax, 0
    mov bx, 0
    jmp l0

l3:
    mov ah, 9
    mov dx, offset mess4
    int 21h
     ; 调用系统响铃
    MOV AH,02H              
    MOV DL,07H
    INT 21H  

    JZ exit

l5:
    mov ah, 9
    mov dx, offset mess5
    int 21h
    ; MOV AH, 02h
    ; MOV DL, 0ah
    ; INT 21h
    ; MOV DL, 0dh
    ; INT 21h
    ; mov ax, 0
    ; mov bx, 0
    jmp l0

l6:
    mov ah, 9
    mov dx, offset mess6
    int 21h
    ; MOV AH, 02h
    ; MOV DL, 0ah
    ; INT 21h
    ; MOV DL, 0dh
    ; INT 21h
    ; mov ax, 0
    ; mov bx, 0
    jmp l0

exit:
    MOV AH, 02h
    MOV DL, 0ah
    INT 21h
    MOV DL, 0dh
    INT 21h

    mov ah, 4ch
    int 21h

code ends
end begin 
