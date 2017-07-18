
_MySoft_UART_Write:

;project.c,9 :: 		void MySoft_UART_Write(char* message)
;project.c,11 :: 		MySoftUSARTWrite_MessageLen=strlen(message);
	CALL	_strlen
	MOV	W0, _MySoftUSARTWrite_MessageLen
;project.c,12 :: 		for(MySoftUSARTWrite_MessageIdx=0; MySoftUSARTWrite_MessageIdx < MySoftUSARTWrite_MessageLen; MySoftUSARTWrite_MessageIdx++)
	CLR	W0
	MOV	W0, _MySoftUSARTWrite_MessageIdx
L_MySoft_UART_Write0:
	MOV	_MySoftUSARTWrite_MessageIdx, W1
	MOV	#lo_addr(_MySoftUSARTWrite_MessageLen), W0
	CP	W1, [W0]
	BRA LT	L__MySoft_UART_Write70
	GOTO	L_MySoft_UART_Write1
L__MySoft_UART_Write70:
;project.c,14 :: 		Soft_UART_Write(message[MySoftUSARTWrite_MessageIdx]);
	MOV	#lo_addr(_MySoftUSARTWrite_MessageIdx), W0
	ADD	W10, [W0], W0
	PUSH	W10
	MOV.B	[W0], W10
	CALL	_Soft_UART_Write
	POP	W10
;project.c,12 :: 		for(MySoftUSARTWrite_MessageIdx=0; MySoftUSARTWrite_MessageIdx < MySoftUSARTWrite_MessageLen; MySoftUSARTWrite_MessageIdx++)
	MOV	#1, W1
	MOV	#lo_addr(_MySoftUSARTWrite_MessageIdx), W0
	ADD	W1, [W0], [W0]
;project.c,15 :: 		}
	GOTO	L_MySoft_UART_Write0
L_MySoft_UART_Write1:
;project.c,16 :: 		}
L_end_MySoft_UART_Write:
	RETURN
; end of _MySoft_UART_Write

_Timer1Int:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;project.c,18 :: 		void Timer1Int() iv IVT_ADDR_T1INTERRUPT {      // Timer interrupt, sample with 40kHz
;project.c,19 :: 		LATC = ~PORTC;                                // invert PortC for generating signal
	MOV	#lo_addr(LATC), W1
	MOV	PORTC, WREG
	COM	W0, [W1]
;project.c,20 :: 		IFS0.T1IF = 0;                                // clear interrupt flag
	BCLR	IFS0, #3
;project.c,21 :: 		}
L_end_Timer1Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _Timer1Int

_InitPort:

;project.c,23 :: 		void InitPort(void) {                           // function for initialization of I/O PORTS
;project.c,24 :: 		ADPCFG = 0xFEFF;                              // Configure AN pins as digital except PinB8
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;project.c,25 :: 		TRISC = 0x0000;                               // set PORTC as output
	CLR	TRISC
;project.c,26 :: 		PORTC = 0x2000;                               // default value of PORTC
	MOV	#8192, W0
	MOV	WREG, PORTC
;project.c,27 :: 		TRISB.B8 = 1;                                 // set PinB8 as input
	BSET	TRISB, #8
;project.c,28 :: 		}
L_end_InitPort:
	RETURN
; end of _InitPort

_InitTimer:

;project.c,30 :: 		void InitTimer(void) {                          // Initialization of Timer1
;project.c,31 :: 		T1CON.B5 = 0;                                 // prescaler 1:1
	BCLR	T1CON, #5
;project.c,32 :: 		T1CON.B4 = 0;
	BCLR	T1CON, #4
;project.c,33 :: 		PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
	CALL	_Get_Fosc_kHz
	MOV	#1000, W2
	MOV	#0, W3
	CALL	__Multiply_32x32
	MOV	#57856, W2
	MOV	#4, W3
	CLR	W4
	CALL	__Divide_32x32
	MOV	W0, PR1
;project.c,34 :: 		TON_bit = 1;                                  // start Timer1
	BSET	TON_bit, #15
;project.c,35 :: 		}
L_end_InitTimer:
	RETURN
; end of _InitTimer

_InitDelay:

;project.c,37 :: 		void InitDelay(void) {                          // Initialization of Timer2
;project.c,38 :: 		T2CON.B5 = 0;                                 // prescaler 1:8
	BCLR	T2CON, #5
;project.c,39 :: 		T2CON.B4 = 1;
	BSET	T2CON, #4
;project.c,40 :: 		TMR2 = 0x0000;                                // Initial value of TMR2 register
	CLR	TMR2
;project.c,41 :: 		T2CON.TON = 1;                                // start Timer2
	BSET	T2CON, #15
;project.c,42 :: 		}
L_end_InitDelay:
	RETURN
; end of _InitDelay

_InitADC:

;project.c,44 :: 		void InitADC(void) {                            // Initialization of ADC module
;project.c,45 :: 		ADC1_Init();
	CALL	_ADC1_Init
;project.c,46 :: 		}
L_end_InitADC:
	RETURN
; end of _InitADC

_InitVariable:

;project.c,48 :: 		void InitVariable(void) {                       // setting initial values
;project.c,49 :: 		abc = 0;
	CLR	W0
	MOV	W0, _abc
;project.c,50 :: 		temp_old = 0;
	CLR	W0
	MOV	W0, _temp_old
;project.c,51 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
;project.c,52 :: 		}
L_end_InitVariable:
	RETURN
; end of _InitVariable

_InitUSART:

;project.c,54 :: 		void InitUSART(void) {                           // Initialization of UART1
;project.c,55 :: 		TRISD = 0;              // Set PORTD as output (error signalization)
	PUSH	W10
	PUSH	W11
	PUSH	W12
	CLR	TRISD
;project.c,56 :: 		LATD = 0;
	CLR	LATD
;project.c,58 :: 		error = Soft_UART_Init(&PORTF, 2, 3, 14400, 0); // Initialize Soft UART at 14400 bps
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
;project.c,59 :: 		if (error > 0) {
	CP.B	W0, #0
	BRA GTU	L__InitUSART78
	GOTO	L_InitUSART3
L__InitUSART78:
;project.c,60 :: 		LATD = error;                                 // Signalize Init error
	MOV	#lo_addr(_error), W0
	ZE	[W0], W0
	MOV	WREG, LATD
;project.c,61 :: 		while(1);                                     // Stop program
L_InitUSART4:
	GOTO	L_InitUSART4
;project.c,62 :: 		}
L_InitUSART3:
;project.c,63 :: 		Delay_ms(100);
	MOV	#11, W8
	MOV	#11309, W7
L_InitUSART6:
	DEC	W7
	BRA NZ	L_InitUSART6
	DEC	W8
	BRA NZ	L_InitUSART6
;project.c,64 :: 		}
L_end_InitUSART:
	POP	W12
	POP	W11
	POP	W10
	RETURN
; end of _InitUSART

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#16
	PUSH	W4
	PUSH	W3

;project.c,66 :: 		void main() {                                   // Main Program
;project.c,68 :: 		InitPort();                                   // Initialization
	PUSH	W10
	PUSH	W11
	CALL	_InitPort
;project.c,69 :: 		InitTimer();
	CALL	_InitTimer
;project.c,70 :: 		InitADC();
	CALL	_InitADC
;project.c,71 :: 		InitUSART();
	CALL	_InitUSART
;project.c,73 :: 		while(1) {                                    // Unending loop
L_main8:
;project.c,76 :: 		IEC0.T1IE = 1;                            // enable T1 interrupt
	BSET	IEC0, #3
;project.c,77 :: 		Delay_us(100);                            // Software PWM lasts 300us
	MOV	#666, W7
L_main10:
	DEC	W7
	BRA NZ	L_main10
	NOP
	NOP
;project.c,78 :: 		IEC0.T1IE = 0;                            // disable T1 interrupt
	BCLR	IEC0, #3
;project.c,81 :: 		Delay_ms(1);                              // wait 1ms so piezzo sattles down
	MOV	#6666, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	NOP
	NOP
;project.c,83 :: 		InitDelay();                              // Start/initialize Timer2 to count Delay
	CALL	_InitDelay
;project.c,85 :: 		temp = ADC1_Get_Sample(8);                // get first two samples
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,86 :: 		Delay_us(1);
	MOV	#6, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	NOP
	NOP
;project.c,87 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,89 :: 		InitVariable();                           // Initialization of Variables
	CALL	_InitVariable
;project.c,91 :: 		while (temp > temp_sec) {                 // check if returned wave is uprising
L_main16:
	MOV	_temp, W1
	MOV	#lo_addr(_temp_sec), W0
	CP	W1, [W0]
	BRA GTU	L__main80
	GOTO	L_main17
L__main80:
;project.c,92 :: 		Delay_us(10);                           //   if not check again in 10us
	MOV	#66, W7
L_main18:
	DEC	W7
	BRA NZ	L_main18
	NOP
	NOP
;project.c,93 :: 		temp = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,94 :: 		Delay_us(1);
	MOV	#6, W7
L_main20:
	DEC	W7
	BRA NZ	L_main20
	NOP
	NOP
;project.c,95 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,96 :: 		}
	GOTO	L_main16
L_main17:
;project.c,98 :: 		while(abc < 1000) {                       // Measure in lenght of 250ms
L_main22:
	MOV	_abc, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA LT	L__main81
	GOTO	L_main23
L__main81:
;project.c,99 :: 		temp = ADC1_Get_Sample(8);              // get sample
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,100 :: 		if (temp > temp_old) {                  // if new value is bigger then old
	MOV	#lo_addr(_temp_old), W1
	CP	W0, [W1]
	BRA GTU	L__main82
	GOTO	L_main24
L__main82:
;project.c,101 :: 		temp_old = temp;                      //   set value of ADC into temporary variable
	MOV	_temp, W0
	MOV	W0, _temp_old
;project.c,102 :: 		time = TMR2;                          //   remember time when value was measured
	MOV	TMR2, WREG
	MOV	W0, _time
;project.c,103 :: 		}
L_main24:
;project.c,104 :: 		abc++;
	MOV	#1, W1
	MOV	#lo_addr(_abc), W0
	ADD	W1, [W0], [W0]
;project.c,105 :: 		Delay_us(50);
	MOV	#333, W7
L_main25:
	DEC	W7
	BRA NZ	L_main25
	NOP
;project.c,106 :: 		}
	GOTO	L_main22
L_main23:
;project.c,107 :: 		T2CON.TON = 0;                            // Stop Timer2
	BCLR	T2CON, #15
;project.c,109 :: 		if (time < 0)                             // absolute value of time
	MOV	_time, W0
	CP	W0, #0
	BRA LTU	L__main83
	GOTO	L_main27
L__main83:
;project.c,110 :: 		time = - time;
	MOV	_time, W1
	MOV	#lo_addr(_time), W0
	SUBR	W1, #0, [W0]
L_main27:
;project.c,113 :: 		if (time < 600)
	MOV	_time, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LTU	L__main84
	GOTO	L_main28
L__main84:
;project.c,114 :: 		distance = time / 40;                   //  40
	MOV	#40, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main29
L_main28:
;project.c,115 :: 		else if ((time > 599) && (time < 1200))
	MOV	_time, W1
	MOV	#599, W0
	CP	W1, W0
	BRA GTU	L__main85
	GOTO	L__main60
L__main85:
	MOV	_time, W1
	MOV	#1200, W0
	CP	W1, W0
	BRA LTU	L__main86
	GOTO	L__main59
L__main86:
L__main58:
;project.c,116 :: 		distance = time / 60;                   //  60
	MOV	#60, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main33
;project.c,115 :: 		else if ((time > 599) && (time < 1200))
L__main60:
L__main59:
;project.c,117 :: 		else if ((time > 1199) && (time < 2800))
	MOV	_time, W1
	MOV	#1199, W0
	CP	W1, W0
	BRA GTU	L__main87
	GOTO	L__main62
L__main87:
	MOV	_time, W1
	MOV	#2800, W0
	CP	W1, W0
	BRA LTU	L__main88
	GOTO	L__main61
L__main88:
L__main57:
;project.c,118 :: 		distance = time / 90;                   //  90
	MOV	#90, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main37
;project.c,117 :: 		else if ((time > 1199) && (time < 2800))
L__main62:
L__main61:
;project.c,119 :: 		else if ((time > 2799) && (time < 7200))
	MOV	_time, W1
	MOV	#2799, W0
	CP	W1, W0
	BRA GTU	L__main89
	GOTO	L__main64
L__main89:
	MOV	_time, W1
	MOV	#7200, W0
	CP	W1, W0
	BRA LTU	L__main90
	GOTO	L__main63
L__main90:
L__main56:
;project.c,120 :: 		distance = time / 110;                  // 110
	MOV	#110, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main41
;project.c,119 :: 		else if ((time > 2799) && (time < 7200))
L__main64:
L__main63:
;project.c,121 :: 		else if ((time > 7199) && (time < 20000))
	MOV	_time, W1
	MOV	#7199, W0
	CP	W1, W0
	BRA GTU	L__main91
	GOTO	L__main66
L__main91:
	MOV	_time, W1
	MOV	#20000, W0
	CP	W1, W0
	BRA LTU	L__main92
	GOTO	L__main65
L__main92:
L__main55:
;project.c,122 :: 		distance = time / 125;                  // 125
	MOV	#125, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main45
;project.c,121 :: 		else if ((time > 7199) && (time < 20000))
L__main66:
L__main65:
;project.c,123 :: 		else if ((time > 19999) && (time < 35000))
	MOV	_time, W1
	MOV	#19999, W0
	CP	W1, W0
	BRA GTU	L__main93
	GOTO	L__main68
L__main93:
	MOV	_time, W1
	MOV	#35000, W0
	CP	W1, W0
	BRA LTU	L__main94
	GOTO	L__main67
L__main94:
L__main54:
;project.c,124 :: 		distance = time / 135;                  // 135
	MOV	#135, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main49
;project.c,123 :: 		else if ((time > 19999) && (time < 35000))
L__main68:
L__main67:
;project.c,126 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
L_main49:
L_main45:
L_main41:
L_main37:
L_main33:
L_main29:
;project.c,128 :: 		if (distance == 0) {                      // if distance is 0 the object is too far
	MOV	_distance, W0
	CP	W0, #0
	BRA Z	L__main95
	GOTO	L_main50
L__main95:
;project.c,129 :: 		MySoft_UART_Write("Too Far");
	ADD	W14, #0, W3
	MOV	#___Lib_System_DefaultPage, W4
	MOV	W4, 52
	MOV	#lo_addr(?ICS?lstr1_project), W4
	REPEAT	#7
	MOV.B	[W4++], [W3++]
	ADD	W14, #0, W0
	MOV	W0, W10
	CALL	_MySoft_UART_Write
;project.c,130 :: 		MySoft_UART_Write("|");
	MOV	#124, W3
	MOV.B	W3, [W14+8]
	MOV	#0, W3
	MOV.B	W3, [W14+9]
	ADD	W14, #8, W0
	MOV	W0, W10
	CALL	_MySoft_UART_Write
;project.c,131 :: 		}
	GOTO	L_main51
L_main50:
;project.c,133 :: 		IntToStr(distance, txt);                // converts time into string
	MOV	#lo_addr(_txt), W11
	MOV	_distance, W10
	CALL	_IntToStr
;project.c,134 :: 		MySoft_UART_Write(txt);
	MOV	#lo_addr(_txt), W10
	CALL	_MySoft_UART_Write
;project.c,135 :: 		MySoft_UART_Write (" cm");               // send value over UART
	MOV	#32, W3
	MOV.B	W3, [W14+10]
	MOV	#99, W3
	MOV.B	W3, [W14+11]
	MOV	#109, W3
	MOV.B	W3, [W14+12]
	MOV	#0, W3
	MOV.B	W3, [W14+13]
	ADD	W14, #10, W0
	MOV	W0, W10
	CALL	_MySoft_UART_Write
;project.c,136 :: 		MySoft_UART_Write("|");
	MOV	#124, W3
	MOV.B	W3, [W14+14]
	MOV	#0, W3
	MOV.B	W3, [W14+15]
	ADD	W14, #14, W0
	MOV	W0, W10
	CALL	_MySoft_UART_Write
;project.c,137 :: 		}
L_main51:
;project.c,139 :: 		Delay_ms(500);                              // delay before next measure
	MOV	#51, W8
	MOV	#56549, W7
L_main52:
	DEC	W7
	BRA NZ	L_main52
	DEC	W8
	BRA NZ	L_main52
;project.c,140 :: 		}
	GOTO	L_main8
;project.c,141 :: 		}
L_end_main:
	POP	W3
	POP	W4
	ULNK
L__main96:
	BRA	L__main96
; end of _main
