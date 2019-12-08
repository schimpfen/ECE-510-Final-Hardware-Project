/*
 * Main.c
 *
 *  Created on: Dec 8, 2019
 *      Author: natha
 */
#include "xparameters.h"
#include "xbasic_types.h"
#include "xgpio.h"
#include "xstatus.h"



XGpio GpioDevice;

Xuint32 Parse(Xuint32 port, int iStart, int iEnd);
Xuint32 bitAt(Xuint32 val, int pos);

int main(void)
{
	//Variables
	Xuint32 statusCode;
	Xuint32 DataRead;
	Xuint32 numA;
	Xuint32 numB;
	Xuint32 numOut;
	Xuint32 oldData;
	char operator;
	statusCode = XGpio_Initialize(&GpioDevice,XPAR_GPIO_0_DEVICE_ID);
	if (statusCode != XST_SUCCESS)
		return XST_FAILURE;

	XGpio_SetDataDirection(&GpioDevice,1,0x00000000);
	XGpio_SetDataDirection(&GpioDevice,2,0xFFFFFFFF);
	oldData = 0xFFFFFFFF;
	xil_printf("ECE510 Hardware Project\r\nJacob Berdichevsky, Nathan Schimpf\r\n");
	for(;;)
	{
		DataRead = XGpio_DiscreteRead(&GpioDevice,2);
		numA = Parse(DataRead,0,9);
		numB = Parse(DataRead,12,21);
		if(DataRead != oldData)
		{
			if(bitAt(DataRead,10) == 0)

			{
				if(bitAt(DataRead,11)==0)//A+B
				{
					numOut = numA + numB;
					operator='+';
				}
				else if(bitAt(DataRead,11)==1)//A-B
				{
					numOut = numA - numB;
					operator='-';
				}
			}
			else if(bitAt(DataRead,10)==1)
			{
				if(bitAt(DataRead,11)==0)//A*B
				{
					numOut = numA * numB;
					operator='*';
				}
				else if(bitAt(DataRead,11)==1)//A/B
				{
					numOut = numA / numB;
					operator='/';
				}
			}

		xil_printf("Num A %c Num B => %d %c %d = %d\r\n",operator,numA,operator,numB,numOut);
		oldData = DataRead;
		}
	}
}

Xuint32 Parse(Xuint32 port, int iStart, int iEnd)
{
	Xuint32 total=0;
	Xuint32 mask = (iStart-iEnd)<<iStart;
	total = port & mask;
	total = total>>iStart;
	return total;
}

Xuint32 bitAt(Xuint32 val, int pos)
{
	return val&(1<<pos);
}

