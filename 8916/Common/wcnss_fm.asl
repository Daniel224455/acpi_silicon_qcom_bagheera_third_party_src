//
// Copyright (c) 2011-2013, Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the Bluetooth Drivers 
// ACPI device definitions, configuration and look-up tables.
// 

//
// FM transport driver
//

Device (FMT0)
{
	Name (_ADR, 2)
	Name(_PRR, Package(0x1) { \_SB.RIVA.WRST })  // Power resource reference for device reset and recovery.
}
