//
// Copyright (c) 2013, Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the sensor ACPI device definitions.
//

Device (QMMI)
{
    Name (_DEP, Package(0x1)
    {
        \_SB_.QDIG, //Qualcomm DIAG Service
    })

    Name (_HID, "QCOM2496")
    Name (_UID, 0)

    Method (_CRS, 0x0, NotSerialized) 
    {
        Name (RBUF, ResourceTemplate ()
        {
            // Emergency download (EMDL) cookie address. Should be the first entry
            // in future as well.
            // 8916 uses TCSR register to control EMDL mode in subsequent boot
            // and thus this address points to TCSR register
            Memory32Fixed (ReadWrite, 0x0193D100, 0x00000004)
            
            // PS_HOLD physical address
            Memory32Fixed (ReadWrite, 0x004AB000, 0x00000004)
        })
        Return (RBUF)
    } 

    // EMDL Cookie list
    Method(EMDL) 
    {
        Name(RBUF, Package(){
            0x00000001 // Mask to enable the EMDL mode in TCSR register
        })
        Return (RBUF)
    }
}
