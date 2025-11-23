//
// Copyright (c) 2015, Qualcomm Technologies Inc. All rights reserved.
//

//
// RH Proxy
//
//
// RHProxy Device Node to enable WinRT API
//
Device(RHPX)
{
	Name(_HID, "QCOM24D4")
	Name(_CID, "MSFT8000")
	Name(_UID, 1)

	Name(_CRS, ResourceTemplate()
	{
		// Index 0 - "SPI0"
		SPISerialBus(              // SPI0_SCLK - GPIO 19 - Pin 8
								   // SPI0_MOSI - GPIO 16 - Pin 14
								   // SPI0_MISO - GPIO 17 - Pin 10
								   // SPI0_CS   - GPIO 18 - Pin 12
			0,                     // Device selection (CS)
			PolarityLow,           // Device selection polarity
			FourWireMode,          // wiremode
			8,                     // databit len
			ControllerInitiated,   // slave mode
			4000000,               // connection speed
			ClockPolarityLow,      // clock polarity
			ClockPhaseFirst,       // clock phase
			"\\_SB.SPI5",          // ResourceSource: SPI bus controller name
			,                     // ResourceSourceIndex
			,
			,
			RawDataBuffer()    // VendorData
			{
					0x00,  // Reserved
					0x00,  // DeassertWait
					0x00,  // ClockAlwaysOn
					0x01,  // MXCSMode
					0x00,  // HSMode
					0x00,  // LoopBackMode
			}
				// Resource usage
				// DescriptorName: creates name for offset of resource descriptor
			)   // Vendor Data

		// Index 1 - "I2C0"
		I2CSerialBus(              // I2C0_SCL - GPIO 7 - Pin 15
								   // I2C0_SDA - GPIO 6 - Pin 17
			0xFFFF,                // SlaveAddress: placeholder
			,                      // SlaveMode: default to ControllerInitiated
			0,                     // ConnectionSpeed: placeholder
			,                      // Addressing Mode: default to 7 bit
			"\\_SB.I2C2",          // ResourceSource: I2C bus controller name
			,
			,
			,                      // Descriptor Name: creates name for offset of resource descriptor
			)                      // VendorData
			
		// Index 2 - "I2C1"
		I2CSerialBus(              // I2C1_SCL - GPIO 23 - Pin 19
								   // I2C1_SDA - GPIO 22 - Pin 21
			0xFFFF,                // SlaveAddress: placeholder
			,                      // SlaveMode: default to ControllerInitiated
			0,                     // ConnectionSpeed: placeholder
			,                      // Addressing Mode: default to 7 bit
			"\\_SB.I2C6",          // ResourceSource: I2C bus controller name
			,
			,
			,                      // Descriptor Name: creates name for offset of resource descriptor
			)                      // VendorData

		// Index 5 - GPIO 12 - B
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 12 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 12 }
		// Index 7 - GPIO 13 - C
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 13 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 13 }
		// Index 27 - GPIO 21 - USR_LED_1_CTRL
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 21 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 21 }
		// Index 15 - GPIO 24 - G
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 24 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 24 }
		// Index 17 - GPIO 25 - H
		//GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 25 }
		//GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 25 }
		// Index 23 - GPIO 28 - K
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 28 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 28 }
		// Index 25 - GPIO 33 - L
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 33 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 33 }
		// Index 21 - GPIO 34 - J
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 34 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 34 }
		// Index 19 - GPIO 35 - I
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 35 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 35 }
		// Index 3 - GPIO 36 - A
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 36 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 36 }
		// Index 9 - GPIO 69 - D
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 69 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 69 }
		// Index 11 - GPIO 115 - E
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 115 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 115 }
		// Index 29 - GPIO 21 - USR_LED_2_CTRL
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.GIO0", 0, ResourceConsumer, , ) { 120 }
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.GIO0",)                            { 120 }
		// Index 13 - PMIC MPP 4 - F
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.PM01", 0, ResourceConsumer, , ) { 0x518 }  
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.PM01",)                            { 0x519 }
		// Index 31 - PMIC GPIO 1 - USR_LED_3_CTRL
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.PM01", 0, ResourceConsumer, , ) { 0x600 }  
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.PM01",)                            { 0x600 }
		// Index 33 - PMIC GPIO 2 - USR_LED_4_CTRL
		GpioIO(Shared, PullDown, 0, 0, IoRestrictionNone, "\\_SB.PM01", 0, ResourceConsumer, , ) { 0x608 }  
		GpioInt(Edge, ActiveBoth, Shared, PullDown, 0, "\\_SB.PM01",)                            { 0x608 }

	})

	Name(_DSD, Package()
	{
		ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
		Package()
		{
			// SPI 0
			Package(2) { "bus-SPI-SPI0", Package() { 0 }},                      // Index 0
			Package(2) { "SPI0-MinClockInHz", 1000 },                           // XXX: QCOM to supply minimum valid SPI clock speed in Hz
			Package(2) { "SPI0-MaxClockInHz", 10000000 },                       // XXX: QCOM to supply maximum valid SPI clock speed in Hz
			Package(2) { "SPI0-SupportedDataBitLengths", Package() { 8 }},      // XXX: List other supported data bit lengths here, e.g. 16, 24, 32
			// I2C0
			Package(2) { "bus-I2C-I2C0", Package() { 1 }},                      // Index 1
			// I2C1
			Package(2) { "bus-I2C-I2C1", Package() { 2 }},                      // Index 2

			// XXX: Mask of supported drive modes:
			//  0x1 - InputHighImpedance           // include this flag if driver supports PullNone
			//  0x2 - InputPullUp                  // include this flag if driver supports PullUp
			//  0x4 - InputPullDown                // include this flag if driver supports PullDown
			//  0x8 - OutputCmos                   // always include this flag unless pin should not be driven as an output
			Package (2) { "GPIO-SupportedDriveModes", 0xf },
			
			// XXX: Uncomment the following two lines if you want to expose 
			//      the native pin numbers, e.g. 36, 12, 13 ...
			//      Otherwise, users will see sequential numbers, e.g. 0, 1, 2 ...
			Package (2) { "GPIO-UseDescriptorPinNumbers", 1 },
			Package (2) { "GPIO-PinCount", 0x609 },
		}
	})
}
