
//
// Copyright (c) 2015 Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the iodevices ACPI device definitions for 
// touch detection driver and customer touch driver
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

///////////////////////////////////////////////////////////////////////////////
//
//     Global ID and Touch Detection Driver (TDD) Entriy
//
///////////////////////////////////////////////////////////////////////////////

//Global Buffer stores detected Touch controller parameters
Name(CLID, Buffer(0x4)
{
    0x01, // Vendor ID : Identifies a vendor
    0x08, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
    0x08, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
    0x01, // Panel detection : Same Controller with different glass panel. Set it to major cfg
          // preprovioned on the controller
})

Name(TDDE, 0)
//Touch Detection Driver
Device (TDD1)
{
    Name (_HID, "QCOM2419")
    Name (_UID, 1)
    Name(_DEP, Package(0x01)
    {
        \_SB_.PEP0
    })
    //
    //Get the controller ID supported by the Driver
    //
    Method(GCID, 0x0, NotSerialized)
    {
        return (CLID)
    }

    Method(SCID, 0x1, NotSerialized)
    {
        Store(Arg0, CLID)
        Store (0x1,\_SB.TDDE) //Store 1 in TDDE
    }
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            // ------------------------------------------------------------------------------------
            //   Note to Customers: Dont update/modify the below entries.
            //   As number of TSC entries listed here should match with Number entreis in TDD driver
            // ------------------------------------------------------------------------------------
            //Atmel
            I2CSerialBus( 0x004A, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            //Synaptics
            I2CSerialBus( 0x0020, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            //FocalTech
            I2CSerialBus( 0x0038, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            //Cypress
            I2CSerialBus( 0x0024, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            // ------------------------------------------------------------------------------------
           
            // ------------------------------------------------------------------------------------
            //  Add Customer Driver Entry Here
            // ------------------------------------------------------------------------------------
            // Replace Customer TSC I2C Slave Address, You should update the TDD as well
            //I2CSerialBus( 0xXXXX, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
        })
        Return (RBUF)
    }
}




///////////////////////////////////////////////////////////////////////////////
//
//     TSC5 Entry
//     Customer/OEM Touch Driver Entry
//
///////////////////////////////////////////////////////////////////////////////

//Device (TSC5) // Use TSC5 only 
//{
//    Name (_HID, "XXXXXX") // TOUCH HID, it should match with HID metnioned in .inx/.inf file 
//    Name (_UID, 1)
//    Name(_DEP, Package()
//    {
//        \_SB.PEP0,
//        \_SB_.TDD1
//    })
//
//    // **** Replace with some other number. This should match with ID mentioned in TDD *****
//    //Controller ID supported by the Driver
//    Name(VCID, Buffer(0x4) // REplace with some value. This value should match with value in TDD driver
//    {
//        0xXX, // Vendor ID : Identifies a vendor
//        0xXX, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
//        0xXX, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
//        0xXX, // Panel detection : Same Controller with different glass panel.
//    })
//    Method (_STA, 0, NotSerialized)
//    {
//        //
//        //Compare the Controller ID (CLID) set by the ACPI global Variable to that supported by
//        //
//        If(LEqual(\_SB.TDDE, 0 ))
//        {
//            Return (0x0F)  // If _STA returns 0xF, load the driver.
//                           // This be will evaluated earlier and return success so device will not be removed
//        }
//        If(LEqual(\_SB.CLID, VCID ))
//        {
//            Return (0x0F)  // If _STA returns 0xF, load the driver
//        }
//        ELse
//        {
//            Return (0x0)    // If _STA returns 0x0, then the driver is not loaded for the device instance
//        }
//    }
//    Method (_CRS, 0x0, NotSerialized)
//    {
//        Name (RBUF, ResourceTemplate ()
//        {   
//            // **** Replace with customer TSC i2c slave address *****
//            I2CSerialBus( 0xXXXX, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,) // Replace with customer TSC i2c slave address
//            GpioInt(Edge, ActiveLow, Exclusive, PullUp, 0, "\\_SB.GIO0", ,) {13}
//            GpioIo(Exclusive, PullNone, 0, 0, , "\\_SB.GIO0", ,) {12}
//        })
//        Return (RBUF)
//    }
//    // PEP Proxy Support
//    Name(PGID, Buffer(10) {"\\_SB.TSC5"})   // Device ID buffer - PGID( Pep given ID ) // This must be SB/TSC5
//    Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
//    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
//                                        // HIDDEN 1 BYTE ( SIZE )
//    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
//    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)
//    Method (_S1D, 0) { Return (3) }     // S1 => D3
//    Method (_S2D, 0) { Return (3) }     // S2 => D3
//    Method (_S3D, 0) { Return (3) }     // S3 => D3
//    Method(_PS0, 0x0, NotSerialized)
//    {
//        Store(Buffer(ESNL){}, DEID)
//        Store(0, DVAL)
//        Store(PGID, DEID)
//        If(\_SB.ABD.AVBL)
//        {
//             Store(DBUF, \_SB.PEP0.FLD0)
//        }
//    }
//    Method(_PS3, 0x0, NotSerialized)
//    {
//        Store(Buffer(ESNL){}, DEID)
//        Store(3, DVAL)
//        Store(PGID, DEID)
//        If(\_SB.ABD.AVBL)
//        {
//             Store(DBUF, \_SB.PEP0.FLD0)
//        }
//    }
//}
