//===========================================================================
//                           <qdss_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by qdss driver.
//
//
//   Copyright (c) 2010-2013 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================

//===========================================================================
// Description & Possible use cases for Qdss's  p-state implementation
// Qdss employs pstate-sets to robustly configure clock and tlmm registers
// pstate-set 0 has pstates for clock frequencies
// pstate-set 1 has pstates for managing tlmm registers for tpiu operation
//========================================================
//      Sinks              p-states allowed
//--------------------------------------------------------
//     non-TPIU            P{0,0}
//                         P{0,1}
//                         P{0,2}
//                         P{0,3}
//       TPIU              P{0,0} AND (P{1,1} OR P{1,3})
//                         P{0,1} AND (P{1,0} OR P{1,2})
//                         P{0,2} AND (P{1,0} OR P{1,2})
//                         P{0,3} AND (P{1,0} OR P{1,2})
//
// Description of pstate-sets and corresponding p-states :
//  pstate-set-0 is the set with allowed qdss clock frequencies
//  under set-0 each p-state holds the following meaning:
//      pstate-0 CLOCK OFF (0 Hz)
//      pstate-1 SVS CLOCK FREQUENCY  (depends on the voltage; ranges 150 to 300 MHz)
//      pstate-2 HIGH CLOCK FREQUENCY (300 MHz)
//      pstate-3 LOW CLOCK FREQUENCY  (150 MHz)
//
//  under set-1 each p-state hold the following meaning:
//      pstate-0 sets SET-B TLMM registers to make TPIU operational
//      pstate-1 clears SET-B TLMM registers to make TPIU operational
//      pstate-0 sets SD TLMM registers to make TPIU operational
//      pstate-0 clears SD TLMM registers to make TPIU operational
//===========================================================================

Scope(\_SB.PEP0)
{
    Method(QDMD){
        Return(QDSC)
    }

    Name(QDSC,
    Package()
    {
        Package()
        {
            "DEVICE",
            "\\_SB.QDSS",
            Package()
            {
                "COMPONENT",
                0x0,
                Package()
                {
                    "FSTATE",
                    0x0,
                },
                Package()
                {
                    "FSTATE",
                    0x1,
                    Package() {"PSTATE_ADJUST", Package() {0, 0},},
                },
                Package()
                {
                    "PSTATE_SET",
                    0x0,
                    // p-state for turning off the clock
                    Package()
                    {
                        "PSTATE",
                        0x0,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 0},},
                    },
                    // p-state for setting the clock to SVS mode (depends on the voltage)
                    Package()
                    {
                        "PSTATE",
                        0x1,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 1},},
                    },
                    // p-state for high speed clock
                    Package()
                    {
                        "PSTATE",
                        0x2,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 2},},
                    },
                    // p-state for low speed mode
                    Package()
                    {
                        "PSTATE",
                        0x3,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 3},},
                    },
                },
                Package()
                {
                    "PSTATE_SET",
                    0x1,
                    // p-state for enabling SET-B TPIU TLMM
                    package()
                    {
                        "PSTATE",
                        0x0,
                        package() {"TLMMPORT", package() {0x10f0, 0x01c8, 0x01c8},},
                        package() {"TLMMPORT", package() {0x1100, 0x01c8, 0x01c8},},
                        package() {"TLMMPORT", package() {0x1110, 0x01c8, 0x01c8},},
                        package() {"TLMMPORT", package() {0x1120, 0x01c8, 0x01c8},},
                        package() {"TLMMPORT", package() {0x1130, 0x01d4, 0x01d4},},
                        package() {"TLMMPORT", package() {0x1140, 0x01d4, 0x01d4},},
                        package() {"TLMMPORT", package() {0x1150, 0x01d4, 0x01d4},},
                        package() {"TLMMPORT", package() {0x1160, 0x01d4, 0x01d4},},
                        package() {"TLMMPORT", package() {0x1170, 0x01d8, 0x01d8},},
                        package() {"TLMMPORT", package() {0x1180, 0x01d8, 0x01d8},},
                        package() {"TLMMPORT", package() {0x1190, 0x01d8, 0x01d8},},
                        package() {"TLMMPORT", package() {0x11a0, 0x01dc, 0x01dc},},
                        package() {"TLMMPORT", package() {0x11b0, 0x01dc, 0x01dc},},
                        package() {"TLMMPORT", package() {0x11c0, 0x01d4, 0x01d4},},
                        package() {"TLMMPORT", package() {0x1590, 0x01c8, 0x01c8},},
                        package() {"TLMMPORT", package() {0x15a0, 0x01cc, 0x01cc},},
                        package() {"TLMMPORT", package() {0x15b0, 0x01cc, 0x01cc},},
                        package() {"TLMMPORT", package() {0x15c0, 0x01cc, 0x01cc},},
                    },
                    // p-state for disabling SET-B TPIU TLMM
                    package()
                    {
                        "PSTATE",
                        0x1,
                        package() {"TLMMPORT", package() {0x10f0, 0x01c8, 0x0},},
                        package() {"TLMMPORT", package() {0x1100, 0x01c8, 0x0},},
                        package() {"TLMMPORT", package() {0x1110, 0x01c8, 0x0},},
                        package() {"TLMMPORT", package() {0x1120, 0x01c8, 0x0},},
                        package() {"TLMMPORT", package() {0x1130, 0x01d4, 0x0},},
                        package() {"TLMMPORT", package() {0x1140, 0x01d4, 0x0},},
                        package() {"TLMMPORT", package() {0x1150, 0x01d4, 0x0},},
                        package() {"TLMMPORT", package() {0x1160, 0x01d4, 0x0},},
                        package() {"TLMMPORT", package() {0x1170, 0x01d8, 0x0},},
                        package() {"TLMMPORT", package() {0x1180, 0x01d8, 0x0},},
                        package() {"TLMMPORT", package() {0x1190, 0x01d8, 0x0},},
                        package() {"TLMMPORT", package() {0x11a0, 0x01dc, 0x0},},
                        package() {"TLMMPORT", package() {0x11b0, 0x01dc, 0x0},},
                        package() {"TLMMPORT", package() {0x11c0, 0x01d4, 0x0},},
                        package() {"TLMMPORT", package() {0x1590, 0x01c8, 0x0},},
                        package() {"TLMMPORT", package() {0x15a0, 0x01cc, 0x0},},
                        package() {"TLMMPORT", package() {0x15b0, 0x01cc, 0x0},},
                        package() {"TLMMPORT", package() {0x15c0, 0x01cc, 0x0},},
                    },
                    // p-state for enabling TPIU SD
                    package()
                    {
                        "PSTATE",
                        0x2,
                        package() {"TLMMPORT", package() {0x2048, 0x016d, 0x016d},},
                        package() {"TLMMPORT", package() {0x2014, 0x0001, 0x0001},},
                        package()
                        {
                            "PMICVREGVOTE", // PMIC VREG resource
                            package()
                            {
                                "PPP_RESOURCE_ID_LDO21_A", // LDO21 for keeping SD Card Voltage up
                                1,       // Voltage Reg  = LDO
                                2950000, // Voltage      = 2.950 Volts
                                9000,    // Peak Current = 9.000 mAmps
                                1, // SW Enable      = Enable
                                0, // Pin Enable     = None
                                1, // SW Power Mode  = NPM
                                0, // Pin Power Mode = None
                                0, // Bypass Enable  = Allowed
                                0, // Head Room
                            },
                        },
                        package()
                        {
                            "PMICVREGVOTE", // PMIC VREG resource
                            package()
                            {
                                "PPP_RESOURCE_ID_LDO13_A", // LDO13 for keeping SD IO Pad voltage up
                                1,       // Voltage Reg  = LDO
                                2950000, // Voltage      = 2.950 Volts
                                6,       // Peak Current = 0.006 mAmps
                                1, // SW Enable      = Enable
                                0, // Pin Enable     = None
                                1, // SW Power Mode  = NPM
                                0, // Pin Power Mode = None
                                0, // Bypass Enable  = Allowed
                                0, // Head Room
                            },
                        },
                    },
                    // p-state for disabling TPIU SD
                    package()
                    {
                        "PSTATE",
                        0x3,
                        package() {"TLMMPORT", package() {0x2048, 0x016d, 0x0},},
                        package() {"TLMMPORT", package() {0x2014, 0x0001, 0x0},},
                        package()
                        {
                            "PMICVREGVOTE", // PMIC VREG resource
                            package()
                            {
                                "PPP_RESOURCE_ID_LDO21_A", // LDO21 for shutting down SD Voltage
                                1, // Voltage Reg    = LDO
                                0, // Voltage        = 0 Volts
                                0, // Peak Current   = 0 mAmps
                                0, // SW Enable      = Disable
                                0, // Pin Enable     = None
                                0, // SW Power Mode  = LPM
                                0, // Pin Power Mode = None
                                0, // Bypass Enable  = Allowed
                                0, // Head Room
                            },
                        },
                        package()
                        {
                            "PMICVREGVOTE", // PMIC VREG resource
                            package()
                            {
                                "PPP_RESOURCE_ID_LDO13_A", // LDO13 for shutting down SD IO Pad voltage
                                1, // Voltage Reg    = LDO
                                0, // Voltage        = 2 Volts
                                0, // Peak Current   = 0 mAmps
                                0, // SW Enable      = Disable
                                0, // Pin Enable     = None
                                0, // SW Power Mode  = LPM
                                0, // Pin Power Mode = None
                                0, // Bypass Enable  = Allowed
                                0, // Head Room
                            },
                        },
                    },
                },
                // pstate-set for enabling the HWEVT Mux clocks
                // for subsystems that are under Qdss address map
                // *the convention followed in the code is for a mux enable state is
                // immediately followed by disable state.*
                // e.g. as in 0 is to enable mmss clock and 0+1 is to disable mmss clock
                Package()
                {
                    "PSTATE_SET",
                    0x2,
                    // p-state for setting the /clk/qdss
                    package()
                    {
                        "PSTATE",
                        0x0,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 1},},
                    },
                    // p-state for shutting of the qdss clock
                    package()
                    {
                        "PSTATE",
                        0x1,
                        package() {"REQUIRED_RESOURCE", package() {1, "/clk/qdss", 0},},
                    },
                },
            },
        },
    })
}
