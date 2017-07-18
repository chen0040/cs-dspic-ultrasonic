/*
 * Project name:
     Soft_UART (Demonstration of using Soft UART library routines)
 * Copyright:
     (c) Mikroelektronika, 2009.
 * Revision History:
     20091106:
       - initial release;
 * Description:
     This code demonstrates how to use software UART library routines.
     Upon receiving data via RS232, MCU immediately sends it back to the sender.
 * Test configuration:
     MCU:             dsPIC30F4013
                      http://ww1.microchip.com/downloads/en/DeviceDoc/70138F.pdf
     Dev.Board:       EasydsPIC6
                      http://www.mikroe.com/eng/products/view/434/easydspic6-development-system/
     Oscillator:      XT-PLL8, 10.000MHz
     Ext. Modules:    None
     SW:              mikroC PRO for dsPIC30/33 and PIC24
                      http://www.mikroe.com/eng/products/view/231/mikroc-pro-for-dspic30-33-and-pic24/
 * NOTES:
     - Conect RX and TX UART jumpers on EasydsPIC6 to RF2 and RF3. (board specific)
*/

char i, error, byte_read;  // Auxiliary variables

void main(){

  //in the orignal code, the AD is disabled, but it seems that commenting out the following line does not affect the program
  //ADPCFG = 0xFFFF;

  TRISB = 0;              // Set PORTB as output (error signalization)
  LATB = 0;

  error = Soft_UART_Init(&PORTF, 2, 3, 14400, 0); // Initialize Soft UART at 14400 bps
  if (error > 0) {
    LATB = error;                                 // Signalize Init error
    while(1);                                     // Stop program
  }
  Delay_ms(100);

  for (i = 'z'; i >= 'A'; i--) {                  // Send bytes from 'z' downto 'A'
    Soft_UART_Write(i);
    Delay_ms(100);
  }

  while(1) {                                      // Endless loop
    byte_read = Soft_UART_Read(&error);           // Read byte, then test error flag
    if (error)                                    // If error was detected
      LATB = error;                               //   signal it on PORTB
    else
      Soft_UART_Write(byte_read);                 // If error was not detected, return byte read
    }
}