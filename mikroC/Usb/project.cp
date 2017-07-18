#line 1 "D:/dsPIC/dsPic/mikroC/Usb/project.c"
#line 1 "d:/dspic/dspic/mikroc/usb/usbdsc.c"
const unsigned int USB_VENDOR_ID = 0x1234;
const unsigned int USB_PRODUCT_ID = 0x0001;
const char USB_SELF_POWER = 0x80;
const char USB_MAX_POWER = 50;
const char HID_INPUT_REPORT_BYTES = 64;
const char HID_OUTPUT_REPORT_BYTES = 64;
const char USB_TRANSFER_TYPE = 0x03;
const char EP_IN_INTERVAL = 1;
const char EP_OUT_INTERVAL = 1;

const char USB_INTERRUPT = 1;
const char USB_HID_EP = 1;
const char USB_HID_RPT_SIZE = 33;


const struct {
 char bLength;
 char bDescriptorType;
 unsigned int bcdUSB;
 char bDeviceClass;
 char bDeviceSubClass;
 char bDeviceProtocol;
 char bMaxPacketSize0;
 unsigned int idVendor;
 unsigned int idProduct;
 unsigned int bcdDevice;
 char iManufacturer;
 char iProduct;
 char iSerialNumber;
 char bNumConfigurations;
} device_dsc = {
 0x12,
 0x01,
 0x0200,
 0x00,
 0x00,
 0x00,
 8,
 USB_VENDOR_ID,
 USB_PRODUCT_ID,
 0x0001,
 0x01,
 0x02,
 0x00,
 0x01
 };


const char configDescriptor1[]= {

 0x09,
 0x02,
 0x29,0x00,
 1,
 1,
 0,
 USB_SELF_POWER,
 USB_MAX_POWER,


 0x09,
 0x04,
 0,
 0,
 2,
 0x03,
 0,
 0,
 0,


 0x09,
 0x21,
 0x01,0x01,
 0x00,
 1,
 0x22,
 USB_HID_RPT_SIZE,0x00,


 0x07,
 0x05,
 USB_HID_EP | 0x80,
 USB_TRANSFER_TYPE,
 0x40,0x00,
 EP_IN_INTERVAL,


 0x07,
 0x05,
 USB_HID_EP,
 USB_TRANSFER_TYPE,
 0x40,0x00,
 EP_OUT_INTERVAL
};

const struct {
 char report[USB_HID_RPT_SIZE];
}hid_rpt_desc =
 {
 {0x06, 0x00, 0xFF,
 0x09, 0x01,
 0xA1, 0x01,

 0x19, 0x01,
 0x29, 0x40,
 0x15, 0x00,
 0x26, 0xFF, 0x00,
 0x75, 0x08,
 0x95, HID_INPUT_REPORT_BYTES,
 0x81, 0x02,

 0x19, 0x01,
 0x29, 0x40,
 0x75, 0x08,
 0x95, HID_OUTPUT_REPORT_BYTES,
 0x91, 0x02,
 0xC0}
 };


const struct {
 char bLength;
 char bDscType;
 unsigned int string[1];
 } strd1 = {
 4,
 0x03,
 {0x0409}
 };



const struct{
 char bLength;
 char bDscType;
 unsigned int string[16];
 }strd2={
 34,
 0x03,
 {'M','i','k','r','o','e','l','e','k','t','r','o','n','i','k','a'}
 };


const struct{
 char bLength;
 char bDscType;
 unsigned int string[15];
}strd3={
 32,
 0x03,
 {'U','S','B',' ','H','I','D',' ','L','i','b','r','a','r','y'}
 };


const char* USB_config_dsc_ptr[1];


const char* USB_string_dsc_ptr[3];

void USB_Init_Desc(){
 USB_config_dsc_ptr[0] = &configDescriptor1;
 USB_string_dsc_ptr[0] = (const char*)&strd1;
 USB_string_dsc_ptr[1] = (const char*)&strd2;
 USB_string_dsc_ptr[2] = (const char*)&strd3;
}
#line 3 "D:/dsPIC/dsPic/mikroC/Usb/project.c"
unsigned short m, k;
unsigned short userRD_buffer[64];
unsigned short userWR_buffer[64];

void interrupt()
{
 asm CALL _Hid_InterruptProc
 asm nop
}

void Init_Main()
{
 INTCON=0;
 INTCON2=0xF5;
 INTCON3=0xC0;
 RCON.IPEN=0;
 PIE1=0;
 PIE2=0;
 PIR1=0;
 PIR2=0;
 ADCON1 |= 0x0F;
 TRISA=0;
 TRISB=0;
 TRISC=0xFF;
 TRISD=0xFF;
 TRISE=0x07;
 LATA=0;
 LATB=0;
 LATC=0;
 LATD=0;
 LATE=0;

 asm{
 LFSR FSR0, 0x000
 MOVLW 0x08
 CLRF POSTINC0, 0
 CPFSEQ FSR0H, 0
 BRA $ - 2
 }

 T0CON=0x07;
 TMR0H=(65536-156) >> 8;
 TMR0L=(65536-156) & 0xFF;
 INTCON.T0IE=1;
 T0CON.TMR0ON=1;
}

void main()
{
 Init_Main();
 Hid_Enable(&userRD_buffer, &userWR_buffer);
 do
 {
 for(k=0; k < 255; k++)
 {
 userWR_buffer[0]=k;
 Hid_Write(&userWR_buffer, 1);
 }
 }while(1);
 Hid_Disable();
}
