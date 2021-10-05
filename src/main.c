#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <stdint.h>

#include <libdragon.h>

int main(void)
{
    long int count = 0;

    init_interrupts();

    console_set_debug(true);
    console_init();
    debug_init_usblog();

    while(1)
    {
        printf("Test counter: %lu\n", count++);

        wait_ms(100);
    }
}
