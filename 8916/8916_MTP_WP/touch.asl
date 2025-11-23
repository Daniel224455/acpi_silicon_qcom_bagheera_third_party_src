//
// Copyright (c) 2015 Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the iodevices ACPI device definitions.
//
//
// ===================================================================
// EDIT HISTORY
//
// when        who     what, where, why
// --------    ---     --------------------------------------------
// 04/20/15    vb      Initial Revision for 8x16,
//                     Refactored from iodevices.asl
// ===================================================================
//


///////////////////////////////////////////////////////////////////////////////
//
//     TSC1 Entry
//
///////////////////////////////////////////////////////////////////////////////
//
// Touch entry - Atmel MXT224e controller.
//
Device (TSC1)
{
    Name (_HID, "QCOM0D40")
    Name (_UID, 1)
    Name(_DEP, Package()
    {
        \_SB.PEP0,
        \_SB_.TDD1
    })

    //Controller ID supported by the Driver
    Name(VCID, Buffer(0x4)
    {
        0x01, // Vendor ID : Identifies a vendor
        0x08, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x08, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x08, // Panel detection : Same Controller with different glass panel.
    })
    Method (_STA, 0, NotSerialized)
    {
        //
        //Compare the Controller ID (CLID) set by the ACPI global Variable to that supported by
        //
        If(LEqual(\_SB.TDDE, 0 ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver.
                           // This be will evaluated earlier and return success so device will not be removed
        }
        If(LEqual(\_SB.CLID, VCID ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver
        }
        ELse
        {
            Return (0x0)    // If _STA returns 0x0, then the driver is not loaded for the device instance
        }
    }
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus( 0x004A, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            I2CSerialBus( 0x0024, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            GpioInt(Level, ActiveLow, Exclusive, PullUp, 0, "\\_SB.GIO0", ,) {13}
            GpioIo(Exclusive, PullNone, 0, 0, , "\\_SB.GIO0", ,) {12}
        })
        Return (RBUF)
    }

    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.TSC1"}) // Device ID buffer - PGID( Pep given ID )

    Name(DBUF, Buffer(DBFL) {})         // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)

    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3

    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }

    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
//
//     TSC2 Entry
//
///////////////////////////////////////////////////////////////////////////////
//
// Touch entry - Synaptics controller.
//
Device (TSC2)
{
    Name (_HID, "QCOM0D41")
    Name (_UID, 1)
    Name(_DEP, Package()
    {
        \_SB.PEP0,
        \_SB_.TDD1
    })
    //Controller ID supported by the Driver
    Name(VCID, Buffer(0x4)
    {
        0x01, // Vendor ID : Identifies a vendor
        0x09, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x09, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x09, // Panel detection : Same Controller with different glass panel.
    })
    Method (_STA, 0, NotSerialized)
    {
        //
        //Compare the Controller ID (CLID) set by the ACPI global Variable to that supported by
        //
        If(LEqual(\_SB.TDDE, 0 ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver.
                           // This be will evaluated earlier and return success so device will not be removed
        }
        If(LEqual(\_SB.CLID, VCID ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver
        }
        ELse
        {
            Return (0x0)    // If _STA returns 0x0, then the driver is not loaded for the device instance
        }
    }
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus( 0x0020, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,RawDataBuffer(){0x50, 0xC3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
            GpioInt(Level, ActiveLow, Exclusive, PullUp, 0, "\\_SB.GIO0", ,) {13}
            GpioIo(Exclusive, PullNone, 0, 0, , "\\_SB.GIO0", ,) {12}
        })
        Return (RBUF)
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.TSC2"})   // Device ID buffer - PGID( Pep given ID )
    Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)
    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
//
//     TSC3 Entry
//
///////////////////////////////////////////////////////////////////////////////
//
// Touch entry - FocalTech controller.
//
Device (TSC3)
{
    Name (_HID, "QCOM0D42")
    Name (_UID, 1)
    Name(_DEP, Package()
    {
        \_SB.PEP0,
        \_SB_.TDD1
    })
    //Controller ID supported by the Driver
    Name(VCID, Buffer(0x4)
    {
        0x01, // Vendor ID : Identifies a vendor
        0x07, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x07, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x07, // Panel detection : Same Controller with different glass panel.
    })
    Method (_STA, 0, NotSerialized)
    {
        //
        //Compare the Controller ID (CLID) set by the ACPI global Variable to that supported by
        //
        If(LEqual(\_SB.TDDE, 0 ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver.
                           // This be will evaluated earlier and return success so device will not be removed
        }
        If(LEqual(\_SB.CLID, VCID ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver
        }
        ELse
        {
            Return (0x0)    // If _STA returns 0x0, then the driver is not loaded for the device instance
        }
    }
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus( 0x0038, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,RawDataBuffer(){0x50, 0xC3, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00})
            GpioInt(Level, ActiveLow, Exclusive, PullUp, 0, "\\_SB.GIO0", ,) {13}
            GpioIo(Exclusive, PullNone, 0, 0, , "\\_SB.GIO0", ,) {12}
        })
        Return (RBUF)
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.TSC3"})   // Device ID buffer - PGID( Pep given ID )
    Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)
    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}


///////////////////////////////////////////////////////////////////////////////
//
//     TSC4 Entry
//
///////////////////////////////////////////////////////////////////////////////
//
// Touch entry - Cypress controller.
//
Device (TSC4)
{
    Name (_HID, "QCOM2418")
    Name (_UID, 1)
    Name(_DEP, Package()
    {
        \_SB.PEP0,
        \_SB_.TDD1
    })
    //Controller ID supported by the Driver
    Name(VCID, Buffer(0x4)
    {
        0x01, // Vendor ID : Identifies a vendor
        0x06, // LSB  : LSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x06, // MSB  : MSB of 16 byte Controller ID. Identifies a controller variant of the vendor
        0x06, // Panel detection : Same Controller with different glass panel.
    })
    Method (_STA, 0, NotSerialized)
    {
        //
        //Compare the Controller ID (CLID) set by the ACPI global Variable to that supported by
        //
        If(LEqual(\_SB.TDDE, 0 ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver.
                           // This be will evaluated earlier and return success so device will not be removed
        }
        If(LEqual(\_SB.CLID, VCID ))
        {
            Return (0x0F)  // If _STA returns 0xF, load the driver
        }
        ELse
        {
            Return (0x0)    // If _STA returns 0x0, then the driver is not loaded for the device instance
        }
    }
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus( 0x0024, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C5",,,,)
            GpioInt(Edge, ActiveLow, Exclusive, PullUp, 0, "\\_SB.GIO0", ,) {13}
            GpioIo(Exclusive, PullNone, 0, 0, , "\\_SB.GIO0", ,) {12}
        })
        Return (RBUF)
    }
    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.TSC4"})   // Device ID buffer - PGID( Pep given ID )
    Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)
    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    Method(_PS0, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized)
    {
        Store(Buffer(ESNL){}, DEID)
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
}

