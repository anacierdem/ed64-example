#include <stdio.h>
#include <malloc.h>
#include <string.h>
#include <stdint.h>
#include <libdragon.h>

#include <libed64.h>

static resolution_t res = RESOLUTION_320x240;
static bitdepth_t bit = DEPTH_32_BPP;

class Test
{
    private:
        int data1;
        float data2;  

    public:  
        void function1()
        {   data1 = 2;  } 

        float function2()
        { 
            data2 = 3.5;
            return data2;
        }
   };

int main(void)
{
  Test o1;
    /* enable interrupts (on the CPU) */
    init_interrupts();

    /* Initialize peripherals */
    display_init( res, bit, 2, GAMMA_NONE, ANTIALIAS_RESAMPLE );
    console_init();
    controller_init();

    everdrive_init(false);

    console_set_render_mode(RENDER_MANUAL);

    int testv = 0;
    /* Main loop test */
    while(1) 
    {
        console_clear();

        printf("\n%f\n\n", o1.function2() );

        printf("\n%d\n\n", testv++ );

        console_render();

        handle_everdrive();
    }
}
