INCLUDE print.asm  

ASSUME CS:CODESG
DATA SEGMENT
    DB '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    DB '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    DB '1993', '1994', '1995'
   

    DD 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    DD 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

    DW 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    DW 11542, 14430, 15257, 17800
DATA ENDS

;AX+210/16向上取整，即AX+14H
;对于DS，偏移量为16*14=224
TABLE SEGMENT
    DB 21 DUP('YEAR SUMM NE ?? ')
TABLE ENDS

STACK SEGMENT
    DW 1 DUP(0)
STACK ENDS

CODESG SEGMENT
START:  MOV AX, DATA
        MOV DS, AX 
        MOV BX, TABLE
        MOV ES, BX  
        MOV BX, 0   ;定位结构体数组元素
        MOV DI, 0   ;定位DATA中的4字节数据
        MOV SI, 0   ;定位DATA中的2字节数据
        MOV CX, 15H
    S:  ;转移年份
        MOV AX, DS:[DI];
        MOV ES:[BX], AX
        MOV AX, DS:[DI+2]
        MOV ES:[BX+2], AX
        ;添加空格 
        MOV BYTE PTR ES:[BX+4], 32

        ;转移收入
        ;作为被除数
        MOV AX, DS:[DI+84];
        MOV ES:[BX+5], AX
        MOV AX, DS:[DI+86]
        MOV ES:[BX+7], AX
        ;添加空格 
        MOV BYTE PTR ES:[BX+9], 32

        ;转移雇员数量
        MOV AX, DS:[SI+168]
        MOV ES:[BX+10], AX
        ;添加空格 
        MOV BYTE PTR ES:[BX+12], 32

        ;计算人均收入，并转移到TABLE中
        MOV AX, ES:[BX+5]   ;低16位
        MOV DX, ES:[BX+7]   ;高16位
        DIV WORD PTR ES:[BX+10]
        MOV ES:[BX+13], AX  ;商默认存放在AX中 
        ;添加空格 
        MOV BYTE PTR ES:[BX+15], 32 

        ;操作完成，BX加16，DI加2
        ADD BX, 16  
        ADD DI, 4
        ADD SI, 2
        LOOP S

        CALL PRINT

        MOV AX, 4C00H
        INT 21H

CODESG ENDS
END START
