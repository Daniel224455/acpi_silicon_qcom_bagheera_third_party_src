//
// Copyright (c) 2015,2018 Qualcomm Technologies, Inc. All rights reserved.
//

//
// UARTBAM1 (BLSP1 UART1) (4-wire UART on SBC)
//
Device (UAR0)
{
    Name (_HID, "QCOM2424")
    Name (_UID, 0)
    Method (_CRS)
    {
        Name (RBUF, ResourceTemplate()
        {
            Memory32Fixed(ReadWrite, 0x078af000, 0x00000100)
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) {139}
            GpioInt(Edge, ActiveLow, Exclusive, PullDown, 0, "\\_SB.GIO0") {1}  // UART RX
        })
        Return (RBUF)
    }
    Method (PROP)
    {
        Name (RBUF, Package()
        {
            "UartClass",            1,  // 0 = UART_DM, 1 = UART_BAM
            "EnableDma",            0,
            "BamBase",     0x07884000,
            "BamPipeTx",            0,
            "BamPipeRx",            1,
            "QgicBase",    0x0b000000,  // for debug purposes
            "ClkrgmBase",  0x01800000,  // for debug purposes
            "TlmmBase",    0x01000000,  // for debug purposes
            "GpioRfrN",             3,  // for debug purposes
            "GpioCtsN",             2,  // for debug purposes
            "GpioRxData",           1,  // for debug purposes
            "GpioTxData",           0,  // for debug purposes
        })
        Return (RBUF)
    }
}

//
// UARTBAM2 (BLSP1 UART2) (loopback testing on DE9 port)
//
Device (UAR1)
{
    Name (_HID, "QCOM2424")
    Name (_UID, 1)
    Method (_CRS)
    {
        Name (RBUF, ResourceTemplate()
        {
            Memory32Fixed(ReadWrite, 0x078b0000, 0x00000100)
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) {140}
            GpioInt(Edge, ActiveLow, Exclusive, PullDown, 0, "\\_SB.GIO0") {5}  // UART RX
        })
        Return (RBUF)
    }
    Method (PROP)
    {
        Name (RBUF, Package()
        {
            "UartClass",            1,  // 0 = UART_DM, 1 = UART_BAM
            "EnableDma",            0,
            "BamBase",     0x07884000,
            "BamPipeTx",            2,
            "BamPipeRx",            3,
            "QgicBase",    0x0b000000,  // for debug purposes
            "ClkrgmBase",  0x01800000,  // for debug purposes
            "TlmmBase",    0x01000000,  // for debug purposes
            "GpioRxData",           5,  // for debug purposes
            "GpioTxData",           4,  // for debug purposes
        })
        Return (RBUF)
    }
}

//
// SPI5
//
Device (SPI5)
{
    Name (_HID, "QCOM240C")
    Name (_UID, 5)
    Name (_DEP, Package(){\_SB_.PEP0, \_SB_.BAM3})
    Method (_CRS)
    {
        Name (RBUF, ResourceTemplate()
        {
            Memory32Fixed(ReadWrite, 0x078b9000, 0x00000800)
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive) {131}
        })
        Return (RBUF)
    }
    Method (FNOC)
    {
         Name(RBUF, Buffer()
         {
             0x05,  // Controller Number
             0x00,  // BamBaseAddress
             0x40,  // BamBaseAddress
             0x88,  // BamBaseAddress
             0x07,  // BamBaseAddress
             0x0D,  // Input Pipe
             0x0C,  // Output Pipe
             0x00,  // Threshold
             0x01   // Threshold
        })
        Return (RBUF)
    }
	
    // Frequency to P-state Mapping table.
    // Table should contain the frequency values in ascending order.
    // Corresponding position value is used as a p-state index
    Method (FTPM)
    {
        Return
        (
            Package ()
            {
               960000,  // P-state 0
              4800000,  // P-state 1
              9600000,  // P-state 2
             16000000,  // P-state 3
             19200000,  // P-state 4
             25000000,  // P-state 5
             50000000   // P-state 6
            }
        )
    }
}

//
// I2C2 - "Core I2C Bus"
//
Device (I2C2)
{
    Name (_HID, "QCOM240E")
    Name (_UID, 2)
    Name (_DEP, Package(0x2)
    {
        \_SB_.BAM3,
        \_SB_.PEP0
    })

    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            // QUP register address space
            Memory32Fixed (ReadWrite, 0x078B6000, 0x00000600)

            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {128}
        })
        Return (RBUF)
    }

    Method(FNOC, 0x0, NotSerialized) {
        Name(RBUF, Buffer()
            {
                0x02,       // Controller Number
                0x01,       // BAM Mode 1=ON, 0=OFF
                0x00,
                0x40,
                0x88,
                0x07,       // BamBaseAddress
                0x07,       // Input Pipe
                0x06,       // Output Pipe
                0x00,
                0x04,       // Threshold
                0x00,       // Source Clock Frequency
                0xF8,
                0x24,
                0x01
            })
        Return (RBUF)
    }
}

//
// I2C4 - "Core I2C Bus"
//
Device (I2C4)
{
    Name (_HID, "QCOM240E")
    Name (_UID, 4)
    Name (_DEP, Package(0x2)
    {
        \_SB_.BAM3,
        \_SB_.PEP0
    })

    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            // QUP register address space
            Memory32Fixed (ReadWrite, 0x078B8000, 0x00000600)

            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {130}
        })
        Return (RBUF)
    }

    Method(FNOC, 0x0, NotSerialized) {
        Name(RBUF, Buffer()
            {
                0x04,       // Controller Number
                0x01,       // BAM Mode 1=ON, 0=OFF
                0x00,
                0x40,
                0x88,
                0x07,       // BamBaseAddress
                0x0B,       // Input Pipe
                0x0A,       // Output Pipe
                0x00,
                0x04,       // Threshold
                0x00,       // Source Clock Frequency
                0xF8,
                0x24,
                0x01
            })
        Return (RBUF)
    }
}

//
// I2C6 - "Core I2C Bus"
//
Device (I2C6)
{
    Name (_HID, "QCOM240E")
    Name (_UID, 6)
    Name (_DEP, Package(0x2)
    {
        \_SB_.BAM3,
        \_SB_.PEP0
    })

    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            // QUP register address space
            Memory32Fixed (ReadWrite, 0x078BA000, 0x00000600)

            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {132}
        })
        Return (RBUF)
    }

    Method(FNOC, 0x0, NotSerialized) {
        Name(RBUF, Buffer()
            {
                0x06,       // Controller Number
                0x01,       // BAM Mode 1=ON, 0=OFF
                0x00,
                0x40,
                0x88,
                0x07,       // BamBaseAddress
                0x0F,       // Input Pipe
                0x0E,       // Output Pipe
                0x00,
                0x04,       // Threshold
                0x00,       // Source Clock Frequency
                0xF8,
                0x24,
                0x01
            })
        Return (RBUF)
    }
}

// 
//  PEP resources for buses
//
Scope(\_SB_.PEP0)
{
    Method(BSMD)
    {
        Return(BSRC)
    }

    Name(BSRC, Package()
    {
        /////////////////////////////////////////////////////////////////////////////////////

        Package()
        {
            "DEVICE", "\\_SB.UAR0",

            Package()
            {
                "COMPONENT", 0,  // UART resources

                Package()
                {
                    "FSTATE", 0,  // enable UART clocks
                    Package(){"CLOCK",  Package(){"gcc_blsp1_ahb_clk",        1, 0, 4}},
                    Package(){"CLOCK",  Package(){"gcc_blsp1_uart1_apps_clk", 1, 0, 4}},
                    Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 500000}},
                },

                Package()
                {
                    "FSTATE", 1,  // disable UART clocks
                    Package(){"CLOCK",  Package(){"gcc_blsp1_ahb_clk",        2, 0, 4}},
                    Package(){"CLOCK",  Package(){"gcc_blsp1_uart1_apps_clk", 2, 0, 4}},
                    Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0}},
                },

                Package()
                {
                    "PSTATE", 0,  // enable GPIOs
                    Package(){"TLMMGPIO", Package(){ 3, 0, 2, 0, 0, 0 }},
                    Package(){"TLMMGPIO", Package(){ 2, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 1, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 0, 0, 2, 0, 0, 0 }},
                },

                Package()
                {
                    "PSTATE", 1,  // disable GPIOs
                    Package(){"TLMMGPIO", Package(){ 3, 0, 2, 0, 0, 0 }},
                    Package(){"TLMMGPIO", Package(){ 2, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 1, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 0, 0, 2, 0, 0, 0 }},
                },

                Package(){"PSTATE",  2, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3,  7372800, 4}}},
                Package(){"PSTATE",  3, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 14745600, 4}}},
                Package(){"PSTATE",  4, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 16000000, 4}}},
                Package(){"PSTATE",  5, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 24000000, 4}}},
                Package(){"PSTATE",  6, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 32000000, 4}}},
                Package(){"PSTATE",  7, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 40000000, 4}}},
                Package(){"PSTATE",  8, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 48000000, 4}}},
                Package(){"PSTATE",  9, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 51200000, 4}}},
                Package(){"PSTATE", 10, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 56000000, 4}}},
                Package(){"PSTATE", 11, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 58982400, 4}}},
                Package(){"PSTATE", 12, Package(){"CLOCK", Package(){"gcc_blsp1_uart1_apps_clk", 3, 64000000, 4}}},
            },

            Package()
            {
                "COMPONENT", 1,  // DMA resources
                Package(){"FSTATE", 0},  // enable DMA clocks
                Package(){"FSTATE", 1},  // disable DMA clocks
            },
        },

        /////////////////////////////////////////////////////////////////////////////////////

        Package()
        {
            "DEVICE", 
			0x02, // debug device			
			"\\_SB.UAR1",


            Package()
            {
                "COMPONENT", 0,  // UART resources

                Package()
                {
                    "FSTATE", 0,  // enable UART clocks
                    Package(){"CLOCK",  Package(){"gcc_blsp1_ahb_clk",        1, 0, 4}},
                    Package(){"CLOCK",  Package(){"gcc_blsp1_uart2_apps_clk", 1, 0, 4}},
                    Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 500000}},
                },

                Package()
                {
                    "FSTATE", 1,  // disable UART clocks
                    Package(){"CLOCK",  Package(){"gcc_blsp1_ahb_clk",        2, 0, 4}},
                    Package(){"CLOCK",  Package(){"gcc_blsp1_uart2_apps_clk", 2, 0, 4}},
                    Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0}},
                },

                Package()
                {
                    "PSTATE", 0,  // enable GPIOs
                    Package(){"TLMMGPIO", Package(){ 5, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 4, 0, 2, 0, 0, 0 }},
                },

                Package()
                {
                    "PSTATE", 1,  // disable GPIOs
                    Package(){"TLMMGPIO", Package(){ 5, 0, 2, 0, 1, 0 }},
                    Package(){"TLMMGPIO", Package(){ 4, 0, 2, 0, 0, 0 }},
                },

                Package(){"PSTATE",  2, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3,  7372800, 4}}},
                Package(){"PSTATE",  3, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 14745600, 4}}},
                Package(){"PSTATE",  4, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 16000000, 4}}},
                Package(){"PSTATE",  5, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 24000000, 4}}},
                Package(){"PSTATE",  6, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 32000000, 4}}},
                Package(){"PSTATE",  7, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 40000000, 4}}},
                Package(){"PSTATE",  8, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 48000000, 4}}},
                Package(){"PSTATE",  9, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 51200000, 4}}},
                Package(){"PSTATE", 10, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 56000000, 4}}},
                Package(){"PSTATE", 11, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 58982400, 4}}},
                Package(){"PSTATE", 12, Package(){"CLOCK", Package(){"gcc_blsp1_uart2_apps_clk", 3, 64000000, 4}}},
            },

            Package()
            {
                "COMPONENT", 1,  // DMA resources
                Package(){"FSTATE", 0},  // enable DMA clocks
                Package(){"FSTATE", 1},  // disable DMA clocks
            },
        },
 
        /////////////////////////////////////////////////////////////////////////////////////

        Package()
        {
            "DEVICE", "\\_SB.SPI5",

            Package()
            {
                "COMPONENT", 0,

                Package() {"FSTATE", 0},

                // /*
                // * QUP SPI clock configurations.
                // */
                // const ClockMuxConfigType  QUPSPIClockConfig[] =
                // {
                //  {    960000,     { HAL_CLK_SOURCE_XO,    20,  1,   2,   2 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {   4800000,     { HAL_CLK_SOURCE_XO,     8,  0,   0,   0 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {   9600000,     { HAL_CLK_SOURCE_XO,     4,  0,   0,   0 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {  16000000,     { HAL_CLK_SOURCE_GPLL0, 20,  1,   5,   5 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {  19200000,     { HAL_CLK_SOURCE_XO,     2,  0,   0,   0 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {  25000000,     { HAL_CLK_SOURCE_GPLL0, 32,  1,   2,   2 }, CLOCK_VREG_LEVEL_LOW,     { {0, 0}, {0xFF, 0xFF} } },
                //  {  50000000,     { HAL_CLK_SOURCE_GPLL0, 32,  0,   0,   0 }, CLOCK_VREG_LEVEL_NOMINAL, { {0, 0}, {0xFF, 0xFF} } },
                //  { 0 }
                // };

                Package(){"PSTATE", 0, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 960000, 3}}},
                Package(){"PSTATE", 1, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 4800000, 3}}},
                Package(){"PSTATE", 2, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 9600000, 3}}},
                Package(){"PSTATE", 3, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 16000000, 3}}},
                Package(){"PSTATE", 4, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 19200000, 3}}},
                Package(){"PSTATE", 5, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 25000000, 3}}},
                Package(){"PSTATE", 6, Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 3, 50000000, 3}}},
            },

            Package()
            {
                "DSTATE", 0,  // enable clocks, enable GPIOs

                Package(){"CLOCK", Package(){"gcc_blsp1_ahb_clk",           1, 0, 1}},
                Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 1, 0, 1}},

                Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 6250000}},

                Package(){"TLMMGPIO", Package(){ 16, 0, 1, 0, 1, 0}},  // MOSI
                Package(){"TLMMGPIO", Package(){ 17, 0, 1, 0, 1, 0}},  // MISO
                Package(){"TLMMGPIO", Package(){ 18, 0, 1, 0, 3, 0}},  // CS
                Package(){"TLMMGPIO", Package(){ 19, 0, 1, 0, 3, 0}},  // CLK
            },

            Package() {"DSTATE", 1,},
            Package() {"DSTATE", 2,},

            Package()
            {
                "DSTATE", 3,  // disable clocks, disable GPIOs

                Package(){"CLOCK", Package(){"gcc_blsp1_ahb_clk",           2, 0, 1}},
                Package(){"CLOCK", Package(){"gcc_blsp1_qup5_spi_apps_clk", 2, 0, 1}},

                Package(){"BUSARB", Package(){3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0}},

                Package(){"TLMMGPIO", Package(){ 16, 0, 0, 0, 1, 0}},  // MOSI
                Package(){"TLMMGPIO", Package(){ 17, 0, 0, 0, 1, 0}},  // MISO
                Package(){"TLMMGPIO", Package(){ 18, 0, 0, 0, 3, 0}},  // CS
                Package(){"TLMMGPIO", Package(){ 19, 0, 0, 0, 1, 0}},  // CLK
            },
        },

        /////////////////////////////////////////////////////////////////////////////////////
        
        Package()
        {
            "DEVICE",
            "\\_SB.I2C2",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                },
            },
            Package()
            {
                "DSTATE",
                0x0, // D0 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 1, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup2_i2c_apps_clk", 8, 19200000, 4}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 153600000, 0 }},

                // Configure SDA and then SCL
                package() {"TLMMGPIO", package() {6, 1, 3, 1, 3, 0}},
                package() {"TLMMGPIO", package() {7, 1, 3, 1, 3, 0}},
            },
            Package()
            {
                "DSTATE",
                0x1, // D1 state
            },
            Package()
            {
                "DSTATE",
                0x2, // D2 state
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 2, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup2_i2c_apps_clk", 2, 19200000, 1}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0 }},

                // Configure SCL and then SDA
                package() { "TLMMGPIO", package() {7, 0, 0, 0, 3, 0}},
                package() { "TLMMGPIO", package() {6, 0, 0, 0, 3, 0}},
            },
        },
        
        ///////////////////////////////////////////////////////////////////////////////////////

        Package()
        {
            "DEVICE",
            "\\_SB.I2C4",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                },
            },
            Package()
            {
                "DSTATE",
                0x0, // D0 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 1, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup4_i2c_apps_clk", 8, 19200000, 4}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 153600000, 0 }},
                
                // Configure SDA and then SCL
                package() {"TLMMGPIO", package() {14, 1, 2, 1, 3, 0}},
                package() {"TLMMGPIO", package() {15, 1, 2, 1, 3, 0}},
            },
            Package()
            {
                "DSTATE",
                0x1, // D1 state
            },
            Package()
            {
                "DSTATE",
                0x2, // D2 state
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 2, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup4_i2c_apps_clk", 2, 19200000, 1}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0 }},

                // Configure SCL and then SDA
                package() { "TLMMGPIO", package() {15, 0, 0, 0, 3, 0}},
                package() { "TLMMGPIO", package() {14, 0, 0, 0, 3, 0}},
            },
        },

        /////////////////////////////////////////////////////////////////////////////////////
        
        Package()
        {
            "DEVICE",
            "\\_SB.I2C6",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                },
            },
            Package()
            {
                "DSTATE",
                0x0, // D0 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 1, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup6_i2c_apps_clk", 8, 19200000, 4}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 153600000, 0 }},

                // Configure SDA and then SCL
                package() {"TLMMGPIO", package() {22, 1, 2, 1, 3, 0}},
                package() {"TLMMGPIO", package() {23, 1, 2, 1, 3, 0}},
            },
            Package()
            {
                "DSTATE",
                0x1, // D1 state
            },
            Package()
            {
                "DSTATE",
                0x2, // D2 state
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
                package() {"CLOCK", package() {"gcc_blsp1_ahb_clk", 2, 100000000, 1}},
                package() {"CLOCK", package() {"gcc_blsp1_qup6_i2c_apps_clk", 2, 19200000, 1}},
                package() {"BUSARB", package() {3, "ICBID_MASTER_BLSP_1", "ICBID_SLAVE_EBI1", 0, 0 }},

                // Configure SCL and then SDA
                package() { "TLMMGPIO", package() {23, 0, 0, 0, 3, 0}},
                package() { "TLMMGPIO", package() {22, 0, 0, 0, 3, 0}},
            },
        },
    })
}

