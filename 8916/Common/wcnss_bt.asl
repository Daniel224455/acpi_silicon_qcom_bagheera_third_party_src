//
// Copyright (c) 2011-2012, Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the Bluetooth Drivers 
// ACPI device definitions, configuration and look-up tables.
// 

// 
// Bluetooth
//

Device (BTH0)
{
    Name (_ADR, 0)
    Name(PCTL, 0x1) // Set this to 1 to make Bluetooth part of WLAN and FM PLDR.
    Method(_PRR, 0, NotSerialized)
    {
        if(LEqual(\_SB.RIVA.BTH0.PCTL, 0x1)) {
            return (Package(0x1) { \_SB.RIVA.WRST })  // Power resource reference for device reset and recovery.
        }
        else {
            return (Package(0x1) { \_SB.RIVA.WRS1 })  // Dummy power resource to unlink Bluetooth from WLAN and FM PLDR.
       }
    }
}

