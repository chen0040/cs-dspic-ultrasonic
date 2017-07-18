#line 1 "D:/dsPIC/dsPic/mikroC/DisLcd/project.c"
#line 43 "D:/dsPIC/dsPic/mikroC/DisLcd/project.c"
sbit LCD_D4 at LATD4_bit;
sbit LCD_D5 at LATD5_bit;
sbit LCD_D6 at LATD6_bit;
sbit LCD_D7 at LATD7_bit;
sbit LCD_RS at LATB4_bit;
sbit LCD_EN at LATB6_bit;

sbit LCD_D4_Direction at TRISD4_bit;
sbit LCD_D5_Direction at TRISD5_bit;
sbit LCD_D6_Direction at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB6_bit;

const unsigned long SAMPLE_FREQ = 40000;
int abc;
unsigned int temp, temp_sec, temp_old, time, distance;
char txt[6];

int MyLcdOutLen=0;
int MyLcdOutIdx=0;
int MyLcdRow=1;
void MyLcd_Out(char* text)
{

 MyLcdOutLen=strlen(text);
 for(MyLcdOutIdx=0; MyLcdOutIdx != MyLcdOutLen; ++MyLcdOutIdx)
 {
 Lcd_Chr(MyLcdRow, MyLcdOutIdx+1, text[MyLcdOutIdx]);
 }
}


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

void InitLCD(void) {
 Lcd_Init();
 Lcd_Cmd(_LCD_CLEAR);
 Lcd_Cmd(_LCD_CURSOR_OFF);
}

void main() {

 InitPort();
 InitTimer();
 InitADC();
 InitLCD();

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
 Lcd_Cmd(_LCD_CLEAR);
 MyLcd_Out ("Too Far!");
 }
 else {
 IntToStr(distance, txt);
 Lcd_Cmd(_LCD_CLEAR);
 MyLcd_Out(txt);
 MyLcd_Out (" cm");
 }

 Delay_ms(500);
 }
}
