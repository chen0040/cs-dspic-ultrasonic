
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;project.c,3 :: 		void main() {
;project.c,7 :: 		Uart1_Init(9600);
	PUSH	W10
	PUSH	W11
	MOV	#9600, W10
	MOV	#0, W11
	CALL	_UART1_Init
;project.c,8 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOV	#2, W8
	MOV	#17796, W7
L_main0:
	DEC	W7
	BRA NZ	L_main0
	DEC	W8
	BRA NZ	L_main0
	NOP
	NOP
;project.c,10 :: 		rx1 = Uart1_Read();          // perform dummy read to clear the register
	CALL	_UART1_Read
	MOV	#lo_addr(_rx1), W1
	MOV.B	W0, [W1]
;project.c,12 :: 		Uart1_Write('s');            // signal start
	MOV	#115, W10
	CALL	_UART1_Write
;project.c,14 :: 		while(1)
L_main2:
;project.c,16 :: 		if(Uart1_Data_Ready())
	CALL	_UART1_Data_Ready
	CP0	W0
	BRA NZ	L__main6
	GOTO	L_main4
L__main6:
;project.c,18 :: 		rx1=Uart1_Read();
	CALL	_UART1_Read
	MOV	#lo_addr(_rx1), W1
	MOV.B	W0, [W1]
;project.c,20 :: 		Uart1_Write(rx1);
	ZE	W0, W10
	CALL	_UART1_Write
;project.c,21 :: 		}
L_main4:
;project.c,22 :: 		}
	GOTO	L_main2
;project.c,23 :: 		}
L_end_main:
L__main7:
	BRA	L__main7
; end of _main
