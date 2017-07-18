
_Timer1Int:
	PUSH	RCOUNT
	PUSH	W0
	MOV	#2, W0
	REPEAT	#12
	PUSH	[W0++]

;distancemeter.c,49 :: 		void Timer1Int() iv IVT_ADDR_T1INTERRUPT {      // Timer interrupt, sample with 40kHz
;distancemeter.c,50 :: 		LATC = ~PORTC;                                // invert PortC for generating signal
	MOV	#lo_addr(LATC), W1
	MOV	PORTC, WREG
	COM	W0, [W1]
;distancemeter.c,51 :: 		IFS0.T1IF = 0;                                // clear interrupt flag
	BCLR	IFS0, #3
;distancemeter.c,52 :: 		}
L_end_Timer1Int:
	MOV	#26, W0
	REPEAT	#12
	POP	[W0--]
	POP	W0
	POP	RCOUNT
	RETFIE
; end of _Timer1Int

_InitPort:

;distancemeter.c,54 :: 		void InitPort(void) {                           // function for initialization of I/O PORTS
;distancemeter.c,55 :: 		ADPCFG = 0xFEFF;                              // Configure AN pins as digital except PinB8
	MOV	#65279, W0
	MOV	WREG, ADPCFG
;distancemeter.c,56 :: 		TRISC = 0x0000;                               // set PORTC as output
	CLR	TRISC
;distancemeter.c,57 :: 		PORTC = 0x2000;                               // default value of PORTC
	MOV	#8192, W0
	MOV	WREG, PORTC
;distancemeter.c,58 :: 		TRISB.B8 = 1;                                 // set PinB8 as input
	BSET	TRISB, #8
;distancemeter.c,59 :: 		}
L_end_InitPort:
	RETURN
; end of _InitPort

_InitTimer:

;distancemeter.c,61 :: 		void InitTimer(void) {                          // Initialization of Timer1
;distancemeter.c,62 :: 		T1CON.B5 = 0;                                 // prescaler 1:1
	BCLR	T1CON, #5
;distancemeter.c,63 :: 		T1CON.B4 = 0;
	BCLR	T1CON, #4
;distancemeter.c,64 :: 		PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
	CALL	_Get_Fosc_kHz
	MOV	#1000, W2
	MOV	#0, W3
	CALL	__Multiply_32x32
	MOV	#57856, W2
	MOV	#4, W3
	CLR	W4
	CALL	__Divide_32x32
	MOV	W0, PR1
;distancemeter.c,65 :: 		TON_bit = 1;                                  // start Timer1
	BSET	TON_bit, #15
;distancemeter.c,66 :: 		}
L_end_InitTimer:
	RETURN
; end of _InitTimer

_InitDelay:

;distancemeter.c,68 :: 		void InitDelay(void) {                          // Initialization of Timer2
;distancemeter.c,69 :: 		T2CON.B5 = 0;                                 // prescaler 1:8
	BCLR	T2CON, #5
;distancemeter.c,70 :: 		T2CON.B4 = 1;
	BSET	T2CON, #4
;distancemeter.c,71 :: 		TMR2 = 0x0000;                                // Initial value of TMR2 register
	CLR	TMR2
;distancemeter.c,72 :: 		T2CON.TON = 1;                                // start Timer2
	BSET	T2CON, #15
;distancemeter.c,73 :: 		}
L_end_InitDelay:
	RETURN
; end of _InitDelay

_InitADC:

;distancemeter.c,75 :: 		void InitADC(void) {                            // Initialization of ADC module
;distancemeter.c,76 :: 		ADC1_Init();
	CALL	_ADC1_Init
;distancemeter.c,77 :: 		}
L_end_InitADC:
	RETURN
; end of _InitADC

_InitVariable:

;distancemeter.c,79 :: 		void InitVariable(void) {                       // setting initial values
;distancemeter.c,80 :: 		abc = 0;
	CLR	W0
	MOV	W0, _abc
;distancemeter.c,81 :: 		temp_old = 0;
	CLR	W0
	MOV	W0, _temp_old
;distancemeter.c,82 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
;distancemeter.c,83 :: 		}
L_end_InitVariable:
	RETURN
; end of _InitVariable

_InitUART:
	LNK	#108
	PUSH	W2
	PUSH	W1

;distancemeter.c,85 :: 		void InitUART(void) {                           // Initialization of UART1
;distancemeter.c,86 :: 		UART1_Init(144000);
	PUSH	W10
	PUSH	W11
	MOV	#12928, W10
	MOV	#2, W11
	CALL	_UART1_Init
;distancemeter.c,87 :: 		UART1_Write_Text ("Distance Meter 2");        // send value over UART
	ADD	W14, #0, W1
	MOV	#___Lib_System_DefaultPage, W2
	MOV	W2, 52
	MOV	#lo_addr(?ICS?lstr1_distancemeter), W2
	REPEAT	#16
	MOV.B	[W2++], [W1++]
	ADD	W14, #0, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,88 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,89 :: 		UART1_Write_Text ("Minimum Distance 20cm");   // send value over UART
	ADD	W14, #17, W1
	MOV	#___Lib_System_DefaultPage, W2
	MOV	W2, 52
	MOV	#lo_addr(?ICS?lstr2_distancemeter), W2
	REPEAT	#21
	MOV.B	[W2++], [W1++]
	ADD	W14, #17, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,90 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,91 :: 		UART1_Write_Text ("Maximum Distance 200cm");  // send value over UART
	MOV	#39, W1
	ADD	W14, W1, W1
	MOV	#___Lib_System_DefaultPage, W2
	MOV	W2, 52
	MOV	#lo_addr(?ICS?lstr3_distancemeter), W2
	REPEAT	#22
	MOV.B	[W2++], [W1++]
	MOV	#39, W0
	ADD	W14, W0, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,92 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,93 :: 		UART1_Write_Text ("Measure precision +-10%"); // send value over UART
	MOV	#62, W1
	ADD	W14, W1, W1
	MOV	#___Lib_System_DefaultPage, W2
	MOV	W2, 52
	MOV	#lo_addr(?ICS?lstr4_distancemeter), W2
	REPEAT	#23
	MOV.B	[W2++], [W1++]
	MOV	#62, W0
	ADD	W14, W0, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,94 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,95 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,96 :: 		UART1_Write_Text ("Starting measurement");    // send value over UART
	MOV	#86, W1
	ADD	W14, W1, W1
	MOV	#___Lib_System_DefaultPage, W2
	MOV	W2, 52
	MOV	#lo_addr(?ICS?lstr5_distancemeter), W2
	REPEAT	#20
	MOV.B	[W2++], [W1++]
	MOV	#86, W0
	ADD	W14, W0, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,97 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,98 :: 		UART1_Write(13);                              // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,99 :: 		Delay_ms(1200);
	MOV	#123, W8
	MOV	#4647, W7
L_InitUART0:
	DEC	W7
	BRA NZ	L_InitUART0
	DEC	W8
	BRA NZ	L_InitUART0
	NOP
	NOP
;distancemeter.c,100 :: 		}
L_end_InitUART:
	POP	W11
	POP	W10
	POP	W1
	POP	W2
	ULNK
	RETURN
; end of _InitUART

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

;distancemeter.c,102 :: 		void main() {                                   // Main Program
;distancemeter.c,104 :: 		InitPort();                                   // Initialization
	PUSH	W10
	PUSH	W11
	CALL	_InitPort
;distancemeter.c,105 :: 		InitTimer();
	CALL	_InitTimer
;distancemeter.c,106 :: 		InitADC();
	CALL	_InitADC
;distancemeter.c,107 :: 		InitUART();
	CALL	_InitUART
;distancemeter.c,109 :: 		while(1) {                                    // Unending loop
L_main2:
;distancemeter.c,112 :: 		IEC0.T1IE = 1;                            // enable T1 interrupt
	BSET	IEC0, #3
;distancemeter.c,113 :: 		Delay_us(100);                            // Software PWM lasts 300us
	MOV	#666, W7
L_main4:
	DEC	W7
	BRA NZ	L_main4
	NOP
	NOP
;distancemeter.c,114 :: 		IEC0.T1IE = 0;                            // disable T1 interrupt
	BCLR	IEC0, #3
;distancemeter.c,117 :: 		Delay_ms(1);                              // wait 1ms so piezzo sattles down
	MOV	#6666, W7
L_main6:
	DEC	W7
	BRA NZ	L_main6
	NOP
	NOP
;distancemeter.c,119 :: 		InitDelay();                              // Start/initialize Timer2 to count Delay
	CALL	_InitDelay
;distancemeter.c,121 :: 		temp = ADC1_Get_Sample(8);                // get first two samples
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;distancemeter.c,122 :: 		Delay_us(1);
	MOV	#6, W7
L_main8:
	DEC	W7
	BRA NZ	L_main8
	NOP
	NOP
;distancemeter.c,123 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;distancemeter.c,125 :: 		InitVariable();                           // Initialization of Variables
	CALL	_InitVariable
;distancemeter.c,127 :: 		while (temp > temp_sec) {                 // check if returned wave is uprising
L_main10:
	MOV	_temp, W1
	MOV	#lo_addr(_temp_sec), W0
	CP	W1, [W0]
	BRA GTU	L__main71
	GOTO	L_main11
L__main71:
;distancemeter.c,128 :: 		Delay_us(10);                           //   if not check again in 10us
	MOV	#66, W7
L_main12:
	DEC	W7
	BRA NZ	L_main12
	NOP
	NOP
;distancemeter.c,129 :: 		temp = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;distancemeter.c,130 :: 		Delay_us(1);
	MOV	#6, W7
L_main14:
	DEC	W7
	BRA NZ	L_main14
	NOP
	NOP
;distancemeter.c,131 :: 		temp_sec = ADC1_Get_Sample(8);
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp_sec
;distancemeter.c,132 :: 		}
	GOTO	L_main10
L_main11:
;distancemeter.c,134 :: 		while(abc < 1000) {                       // Measure in lenght of 250ms
L_main16:
	MOV	_abc, W1
	MOV	#1000, W0
	CP	W1, W0
	BRA LT	L__main72
	GOTO	L_main17
L__main72:
;distancemeter.c,135 :: 		temp = ADC1_Get_Sample(8);              // get sample
	MOV	#8, W10
	CALL	_ADC1_Get_Sample
	MOV	W0, _temp
;distancemeter.c,136 :: 		if (temp > temp_old) {                  // if new value is bigger then old
	MOV	#lo_addr(_temp_old), W1
	CP	W0, [W1]
	BRA GTU	L__main73
	GOTO	L_main18
L__main73:
;distancemeter.c,137 :: 		temp_old = temp;                      //   set value of ADC into temporary variable
	MOV	_temp, W0
	MOV	W0, _temp_old
;distancemeter.c,138 :: 		time = TMR2;                          //   remember time when value was measured
	MOV	TMR2, WREG
	MOV	W0, _time
;distancemeter.c,139 :: 		}
L_main18:
;distancemeter.c,140 :: 		abc++;
	MOV	#1, W1
	MOV	#lo_addr(_abc), W0
	ADD	W1, [W0], [W0]
;distancemeter.c,141 :: 		Delay_us(50);
	MOV	#333, W7
L_main19:
	DEC	W7
	BRA NZ	L_main19
	NOP
;distancemeter.c,142 :: 		}
	GOTO	L_main16
L_main17:
;distancemeter.c,143 :: 		T2CON.TON = 0;                            // Stop Timer2
	BCLR	T2CON, #15
;distancemeter.c,145 :: 		if (time < 0)                             // absolute value of time
	MOV	_time, W0
	CP	W0, #0
	BRA LTU	L__main74
	GOTO	L_main21
L__main74:
;distancemeter.c,146 :: 		time = - time;
	MOV	_time, W1
	MOV	#lo_addr(_time), W0
	SUBR	W1, #0, [W0]
L_main21:
;distancemeter.c,149 :: 		if (time < 600)
	MOV	_time, W1
	MOV	#600, W0
	CP	W1, W0
	BRA LTU	L__main75
	GOTO	L_main22
L__main75:
;distancemeter.c,150 :: 		distance = time / 40;                   //  40
	MOV	#40, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main23
L_main22:
;distancemeter.c,151 :: 		else if ((time > 599) && (time < 1200))
	MOV	_time, W1
	MOV	#599, W0
	CP	W1, W0
	BRA GTU	L__main76
	GOTO	L__main54
L__main76:
	MOV	_time, W1
	MOV	#1200, W0
	CP	W1, W0
	BRA LTU	L__main77
	GOTO	L__main53
L__main77:
L__main52:
;distancemeter.c,152 :: 		distance = time / 60;                   //  60
	MOV	#60, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main27
;distancemeter.c,151 :: 		else if ((time > 599) && (time < 1200))
L__main54:
L__main53:
;distancemeter.c,153 :: 		else if ((time > 1199) && (time < 2800))
	MOV	_time, W1
	MOV	#1199, W0
	CP	W1, W0
	BRA GTU	L__main78
	GOTO	L__main56
L__main78:
	MOV	_time, W1
	MOV	#2800, W0
	CP	W1, W0
	BRA LTU	L__main79
	GOTO	L__main55
L__main79:
L__main51:
;distancemeter.c,154 :: 		distance = time / 90;                   //  90
	MOV	#90, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main31
;distancemeter.c,153 :: 		else if ((time > 1199) && (time < 2800))
L__main56:
L__main55:
;distancemeter.c,155 :: 		else if ((time > 2799) && (time < 7200))
	MOV	_time, W1
	MOV	#2799, W0
	CP	W1, W0
	BRA GTU	L__main80
	GOTO	L__main58
L__main80:
	MOV	_time, W1
	MOV	#7200, W0
	CP	W1, W0
	BRA LTU	L__main81
	GOTO	L__main57
L__main81:
L__main50:
;distancemeter.c,156 :: 		distance = time / 110;                  // 110
	MOV	#110, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main35
;distancemeter.c,155 :: 		else if ((time > 2799) && (time < 7200))
L__main58:
L__main57:
;distancemeter.c,157 :: 		else if ((time > 7199) && (time < 20000))
	MOV	_time, W1
	MOV	#7199, W0
	CP	W1, W0
	BRA GTU	L__main82
	GOTO	L__main60
L__main82:
	MOV	_time, W1
	MOV	#20000, W0
	CP	W1, W0
	BRA LTU	L__main83
	GOTO	L__main59
L__main83:
L__main49:
;distancemeter.c,158 :: 		distance = time / 125;                  // 125
	MOV	#125, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main39
;distancemeter.c,157 :: 		else if ((time > 7199) && (time < 20000))
L__main60:
L__main59:
;distancemeter.c,159 :: 		else if ((time > 19999) && (time < 35000))
	MOV	_time, W1
	MOV	#19999, W0
	CP	W1, W0
	BRA GTU	L__main84
	GOTO	L__main62
L__main84:
	MOV	_time, W1
	MOV	#35000, W0
	CP	W1, W0
	BRA LTU	L__main85
	GOTO	L__main61
L__main85:
L__main48:
;distancemeter.c,160 :: 		distance = time / 135;                  // 135
	MOV	#135, W2
	MOV	_time, W0
	REPEAT	#17
	DIV.U	W0, W2
	MOV	W0, _distance
	GOTO	L_main43
;distancemeter.c,159 :: 		else if ((time > 19999) && (time < 35000))
L__main62:
L__main61:
;distancemeter.c,162 :: 		distance = 0;
	CLR	W0
	MOV	W0, _distance
L_main43:
L_main39:
L_main35:
L_main31:
L_main27:
L_main23:
;distancemeter.c,164 :: 		if (distance == 0) {                      // if distance is 0 the object is too far
	MOV	_distance, W0
	CP	W0, #0
	BRA Z	L__main86
	GOTO	L_main44
L__main86:
;distancemeter.c,165 :: 		UART1_Write_Text ("Too Far!");          // send value over UART
	ADD	W14, #0, W3
	MOV	#___Lib_System_DefaultPage, W4
	MOV	W4, 52
	MOV	#lo_addr(?ICS?lstr6_distancemeter), W4
	REPEAT	#8
	MOV.B	[W4++], [W3++]
	ADD	W14, #0, W0
	MOV	W0, W10
	CALL	_UART1_Write_Text
;distancemeter.c,166 :: 		UART1_Write(13);                        // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,167 :: 		}
	GOTO	L_main45
L_main44:
;distancemeter.c,169 :: 		IntToStr(distance, txt);                // converts time into string
	MOV	#lo_addr(_txt), W11
	MOV	_distance, W10
	CALL	_IntToStr
;distancemeter.c,170 :: 		UART1_Write_Text(txt);                  // send value over UART
	MOV	#lo_addr(_txt), W10
	CALL	_UART1_Write_Text
;distancemeter.c,171 :: 		UART1_Write_Text (" cm");               // send value over UART
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
	CALL	_UART1_Write_Text
;distancemeter.c,172 :: 		UART1_Write(13);                        // line feed
	MOV	#13, W10
	CALL	_UART1_Write
;distancemeter.c,173 :: 		}
L_main45:
;distancemeter.c,175 :: 		Delay_ms(500);                              // delay before next measure
	MOV	#51, W8
	MOV	#56549, W7
L_main46:
	DEC	W7
	BRA NZ	L_main46
	DEC	W8
	BRA NZ	L_main46
;distancemeter.c,176 :: 		}
	GOTO	L_main2
;distancemeter.c,177 :: 		}
L_end_main:
	POP	W3
	POP	W4
	ULNK
L__main87:
	BRA	L__main87
; end of _main
