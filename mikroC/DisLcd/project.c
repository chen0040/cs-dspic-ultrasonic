/*
 * Project name:
     UltraSonic Distance Meter on UART
 * Copyright:
     (c) Mikroelektronika, 2010.
  * Revision History
     2010:
    - Initial release;
    - 20101110(RR);
 * Description:
     This code demonstrates working with Distance Meter (MB1100).
     Value read from it is sent over UART.
 * Test configuration:

     mcu:             
                      http://ww1.microchip.com/downloads/en/DeviceDoc/70138F.pdf

     Dev.Board:       ac:EasydsPIC6
                      http://www.mikroe.com/eng/products/view/434/easydspic6-development-system/

     Oscillator:      XT with 8x PLL, 10.0000 MHz

     ext. modules:    
                      http://www.mikroe.com/eng/products/view/438/distance-meter-2-board/

                      
                      http://www.mikroe.com/eng/products/view/439/distance-meter-2-proto-board/

                      ac:SmartADAPT2_Board
                      http://www.mikroe.com/eng/products/view/158/smartadapt2-board/

     SW:              mikroC PRO for dsPIC
                      http://www.mikroe.com/eng/products/view/231/mikroc-pro-for-dspic30-33-and-pic24/

 * NOTES:
     - MCU must work on 80MHz, 10MHz Oscillator and 8x PLL
     - Distance Meter Board needs to be connected to PortB (AN pin to RB8, PWM pins to RC13 and RC14)
       For easier connection use SmartADAPT2 Board, short pins O0 - I0, O9 - I5 and O10 - I6
     - Turn On UART switches (SW7.2 and SW7.6)
     - After programming MCU, hard reset development system
*/

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

const unsigned long SAMPLE_FREQ  = 40000;       // Hz
int abc;
unsigned int temp, temp_sec, temp_old, time, distance;    // global variables
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


void Timer1Int() iv IVT_ADDR_T1INTERRUPT {      // Timer interrupt, sample with 40kHz
  LATC = ~PORTC;                                // invert PortC for generating signal
  IFS0.T1IF = 0;                                // clear interrupt flag
}

void InitPort(void) {                           // function for initialization of I/O PORTS
  ADPCFG = 0xFEFF;                              // Configure AN pins as digital except PinB8
  TRISC = 0x0000;                               // set PORTC as output
  PORTC = 0x2000;                               // default value of PORTC
  TRISB.B8 = 1;                                 // set PinB8 as input
}

void InitTimer(void) {                          // Initialization of Timer1
  T1CON.B5 = 0;                                 // prescaler 1:1
  T1CON.B4 = 0;
  PR1 = (unsigned long)(Get_Fosc_kHz()) * 1000 / (8 * SAMPLE_FREQ);
  TON_bit = 1;                                  // start Timer1
}

void InitDelay(void) {                          // Initialization of Timer2
  T2CON.B5 = 0;                                 // prescaler 1:8
  T2CON.B4 = 1;
  TMR2 = 0x0000;                                // Initial value of TMR2 register
  T2CON.TON = 1;                                // start Timer2
}

void InitADC(void) {                            // Initialization of ADC module
  ADC1_Init();
}

void InitVariable(void) {                       // setting initial values
  abc = 0;
  temp_old = 0;
  distance = 0;
}

void InitLCD(void) {                           // Initialization of UART1
  Lcd_Init();
  Lcd_Cmd(_LCD_CLEAR);
  Lcd_Cmd(_LCD_CURSOR_OFF);
}

void main() {                                   // Main Program

  InitPort();                                   // Initialization
  InitTimer();
  InitADC();
  InitLCD();

  while(1) {                                    // Unending loop

    // start software PWM
    IEC0.T1IE = 1;                            // enable T1 interrupt
    Delay_us(100);                            // Software PWM lasts 300us
    IEC0.T1IE = 0;                            // disable T1 interrupt
    // end software PWM

    Delay_ms(1);                              // wait 1ms so piezzo sattles down

    InitDelay();                              // Start/initialize Timer2 to count Delay

    temp = ADC1_Get_Sample(8);                // get first two samples
    Delay_us(1);
    temp_sec = ADC1_Get_Sample(8);

    InitVariable();                           // Initialization of Variables

    while (temp > temp_sec) {                 // check if returned wave is uprising
      Delay_us(10);                           //   if not check again in 10us
      temp = ADC1_Get_Sample(8);
      Delay_us(1);
      temp_sec = ADC1_Get_Sample(8);
    }

    while(abc < 1000) {                       // Measure in lenght of 250ms
      temp = ADC1_Get_Sample(8);              // get sample
      if (temp > temp_old) {                  // if new value is bigger then old
        temp_old = temp;                      //   set value of ADC into temporary variable
        time = TMR2;                          //   remember time when value was measured
      }
      abc++;
      Delay_us(50);
    }
    T2CON.TON = 0;                            // Stop Timer2

    if (time < 0)                             // absolute value of time
      time = - time;

    // Part for converting time into distance in cm with precision +-10%
    if (time < 600)
      distance = time / 40;                   //  40
    else if ((time > 599) && (time < 1200))
      distance = time / 60;                   //  60
    else if ((time > 1199) && (time < 2800))
      distance = time / 90;                   //  90
    else if ((time > 2799) && (time < 7200))
      distance = time / 110;                  // 110
    else if ((time > 7199) && (time < 20000))
      distance = time / 125;                  // 125
    else if ((time > 19999) && (time < 35000))
      distance = time / 135;                  // 135
    else
      distance = 0;

    if (distance == 0) {                      // if distance is 0 the object is too far
      Lcd_Cmd(_LCD_CLEAR);
      MyLcd_Out ("Too Far!");          // send value over UART
    }
    else {
      IntToStr(distance, txt);                // converts time into string
      Lcd_Cmd(_LCD_CLEAR);
      MyLcd_Out(txt);                  // send value over UART
      MyLcd_Out (" cm");               // send value over UART
    }

    Delay_ms(500);                              // delay before next measure
  }
}