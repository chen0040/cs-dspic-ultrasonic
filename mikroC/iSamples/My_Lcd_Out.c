sbit Lcd_D4 at LATD4_bit;
sbit Lcd_D5 at LATD5_bit;
sbit Lcd_D6 at LATD6_bit;
sbit Lcd_D7 at LATD7_bit;
sbit Lcd_RS at LATB4_bit;
sbit Lcd_EN at LATB6_bit;

sbit LCD_D4_DIRECTION at TRISD4_bit;
sbit LCD_D5_DIRECTION at TRISD5_bit;
sbit LCD_D6_DIRECTION at TRISD6_bit;
sbit LCD_D7_Direction at TRISD7_bit;
sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB6_bit;

int MyLcdOutLen=0;
int MyLcdOutIdx=0;

void My_Lcd_Out(int row, int col, char* message)
{
 MyLcdOutLen=strlen(message);
 for(MyLcdOutIdx=0; MyLcdOutIdx != MyLcdOutLen; ++MyLcdOutIdx)
 {
  Lcd_Chr(row, col+MyLcdOutIdx, message[MyLcdOutIdx]);
 }
}

char text[6]="Hello";

void main() {
     Lcd_Init();
     Lcd_Cmd(_LCD_CLEAR);
     Lcd_Cmd(_LCD_CURSOR_OFF);
     
     My_Lcd_Out(1, 3, text);
     //Lcd_Out(1, 3, "HelloWorld"); //this line is not working
}