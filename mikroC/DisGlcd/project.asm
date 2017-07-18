
_Timer1Int:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;project.c,78 :: 		void Timer1Int() iv IVT_ADDR_T1INTERRUPT {      // Timer interrupt, sample with 40kHz
;project.c,79 :: 		LATC = ~PORTC;                                // invert PortC for generating signal
	MOV	#lo_addr(LATC), W1
	MOV	PORTC, WREG
	COM	W0, [W1]
;project.c,80 :: 		IFS0.T1IF = 0;                                // clear interrupt flag
	BCLR	IFS0, #3
;project.c,81 :: 		}
L_end_Timer1Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _Timer1Int

_InitPort:

;project.c,83 :: 		void InitPort(void) {                           // function for initialization of I/O PORTS
;project.c,84 :: 		ADPCFG = 0xFEFF;                              // Configure AN pins as digital except PinB8
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;project.c,85 :: 		TRISC = 0x0000;                               // set PORTC as output
	CLR	TRISC
;project.c,86 :: 		PORTC = 0x2000;                               // default value of PORTC
	MOV	#8192, W0
	MOV	WREG, PORTC
;project.c,87 :: 		TRISB.B8 = 1;                                 // set PinB8 as input
	BSET	TRISB, #8
;project.c,88 :: 		}
L_end_InitPort:
	RETURN
; end of _InitPort

_InitTimer:

;project.c,90 :: 		void InitTimer(void) {                          // Initialization of Timer1
;project.c,91 :: 		T1CON.B5 = 0;                                 // prescaler 1:1
	BCLR	T1CON, #5
;project.c,92 :: 		T1CON.B4 = 0;
	BCLR	T1CON, #4
;project.c,93 :: 		PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
	CALL	_Get_Fosc_kHz
	MOV	#1000, W2
	MOV	#0, W3
	CALL	__Multiply_32x32
	MOV	#57856, W2
	MOV	#4, W3
	CLR	W4
	CALL	__Divide_32x32
	MOV	W0, PR1
;project.c,94 :: 		TON_bit = 1;                                  // start Timer1
	BSET	TON_bit, #15
;project.c,95 :: 		}
L_end_InitTimer:
	RETURN
; end of _InitTimer

_InitDelay:

;project.c,97 :: 		void InitDelay(void) {                          // Initialization of Timer2
;project.c,98 :: 		T2CON.B5 = 0;                                 // prescaler 1:8
	BCLR	T2CON, #5
;project.c,99 :: 		T2CON.B4 = 1;
	BSET	T2CON, #4
;project.c,100 :: 		TMR2 = 0x0000;                                // Initial value of TMR2 register
	CLR	TMR2
;project.c,101 :: 		T2CON.TON = 1;                                // start Timer2
	BSET	T2CON, #15
;project.c,102 :: 		}
L_end_InitDelay:
	RETURN
; end of _InitDelay

_InitADC:

;project.c,104 :: 		void InitADC(void) {                            // Initialization of ADC module
;project.c,105 :: 		ADC1_Init();
	CALL	_ADC1_Init
;project.c,106 :: 		}
L_end_InitADC:
	RETURN
; end of _InitADC

_InitVariable:

;project.c,108 :: 		void InitVariable(void) {                       // setting initial values
;project.c,109 :: 		abc = 0;
	CLR	W0
	MOV	W0, _abc
;project.c,110 :: 		temp_old = 0;
	CLR	W0
	MOV	W0, _temp_old
;project.c,111 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
;project.c,112 :: 		}
L_end_InitVariable:
	RETURN
; end of _InitVariable

_InitGLCD:

;project.c,114 :: 		void InitGLCD(void) {                           // Initialization of UART1
;project.c,115 :: 		Glcd_Init();
	CALL	_Glcd_Init
;project.c,118 :: 		}
L_end_InitGLCD:
	RETURN
; end of _InitGLCD

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

;project.c,120 :: 		void main() {                                   // Main Program
;project.c,122 :: 		InitPort();                                   // Initialization
	PUSH	W10
	PUSH	W11
	PUSH	W12
	PUSH	W13
	CALL	_InitPort
;project.c,123 :: 		InitTimer();
	CALL	_InitTimer
;project.c,124 :: 		InitADC();
	CALL	_InitADC
;project.c,125 :: 		InitGLCD();
	CALL	_InitGLCD
;project.c,127 :: 		while(1) {                                    // Unending loop
L_main0:
;project.c,130 :: 		IEC0.T1IE = 1;                            // enable T1 interrupt
	BSET	IEC0, #3
;project.c,131 :: 		Delay_us(100);                            // Software PWM lasts 300us
	MOV	#83, W7
L_main2:
	DEC	W7
	BRA NZ	L_main2
	NOP
;project.c,132 :: 		IEC0.T1IE = 0;                            // disable T1 interrupt
	BCLR	IEC0, #3
;project.c,135 :: 		Delay_ms(1);                              // wait 1ms so piezzo sattles down
	MOV	#833, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	NOP
;project.c,137 :: 		InitDelay();                              // Start/initialize Timer2 to count Delay
	CALL	_InitDelay
;project.c,139 :: 		temp = ADC1_Get_Sample(8);                // get first two samples
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,140 :: 		Delay_us(1);
	NOP
	NOP
;project.c,141 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,143 :: 		InitVariable();                           // Initialization of Variables
	CALL	_InitVariable
;project.c,145 :: 		while (temp > temp_sec) {                 // check if returned wave is uprising
L_main6:
	MOV	_temp, W1
	MOV	#lo_addr(_temp_sec), W0
	CP	W1, [W0]
	BRA GTU	L__main65
	GOTO	L_main7
L__main65:
;project.c,146 :: 		Delay_us(10);                           //   if not check again in 10us
	MOV	#8, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	NOP
;project.c,147 :: 		temp = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,148 :: 		Delay_us(1);
	NOP
	NOP
;project.c,149 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;project.c,150 :: 		}
	GOTO	L_main6
L_main7:
;project.c,152 :: 		while(abc < 1000) {                       // Measure in lenght of 250ms
L_main10:
	MOV	_abc, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA LT	L__main66
	GOTO	L_main11
L__main66:
;project.c,153 :: 		temp = ADC1_Get_Sample(8);              // get sample
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;project.c,154 :: 		if (temp > temp_old) {                  // if new value is bigger then old
	MOV	#lo_addr(_temp_old), W1
	CP	W0, [W1]
	BRA GTU	L__main67
	GOTO	L_main12
L__main67:
;project.c,155 :: 		temp_old = temp;                      //   set value of ADC into temporary variable
	MOV	_temp, W0
	MOV	W0, _temp_old
;project.c,156 :: 		time = TMR2;                          //   remember time when value was measured
	MOV	TMR2, WREG
	MOV	W0, _time
;project.c,157 :: 		}
L_main12:
;project.c,158 :: 		abc++;
	MOV	#1, W1
	MOV	#lo_addr(_abc), W0
	ADD	W1, [W0], [W0]
;project.c,159 :: 		Delay_us(50);
	MOV	#41, W7
L_main13:
	DEC	W7
	BRA NZ	L_main13
	NOP
	NOP
;project.c,160 :: 		}
	GOTO	L_main10
L_main11:
;project.c,161 :: 		T2CON.TON = 0;                            // Stop Timer2
	BCLR	T2CON, #15
;project.c,163 :: 		if (time < 0)                             // absolute value of time
	MOV	_time, W0
	CP	W0, #0
	BRA LTU	L__main68
	GOTO	L_main15
L__main68:
;project.c,164 :: 		time = - time;
	MOV	_time, W1
	MOV	#lo_addr(_time), W0
	SUBR	W1, #0, [W0]
L_main15:
;project.c,167 :: 		if (time < 600)
	MOV	_time, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LTU	L__main69
	GOTO	L_main16
L__main69:
;project.c,168 :: 		distance = time / 40;                   //  40
	MOV	#40, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main17
L_main16:
;project.c,169 :: 		else if ((time > 599) && (time < 1200))
	MOV	_time, W1
	MOV	#599, W0
	CP	W1, W0
	BRA GTU	L__main70
	GOTO	L__main48
L__main70:
	MOV	_time, W1
	MOV	#1200, W0
	CP	W1, W0
	BRA LTU	L__main71
	GOTO	L__main47
L__main71:
L__main46:
;project.c,170 :: 		distance = time / 60;                   //  60
	MOV	#60, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main21
;project.c,169 :: 		else if ((time > 599) && (time < 1200))
L__main48:
L__main47:
;project.c,171 :: 		else if ((time > 1199) && (time < 2800))
	MOV	_time, W1
	MOV	#1199, W0
	CP	W1, W0
	BRA GTU	L__main72
	GOTO	L__main50
L__main72:
	MOV	_time, W1
	MOV	#2800, W0
	CP	W1, W0
	BRA LTU	L__main73
	GOTO	L__main49
L__main73:
L__main45:
;project.c,172 :: 		distance = time / 90;                   //  90
	MOV	#90, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main25
;project.c,171 :: 		else if ((time > 1199) && (time < 2800))
L__main50:
L__main49:
;project.c,173 :: 		else if ((time > 2799) && (time < 7200))
	MOV	_time, W1
	MOV	#2799, W0
	CP	W1, W0
	BRA GTU	L__main74
	GOTO	L__main52
L__main74:
	MOV	_time, W1
	MOV	#7200, W0
	CP	W1, W0
	BRA LTU	L__main75
	GOTO	L__main51
L__main75:
L__main44:
;project.c,174 :: 		distance = time / 110;                  // 110
	MOV	#110, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main29
;project.c,173 :: 		else if ((time > 2799) && (time < 7200))
L__main52:
L__main51:
;project.c,175 :: 		else if ((time > 7199) && (time < 20000))
	MOV	_time, W1
	MOV	#7199, W0
	CP	W1, W0
	BRA GTU	L__main76
	GOTO	L__main54
L__main76:
	MOV	_time, W1
	MOV	#20000, W0
	CP	W1, W0
	BRA LTU	L__main77
	GOTO	L__main53
L__main77:
L__main43:
;project.c,176 :: 		distance = time / 125;                  // 125
	MOV	#125, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main33
;project.c,175 :: 		else if ((time > 7199) && (time < 20000))
L__main54:
L__main53:
;project.c,177 :: 		else if ((time > 19999) && (time < 35000))
	MOV	_time, W1
	MOV	#19999, W0
	CP	W1, W0
	BRA GTU	L__main78
	GOTO	L__main56
L__main78:
	MOV	_time, W1
	MOV	#35000, W0
	CP	W1, W0
	BRA LTU	L__main79
	GOTO	L__main55
L__main79:
L__main42:
;project.c,178 :: 		distance = time / 135;                  // 135
	MOV	#135, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main37
;project.c,177 :: 		else if ((time > 19999) && (time < 35000))
L__main56:
L__main55:
;project.c,180 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
L_main37:
L_main33:
L_main29:
L_main25:
L_main21:
L_main17:
;project.c,182 :: 		if (distance == 0) {                      // if distance is 0 the object is too far
	MOV	_distance, W0
	CP	W0, #0
	BRA Z	L__main80
	GOTO	L_main38
L__main80:
;project.c,183 :: 		GLcd_Write_Text("Too Far!", 10, 0, 1);
	ADD	W14, #0, W3
	MOV	#___Lib_System_DefaultPage, W4
	MOV	W4, 52
	MOV	#lo_addr(?ICS?lstr1_project), W4
	REPEAT	#8
	MOV.B	[W4++], [W3++]
	ADD	W14, #0, W0
	MOV.B	#1, W13
	CLR	W12
	MOV.B	#10, W11
	MOV	W0, W10
	CALL	_Glcd_Write_Text
;project.c,185 :: 		}
	GOTO	L_main39
L_main38:
;project.c,187 :: 		IntToStr(distance, txt);                // converts time into string
	MOV	#lo_addr(_txt), W11
	MOV	_distance, W10
	CALL	_IntToStr
;project.c,188 :: 		GLcd_Write_Text(txt, 10, 0, 1);
	MOV.B	#1, W13
	CLR	W12
	MOV.B	#10, W11
	MOV	#lo_addr(_txt), W10
	CALL	_Glcd_Write_Text
;project.c,190 :: 		GLcd_Write_Text (" cm", 100, 0, 1);               // send value over UART
	MOV	#32, W3
	MOV.B	W3, [W14+9]
	MOV	#99, W3
	MOV.B	W3, [W14+10]
	MOV	#109, W3
	MOV.B	W3, [W14+11]
	MOV	#0, W3
	MOV.B	W3, [W14+12]
	ADD	W14, #9, W0
	MOV.B	#1, W13
	CLR	W12
	MOV.B	#100, W11
	MOV	W0, W10
	CALL	_Glcd_Write_Text
;project.c,191 :: 		}
L_main39:
;project.c,193 :: 		Delay_ms(500);                              // delay before next measure
	MOV	#7, W8
	MOV	#23451, W7
L_main40:
	DEC	W7
	BRA NZ	L_main40
	DEC	W8
	BRA NZ	L_main40
	NOP
	NOP
;project.c,194 :: 		}
	GOTO	L_main0
;project.c,195 :: 		}
L_end_main:
	POP	W3
	POP	W4
	ULNK
L__main81:
	BRA	L__main81
; end of _main
