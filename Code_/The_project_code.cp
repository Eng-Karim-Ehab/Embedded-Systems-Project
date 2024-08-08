#line 1 "C:/Users/ehaba/OneDrive/Desktop/Embedded System Project/Code_/The_project_code.c"

char south_G_west_R = 0b00100001;
char south_Y_west_R = 0b00010001;
char south_R_west_G = 0b00001100;
char south_R_west_Y = 0b00001010;
char counter, sec, left, right, i, j, switch_flag = 5, manual_flag = 0, fflag = 0, flag;
unsigned short x;


void Switch()
{
 if (portB == south_R_west_G)
 {
 portB = south_R_west_Y;
 switch_flag = 0;
 }
 else if(portB == south_G_west_R)
 {
 portB = south_Y_west_R;
 switch_flag = 1;
 }

 for(j = 3; j > 0; j--)
 {

 for(i = 0; i < 5; i++)
 {
 left = j / 10;
 right = j % 10;
 portD = 0b00000001;
 portC = right;
 delay_ms(15);
 portD = 0b00000010;
 portC = left;
 delay_ms(15);
 }
 }


 if (portB == south_R_west_Y)
 {
 portB = south_G_west_R;
 switch_flag = 0;
 }

 else if(portB == south_Y_west_R)
 {
 portB = south_R_west_G;
 switch_flag = 1;
 }

}




void interrupt()
{


 if(RBIF_BIT == 1)
 {
 x = portB;
 RBIF_BIT = 0 ;

 if(portB.b6 == 0 && portA.b0 == 0)
 {
 flag = 1;
 }
 }
}








void main()
{
 adcon1 = 6;
 trisA.b4 = 1;
 trisA.b0 = 1;
 trisC = 0;
 portC = 0;
 trisD.b0 = 0; trisD.b1 = 0;
 portD.b0 = 1; portD.b1 = 1;
 trisB = 0b11000000;
 portB = 0;



 NOT_RBPU_BIT = 0;

 x = portB;
 RBIF_BIT = 0;
 GIE_BIT = 1;
 RBIE_BIT = 1;


 while(portA.B4 == 1);

 loop_15s:
 for (counter = 15; counter > 0; counter--)
 {
 if (flag)
 {
 flag = 0;
 Switch();
 if(switch_flag)
 {
 break;
 }
 else
 {
 goto loop_15s;
 }
 }

 if (counter > 3)
 {
 portB = south_G_west_R;
 }

 else
 {
 portB = south_Y_west_R;
 }

 for (sec = 0; sec < 5; sec++)
 {
 left = counter / 10;
 right = counter % 10;
 portD = 0b00000001;
 portC = right;
 delay_ms(15);
 portD = 0b00000010;
 portC = left;
 delay_ms(15);
 }
 }

 loop_23s:
 for (counter = 23; counter > 0; counter--)
 {
 if (flag)
 {
 flag = 0;
 Switch();
 if(switch_flag)
 {
 break;
 }
 else
 {
 goto loop_23s;
 }
 }

 if (counter > 3)
 {
 portB = south_R_west_G;
 }
 else
 {
 portB = south_R_west_Y;
 }

 for (sec = 0; sec < 5; sec++)
 {
 left = counter / 10;
 right = counter % 10;
 portD = 0b00000001;
 portC = right;
 delay_ms(15);
 portD = 0b00000010;
 portC = left;
 delay_ms(15);
 }
 }

 goto loop_15s;
}
