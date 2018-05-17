/*
12. To interface LCD with ARM processor-- ARM7TDMI/LPC2148. Write and execute
programs in C language for displaying text messages and numbers on LCD.
*/

#include <lpc214x.h>
#include <stdio.h>

//Function prototypes
void lcd_init(void);
void wr_cn(void);
void clr_disp(void);
void delay(unsigned int);
void lcd_com(void);
void wr_dn(void);
void lcd_data(void);

unsigned char temp1;
unsigned long int temp, r = 0;
unsigned char *ptr, disp[] = "ALS,R&D SECTION,", disp1[] = "BENGALURU-58";

int main()
{
    IO0DIR = 0x000000FC; //configure o/p lines for lcd
    IO0PIN = 0X00000000;

    delay(3200); //delay
    lcd_init();  //lcd intialisation
    delay(3200); //delay
    clr_disp();  //clear display
    delay(3200); //delay

    //........LCD DISPLAY TEST.........//
    temp1 = 0x80; //Display starting address	of first line 1 th pos
    lcd_com();

    ptr = disp;
    while (*ptr != '\0')
    {
        temp1 = *ptr;
        lcd_data();
        ptr++;
    }

    temp1 = 0xC0; // Display starting address of second line 4 th pos
    lcd_com();

    ptr = disp1;
    while (*ptr != '\0')
    {
        temp1 = *ptr;
        lcd_data();
        ptr++;
    }
    while (1)
        ;
} //end of main()

// lcd initialisation routine.
void lcd_init(void)
{
    temp = 0x30;
    wr_cn();
    delay(3200);

    temp = 0x30;
    wr_cn();
    delay(3200);

    temp = 0x30;
    wr_cn();
    delay(3200);

    temp = 0x20; // change to 4 bit mode from default 8 bit mode
    wr_cn();
    delay(3200);

    // load command for lcd function setting with lcd in 4 bit mode,
    // 2 line and 5x7 matrix display

    temp = 0x28;
    lcd_com();
    delay(3200);

    // load a command for display on, cursor on and blinking off
    temp1 = 0x0C;
    lcd_com();
    delay(800);

    // command for cursor increment after data dump
    temp1 = 0x06;
    lcd_com();
    delay(800);

    temp1 = 0x80; // set the cursor to beginning of line 1
    lcd_com();
    delay(800);
}

void lcd_com(void)
{
    temp = temp1 & 0xf0;
    wr_cn();
    temp = temp1 & 0x0f;
    temp = temp << 4;
    wr_cn();
    delay(500);
}

// command nibble o/p routine
void wr_cn(void) //write command reg
{
    IO0CLR = 0x000000FC; // clear the port lines.
    IO0SET = temp;       // Assign the value to the PORT lines
    IO0CLR = 0x00000004; // clear bit  RS = 0
    IO0SET = 0x00000008; // E=1
    delay(10);
    IO0CLR = 0x00000008;
}

// data nibble o/p routine
void wr_dn(void) ////write data reg
{
    IO0CLR = 0x000000FC; // clear the port lines.
    IO0SET = temp;       // Assign the value to the PORT lines
    IO0SET = 0x00000004; // set bit  RS = 1
    IO0SET = 0x00000008; // E=1
    delay(10);
    IO0CLR = 0x00000008;
}

// data o/p routine which also outputs high nibble first
// and lower nibble next
void lcd_data(void)
{
    temp = temp1 & 0xf0;
    temp = temp << 6;
    wr_dn();
    temp = temp1 & 0x0f;
    temp = temp << 4;
    wr_dn();
    delay(100);
}

void clr_disp(void)
{
    // command to clear lcd display
    temp1 = 0x01;
    lcd_com();
    delay(500);
}

void delay(unsigned int r1)
{
    for (r = 0; r < r1; r++)
        ;
}