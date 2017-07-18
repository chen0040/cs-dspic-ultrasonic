const unsigned long SAMPLE_FREQ  = 40000;       // Hz
int abc;
unsigned int temp, temp_sec, temp_old, time, distance;    // global variables
char txt[6];
char i, error, byte_read;  // Auxiliary variables
int MySoftUSARTWrite_MessageLen=0;
int MySoftUSARTWrite_MessageIdx=0;

void MySoft_UART_Write(char* message)
{
 MySoftUSARTWrite_MessageLen=strlen(message);
 for(MySoftUSARTWrite_MessageIdx=0; MySoftUSARTWrite_MessageIdx < MySoftUSARTWrite_MessageLen; MySoftUSARTWrite_MessageIdx++)
 {
  Soft_UART_Write(message[MySoftUSARTWrite_MessageIdx]);
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

void InitUSART(void) {                           // Initialization of UART1
  TRISD = 0;              // Set PORTD as output (error signalization)
  LATD = 0;

  error = Soft_UART_Init(&PORTF, 2, 3, 14400, 0); // Initialize Soft UART at 14400 bps
  if (error > 0) {
    LATD = error;                                 // Signalize Init error
    while(1);                                     // Stop program
  }
  Delay_ms(100);
}

void main() {                                   // Main Program

  InitPort();                                   // Initialization
  InitTimer();
  InitADC();
  InitUSART();

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
       MySoft_UART_Write("Too Far");
       MySoft_UART_Write("|");
    }
    else {
      IntToStr(distance, txt);                // converts time into string
      MySoft_UART_Write(txt);
      MySoft_UART_Write (" cm");               // send value over UART
      MySoft_UART_Write("|");
    }

    Delay_ms(500);                              // delay before next measure
  }
}