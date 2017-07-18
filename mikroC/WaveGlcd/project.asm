
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#2

;project.c,36 :: 		void main() {
;project.c,37 :: 		Glcd_Init();
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CALL	_Glcd_Init
;project.c,39 :: 		while(1)
L_main0:
;project.c,41 :: 		Glcd_Fill(0x00);
	CLR	W10
	CALL	_Glcd_Fill
;project.c,42 :: 		x=0;
	CLR	W0
	CLR	W1
	MOV	W0, _x
	MOV	W1, _x+2
;project.c,43 :: 		while(x < 127)
L_main2:
	MOV	#0, W2
	MOV	#17150, W3
	MOV	_x, W0
	MOV	_x+2, W1
	CALL	__Compare_Le_Fp
	CP0	W0
	CLR.B	W0
	BRA GE	L__main7
	INC.B	W0
L__main7:
	CP0.B	W0
	BRA NZ	L__main8
	GOTO	L_main3
L__main8:
;project.c,45 :: 		x1=x * 3.14 / 127.0;
	MOV	_x, W0
	MOV	_x+2, W1
	MOV	#62915, W2
	MOV	#16456, W3
	CALL	__Mul_FP
	MOV	#0, W2
	MOV	#17150, W3
	CALL	__Div_FP
	MOV	W0, _x1
	MOV	W1, _x1+2
;project.c,46 :: 		y=30 + 30* x1;
	MOV	#0, W2
	MOV	#16880, W3
	CALL	__Mul_FP
	MOV	#0, W2
	MOV	#16880, W3
	CALL	__AddSub_FP
	MOV	W0, _y
	MOV	W1, _y+2
;project.c,47 :: 		x+=dx;
	MOV	_x, W2
	MOV	_x+2, W3
	MOV	_dx, W0
	MOV	_dx+2, W1
	CALL	__AddSub_FP
	MOV	W0, _x
	MOV	W1, _x+2
;project.c,48 :: 		Delay_ms(100);
	MOV	#2, W8
	MOV	#17796, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	DEC	W8
	BRA NZ	L_main4
	NOP
	NOP
;project.c,49 :: 		Glcd_Dot(x, y, 1);
	MOV	_y, W0
	MOV	_y+2, W1
	CALL	__Float2Longint
	MOV.B	W0, [W14+0]
	MOV	_x, W0
	MOV	_x+2, W1
	CALL	__Float2Longint
	MOV.B	#1, W12
	MOV.B	[W14+0], W1
	MOV.B	W1, W11
	MOV.B	W0, W10
	CALL	_Glcd_Dot
;project.c,50 :: 		}
	GOTO	L_main2
L_main3:
;project.c,51 :: 		}
	GOTO	L_main0
;project.c,52 :: 		}
L_end_main:
	ULNK
L__main9:
	BRA	L__main9
; end of _main
