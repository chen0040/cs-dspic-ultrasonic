char rx1;

void main() {
     //ADCON1 |= 0x0C; // Configure AN pins as digital
     //U1MODEbits.ALTIO = 1;
     //U1MODEbits.LPBACK = 1;
     Uart1_Init(9600);
     Delay_ms(100);                  // Wait for UART module to stabilize
      //Delay_ms(10);                     // pause for usart lines stabilization
    rx1 = Uart1_Read();          // perform dummy read to clear the register

  Uart1_Write('s');            // signal start
     
     while(1)
     {
      if(Uart1_Data_Ready())
      {
       rx1=Uart1_Read();
       //Delay_ms(100);
       Uart1_Write(rx1);
      }
     }
}
