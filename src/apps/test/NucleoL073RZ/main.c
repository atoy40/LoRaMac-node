#include "board.h"

//static TimerEvent_t Led1Timer;

static Gpio_t Button;

void timerCb() {
    GpioWrite( &Led1, 0);
}

/**
 * Main application entry point.
 */
int main( void )
{
        BoardInitMcu( );
        //BoardInitPeriph( );

        //TimerInit(&Led1Timer, &timerCb);
        //TimerSetValue(&Led1Timer, 1000);
        //TimerStart(&Led1Timer);

        //GpioInit( &Button, NSWITCH_1, PIN_INPUT, PIN_PUSH_PULL, PIN_NO_PULL, 0 );
        //GpioSetInterrupt( &Button, IRQ_RISING_EDGE, IRQ_MEDIUM_PRIORITY, ( GpioIrqHandler * )timerCb);

        GpioWrite( &Led1, 1);

        //DelayMs(1000);
        
        //GpioWrite( &Led1, 0);
}