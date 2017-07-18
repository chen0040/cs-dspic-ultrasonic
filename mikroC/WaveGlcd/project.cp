#line 1 "D:/dsPIC/dsPic/mikroC/WaveGlcd/project.c"
sbit GLCD_D0 at LATD0_bit;
sbit GLCD_D1 at LATD1_bit;
sbit GLCD_D2 at LATD2_bit;
sbit GLCD_D3 at LATD3_bit;
sbit GLCD_D4 at LATD4_bit;
sbit GLCD_D5 at LATD5_bit;
sbit GLCD_D6 at LATD6_bit;
sbit GLCD_D7 at LATD7_bit;
sbit GLCD_D0_Direction at TRISD0_bit;
sbit GLCD_D1_Direction at TRISD1_bit;
sbit GLCD_D2_Direction at TRISD2_bit;
sbit GLCD_D3_Direction at TRISD3_bit;
sbit GLCD_D4_Direction at TRISD4_bit;
sbit GLCD_D5_Direction at TRISD5_bit;
sbit GLCD_D6_Direction at TRISD6_bit;
sbit GLCD_D7_Direction at TRISD7_bit;

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

double x=0;
double y=0;
double x1=0;
double dx=1;

void main() {
 Glcd_Init();

 while(1)
 {
 Glcd_Fill(0x00);
 x=0;
 while(x < 127)
 {
 x1=x * 3.14 / 127.0;
 y=30 + 30* x1;
 x+=dx;
 Delay_ms(100);
 Glcd_Dot(x, y, 1);
 }
 }
}
