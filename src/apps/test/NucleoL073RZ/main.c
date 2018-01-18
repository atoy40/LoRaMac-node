#include "board.h"
#include "LoRaMac.h"
#include "LoRaMacTest.h"

#define IEEE_OUI                                    0x00, 0xC0, 0xE1
#define LORAWAN_DEVICE_EUI                          { IEEE_OUI, 0xC8, 0x1E, 0xFE, 0xBA, 0xA7 }
#define LORAWAN_APPLICATION_EUI                     { 0x70, 0xB3, 0xD5, 0x7E, 0xF0, 0x00, 0x40, 0x5D }
#define LORAWAN_APPLICATION_KEY                     { 0x15, 0x8A, 0x34, 0x3B, 0xCC, 0x3E, 0xDE, 0xEC, 0xD2, 0x93, 0x45, 0xB4, 0xD3, 0x64, 0xA4, 0x37 }

static uint8_t DevEui[] = LORAWAN_DEVICE_EUI;
static uint8_t AppEui[] = LORAWAN_APPLICATION_EUI;
static uint8_t AppKey[] = LORAWAN_APPLICATION_KEY;

static TimerEvent_t Led1Timer;

static uint32_t state = 0;

//static Gpio_t Button;

void timerCb() {
    TimerStop(&Led1Timer);
    state = 1 - state;
    GpioWrite( &Led1, 0);
}

static void McpsConfirm( McpsConfirm_t *mcpsConfirm )
{
}

static void McpsIndication( McpsIndication_t *mcpsIndication )
{
}

static void MlmeConfirm( MlmeConfirm_t *mlmeConfirm )
{
    switch( mlmeConfirm->MlmeRequest )
    {
        case MLME_JOIN:
        {
            GpioWrite( &Led1, 1);
            TimerSetValue(&Led1Timer, 100);
            TimerStart(&Led1Timer);
            return;
        }
        default:
        {
            break;
        }
    }

    GpioWrite( &Led1, 1);
    TimerSetValue(&Led1Timer, 1000);
    TimerStart(&Led1Timer);
}



/**
 * Main application entry point.
 */
int main( void )
{
    LoRaMacPrimitives_t LoRaMacPrimitives;
    LoRaMacCallback_t LoRaMacCallbacks;
    MibRequestConfirm_t mibReq;

    BoardInitMcu( );
    BoardInitPeriph( );

    LoRaMacPrimitives.MacMcpsConfirm = McpsConfirm;
    LoRaMacPrimitives.MacMcpsIndication = McpsIndication;
    LoRaMacPrimitives.MacMlmeConfirm = MlmeConfirm;
    LoRaMacCallbacks.GetBatteryLevel = BoardGetBatteryLevel;

    TimerInit(&Led1Timer, &timerCb);

    printf("Led started\r\n");
    Delay(1);

    LoRaMacInitialization( &LoRaMacPrimitives, &LoRaMacCallbacks, LORAMAC_REGION_EU868 );

    Delay(1);
    printf("Loramac initialized\r\n");

    mibReq.Type = MIB_ADR;
    mibReq.Param.AdrEnable = true;
    LoRaMacMibSetRequestConfirm( &mibReq );

    mibReq.Type = MIB_PUBLIC_NETWORK;
    mibReq.Param.EnablePublicNetwork = true;
    LoRaMacMibSetRequestConfirm( &mibReq );

    LoRaMacTestSetDutyCycleOn( false );

    MlmeReq_t mlmeReq;

    // Initialize LoRaMac device unique ID
    //BoardGetUniqueId( DevEui );

    mlmeReq.Type = MLME_JOIN;

    mlmeReq.Req.Join.DevEui = DevEui;
    mlmeReq.Req.Join.AppEui = AppEui;
    mlmeReq.Req.Join.AppKey = AppKey;
    mlmeReq.Req.Join.NbTrials = 3;

    LoRaMacMlmeRequest( &mlmeReq );

    //GpioInit( &Button, NSWITCH_1, PIN_INPUT, PIN_PUSH_PULL, PIN_NO_PULL, 0 );
    //GpioSetInterrupt( &Button, IRQ_RISING_EDGE, IRQ_MEDIUM_PRIORITY, ( GpioIrqHandler * )timerCb);

    while(1) {
        TimerLowPowerHandler( );
    }
}