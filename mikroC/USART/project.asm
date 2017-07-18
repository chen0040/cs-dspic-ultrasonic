
_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68

;project.c,27 :: 		void main(){
;project.c,32 :: 		TRISB = 0;              // Set PORTB as output (error signalization)
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	TRISB
;project.c,33 :: 		LATB = 0;
	CLR	LATB
;project.c,35 :: 		error = Soft_UART_Init(&PORTF, 2, 3, 14400, 0); // Initialize Soft UART at 14400 bps
	MOV	#3, W12
	MOV	#2, W11
	MOV	#lo_addr(PORTF), W10
	CLR	W0
	PUSH	W0
	MOV	#14400, W0
	MOV	#0, W1
	PUSH.D	W0
	CALL	_Soft_UART_Init
	SUB	#6, W15
	MOV	#lo_addr(_error), W1
	MOV.B	W0, [W1]
;project.c,36 :: 		if (error > 0) {
	CP.B	W0, #0
	BRA GTU	L__main15
	GOTO	L_main0
L__main15:
;project.c,37 :: 		LATB = error;                                 // Signalize Init error
	MOV	#lo_addr(_error), W0
	ZE	[W0], W0
	MOV	WREG, LATB
;project.c,38 :: 		while(1);                                     // Stop program
L_main1:
	GOTO	L_main1
;project.c,39 :: 		}
L_main0:
;project.c,40 :: 		Delay_ms(100);
	MOV	#11, W8
	MOV	#11309, W7
L_main3:
	DEC	W7
	BRA NZ	L_main3
	DEC	W8
	BRA NZ	L_main3
;project.c,42 :: 		for (i = 'z'; i >= 'A'; i--) {                  // Send bytes from 'z' downto 'A'
	MOV	#lo_addr(_i), W1
	MOV.B	#122, W0
	MOV.B	W0, [W1]
L_main5:
	MOV	#lo_addr(_i), W0
	MOV.B	[W0], W1
	MOV.B	#65, W0
	CP.B	W1, W0
	BRA GEU	L__main16
	GOTO	L_main6
L__main16:
;project.c,43 :: 		Soft_UART_Write(i);
	MOV	#lo_addr(_i), W0
	MOV.B	[W0], W10
	CALL	_Soft_UART_Write
;project.c,44 :: 		Delay_ms(100);
	MOV	#11, W8
	MOV	#11309, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	DEC	W8
	BRA NZ	L_main8
;project.c,42 :: 		for (i = 'z'; i >= 'A'; i--) {                  // Send bytes from 'z' downto 'A'
	MOV.B	#1, W1
	MOV	#lo_addr(_i), W0
	SUBR.B	W1, [W0], [W0]
;project.c,45 :: 		}
	GOTO	L_main5
L_main6:
;project.c,47 :: 		while(1) {                                      // Endless loop
L_main10:
;project.c,48 :: 		byte_read = Soft_UART_Read(&error);           // Read byte, then test error flag
	MOV	#lo_addr(_error), W10
	CALL	_Soft_UART_Read
	MOV	#lo_addr(_byte_read), W1
	MOV.B	W0, [W1]
;project.c,49 :: 		if (error)                                    // If error was detected
	MOV	#lo_addr(_error), W0
	CP0.B	[W0]
	BRA NZ	L__main17
	GOTO	L_main12
L__main17:
;project.c,50 :: 		LATB = error;                               //   signal it on PORTB
	MOV	#lo_addr(_error), W0
	ZE	[W0], W0
	MOV	WREG, LATB
	GOTO	L_main13
L_main12:
;project.c,52 :: 		Soft_UART_Write(byte_read);                 // If error was not detected, return byte read
	MOV	#lo_addr(_byte_read), W0
	MOV.B	[W0], W10
	CALL	_Soft_UART_Write
L_main13:
;project.c,53 :: 		}
	GOTO	L_main10
;project.c,54 :: 		}
L_end_main:
L__main18:
	BRA	L__main18
; end of _main
