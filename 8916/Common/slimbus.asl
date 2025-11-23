//
// SLIMbus controller
//
Device (SLM1)
{
	//Name (_HID, "QCOM240D")
	//Name (_UID, 1)
	Name (_ADR, 0)

	Method (_CRS, 0x0, NotSerialized) 
	{
		Name (RBUF, ResourceTemplate ()
		{
			// SLIMbus register address space
			Memory32Fixed (ReadWrite, 0xfe12f000, 0x0002c000)

			Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {195}
		})
		Return (RBUF)
	}

	Method(FNOC, 0x0, NotSerialized) 
	{
		Name(RBUF, Buffer()
		{
			0x00, // EA[7:0]
			0x00, // EA[15:8]
			0xD0, // EA[23:16]
			0x00, // EA[31:24]
			0x17, // EA[39:32]
			0x02, // EA[47:40]
			0x01, // EE assignment 0
			0x00, // EE assignment 1
			0x02, // EE assignment 2
			0x03, // EE assignment 3
			0x01, // Local EE number
			0x01, // Setup trust assignment
			0x1, // SW workarounds 0
			0x1, // SW workarounds 1
			0x1, // SW workarounds 2
		})
		Return (RBUF)
	}  
}

