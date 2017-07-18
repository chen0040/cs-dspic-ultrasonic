#line 1 "D:/dsPIC/dsPic/mikroC/Uart/project.c"
char rx1;

void main() {



 Uart1_Init(9600);
 Delay_ms(100);

 rx1 = Uart1_Read();

 Uart1_Write('s');

 while(1)
 {
 if(Uart1_Data_Ready())
 {
 rx1=Uart1_Read();

 Uart1_Write(rx1);
 }
 }
}
