//===========================================================================
//                           <camera_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by camera drivers.
//
//
//   Copyright (c) 2010-2014 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================


Scope(\_SB_.PEP0)
{
    // CAMERA
    Method(CPMD)
    {
        Return(CPCC)
    }

    // Exa-SoC Devices
    Method(CPMX)
    {
        Return (CPXC)
    }

    Name(CPCC, Package()
    {
        Package()
        {
            "DEVICE",
            "\\_SB.JPGE",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0
                Package()
                {
                    "FSTATE",
                    0x0, // F0 State

                    // Footswitch
                    package() { "FOOTSWITCH", package() { "VDD_CAMSS_JPEG", 1 }},
                    
                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",  400000000,          0 }},

                    // Pstate for bandwidth. P2 state
                    package() { "PSTATE_ADJUST",     package() { 1, 2 }},

                    //                               Req                                                         IB           AB
                    //                               Type           Master                     Slave             Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------   -----------  -----------
                    package() { "BUSARB", Package() { 3,     "ICBID_MASTER_JPEG",        "ICBID_SLAVE_EBI1",     360000000,   360000000 } },

                                                    // Action:       1 == ENABLE 3 == SET_FREQ   8 = Set frequency and enable
                                                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST                                
                                                    // Clock Name                 Action     Frequency            MatchType
                                                    // ----------                 ------     ----------           ----------
                    package() { "CLOCK", package() { "gcc_camss_top_ahb_clk",           1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_camss_ahb_clk",               8,        80000000,             3      }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg0_clk",             1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg_axi_clk",          1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg_ahb_clk",          1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_jpeg_tbu_clk",                1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_smmu_cfg_clk",                1,       000000000,             1,     }     },
                    package() { "CLOCK", package() { "gcc_apss_tcu_clk",                1,       000000000,             1,     }     },
                    // Pstate adjust for clock frequencies. P2 state
                    package() { "PSTATE_ADJUST", Package () { 0, 2 }},   
                },
                Package()
                {
                    "FSTATE",
                    0x1, // F1 State
                    package() { "CLOCK", package() { "gcc_apss_tcu_clk",              2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_smmu_cfg_clk",              2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_jpeg_tbu_clk",             2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg_ahb_clk",       2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg_axi_clk",       2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_camss_jpeg0_clk",          2,       0,             0,     }     },
                    package() { "CLOCK", package() { "gcc_camss_ahb_clk",            2,       0,             3,     }     },
                    package() { "CLOCK", package() { "gcc_camss_top_ahb_clk",        2,       0,             0,     }     },

                    //                                   Req                                                         IB           AB
                    //                                   Type           Master                     Slave             Bytes/Sec    Bytes/Sec
                    //                                   ----   -----------------------    ----------------------   -----------  -----------
                    Package() { "BUSARB", Package()     { 3,    "ICBID_MASTER_JPEG",          "ICBID_SLAVE_EBI1",     0,           0 } },
                    Package() { "PSTATE_ADJUST",     package() { 1, 3 }},
                    
                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",          0,          0 }},

                    Package() { "FOOTSWITCH", Package() { "VDD_CAMSS_JPEG",         2 }},
                },
                // P-state set 0: Clock frequency adjustments
                Package()
                {
                    "PSTATE_SET",
                    0,
                    // Turbo mode
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        Package(){ "CLOCK", Package(){ "gcc_camss_jpeg0_clk",              3,       320000000,       3,     }},
                    },
                    // Nominal max
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        Package(){ "CLOCK", Package(){ "gcc_camss_jpeg0_clk",              3,       266670000,       3,     }},
                    },
                    // Standby mode
                    Package()
                    { 
                        "PSTATE", 
                        2,
                        Package(){ "CLOCK", Package(){ "gcc_camss_jpeg0_clk",              3,        80000000,       3,     }},
                    },
                },
                // P-state set 1: Bandwidth adjustments
                Package()
                {
                    "PSTATE_SET",
                    1,
                    // Turbo mode
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_JPEG",          "ICBID_SLAVE_EBI1",     768000000, 768000000 } },
                    },
                    // Nominal max
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_JPEG",          "ICBID_SLAVE_EBI1",     638400000, 638400000 } },
                    },
                    // Standby mode
                    Package()
                    { 
                        "PSTATE", 
                        2,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_JPEG",          "ICBID_SLAVE_EBI1",     128000000, 128000000 } },
                    },
                    // Off
                    Package()
                    {   
                        "PSTATE", 
                        3,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_JPEG",          "ICBID_SLAVE_EBI1",     000000000, 000000000 } },
                    },
                },
            },
        },
       
        //Device CAMP Data
        Package()
        {
            "DEVICE",
            "\\_SB.CAMP",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                    
                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",  400000000,          0 }},

                    // Action:       1 == ENABLE 2 == DISABLE 3 == SET_FREQ 8 == EN_SETFREQ
                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //                                  Clock Name                 Action     Frequency        MatchType
                    //                                  ----------                 ------     ----------       ----------
                    
                    package(){ "CLOCK", package(){ "gcc_camss_top_ahb_clk",           1,         0,              1     }},
                    package(){ "CLOCK", package(){ "gcc_camss_cci_ahb_clk",           8,         80000000,       3     }},
                    package(){ "CLOCK", package(){ "gcc_camss_cci_clk",               8,         19200000,       3     }},
                    package(){ "CLOCK", package(){ "gcc_camss_ahb_clk",               8,         80000000,       3     }},
                    package(){ "CLOCK", package(){ "gcc_camss_gp0_clk",               8,         200000000,      3     }},
                    package(){ "CLOCK", package(){ "gcc_camss_gp1_clk",               8,         200000000,      3     }},
                   

                    //                                   PIN   State     Func    Sel Direction PullDriveStrength
                    //Common for All CAM
                    package(){ "TLMMGPIO",  package(){     29,      1,     1,      1,     3,     0,},    }, // TLMMGPIO resource CAM_CCI_SDA0 2 mA
                    package(){ "TLMMGPIO",  package(){     30,      1,     1,      1,     3,     0,},    }, // TLMMGPIO resource CAM_CCI_SCL0

                    //CAM1 & CAM2 - Main(Rear) & WebCam(Front)
                    package(){ "TLMMGPIO",  package(){     26,      1,     1,      1,     0,     2,},    }, // TLMMGPIO resource CAM_MCLK0 6mA
                    package(){ "TLMMGPIO",  package(){     27,      1,     1,      1,     0,     2,},    },                     
                    
                    // 8MP VANA VDDA
                    // 1MP VANA VDDA
                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {
                            "PPP_RESOURCE_ID_LDO2_A", // VREG ID
                            1,         // Voltage Regulator type = LDO
                            1200000,   // Voltage is in micro volts
                            165000,     // Peak current in microamps
                            1,         // force enable from software
                            0,         // disable pin control enable
                            1,         // power mode - Normal Power Mode
                            0,         // power mode pin control - disable
                            0,         // bypass mode allowed
                            0,         // head room voltage
                        },
                    },

                    //CAMERA_MIPI_8MP_PIEZIO_VDD
                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {
                            "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                            1,          // Voltage Regulator type = LDO
                            1800000,    // Voltage is in micro volts on 89
                            300000,      // Peak current in microamps
                            1,          // force enable from software
                            0,          // disable pin control enable
                            1,          // power mode - Normal Power Mode
                            0,          // power mode pin control - disable
                            0,          // bypass mode allowed
                            0,          // head room voltage
                        },
                    },
                    
                    //CAMERA_MIPI_8MP_PIEZIO_VDD
                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {
                            "PPP_RESOURCE_ID_LDO10_A", // VREG ID
                            1,          // Voltage Regulator type = LDO
                            2800000,    // Voltage is in micro volts on 89
                            150000,      // Peak current in microamps
                            1,          // force enable from software
                            0,          // disable pin control enable
                            1,          // power mode - Normal Power Mode
                            0,          // power mode pin control - disable
                            0,          // bypass mode allowed
                            0,          // head room voltage
                        },
                    },
                    
                    //CAMERA_MIPI_8MP_PIEZIO_VDD
                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {
                            "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                            1,          // Voltage Regulator type = LDO
                            2850000,    // Voltage is in micro volts on 89
                            600000,      // Peak current in microamps
                            1,          // force enable from software
                            0,          // disable pin control enable
                            1,          // power mode - Normal Power Mode
                            0,          // power mode pin control - disable
                            0,          // bypass mode allowed
                            0,          // head room voltage
                        },
                    },
                    package()
                    {
                        "DELAY", // Clock resource
                        package()
                        {
                            10,  // 10 Milsec delay
                        }
                    },
                },
                Package()
                {
                    "FSTATE",
                    0x1, // f1 state

                    package(){ "TLMMGPIO",  package(){     26,      0,     0,      0,     1,     0,},    }, // TLMMGPIO resource CAM_MCLK0   
                    package(){ "TLMMGPIO",  package(){     30,      0,     0,      0,     1,     0,},    }, // TLMMGPIO resource CAM_CCI_SCL0
                    package(){ "TLMMGPIO",  package(){     29,      0,     0,      0,     1,     0,},    }, // TLMMGPIO resource CAM_CCI_SDA0
                 
                    package(){ "CLOCK",     package(){ "gcc_camss_gp1_clk",              2,          0,              3,     }},
                    package(){ "CLOCK",     package(){ "gcc_camss_gp0_clk",              2,          0,              3,     }},
                    package(){ "CLOCK",     package(){ "gcc_camss_ahb_clk",              2,          0,              3,     }},
                    package(){ "CLOCK",     package(){ "gcc_camss_cci_clk",              2,          0,              3,     }},
                    package(){ "CLOCK",     package(){ "gcc_camss_cci_ahb_clk",          2,          0,              1,     }},
                    package(){ "CLOCK",     package(){ "gcc_camss_top_ahb_clk",          2,          0,              1,     }},

                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",          0,          0 }},

                    Package()
                    {
                        //CAMERA_MIPI_8MP_PIEZIO_VDD
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {
                           "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                           1,      // Voltage Regulator type = LDO
                           0,      // Voltage is in micro volts on 89
                           0,      // Peak current in microamps
                           0,      // force enable from software
                           0,      // disable pin control enable
                           1,      // power mode - Normal Power Mode
                           0,      // power mode pin control - disable
                           0,      // bypass mode allowed
                           0,      // head room voltage
                        },
                    },
                   
                    Package()
                    {
                       //CAMERA_MIPI_8MP_PIEZIO_VDD
                       "PMICVREGVOTE", // PMICVREGVOTE resource
                       Package()
                       {
                           "PPP_RESOURCE_ID_LDO10_A", // VREG ID
                           1,      // Voltage Regulator type = LDO
                           0,      // Voltage is in micro volts on 89
                           0,      // Peak current in microamps
                           0,      // force enable from software
                           0,      // disable pin control enable
                           1,      // power mode - Normal Power Mode
                           0,      // power mode pin control - disable
                           0,      // bypass mode allowed
                           0,      // head room voltage
                       },
                    },
                   
                    Package()
                    {
                       //CAMERA_MIPI_8MP_PIEZIO_VDD
                       "PMICVREGVOTE", // PMICVREGVOTE resource
                       Package()
                       {
                           "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                           1,      // Voltage Regulator type = LDO
                           0,      // Voltage is in micro volts on 89
                           0,      // Peak current in microamps
                           0,      // force enable from software
                           0,      // disable pin control enable
                           1,      // power mode - Normal Power Mode
                           0,      // power mode pin control - disable
                           0,      // bypass mode allowed
                           0,      // head room voltage
                       },
                    },
                   
                   
                    Package()
                    {
                       //CAMERA_MIPI_8MP_PIEZIO_VDD
                       "PMICVREGVOTE", // PMICVREGVOTE resource
                       Package()
                       {
                            "PPP_RESOURCE_ID_LDO2_A", // VREG ID
                            1,      // Voltage Regulator type = LDO
                            0,      // Voltage is in micro volts on 89
                            0,      // Peak current in microamps
                            0,      // force enable from software
                            0,      // disable pin control enable
                            0,      // power mode - Low Power Mode
                            0,      // power mode pin control - disable
                            0,      // bypass mode allowed
                            0,      // head room voltage
                       },
                    },
                },
            },
        },
        //Device VFE0 Data
        Package()
        {
            "DEVICE",
            "\\_SB.VFE0",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // F0 state
          
                    Package(){ "FOOTSWITCH", Package(){ "VDD_CAMSS_VFE",           1    }},
                    Package(){"PSTATE_ADJUST", Package () { 1, 3 }},
  
                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",  400000000,          0 }},

                    // Action:       1 == ENABLE 2 == DISABLE 3 == SET_FREQ 8 == EN_SETFREQ
                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST

                    //                                  Clock Name                 Action     Frequency       MatchType
                    //                                  ---------                  ------     ----------      ----------
                    package(){ "CLOCK", package(){ "gcc_camss_vfe0_clk",              1,          0,               1,   }}, 
                    Package(){"PSTATE_ADJUST", Package () { 0, 3 }},
                    package(){ "CLOCK", package(){ "gcc_camss_vfe_axi_clk",           1,          0,               1,   }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_top_ahb_clk",           1,          0,               1,   }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_vfe_ahb_clk",           1,          0,               1,   }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_ahb_clk",               8,         80000000,         3,   }},
                    package(){ "CLOCK", package(){ "gcc_vfe_tbu_clk",                 1,          0,               1,   }}, 
                    package(){ "CLOCK", package(){ "gcc_smmu_cfg_clk",                1,          0,               1,   }},
                    package(){ "CLOCK", package(){ "gcc_apss_tcu_clk",                1,          0,               1,   }},

                },
                Package()
                {
                    "FSTATE",
                    0x1, // F1 state

                    package(){ "CLOCK", package(){ "gcc_apss_tcu_clk",                2,          0,               0,   }},
                    package(){ "CLOCK", package(){ "gcc_smmu_cfg_clk",                2,          0,               0,   }},
                    package(){ "CLOCK", package(){ "gcc_vfe_tbu_clk",                 2,          0,               1,   }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_vfe_ahb_clk",           2,          0,               1,   }},
                    package(){ "CLOCK", package(){ "gcc_camss_top_ahb_clk",           2,          0,               1,   }},
                    package(){ "CLOCK", package(){ "gcc_camss_vfe_axi_clk",           2,          0,               1,   }},
                    package(){ "CLOCK", package(){ "gcc_camss_vfe0_clk",              2,          0,               1,   }},
                    package(){ "CLOCK", package(){ "gcc_camss_ahb_clk",               2,          0,               3,   }},

                    //                               Req                                                              IB           AB
                    //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                    //                               ----   -----------------------    ----------------------       ----------   ----------
                    Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_CAMERA_CFG",          0,          0 }},

                    Package(){"PSTATE_ADJUST", Package () { 1, 11 }},          
                    Package(){ "FOOTSWITCH", Package(){ "VDD_CAMSS_VFE",           2    }},
                },
                Package()
                { 
                    "PSTATE_SET",
                    0,
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       465000000,       3,     }},
                    },
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       400000000,       3,     }},
                    },
                    Package()
                    { 
                        "PSTATE", 
                        2,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       320000000,       3,     }},
                    },
                    Package()
                    {   
                        "PSTATE", 
                        3,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       266670000,       3,     }},
                    },
                    Package()
                    {   
                        "PSTATE", 
                        4,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       228570000,       3,     }},
                    },
                    Package()
                    {   
                        "PSTATE", 
                        5,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       200000000,        3,     }},
                    },
                    Package()
                    {  
                        "PSTATE", 
                        6,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       133000000,        3,     }},
                    },
                    Package()
                    {   
                        "PSTATE", 
                        7,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_vfe0_clk",              3,       80000000,        3,     }},
                    },
                },
                Package()
                {
                    "PSTATE_SET",
                    1,
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     3400000000,   3400000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     3000000000,   3000000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        2,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     2000000000,   2000000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        3,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     1500000000,   1500000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        4,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     1200000000,   1200000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        5,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     1000000000,   1000000000 } },
                    },
                    Package()
                    {
                        "PSTATE", 
                        6,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     900000000,   900000000 } },
                    },
                    Package()
                    {
                        "PSTATE", 
                        7,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     800000000,   800000000 } },
                    },
                    Package()
                    {
                        "PSTATE", 
                        8,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     700000000,   700000000 } },
                    },
                    Package()
                    {
                        "PSTATE", 
                        9,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     600000000,   600000000 } },
                    },
                    Package()
                    {  
                        "PSTATE", 
                        10,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     300000000,   300000000 } },
                    },
                    Package()
                    {  
                        "PSTATE", 
                        11,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     0,   0 } },
                    },
                },
            },
            Package()
            {
                "COMPONENT",
                0x1, // Component 1.  //VFE 1 component
                Package()
                {
                    "FSTATE",
                    0x0, // F0 state
                    //  Package(){ "FOOTSWITCH", Package(){ "VDD_CAMSS_VFE",           1    }},
                    //   Package(){"PSTATE_ADJUST", Package () { 1, 3 }},
                    // Action:       1 == ENABLE 2 == DISABLE 3 == SET_FREQ 8 == EN_SETFREQ
                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //                                  Clock Name                 Action     Frequency       MatchType
                    //                                  ---------                  ------     ----------      ----------
                    //   package(){ "CLOCK", package(){ "camss_vfe_vfe1_clk",              1,       0,       1,     }}, 
                    //    Package(){"PSTATE_ADJUST", Package () { 0, 1 }},
                    //    package(){ "CLOCK", package(){ "camss_vfe_vfe_axi_clk",           1,       0,       1,     }}, 
                    //    package(){ "CLOCK", package(){ "camss_top_ahb_clk",               1,       0,       1,     }}, 
                    //     package(){ "CLOCK", package(){ "camss_vfe_vfe_ahb_clk",           1,       0,       1,     }}, 
                },
                Package()
                {
                    "FSTATE",
                    0x1, // F1 state
                    //  package(){ "CLOCK", package(){ "camss_vfe_vfe_ahb_clk",           2,     0,               0,     }},
                    //    package(){ "CLOCK", package(){ "camss_top_ahb_clk",               2,     0,               0,     }},
                    //    package(){ "CLOCK", package(){ "camss_vfe_vfe_axi_clk",           2,     0,               0,     }},
                    //    package(){ "CLOCK", package(){ "camss_vfe_vfe1_clk",              2,     0,               0,     }},
                    //    Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     0,           0 } },   
                    //  Package(){ "FOOTSWITCH", Package(){ "VDD_CAMSS_VFE",           2    }},          

                },
            },

            Package()
            {
                "COMPONENT",
                0x2, // Component 2.  //CPP component
                Package()
                {
                    "FSTATE",
                    0x0, // F0 state
                    Package(){"PSTATE_ADJUST", Package () { 1, 4 }},
                    // CPP clocks
                    //                                  Clock Name                 Action     Frequency       MatchType
                    //                                  ---------                  ------     ----------      ----------
                    package(){ "CLOCK", package(){ "gcc_camss_cpp_clk",                1,         0,                1,     }},
                    Package(){"PSTATE_ADJUST", Package () { 0, 1 }},
                    package(){ "CLOCK", package(){ "gcc_camss_cpp_ahb_clk",            1,         0,                1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_ahb_clk",                8,         80000000,         3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_micro_ahb_clk",          1,         0,                1,     }},
          
                },
                Package()
                {
                    "FSTATE",
                    0x1, // F1 state
                    //                                  Clock Name                 Action     Frequency       MatchType
                    //                                  ---------                  ------     ----------      ----------
                    package(){ "CLOCK", package(){ "gcc_camss_micro_ahb_clk",          2,         0,                0,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_cpp_ahb_clk",            2,         0,                0,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_cpp_clk",                2,         0,                0,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_ahb_clk",                2,         0,                3,     }},
                    package(){"PSTATE_ADJUST", Package () { 1, 8 }},   
                },
                Package()
                {
                    "PSTATE_SET",
                    0,
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_cpp_clk",              3,       320000000,       3,     }},
                    },
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        //                                  Clock Name                 Action     Frequency       MatchType
                        //                                  ---------                  ------     ----------      ----------
                        Package(){ "CLOCK", Package(){ "gcc_camss_cpp_clk",              3,       266000000,       3,     }},
                    },
               },
                Package()
                {
                    "PSTATE_SET",
                    1,
                    Package()
                    { 
                        "PSTATE", 
                        0,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     3400000000,   3400000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        1,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     2400000000,   2400000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        2,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     1200000000,   1200000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        3,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     800000000,   800000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        4,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     200000000,   200000000 } },
                    },
                    Package()
                    { 
                        "PSTATE", 
                        5,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     120000000,   120000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        6,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     60000000,   60000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        7,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     30000000,   30000000 } },
                    },
                    Package()
                    {   
                        "PSTATE", 
                        8,
                        Package() { "BUSARB", Package() { 3,    "ICBID_MASTER_VFE",          "ICBID_SLAVE_EBI1",     0,           0 } },             
                    },
               },
           },
        },

    })

    Name(CPXC,
    Package ()
    { 
        //Device CAMS Data
        Package()
        {
            "DEVICE",
            "\\_SB.CAMS",
            Package()
            {
                    "DSTATE",
                    0x0, // D0 state

                    // Action:       1 == ENABLE 2 == DISABLE 3 == SET_FREQ 8 == EN_SETFREQ
                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST

                    //                                  Clock Name                 Action     Frequency       MatchType
                    //                                ---------                     ------     ----------     ----------
                    package(){ "CLOCK", package(){ "gcc_camss_csi0_clk",                 8,         200000000,      3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0phytimer_clk",         8,         200000000,      3,     }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_mclk0_clk",                8,         24000000,       3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi_vfe0_clk",             1,         0,              1,     }},    
                    package(){ "CLOCK", package(){ "gcc_camss_csi0phy_clk",              1,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0pix_clk",              1,         0,              1,     }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_csi0rdi_clk",              1,         0,              1,     }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_csi0_ahb_clk",             1,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_ispif_ahb_clk",            1,         0,              1,     }},
                },
                Package()
                {
                    "DSTATE",
                    0x3, // D3 state
                    package(){ "CLOCK", package(){ "gcc_camss_ispif_ahb_clk",            2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0_ahb_clk",             2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0rdi_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0pix_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0phy_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi_vfe0_clk",             2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_mclk0_clk",                2,         0,              3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0phytimer_clk",         2,         0,              3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi0_clk",                 2,         0,              3,     }},
                },
            },
        //Device CAMF Data
        Package()
        {
            "DEVICE",
            "\\_SB.CAMF",
            Package()
           {
                   "DSTATE",
                    0x0, // D0 state
                    // Action:       1 == ENABLE 2 == DISABLE 3 == SET_FREQ 8 == EN_SETFREQ
                    // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST 3 == CLOCK_FREQUENCY_HZ_CLOSEST

                                                  // Clock Name                 Action     Frequency            MatchType
                                                  //-----------                 ------     ----------           ----------

                    package(){ "CLOCK", package(){ "gcc_camss_csi1_clk",                 8,         200000000,      3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1phytimer_clk",         8,         200000000,      3,     }},  
                    package(){ "CLOCK", package(){ "gcc_camss_mclk1_clk",                8,         24000000,       3,     }},
                    //package(){ "CLOCK", package(){ "gcc_camss_mclk0_clk",                8,         24000000,       3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi_vfe0_clk",             1,         0,              1,     }},    
                    package(){ "CLOCK", package(){ "gcc_camss_csi1phy_clk",              1,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1pix_clk",              1,         0,              1,     }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_csi1rdi_clk",              1,         0,              1,     }}, 
                    package(){ "CLOCK", package(){ "gcc_camss_csi1_ahb_clk",             1,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_ispif_ahb_clk",            1,         0,              1,     }},
        
               },
               Package()
               {
                    "DSTATE",
                    0x3, // D3 state
                    package(){ "CLOCK", package(){ "gcc_camss_ispif_ahb_clk",            2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1_ahb_clk",             2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1rdi_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1pix_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1phy_clk",              2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi_vfe0_clk",             2,         0,              1,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_mclk0_clk",                2,         0,              3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_mclk1_clk",                2,         0,              3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1phytimer_clk",         2,         0,              3,     }},
                    package(){ "CLOCK", package(){ "gcc_camss_csi1_clk",                 2,         0,              3,     }},
               },
            },
    })
}
