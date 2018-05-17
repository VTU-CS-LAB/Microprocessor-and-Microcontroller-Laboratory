/*
7. To write and simulate C Programs for ARM microprocessor using KEIL (Demonstrate with
the help of a suitable program)
*/

#include <LPC241X.h>

int main()
{
    int a, b, c, d, e, f, g, h;
    a = 0xA;
    b = 2;
    c = 4 * a + 2 * b;
    d = a * b;
    e = a & b;
    f = ~a;
    g = a++;
    h = a;
    return 0;
}