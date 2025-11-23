//
// Copyright (c) 2011-2012, Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the WLAN Drivers 
// ACPI device definitions, configuration and look-up tables.
// 

// 
// WLAN
//

Device (QWLN)   
{
	Name (_ADR, 1)
	Name(_PRR, Package(0x1) { \_SB.RIVA.WRST })  // Power resource reference for device reset and recovery.

	Name(_PRW, Package() {0,0}) // wakeable from S0
	Name(_S0W, 2) // S0 should put device in D2 for wake
	Name(_S4W, 2) // all other Sx (just in case) should also wake from D2

	Method (_CRS, 0x0, NotSerialized) {
		Name (RBUF, ResourceTemplate ()
		{
			// Shared memory
			Memory32Fixed (ReadWrite, 0x0A000000, 0x01000000)
   
			// Inbound interrupt from Riva:
			// RIVA_APPS_WLAN_RX_DATA_AVAIL_IRQ 178
			Interrupt(ResourceConsumer, Level, ActiveHigh, SharedAndWake, , , ) {178}

			// Inbound interrupt from Riva:
			// RIVA_APPS_WLAN_DATA_XFER_DONE_IRQ 177
			Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {177}
		})
		Return (RBUF)
	}

	Method (_PS0)
	{ 
		  // just a place holder to allow disable                
	}

	Method (_PS1)
	{ 
		  // just a place holder to allow disable                
	}

	Method (_PS2)
	{ 
		  // just a place holder to allow disable                
	}

	Method (_PS3)
	{ 
		  // just a place holder to allow disable                  
	}
}
