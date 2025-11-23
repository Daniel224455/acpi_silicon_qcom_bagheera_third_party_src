//
// Copyright (c) 2015 Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the iodevices ACPI device definitions for hwn clients
//
//
// ===================================================================
// EDIT HISTORY
//
// when        who     what, where, why
// --------    ---     --------------------------------------------
// 04/20/15    vb      Initial Revision for 8x16, 
//                     refactored from iodevices.asl
// ===================================================================
//


//
//HWN LED
//
Device (HWN0)
{
    Name (_HID, "QCOM0D50")
    Name (_UID, 0)

    // ACPI method for LED Configs
    Method(HWNL, 0x0, NotSerialized)
    {
        Name (CFG0,
        Package()
        {

            0,  // PMIC number PM8916
            1,  // Total HWN LEDs
  
            411, // Fade interval in ms (0-511 ms)
            20, // Fade Steps i.e 5, 10, 15, 20(max)

            1,  // LED2(HR) pmic mpp number(base index 0 i.e 2->1)
            2,  // Current sink level of mpp(5ma - 40ma) 
            3,  // LED2 lpg bank(Not supported since no PWM for HR LED
            1, // DTEST field (1 since PWM control is not required)

        })
        Return (CFG0)
    }
}


//
//HWN Haptics
//
Device (HWN1)
{
    Name (_HID, "QCOM2147")
    Name (_CID, "ACPI\QCOM2147")

    Method(_CRS)
    {
        Name(NAM, Buffer() {"\\_SB.SPMI"})
        Name(PON1, Buffer()
        {
            0x8E,       // SPB Descriptor
            0x13, 0x00, // Length including NAM above
            0x01,       // +0x00 SPB Descriptor Revision
            0x00,       // +0x01 Resource Source Index
            0xC1,       // +0x02 Bus type - vendor defined values are in the range 0xc0-0xff
            0x02,       // +0x03 Consumer + controller initiated
            0x01, 0xC0, // +0x04 Type specific flags . Slave id, Upper8 bit address
            0x01,       // +0x06 Type specific revision
            0x00, 0x00  // +0x07 type specific data length
                        // +0x09 - 0xd bytes for NULL-terminated NAM
                        // Length = 0x13
        })
        Name(END, Buffer() {0x79, 0x00})

        Concatenate(PON1, NAM, Local0)

        Concatenate(Local0, END, Local1)

        Return(Local1)
    }

    Method(HWNH, 0x0, NotSerialized)
    {
        Name (CFG0,
        Package()
        {
            1,     // Total HWN Vibs
            0,     // Pmic number,
            30,    // Max voltage rating in 100 Milli Volts
            20,    // Starting Voltage.in 100 Milli Volts
            20,    // OverDrive Period in milli sec
        })
        Return (CFG0)
    }
}
