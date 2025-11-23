
//
// Invensense MPU6050 Accel & Gyro Sensor
//
Device (GYR1)
{
    Name (_HID, "HID_GYR1")
    Name (_UID, 1)

    Name(_DEP, Package(0x01)
    {
        \_SB_.PEP0
    })
    
    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus(0x68, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C2",,,,)
            GpioInt(Level, ActiveHigh, ExclusiveAndWake, PullNone, 0, "\\_SB.GIO0",) {115}
        })
        Return (RBUF)
    }
    
    // ROTM describes relationship between the sensor's X,Y and Z axes and the 
    //  phone's X,Y and Z axes (defined by OEM). This is known as the Rotation Matrix.
    //  Each row represents the transformation applied to the X, Y and Z axis 
    //  respectively. 
    //  Each entry is a decimal number between -1 and 1 with each number
    //  having a max of 3 decimal places.
    Method(ROTM, 0x0, NotSerialized) {
        Name(RBUF, Package(){
            "1 0 0",
            "0 -1 0",
            "0 0 -1"
        })
        Return (RBUF)
    }

    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.GYR1"})   // Device ID buffer - PGID( Pep given ID )

    Name(DBUF, Buffer(DBFL) {})         // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)

    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    
    Method(_PS0, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    
    Method(UACC, 0x0, NotSerialized) { // Since the MPU6050 drivers implements ACC and GYRO
        Name(RBUF, Buffer(){1})        // functionality, this flag is used to determine if
        Return (RBUF)                  // ACC should be enabled. GYRO is enabled all of the 
    }                                  // time.
                                       
}

//
// Avago APDS-9900 Ambient Light and Proximity Sensor
//
Device (ALS1)
{
    Name (_HID, "HID_ALS1")
    Name (_UID, 1)

    Name(_DEP, Package(0x01)
    {
        \_SB_.PEP0
    })

    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus(0x39, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C2",,,,)
            GpioInt(Level, ActiveLow, Exclusive, PullNone, 0, "\\_SB.GIO0",) {113}
        })
        Return (RBUF)
    }

    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.ALS1"})   // Device ID buffer - PGID( Pep given ID )

    Name(DBUF, Buffer(DBFL) {})           // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)

    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    
    Method(_PS0, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
             Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }    
}

//
// AsahiKasei AK8963C Magnetometer Sensor
//
Device (MAG1)
{
    Name (_HID, "HID_MAG1")
    Name (_UID, 1)
    
    Name(_DEP, Package(0x01)
    {
        \_SB_.PEP0
    })

    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            I2CSerialBus(0x0C, ControllerInitiated, 400000, AddressingMode7Bit, "\\_SB.I2C2",,,,)
            GpioInt(Level, ActiveHigh, Exclusive, PullNone, 0, "\\_SB.GIO0",) {69}
        })
        Return (RBUF)
    }

    // ROTM describes relationship between the sensor's X,Y and Z axes and the 
    //  phone's X,Y and Z axes (defined by OEM). This is known as the Rotation Matrix.
    //  Each row represents the transformation applied to the X, Y and Z axis 
    //  respectively. 
    //  Each entry is a decimal number between -1 and 1 with each number
    //  having a max of 3 decimal places.
    Method(ROTM, 0x0, NotSerialized) {
        Name(RBUF, Package(){
            "0 1 0",
            "1 0 0",
            "0 0 -1"
        })
        Return (RBUF)
    }

    // PEP Proxy Support
    Name(PGID, Buffer(10) {"\\_SB.MAG1"}) // Device ID buffer - PGID( Pep given ID )

    Name(DBUF, Buffer(DBFL) {})         // Device ID buffer - PGID( Pep given ID )
    CreateByteField(DBUF, 0x0, STAT)    // STATUS 1 BYTE
                                        // HIDDEN 1 BYTE ( SIZE )
    CreateByteField(DBUF, 2, DVAL )     // Packet value, 1 BYTES Device Status
    CreateField(DBUF, 24, 160, DEID)    // Device ID, 20 BYTES(160 Bits)

    Method (_S1D, 0) { Return (3) }     // S1 => D3
    Method (_S2D, 0) { Return (3) }     // S2 => D3
    Method (_S3D, 0) { Return (3) }     // S3 => D3
    
    Method(_PS0, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(0, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }
    Method(_PS3, 0x0, NotSerialized) {
        Store(Buffer(ESNL){}, DEID) 
        Store(3, DVAL)
        Store(PGID, DEID)
        If(\_SB.ABD.AVBL)
        {
            Store(DBUF, \_SB.PEP0.FLD0)
        }
    }    
}
