
_MyLcd_Out:

;project.c,65 :: 		void MyLcd_Out(char* text)
;project.c,68 :: 		MyLcdOutLen=strlen(text);
	PUSH	W11
	PUSH	W12
	CALL	_strlen
	MOV	W0, _MyLcdOutLen
;project.c,69 :: 		for(MyLcdOutIdx=0; MyLcdOutIdx != MyLcdOutLen; ++MyLcdOutIdx)
	CLR	W0
	MOV	W0, _MyLcdOutIdx
L_MyLcd_Out0:
	MOV	_MyLcdOutIdx, W1
	MOV	#lo_addr(_MyLcdOutLen), W0
	CP	W1, [W0]
	BRA NZ	L__MyLcd_Out61
	GOTO	L_MyLcd_Out1
L__MyLcd_Out61:
;project.c,71 :: 		Lcd_Chr(MyLcdRow, MyLcdOutIdx+1, text[MyLcdOutIdx]);
	MOV	#lo_addr(_MyLcdOutIdx), W0
	ADD	W10, [W0], W1
	MOV	_MyLcdOutIdx, W0
	INC	W0
	PUSH	W10
	MOV.B	[W1], W12
	MOV	W0, W11
	MOV	_MyLcdRow, W10
	CALL	_Lcd_Chr
	POP	W10
;project.c,69 :: 		for(MyLcdOutIdx=0; MyLcdOutIdx != MyLcdOutLen; ++MyLcdOutIdx)
	MOV	#1, W1
	MOV	#lo_addr(_MyLcdOutIdx), W0
	ADD	W1, [W0], [W0]
;project.c,72 :: 		}
	GOTO	L_MyLcd_Out0
L_MyLcd_Out1:
;project.c,73 :: 		}
L_end_MyLcd_Out:
	POP	W12
	POP	W11
	RETURN
; end of _MyLcd_Out

_Timer1Int:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;project.c,76 :: 		void Timer1Int() iv IVT_ADDR_T1INTERRUPT {      // Timer interrupt, sample with 40kHz
;project.c,77 :: 		LATC = ~PORTC;                                // invert PortC for generating signal
	MOV	#lo_addr(LATC), W1
	MOV	PORTC, WREG
	COM	W0, [W1]
;project.c,78 :: 		IFS0.T1IF = 0;                                // clear interrupt flag
	BCLR	IFS0, #3
;project.c,79 :: 		}
L_end_Timer1Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _Timer1Int

_InitPort:

;project.c,81 :: 		void InitPort(void) {                           // function for initialization of I/O PORTS
;project.c,82 :: 		ADPCFG = 0xFEFF;                              // Configure AN pins as digital except PinB8
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;project.c,83 :: 		TRISC = 0x0000;                               // set PORTC as output
	CLR	TRISC
;project.c,84 :: 		PORTC = 0x2000;                               // default value of PORTC
	MOV	#8192, W0
	MOV	WREG, PORTC
;project.c,85 :: 		TRISB.B8 = 1;                                 // set PinB8 as input
	BSET	TRISB, #8
;project.c,86 :: 		}
L_end_InitPort:
	RETURN
; end of _InitPort

_InitTimer:

;project.c,88 :: 		void InitTimer(void) {                          // Initialization of Timer1
;project.c,89 :: 		T1CON.B5 = 0;                                 // prescaler 1:1
	BCLR	T1CON, #5
;project.c,90 :: 		T1CON.B4 = 0;
	BCLR	T1CON, #4
;project.c,91 :: 		PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
	CALL	_Get_Fosc_kHz
	MOV	#1000, W2
	MOV	#0, W3
	CALL	__Multiply_32x32
	MOV	#57856, W2
	MOV	#4, W3
	CLR	W4
	CALL	__Divide_32x32
	MOV	W0, PR1
;project.c,92 :: 		TON_bit = 1;                                  // start Timer1
	BSET	TON_bit, #15
;project.c,93 :: 		}
L_end_InitTimer:
	RETURN
; end of _InitTimer

_InitDelay:

;project.c,95 :: 		void InitDelay(void) {                          // Initialization of Timer2
;project.c,96 :: 		T2CON.B5 = 0;                                 // prescaler 1:8
	BCLR	T2CON, #5
;project.c,97 :: 		T2CON.B4 = 1;
	BSET	T2CON, #4
;project.c,98 :: 		TMR2 = 0x0000;                                // Initial value of TMR2 register
	CLR	TMR2
;project.c,99 :: 		T2CON.TON = 1;                                // start Timer2
	BSET	T2CON, #15
;project.c,100 :: 		}
L_end_InitDelay:
	RETURN
; end of _InitDelay

_InitADC:

;project.c,102 :: 		void InitADC(void) {                            // Initialization of ADC module
;project.c,103 :: 		ADC1_Init();
	CALL	_ADC1_Init
;project.c,104 :: 		}
L_end_InitADC:
	RETURN
; end of _InitADC

_InitVariable:

;project.c,106 :: 		void InitVariable(void) {                       // setting initial values
;project.c,107 :: 		abc = 0;
	CLR	W0
	MOV	W0, _abc
;project.c,108 :: 		temp_old = 0;
	CLR	W0
	MOV	W0, _temp_old
;project.c,109 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
;project.c,110 :: 		}
L_end_InitVariable:
	RETURN
; end of _InitVariable

_InitLCD:

;project.c,112 :: 		void InitLCD(void) {                           // Initialization of UART1
;project.c,113 :: 		Lcd_Init();
	PUSH	W10
	CALL	_Lcd_Init
;project.c,114 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;project.c,115 :: 		Lcd_Cmd(_LCD_CURSOR_OFF);
	MOV.B	#12, W10
	CALL	_Lcd_Cmd
;project.c,116 :: 		}
L_end_InitLCD:
	POP	W10
	RETURN
; end of _InitLCD

_main:
	MOV	#2048, W15
	MOV	#6142, W0
	MOV	WREG, 32
	MOV	#1, W0
	MOV	WREG, 52
	MOV	#4, W0
	IOR	68
	LNK	#14
	PUSH	W4
	PUSH	W3

;project.c,118 :: 		void main() {                                   // Main Program
;project.c,120 :: 		InitPort();                                   // Initialization
	PUSH	W10
	PUSH	W11
	CALL	_InitPort
;project.c,121 :: 		InitTimer();
	CALL	_InitTimer
;project.c,122 :: 		InitADC();
	CALL	_InitADC
;project.c,123 :: 		InitLCD();
	CALL	_InitLCD
;project.c,125 :: 		while(1) {                                    // Unending loop
L_main3:
;project.c,128 :: 		IEC0.T1IE = 1;                            // enable T1 interrupt
	BSET	IEC0, #3
;project.c,129 :: 		Delay_us(100);                            // Software PWM lasts 300us
	MOV	#83, W7
L_main5:
	DEC	W7
	BRA NZ	L_main5
	NOP
;project.c,130 :: 		IEC0.T1IE = 0;                            // disable T1 interrupt
	BCLR	IEC0, #3
;project.c,133 :: 		Delay_ms(1);                              // wait 1ms so piezzo sattles down
	MOV	#833, W7
L_main7:
	DEC	W7
	BRA NZ	L_main7
	NOP
;project.c,135 :: 		InitDelay();                              // Start/initialize Timer2 to count Delay
	CALL	_InitDelay
;project.c,137 :: 		temp = ADC1_Get_Sample(8);                // get first two samples
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,138 :: 		Delay_us(1);
	NOP
	NOP
;project.c,139 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,141 :: 		InitVariable();                           // Initialization of Variables
	CALL	_InitVariable
;project.c,143 :: 		while (temp > temp_sec) {                 // check if returned wave is uprising
L_main9:
	MOV	_temp, W1
	MOV	#lo_addr(_temp_sec), W0
	CP	W1, [W0]
	BRA GTU	L__main70
	GOTO	L_main10
L__main70:
;project.c,144 :: 		Delay_us(10);                           //   if not check again in 10us
	MOV	#8, W7
L_main11:
	DEC	W7
	BRA NZ	L_main11
	NOP
;project.c,145 :: 		temp = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,146 :: 		Delay_us(1);
	NOP
	NOP
;project.c,147 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,148 :: 		}
	GOTO	L_main9
L_main10:
;project.c,150 :: 		while(abc < 1000) {                       // Measure in lenght of 250ms
L_main13:
	MOV	_abc, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA LT	L__main71
	GOTO	L_main14
L__main71:
;project.c,151 :: 		temp = ADC1_Get_Sample(8);              // get sample
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,152 :: 		if (temp > temp_old) {                  // if new value is bigger then old
	MOV	#lo_addr(_temp_old), W1
	CP	W0, [W1]
	BRA GTU	L__main72
	GOTO	L_main15
L__main72:
;project.c,153 :: 		temp_old = temp;                      //   set value of ADC into temporary variable
	MOV	_temp, W0
	MOV	W0, _temp_old
;project.c,154 :: 		time = TMR2;                          //   remember time when value was measured
	MOV	TMR2, WREG
	MOV	W0, _time
;project.c,155 :: 		}
L_main15:
;project.c,156 :: 		abc++;
	MOV	#1, W1
	MOV	#lo_addr(_abc), W0
	ADD	W1, [W0], [W0]
;project.c,157 :: 		Delay_us(50);
	MOV	#41, W7
L_main16:
	DEC	W7
	BRA NZ	L_main16
	NOP
	NOP
;project.c,158 :: 		}
	GOTO	L_main13
L_main14:
;project.c,159 :: 		T2CON.TON = 0;                            // Stop Timer2
	BCLR	T2CON, #15
;project.c,161 :: 		if (time < 0)                             // absolute value of time
	MOV	_time, W0
	CP	W0, #0
	BRA LTU	L__main73
	GOTO	L_main18
L__main73:
;project.c,162 :: 		time = - time;
	MOV	_time, W1
	MOV	#lo_addr(_time), W0
	SUBR	W1, #0, [W0]
L_main18:
;project.c,165 :: 		if (time < 600)
	MOV	_time, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LTU	L__main74
	GOTO	L_main19
L__main74:
;project.c,166 :: 		distance = time / 40;                   //  40
	MOV	#40, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main20
L_main19:
;project.c,167 :: 		else if ((time > 599) && (time < 1200))
	MOV	_time, W1
	MOV	#599, W0
	CP	W1, W0
	BRA GTU	L__main75
	GOTO	L__main51
L__main75:
	MOV	_time, W1
	MOV	#1200, W0
	CP	W1, W0
	BRA LTU	L__main76
	GOTO	L__main50
L__main76:
L__main49:
;project.c,168 :: 		distance = time / 60;                   //  60
	MOV	#60, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main24
;project.c,167 :: 		else if ((time > 599) && (time < 1200))
L__main51:
L__main50:
;project.c,169 :: 		else if ((time > 1199) && (time < 2800))
	MOV	_time, W1
	MOV	#1199, W0
	CP	W1, W0
	BRA GTU	L__main77
	GOTO	L__main53
L__main77:
	MOV	_time, W1
	MOV	#2800, W0
	CP	W1, W0
	BRA LTU	L__main78
	GOTO	L__main52
L__main78:
L__main48:
;project.c,170 :: 		distance = time / 90;                   //  90
	MOV	#90, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main28
;project.c,169 :: 		else if ((time > 1199) && (time < 2800))
L__main53:
L__main52:
;project.c,171 :: 		else if ((time > 2799) && (time < 7200))
	MOV	_time, W1
	MOV	#2799, W0
	CP	W1, W0
	BRA GTU	L__main79
	GOTO	L__main55
L__main79:
	MOV	_time, W1
	MOV	#7200, W0
	CP	W1, W0
	BRA LTU	L__main80
	GOTO	L__main54
L__main80:
L__main47:
;project.c,172 :: 		distance = time / 110;                  // 110
	MOV	#110, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main32
;project.c,171 :: 		else if ((time > 2799) && (time < 7200))
L__main55:
L__main54:
;project.c,173 :: 		else if ((time > 7199) && (time < 20000))
	MOV	_time, W1
	MOV	#7199, W0
	CP	W1, W0
	BRA GTU	L__main81
	GOTO	L__main57
L__main81:
	MOV	_time, W1
	MOV	#20000, W0
	CP	W1, W0
	BRA LTU	L__main82
	GOTO	L__main56
L__main82:
L__main46:
;project.c,174 :: 		distance = time / 125;                  // 125
	MOV	#125, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main36
;project.c,173 :: 		else if ((time > 7199) && (time < 20000))
L__main57:
L__main56:
;project.c,175 :: 		else if ((time > 19999) && (time < 35000))
	MOV	_time, W1
	MOV	#19999, W0
	CP	W1, W0
	BRA GTU	L__main83
	GOTO	L__main59
L__main83:
	MOV	_time, W1
	MOV	#35000, W0
	CP	W1, W0
	BRA LTU	L__main84
	GOTO	L__main58
L__main84:
L__main45:
;project.c,176 :: 		distance = time / 135;                  // 135
	MOV	#135, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main40
;project.c,175 :: 		else if ((time > 19999) && (time < 35000))
L__main59:
L__main58:
;project.c,178 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
L_main40:
L_main36:
L_main32:
L_main28:
L_main24:
L_main20:
;project.c,180 :: 		if (distance == 0) {                      // if distance is 0 the object is too far
	MOV	_distance, W0
	CP	W0, #0
	BRA Z	L__main85
	GOTO	L_main41
L__main85:
;project.c,181 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;project.c,182 :: 		MyLcd_Out ("Too Far!");          // send value over UART
	ADD	W14, #0, W3
	MOV	#___Lib_System_DefaultPage, W4
	MOV	W4, 52
	MOV	#lo_addr(?ICS?lstr1_project), W4
	REPEAT	#8
	MOV.B	[W4++], [W3++]
	ADD	W14, #0, W0
	MOV	W0, W10
	CALL	_MyLcd_Out
;project.c,183 :: 		}
	GOTO	L_main42
L_main41:
;project.c,185 :: 		IntToStr(distance, txt);                // converts time into string
	MOV	#lo_addr(_txt), W11
	MOV	_distance, W10
	CALL	_IntToStr
;project.c,186 :: 		Lcd_Cmd(_LCD_CLEAR);
	MOV.B	#1, W10
	CALL	_Lcd_Cmd
;project.c,187 :: 		MyLcd_Out(txt);                  // send value over UART
	MOV	#lo_addr(_txt), W10
	CALL	_MyLcd_Out
;project.c,188 :: 		MyLcd_Out (" cm");               // send value over UART
	MOV	#32, W3
	MOV.B	W3, [W14+9]
	MOV	#99, W3
	MOV.B	W3, [W14+10]
	MOV	#109, W3
	MOV.B	W3, [W14+11]
	MOV	#0, W3
	MOV.B	W3, [W14+12]
	ADD	W14, #9, W0
	MOV	W0, W10
	CALL	_MyLcd_Out
;project.c,189 :: 		}
L_main42:
;project.c,191 :: 		Delay_ms(500);                              // delay before next measure
	MOV	#7, W8
	MOV	#23451, W7
L_main43:
	DEC	W7
	BRA NZ	L_main43
	DEC	W8
	BRA NZ	L_main43
	NOP
	NOP
;project.c,192 :: 		}
	GOTO	L_main3
;project.c,193 :: 		}
L_end_main:
	POP	W3
	POP	W4
	ULNK
L__main86:
	BRA	L__main86
; end of _main
