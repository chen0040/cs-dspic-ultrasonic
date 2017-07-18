#line 1 "D:/dsPIC/dsPic/mikroC/USART/project.c"
#line 25 "D:/dsPIC/dsPic/mikroC/USART/project.c"
char i, error, byte_read;

void main(){




 TRISB = 0;
 LATB = 0;

 error = Soft_UART_Init(&PORTF, 2, 3, 14400, 0);
 if (error > 0) {
 LATB = error;
 while(1);
 }
 Delay_ms(100);

 for (i = 'z'; i >= 'A'; i--) {
 Soft_UART_Write(i);
 Delay_ms(100);
 }

 while(1) {
 byte_read = Soft_UART_Read(&error);
 if (error)
 LATB = error;
 else
 Soft_UART_Write(byte_read);
 }
}
