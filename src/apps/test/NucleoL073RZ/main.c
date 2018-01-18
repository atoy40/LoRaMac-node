#include "board.h"

static TimerEvent_t Led1Timer;

static uint32_t state = 0;

//static Gpio_t Button;

void timerCb() {
    state = 1 - state;
    GpioWrite( &Led1, state);
    TimerStart(&Led1Timer);
}

/**
 * Main application entry point.
 */
int main( void )
{
        BoardInitMcu( );
        BoardInitPeriph( );

        TimerInit(&Led1Timer, &timerCb);
        TimerSetValue(&Led1Timer, GetBoardPowerSource() == BATTERY_POWER ? 100 : 500);
        TimerStart(&Led1Timer);

        //GpioInit( &Button, NSWITCH_1, PIN_INPUT, PIN_PUSH_PULL, PIN_NO_PULL, 0 );
        //GpioSetInterrupt( &Button, IRQ_RISING_EDGE, IRQ_MEDIUM_PRIORITY, ( GpioIrqHandler * )timerCb);

        while(1) {
            printf("bla\r\n");
            //UartMcuPutChar( &Uart1, 'a' );
            DelayMs(1000);
        }
}