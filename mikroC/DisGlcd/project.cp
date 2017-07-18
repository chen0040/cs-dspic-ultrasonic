#line 1 "D:/dsPIC/dsPic/mikroC/DisGlcd/project.c"
#line 43 "D:/dsPIC/dsPic/mikroC/DisGlcd/project.c"
sbit GLCD_D7 at RD7_bit;
sbit GLCD_D6 at RD6_bit;
sbit GLCD_D5 at RD5_bit;
sbit GLCD_D4 at RD4_bit;
sbit GLCD_D3 at RD3_bit;
sbit GLCD_D2 at RD2_bit;
sbit GLCD_D1 at RD1_bit;
sbit GLCD_D0 at RD0_bit;
sbit GLCD_D7_Direction at TRISD7_bit;
sbit GLCD_D6_Direction at TRISD6_bit;
sbit GLCD_D5_Direction at TRISD5_bit;
sbit GLCD_D4_Direction at TRISD4_bit;
sbit GLCD_D3_Direction at TRISD3_bit;
sbit GLCD_D2_Direction at TRISD2_bit;
sbit GLCD_D1_Direction at TRISD1_bit;
sbit GLCD_D0_Direction at TRISD0_bit;

sbit GLCD_CS1 at LATB2_bit;
sbit GLCD_CS2 at LATB3_bit;
sbit GLCD_RS at LATB4_bit;
sbit GLCD_RW at LATB5_bit;
sbit GLCD_EN at LATB6_bit;
sbit GLCD_RST at LATB7_bit;
sbit GLCD_CS1_Direction at TRISB2_bit;
sbit GLCD_CS2_Direction at TRISB3_bit;
sbit GLCD_RS_Direction at TRISB4_bit;
sbit GLCD_RW_Direction at TRISB5_bit;
sbit GLCD_EN_Direction at TRISB6_bit;
sbit GLCD_RST_Direction at TRISB7_bit;

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

void InitGLCD(void) {
 Glcd_Init();


}

void main() {

 InitPort();
 InitTimer();
 InitADC();
 InitGLCD();

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
 GLcd_Write_Text("Too Far!", 10, 0, 1);

 }
 else {
 IntToStr(distance, txt);
 GLcd_Write_Text(txt, 10, 0, 1);

 GLcd_Write_Text (" cm", 100, 0, 1);
 }

 Delay_ms(500);
 }
}
