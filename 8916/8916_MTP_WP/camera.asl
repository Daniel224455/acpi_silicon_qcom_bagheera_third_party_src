//===========================================================================
//                           <camera.asl>
// DESCRIPTION
//   This file contains the ACPI Extensions for Camera drivers
//
//
//   Copyright (c) 2010-2015 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================
    //
    //CAMERA PLATFORM
    //
    Device (CAMP)
    {
        Name (_DEP, Package(0x2)
        {
            \_SB_.PEP0,
            \_SB_.PMIC
        })

        Name (_HID, "QCOM0715")
        Name (_UID, 27)

        Method (_CRS, 0x0, NotSerialized)
        {
            Name (RBUF, ResourceTemplate ()
            {
                //CAMSS_A_CCI
                Memory32Fixed (ReadWrite, 0x01B0C000, 0x00004000) //good

                //CAMSS_A_CAMSS
                Memory32Fixed (ReadWrite, 0x01B00000, 0x00004000) //good

                //MMSS_A_CCI
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {82}

                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){35} //CAMSENSOR_1_RST_N
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){34} //CAMSENSOR_1_STANBY
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){28} //CAMSENSOR_2_RST_N
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){33} //CAMSENSOR_2_STANBY
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){36} //FLASH_LED_RESET  
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){31} //FLASH_LED_STB_0   
                GpioIo(Exclusive,PullNone,0,0, ,"\\_SB.GIO0", ,){32} //FLASH_LED_STB_1   

            })
            Return (RBUF)

        }

        Method (INFO)
        {
            // INFO is 32 bit number that determines the sensor orientation and I2C bus used by camera
            // The number is broken down into 4 bytes
            // bits 0-7 represent back sensor orientation, bit 0 : if flip enabled (value 1 enabled, value 0 disabled) , bit 1 : if mirror enabled (value 1 enabled, value 0 disabled)
            // bits 2-7 are not used
            // bits 8-15 represent front sensor orientation, bit 8 : if flip enabled (value 1 enabled, value 0 disabled), bit 9 : if mirror enabled (value 1 enabled, value 0 disabled)
            // bits 10-15 not used
            // bit 16 represents front sensor I2C bus. if value 0: bus is I2C bus 0. if value 1: bus is I2C bus 1
            // bit 17 represents back sensor I2C bus.  if value 0: bus is I2C bus 0.  if value 1: bus is I2C bus 1
            // bits 18-19 are unused
            // bit 20 represents PMIC flash LED configuration. 0 = PMIC_FLASH_LED_CONFIG_0, 1 = PMIC_FLASH_LED_CONFIG_1
            // bits 21-22 represent flash type bit 22-21: 00 = CAMFLASH_METHOD_0, 01 = CAMFLASH_METHOD_1, 10 = CAMFLASH_METHOD_2, 11 = CAMFLASH_METHOD_3,
            // bits 21-31 are unused

            Return(0x01000000)
        }
    }

    //
    //CAMERA FRONT SENSOR
    //

    Device (CAMF)
    {
        Name (_DEP, Package(0x3)
        {
            \_SB_.CAMP,
            \_SB_.PEP0,
                            \_SB_.CAMS
        })

        Name (_HID, "QCOM244E")
        Name (_UID, 26)

        Method (_CRS, 0x0, NotSerialized)
        {
            Name (RBUF, ResourceTemplate ()
            {
                // MIPI_CSI_1
                Memory32Fixed (ReadWrite, 0x1B08400, 0x000003FF)
                // MIPI_CSI_1_PHY1
                Memory32Fixed (ReadWrite, 0x1B0B000, 0x000003FF)

                // MMSS_A_CSID_CSI_1 Interrupt
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {84}

            })
            Return (RBUF)
        }
        // PEP Proxy Support
        Name(PGID, Buffer(10) {"\\_SB.CAMF"})   // Device ID buffer - PGID( Pep given ID )

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
            Store(DBUF, \_SB.PEP0.FLD0)
        }
        Method(_PS3, 0x0, NotSerialized)
        {
            Store(Buffer(ESNL){}, DEID)
            Store(3, DVAL)
            Store(PGID, DEID)
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }


    Device (VFE0)
    {
        Name (_DEP, Package(0x2)
        {
            \_SB_.ATCU,
                            \_SB_.CAMP
        })

        Name (_HID, "QCOM0700")
        Name (_UID, 22)

        Method (_CRS, 0x0, NotSerialized)
        {
            Name (RBUF, ResourceTemplate ()
            {
                // ISPIF Length holds good from B-family
                Memory32Fixed (ReadWrite, 0x01B0A000, 0x00000C00)
                //VBIF MMSS_A_VBIF_VFE_VBIF_VFE_DENOISE
                Memory32Fixed (ReadWrite, 0x01B40000, 0x00003000)
                // CPP register space Length holds good from B-family
                Memory32Fixed (ReadWrite, 0x01B18000, 0x00004000)
                //Micro Controller Length holds good from B-family
                Memory32Fixed (ReadWrite, 0x01B04000, 0x00004000)
                // VFE0
                Memory32Fixed (ReadWrite, 0x01B10000, 0x00004000)
                // LPASS_AVTIMER
                Memory32Fixed (ReadWrite, 0x7706000, 0x00000100)

                // VFE0 interrupt
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {89}

                // ISPIF interrupt
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {87}

                // MICRO interrupt
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {81}
            })
            Return (RBUF)
        }
    }

    //
    // Hardware JPEG Encoder - Done
    //
    Device (FLSH)
    {
        Name (_DEP, Package(0x2)
                    {
                        \_SB_.CAMS,
                            \_SB_.PEP0
                    })
        Name (_HID, "QCOM0705")
        Name (_UID, 25)
        Method (_CRS, 0x0, NotSerialized) {
            Name (RBUF, ResourceTemplate ()
            {

            })
            Return (RBUF)
        }
    }
    //
    // Hardware JPEG Encoder - Done
    //
    Device (JPGE)
    {
        Name (_DEP, Package(0x2)
        {
            \_SB_.CAMP,
            \_SB_.ATCU
        })

        Name (_HID, "QCOM2467")
        Name (_UID, 23)

        Method (_CRS, 0x0, NotSerialized) {
            Name (RBUF, ResourceTemplate ()
            {
                // HW JPEG Encoder 0 register space
                Memory32Fixed (ReadWrite, 0x1B1C000 , 0x00004000)

                // TODO: this should later on be moved to CAMP
                // VBIF address space shared by the HW JPEG Encoder 1 & 2, and the HW JPEG Decoder
                // 0xFDA60C30 - 0xFDA60000 + 4
                Memory32Fixed (ReadWrite, 0x1B60000, 0x00003000)

                // JPEGE 0 Interrupt  correct
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {91}
            })
            Return (RBUF)
        }
    }

    // CAMERA SENSOR
    Device (CAMS)
    {
        Name (_DEP, Package(0x2)
        {
            \_SB_.CAMP,
            \_SB_.PEP0
        })

        Name (_HID, "QCOM2448")
        Name (_UID, 21)

        Method (_CRS, 0x0, NotSerialized)
        {
            Name (RBUF, ResourceTemplate ()
            {
                // MMSS_A_CSID_0 Length holds good from B-family
                Memory32Fixed (ReadWrite, 0x01B08000, 0x000003FF)
                // MMSS_A_CSI_PHY_0
                Memory32Fixed (ReadWrite, 0x01B0AC00, 0x000003FF)

                // MMSS_A_CSID_0 Interrupt
                Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {83}
            })
            Return (RBUF)
        }
        // PEP Proxy Support
        Name(PGID, Buffer(10) {"\\_SB.CAMS"})   // Device ID buffer - PGID( Pep given ID )

        Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
        CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                            // //HIDDEN 1 BYTE ( SIZE )
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
            Store(DBUF, \_SB.PEP0.FLD0)
        }
        Method(_PS3, 0x0, NotSerialized)
        {
            Store(Buffer(ESNL){}, DEID)
            Store(3, DVAL)
            Store(PGID, DEID)
            Store(DBUF, \_SB.PEP0.FLD0)
        }

    }