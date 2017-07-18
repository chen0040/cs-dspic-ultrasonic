#line 1 "D:/dsPIC/dsPic/mikroC/mikroC PRO for dsPIC/distancemeter.c"
#line 44 "D:/dsPIC/dsPic/mikroC/mikroC PRO for dsPIC/distancemeter.c"
const unsigned long SAMPLE_FREQ = 40000;
int abc;
unsigned int temp, temp_sec, temp_old, time, distance;
char txt[6];

void Timer1Int() iv IVT_ADDR_T1INTERRUPT {
 LATC = ~PORTC;
 IFS0.T1IF = 0;
}

void InitPort(void) {
 ADPCFG = 0xFEFF;
 TRISC = 0x0000;
 PORTC = 0x2000;
 TRISB.B8 = 1;
}

void InitTimer(void) {
 T1CON.B5 = 0;
 T1CON.B4 = 0;
 PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
 TON_bit = 1;
}

void InitDelay(void) {
 T2CON.B5 = 0;
 T2CON.B4 = 1;
 TMR2 = 0x0000;
 T2CON.TON = 1;
}

void InitADC(void) {
 ADC1_Init();
}

void InitVariable(void) {
 abc = 0;
 temp_old = 0;
 distance = 0;
}

void InitUART(void) {
 UART1_Init(144000);
 UART1_Write_Text ("Distance Meter 2");
 UART1_Write(13);
 UART1_Write_Text ("Minimum Distance 20cm");
 UART1_Write(13);
 UART1_Write_Text ("Maximum Distance 200cm");
 UART1_Write(13);
 UART1_Write_Text ("Measure precision +-10%");
 UART1_Write(13);
 UART1_Write(13);
 UART1_Write_Text ("Starting measurement");
 UART1_Write(13);
 UART1_Write(13);
 Delay_ms(1200);
}

void main() {

 InitPort();
 InitTimer();
 InitADC();
 InitUART();

 while(1) {


 IEC0.T1IE = 1;
 Delay_us(100);
 IEC0.T1IE = 0;


 Delay_ms(1);

 InitDelay();

 temp = ADC1_Get_Sample(8);
 Delay_us(1);
 temp_sec = ADC1_Get_Sample(8);

 InitVariable();

 while (temp > temp_sec) {
 Delay_us(10);
 temp = ADC1_Get_Sample(8);
 Delay_us(1);
 temp_sec = ADC1_Get_Sample(8);
 }

 while(abc < 1000) {
 temp = ADC1_Get_Sample(8);
 if (temp > temp_old) {
 temp_old = temp;
 time = TMR2;
 }
 abc++;
 Delay_us(50);
 }
 T2CON.TON = 0;

 if (time < 0)
 time = - time;


 if (time < 600)
 distance = time / 40;
 else if ((time > 599) && (time < 1200))
 distance = time / 60;
 else if ((time > 1199) && (time < 2800))
 distance = time / 90;
 else if ((time > 2799) && (time < 7200))
 distance = time / 110;
 else if ((time > 7199) && (time < 20000))
 distance = time / 125;
 else if ((time > 19999) && (time < 35000))
 distance = time / 135;
 else
 distance = 0;

 if (distance == 0) {
 UART1_Write_Text ("Too Far!");
 UART1_Write(13);
 }
 else {
 IntToStr(distance, txt);
 UART1_Write_Text(txt);
 UART1_Write_Text (" cm");
 UART1_Write(13);
 }

 Delay_ms(500);
 }
}
