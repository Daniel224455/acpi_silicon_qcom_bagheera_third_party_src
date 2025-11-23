//--------------------------------------------------------------------------------------------------
// Copyright (c) 2012-2016 Qualcomm Technologies, Inc.  All Rights Reserved.
// Qualcomm Technologies Proprietary and Confidential.
//--------------------------------------------------------------------------------------------------

Scope(\_SB_.PEP0)
{
    // Graphics Resources
    //
    Method (GPMD)
    {
        Name (GPCC, Package()
        {
            //-----------------------------------------------------------------------------------------
            //  GRAPHICS, DISPLAY, and VIDEO resources
            //
            //  !!WARNING: The below table entries are auto-generated and are part of several
            //             interdependent ACPI methods that are all auto-generated from a single source.
            //             These components should NOT be edited by hand, as they must stay in sync
            //             with all other dependent graphics methods.
            //-----------------------------------------------------------------------------------------
            //  OWNING DRIVER: qcdxkm8916.sys
            //
            //  HW CONTROLLED: 3D core
            //                 MDP core
            //                 Internal display circuitry
            //                 HDMI circuitry
            //                 Rotator core
            //                 Video Decode core
            //
            //  COMPONENTS:
            //                 C0 - Internal Display Power States
            //                 C1 - 3D Graphics Engine Power States
            //                 C2 - Rotator Engine Power States
            //                 C3 - Video Engine Power States
            //                 C4 - Miracast Power States
            //                 C5 - Dummy Component for WP Workaround
            //                 C6 - VidPn Source 0
            //                 C7 - VidPn Source 1
            //-----------------------------------------------------------------------------------------
            //
            Package()
            {
                "DEVICE",
                "\\_SB.GPU0",
                
                //--------------------------------------------------------------------------------------
                //  C0  (qcdxkm8916.sys) - Internal Display Power States
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    0,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C0.F0  (qcdxkm8916.sys) - Internal Display Power States
                    //
                    //  o STATE
                    //  -- MDP footswitch enabled
                    //  o CLOCKS
                    //  -- MDP core clock enabled (via PS4.P0)
                    //  -- MDP VSync clock enabled (via PS4.P0)
                    //  -- MDP AHB and AXI interface clocks enabled (via PS4.P0)
                    //  -- DSI clocks enable, pclk, byte, escape (via PS4.P0)
                    //  -- MMSS AHB NOC frequency set (via PS2)
                    //  o RAILs
                    //  -- LDO2   (VDDA_MIPI_DSI)
                    //  -- LDO6   (DISP_LCD1_MIPI_VDDIO)
                    //  ---- Note: Asymmetry for LDO6 behavior is intentional, to leave
                    //       the bridge powered on to avoid reprogramming on resume
                    //  -- LDO17  (DISP_LCD1_MIPI_VDDIO)
                    //  o GPIOs
                    //  -- MDP TE input (pin 24)
                    //  -- Panel power  (Pin 97)(DISPLAY_5V_EN)
                    //  -- Back light enable(Pin 98)(BACKLIGHT_EN)
                    //  o WLED
                    //  -- Enable WLED Interface
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C0.F1  (qcdxkm8916.sys) - Internal Display Power States
                    //
                    //  o STATE
                    //  -- MDP footswitch disabled
                    //  o CLOCKS
                    //  -- MDP AHB and AXI interface clocks disabled (via PS4.P1)
                    //  -- MDP core clock disabled (via PS4.P1)
                    //  -- MDP VSync clock disabled (via PS4.P1)
                    //  -- DSI clocks disabled, pclk, byte, escape (via PS4.P1)
                    //  o RAILs
                    //  -- LDO2   (VDDA_MIPI_DSI)
                    //  -- LDO6   (DISP_LCD1_MIPI_VDDIO)
                    //  ---- Note: Asymmetry for LDO6 behavior is intentional, to leave
                    //       the bridge powered on to avoid reprogramming on resume
                    //  -- LDO17  (DISP_LCD1_MIPI_VDDIO)
                    //  o GPIOs
                    //  -- MDP TE input (pin 24)
                    //  -- Panel power  (Pin 97)(DISPLAY_5V_EN)
                    //  -- Back light enable(Pin 98)(BACKLIGHT_EN)
                    //  o WLED
                    //  -- Disable WLED Interface
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            Package() { "PSTATE_SAVE" },
                            Package() { "PSTATE_ADJUST", Package() { 2, 1 }},
                            Package() { "PSTATE_ADJUST", Package() { 3, 12 }},
                            Package() { "PSTATE_ADJUST", Package() { 4, 32 }},
                            
                            // Action:       2 == DISABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }},
                            
                            //                                            Required      NPA Node Name                  Enable
                            //                                            --------     ----------------           -----------------
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/xo/cxo",                              0    }},
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/pmic/client/hfpll1",                  0    }},
                            
                            Package()
                            {
                                "PMICVREGVOTE",
                                Package()
                                {
                                    "PPP_RESOURCE_ID_LDO2_A",
                                    1,           // Voltage Regulator Type, 1 = LDO
                                    0,           // Voltage (uV)
                                    0,           // Peak Current (uA)
                                    0,           // Software Enable
                                    0,           // Pin Enable
                                    0,           // Software Power Mode
                                    0,           // Pin Power Mode
                                    0,           // Bypass Enable
                                    0,           // Headroom
                                },
                            },
                            
                            Package()
                            {
                                "PMICVREGVOTE",
                                Package()
                                {
                                    "PPP_RESOURCE_ID_LDO17_A",
                                    1,           // Voltage Regulator Type, 1 = LDO
                                    0,           // Voltage (uV)
                                    0,           // Peak Current (uA)
                                    0,           // Software Enable
                                    0,           // Pin Enable
                                    0,           // Software Power Mode
                                    0,           // Pin Power Mode
                                    0,           // Bypass Enable
                                    0,           // Headroom
                                },
                            },
                            
                            Package()
                            {
                                "PMICWLED",
                                Package()
                                {
                                    "IOCTL_PM_WLED_MODULE_ENABLE",
                                    0,       // PM8916
                                    0,       // WLED Disabled
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     97,  // TLMM GPIO       :  97 = Display Power Enable
                                      0,  // State           :   0 = INACTIVE
                                      0,  // Function Select :   0 = ??
                                      0,  // Direction       :   0 = INPUT
                                      1,  // Pull Type       :   1 = PULL_DOWN
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     98,  // TLMM GPIO       :  98 = Display back light Enable
                                      0,  // State           :   0 = INACTIVE
                                      0,  // Function Select :   0 = ??
                                      0,  // Direction       :   0 = INPUT
                                      1,  // Pull Type       :   1 = PULL_DOWN
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     24,  // TLMM GPIO       :  24 = Display TE pin
                                      1,  // State           :   1 = ACTIVE
                                      0,  // Function Select :   0 = ??
                                      0,  // Direction       :   0 = INPUT
                                      1,  // Pull Type       :   1 = PULL_DOWN
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            //                                            Required      NPA Node Name              Enable
                            //                                            --------     ----------------       -----------------
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/xo/cxo",                         1    }},
                            
                            // Action:       1 == ENABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }},
                            
                            Package() { "PSTATE_RESTORE" },
                            
                            //                                            Required      NPA Node Name                  Enable
                            //                                            --------     ----------------           -----------------
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/pmic/client/hfpll1",                  1    }},
                            
                            Package()
                            {
                                "PMICVREGVOTE",
                                Package()
                                {
                                    "PPP_RESOURCE_ID_LDO2_A",
                                    1,           // Voltage Regulator Type, 1 = LDO
                                    1200000,     // Voltage (uV)
                                    40000,       // Peak Current (uA)
                                    1,           // Software Enable
                                    0,           // Pin Enable
                                    1,           // Software Power Mode
                                    0,           // Pin Power Mode
                                    0,           // Bypass Enable
                                    0,           // Headroom
                                },
                            },
                            
                            Package()
                            {
                                "PMICVREGVOTE",
                                Package()
                                {
                                    "PPP_RESOURCE_ID_LDO6_A",
                                    1,           // Voltage Regulator Type, 1 = LDO
                                    1800000,     // Voltage (uV)
                                    40000,       // Peak Current (uA)
                                    1,           // Software Enable
                                    0,           // Pin Enable
                                    1,           // Software Power Mode
                                    0,           // Pin Power Mode
                                    0,           // Bypass Enable
                                    0,           // Headroom
                                },
                            },
                            
                            Package()
                            {
                                "PMICVREGVOTE",
                                Package()
                                {
                                    "PPP_RESOURCE_ID_LDO17_A",
                                    1,           // Voltage Regulator Type, 1 = LDO
                                    28500000,    // Voltage (uV)
                                    150000,      // Peak Current (uA)
                                    1,           // Software Enable
                                    0,           // Pin Enable
                                    1,           // Software Power Mode
                                    0,           // Pin Power Mode
                                    0,           // Bypass Enable
                                    0,           // Headroom
                                },
                            },
                            
                            Package()
                            {
                                "PMICWLED",
                                Package()
                                {
                                    "IOCTL_PM_WLED_MODULE_ENABLE",
                                    0,       // PM8916
                                    1,       // WLED Enabled
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     97,  // TLMM GPIO       :  97 = Display Power Enable
                                      1,  // State           :   1 = ACTIVE
                                      0,  // Function Select :   0 = ??
                                      1,  // Direction       :   1 = OUTPUT
                                      1,  // Pull Type       :   1 = PULL_DOWN
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     98,  // TLMM GPIO       :  98 = Display back light enable
                                      1,  // State           :   1 = ACTIVE
                                      0,  // Function Select :   0 = ??
                                      1,  // Direction       :   1 = OUTPUT
                                      1,  // Pull Type       :   1 = PULL_DOWN
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                            
                            Package()
                            {
                                "TLMMGPIO",
                                Package()
                                {
                                     24,  // TLMM GPIO       :  24 = Display TE pin
                                      1,  // State           :   1 = ACTIVE
                                      1,  // Function Select :   1 = ??
                                      0,  // Direction       :   0 = INPUT
                                      0,  // Pull Type       :   0 = NOPULL
                                      0,  // Drive Strength  :   0 = 2mA
                                },
                            },
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 1 },
                    Package() { "PRELOAD_FSTATE", 0 },
                    Package() { "ABANDON_FSTATE", 0 },
                    
                    //----------------------------------------------------------------------------------
                    // C0.PS0 - Internal Display: MDP Reset Control
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        0,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       10 == RESETCLOCK_ASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      10,               0,       1   }},
                            
                            Package()
                            {
                                "DELAY",
                                Package()
                                {
                                    1,           // Delay in milliseconds
                                }
                            },
                            
                            // Action:       11 == RESETCLOCK_DEASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      11,               0,       1   }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 0 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 0 },
                    },
                    //----------------------------------------------------------------------------------
                    // C0.PS1 - Internal Display: MDP Footswitch override
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        1,
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        //
                        //                                                              Domain Name          Action
                        //                                                              ----------------     ------
                        Package() { "PSTATE",   0, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }}},
                        Package() { "PSTATE",   1, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C0.PS2 - Internal Display: Power states for MDP scan-out HW
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        2,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                        //
                        //                                                         Clock Name               Action    Frequency   MatchType
                        //                                                         --------------------     ------    ----------  ---------
                        Package() { "PSTATE",   0, Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_vsync_clk",    1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_pclk0_clk",    1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_esc0_clk",     1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_byte0_clk",    1,               0,       1   }}},
                        Package() { "PSTATE",   1, Package() { "CLOCK", Package() { "gcc_mdss_vsync_clk",    2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_pclk0_clk",    2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_esc0_clk",     2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_byte0_clk",    2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      2,               0,       1   }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 0 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 0 },
                    },
                    //----------------------------------------------------------------------------------
                    // C0.PS3 - Internal Display: MDP Core Clock Frequency
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        3,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       320000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       266666667,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       240000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       228571429,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            4,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       200000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            5,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       160000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            6,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       133333333,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            7,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       100000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            8,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        85714286,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            9,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        75000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            10,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        60000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            11,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        37500000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            12,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,               0,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",          0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C0.PS4 - Internal Display: Display Bandwidth to EBI
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        4,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   0, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1556676532, 1556676532 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   1, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1415160484, 1415160484 }}},
                        Package() { "PSTATE",   2, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1286509530, 1286509530 }}},
                        Package() { "PSTATE",   3, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1169554119, 1169554119 }}},
                        Package() { "PSTATE",   4, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1063231017, 1063231017 }}},
                        Package() { "PSTATE",   5, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        966573652,  966573652 }}},
                        Package() { "PSTATE",   6, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        878703320,  878703320 }}},
                        Package() { "PSTATE",   7, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        798821200,  798821200 }}},
                        Package() { "PSTATE",   8, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        726201091,  726201091 }}},
                        Package() { "PSTATE",   9, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        660182810,  660182810 }}},
                        Package() { "PSTATE",  10, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        600166191,  600166191 }}},
                        Package() { "PSTATE",  11, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        545605628,  545605628 }}},
                        Package() { "PSTATE",  12, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        496005116,  496005116 }}},
                        Package() { "PSTATE",  13, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        450913742,  450913742 }}},
                        Package() { "PSTATE",  14, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        409921584,  409921584 }}},
                        Package() { "PSTATE",  15, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        372655985,  372655985 }}},
                        Package() { "PSTATE",  16, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        338778168,  338778168 }}},
                        Package() { "PSTATE",  17, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        307980153,  307980153 }}},
                        Package() { "PSTATE",  18, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        279981957,  279981957 }}},
                        Package() { "PSTATE",  19, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        254529052,  254529052 }}},
                        Package() { "PSTATE",  20, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        231390047,  231390047 }}},
                        Package() { "PSTATE",  21, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        210354589,  210354589 }}},
                        Package() { "PSTATE",  22, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        191231444,  191231444 }}},
                        Package() { "PSTATE",  23, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        173846767,  173846767 }}},
                        Package() { "PSTATE",  24, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        158042516,  158042516 }}},
                        Package() { "PSTATE",  25, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        143675014,  143675014 }}},
                        Package() { "PSTATE",  26, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        130613649,  130613649 }}},
                        Package() { "PSTATE",  27, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        118739681,  118739681 }}},
                        Package() { "PSTATE",  28, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        107945165,  107945165 }}},
                        Package() { "PSTATE",  29, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         98131968,   98131968 }}},
                        Package() { "PSTATE",  30, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         89210880,   89210880 }}},
                        Package() { "PSTATE",  31, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         81100800,   81100800 }}},
                        Package() { "PSTATE",  32, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",                0,          0 }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 4 },
                        Package() { "PREPARE_PSTATE", 4 },
                        Package() { "ABANDON_PSTATE", 4 },
                    },
                },
                
                //--------------------------------------------------------------------------------------
                //  C1  (qcdxkm8916.sys) - 3D Graphics Engine Power States
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    1,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C1.F0  (qcdxkm8916.sys) - 3D Graphics Engine Power States
                    //
                    //  When in this state:
                    //  - Graphics power rail is on with voltage >= SVS
                    //  - GFX footswitch is enabled
                    //  - AHB and AXI interface clocks are enabled and have frequencies > 0 Hz
                    //  - 3D core clock is enabled and has a frequency > 0 Hz
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C1.F1  (qcdxkm8916.sys) - 3D Graphics Engine Power States
                    //
                    //  When in this state:
                    //  - AHB and AXI interface clocks are disabled
                    //  - 3D core clock is disabled
                    //  - XO Shutdown generally precluded because freq votes still in place
                    //  - Graphics power rail is on with voltage >= SVS
                    //  - GFX footswitch is enabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",       2,               0,       1   }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",       1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    1,               0,       1   }},
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C1.F2  (qcdxkm8916.sys) - 3D Graphics Engine Power States
                    //
                    //  When in this state:
                    //  - Vote for graphics power rail removed
                    //  - GFX footswitch is disabled (Unless overridden by PS1)
                    //  - AHB and AXI interface clocks are disabled
                    //  - 3D core clock is disabled
                    //  - AHB freq vote removed (via PSTATE_ADJUST)
                    //  - Bandwidth vote removed (via PSTATE_ADJUST)
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        2,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",       2,               0,       1   }},
                            
                            Package() { "PSTATE_SAVE" },
                            Package() { "PSTATE_ADJUST", Package() { 2, 3 }},
                            
                            // Action:       2 == DISABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_OXILI",         2    }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_OXILI",         1    }},
                            
                            Package() { "PSTATE_RESTORE" },
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",       1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    1,               0,       1   }},
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 0 },
                    Package() { "PRELOAD_FSTATE", 2 },
                    Package() { "ABANDON_FSTATE", 2 },
                    
                    //----------------------------------------------------------------------------------
                    // C1.PS0 - 3D Graphics Core P-State Set: Reset
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        0,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       10 == RESETCLOCK_ASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      10,               0,       1   }},
                            
                            Package()
                            {
                                "DELAY",
                                Package()
                                {
                                    1,           // Delay in milliseconds
                                }
                            },
                            
                            // Action:       11 == RESETCLOCK_DEASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_bimc_gfx_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_bimc_gpu_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gmem_clk",    11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_ahb_clk",     11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   11,               0,       1   }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C1.PS1 - 3D Graphics Core P-State Set: Footswitch override
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        1,
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        //
                        //                                                              Domain Name          Action
                        //                                                              ----------------     ------
                        Package() { "PSTATE",   0, Package() { "FOOTSWITCH", Package() { "VDD_OXILI",         1    }}},
                        Package() { "PSTATE",   1, Package() { "FOOTSWITCH", Package() { "VDD_OXILI",         2    }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C1.PS2 - 3D Graphics Core P-State Set: Core Clock Frequency
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        2,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   3,       398000000,       1   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_GFX3D_CFG",   400000000,          0 }},
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_GFX3D",       "ICBID_SLAVE_EBI1",       4264000000, 1066000000 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   3,       308000000,       1   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_GFX3D_CFG",   400000000,          0 }},
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_GFX3D",       "ICBID_SLAVE_EBI1",       3200000000,  800000000 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   3,       198000000,       1   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_GFX3D_CFG",   400000000,          0 }},
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_GFX3D",       "ICBID_SLAVE_EBI1",       1600000000,  160000000 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_oxili_gfx3d_clk",   3,               0,       1   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_GFX3D_CFG",           0,          0 }},
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_GFX3D",       "ICBID_SLAVE_EBI1",                0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 2 },
                        Package() { "PREPARE_PSTATE", 2 },
                        Package() { "ABANDON_PSTATE", 2 },
                    },
                },
                
                //--------------------------------------------------------------------------------------
                //  C2  (qcdxkm8916.sys) - Rotator Engine Power States
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    2,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C2.F0  (qcdxkm8916.sys) - Rotator Engine Power States
                    //
                    //  State:
                    //  - MDP footswitch enabled
                    //  - MDP core clock enabled
                    //  - MDP AHB and AXI interface clocks enabled
                    //  - MMSS AHB NOC frequency set
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C2.F1  (qcdxkm8916.sys) - Rotator Engine Power States
                    //
                    //  State:
                    //  - MDP AHB and AXI interface clocks disabled
                    //  - MDP core clock disabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      2,               0,       1   }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      1,               0,       1   }},
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C2.F2  (qcdxkm8916.sys) - Rotator Engine Power States
                    //
                    //  State:
                    //  - MDP AHB and AXI interface clocks disabled
                    //  - MDP core clock disabled
                    //  - MMSS AHB NOC frequency set to 0
                    //  - MDP footswitch disabled
                    //  - AHB freq vote removed (via PSTATE_ADJUST)
                    //  - Bandwidth vote removed (via PSTATE_ADJUST)
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        2,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      2,               0,       1   }},
                            
                            // Action:       2 == DISABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }},
                            
                            Package() { "PSTATE_SAVE" },
                            Package() { "PSTATE_ADJUST", Package() { 2, 12 }},
                            Package() { "PSTATE_ADJUST", Package() { 3, 14 }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }},
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      1,               0,       1   }},
                            
                            Package() { "PSTATE_RESTORE" },
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 0 },
                    Package() { "PRELOAD_FSTATE", 2 },
                    Package() { "ABANDON_FSTATE", 2 },
                    
                    //----------------------------------------------------------------------------------
                    // C2.PS0 - Rotator Core P-State Set: Reset
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        0,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       10 == RESETCLOCK_ASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      10,               0,       1   }},
                            
                            Package()
                            {
                                "DELAY",
                                Package()
                                {
                                    1,           // Delay in milliseconds
                                }
                            },
                            
                            // Action:       11 == RESETCLOCK_DEASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      11,               0,       1   }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 0 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 0 },
                    },
                    //----------------------------------------------------------------------------------
                    // C2.PS1 - Rotator Core P-State Set: Footswitch override
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        1,
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        //
                        //                                                              Domain Name          Action
                        //                                                              ----------------     ------
                        Package() { "PSTATE",   0, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }}},
                        Package() { "PSTATE",   1, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C2.PS2 - Rotator Core P-State Set: Rotator Core Clock Frequency
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        2,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       320000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       266666667,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       240000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       228571429,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            4,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       200000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            5,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       160000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            6,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       133333333,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            7,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       100000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            8,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        85714286,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            9,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        75000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            10,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        60000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            11,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        37500000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            12,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,               0,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",          0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 6 },
                        Package() { "PREPARE_PSTATE", 6 },
                        Package() { "ABANDON_PSTATE", 6 },
                    },
                    //----------------------------------------------------------------------------------
                    // C2.PS3 - Rotator Core P-State Set: Rotator Bandwidth to EBI
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        3,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   0, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       2560000000, 2560000000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   1, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       2133333336, 2133333336 }}},
                        Package() { "PSTATE",   2, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1920000000, 1920000000 }}},
                        Package() { "PSTATE",   3, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1828571432, 1828571432 }}},
                        Package() { "PSTATE",   4, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1600000000, 1600000000 }}},
                        Package() { "PSTATE",   5, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1280000000, 1280000000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   6, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1064000000, 1064000000 }}},
                        Package() { "PSTATE",   7, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        800000000,  800000000 }}},
                        Package() { "PSTATE",   8, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        685680000,  685680000 }}},
                        Package() { "PSTATE",   9, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        600000000,  600000000 }}},
                        Package() { "PSTATE",  10, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        480000000,  480000000 }}},
                        Package() { "PSTATE",  11, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        300000000,  300000000 }}},
                        Package() { "PSTATE",  12, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        200000000,  200000000 }}},
                        Package() { "PSTATE",  13, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        100000000,  100000000 }}},
                        Package() { "PSTATE",  14, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",                0,          0 }}},
                    },
                },
                
                //--------------------------------------------------------------------------------------
                //  C3  (qcdxkm8916.sys) - Video Engine Power States
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    3,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C3.F0  (qcdxkm8916.sys) - Video Engine Power States
                    //
                    //  When in this state:
                    //  - Video footswitch is enabled
                    //  - AHB and AXI interface clocks are enabled and have frequencies > 0 Hz
                    //  - Video core clock is enabled and has a frequency > 0 Hz
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C3.F1  (qcdxkm8916.sys) - Video Engine Power States
                    //
                    //  When in this state:
                    //  - AHB and AXI interface clocks are disabled
                    //  - Video core clock is disabled
                    //  - XO Shutdown generally precluded because BW vote still in place
                    //  - Video footswitch is enabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",       2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",       2,               0,       1   }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",       1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",       1,               0,       1   }},
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C3.F2  (qcdxkm8916.sys) - Video Engine Power States
                    //
                    //  When in this state:
                    //  - Video footswitch may be disabled by RPM before XO shutdown
                    //  - AHB and AXI interface clocks are disabled
                    //  - Video core clock is disabled
                    //  - AHB freq vote removed (via PSTATE_ADJUST)
                    //  - EBI Bandwidth vote removed (via PSTATE_ADJUST)
                    //  - OCMEM Bandwidth vote removed (via PSTATE_ADJUST)
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        2,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            // Action:       2 == DISABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",       2,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",       2,               0,       1   }},
                            
                            Package() { "PSTATE_SAVE" },
                            Package() { "PSTATE_ADJUST", Package() { 2, 3 }},
                            Package() { "PSTATE_ADJUST", Package() { 3, 3 }},
                            Package() { "PSTATE_ADJUST", Package() { 4, 4 }},
                            Package() { "PSTATE_ADJUST", Package() { 5, 4 }},
                            
                            // Action:       2 == DISABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_VENUS0",        2    }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            // Action:       1 == ENABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_VENUS0",        1    }},
                            Package() { "PSTATE_ADJUST", Package() { 0, 0 }},
                            
                            // Action:       1 == ENABLE
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",       1,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",       1,               0,       1   }},
                            
                            Package() { "PSTATE_RESTORE" },
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 0 },
                    Package() { "PRELOAD_FSTATE", 2 },
                    Package() { "ABANDON_FSTATE", 2 },
                    
                    //----------------------------------------------------------------------------------
                    // C3.PS0 - Video Core P-State Set: Reset
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        0,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       10 == RESETCLOCK_ASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     10,               0,       1   }},
                            
                            Package()
                            {
                                "DELAY",
                                Package()
                                {
                                    1,           // Delay in milliseconds
                                }
                            },
                            
                            // Action:       11 == RESETCLOCK_DEASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_axi_clk",     11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_ahb_clk",     11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 11,               0,       1   }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C3.PS1 - Video Core P-State Set: Footswitch override
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        1,
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        //
                        //                                                              Domain Name          Action
                        //                                                              ----------------     ------
                        Package() { "PSTATE",   0, Package() { "FOOTSWITCH", Package() { "VDD_VENUS0",        1    }}},
                        Package() { "PSTATE",   1, Package() { "FOOTSWITCH", Package() { "VDD_VENUS0",        2    }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C3.PS2 - Video Core Performance: Core Clock Frequency for Decoder
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        2,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       228000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   400000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       160000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   400000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       100000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,               0,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",           0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 2 },
                        Package() { "PREPARE_PSTATE", 2 },
                        Package() { "ABANDON_PSTATE", 2 },
                    },
                    //----------------------------------------------------------------------------------
                    // C3.PS3 - Video Core Performance: Core Clock Frequency for Encoder
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        3,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       228000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   400000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       160000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   400000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,       100000000,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",   200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_venus0_vcodec0_clk", 3,               0,       3   }},
                            
                            //                               Req                                                             IB           AB
                            //                               Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------      ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_VENUS_CFG",           0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 3 },
                        Package() { "PREPARE_PSTATE", 3 },
                        Package() { "ABANDON_PSTATE", 3 },
                    },
                    //----------------------------------------------------------------------------------
                    // C3.PS4 - Video Decoder Performance: Port0 Bandwidth to EBI
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        4,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   0, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",       1745200000, 1725600000 }}},
                        Package() { "PSTATE",   1, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",       1331000000, 1084160000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   2, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",        831900000,  298900000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   3, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",        831900000,   99600000 }}},
                        Package() { "PSTATE",   4, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",                0,          0 }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 3 },
                        Package() { "PREPARE_PSTATE", 3 },
                        Package() { "ABANDON_PSTATE", 3 },
                    },
                    //----------------------------------------------------------------------------------
                    // C3.PS5 - Video Encoder Performance: Port0 Bandwidth to EBI
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        5,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   0, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",       1745200000, 1725600000 }}},
                        Package() { "PSTATE",   1, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",       1537600000, 1453760000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   2, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",       1079000000,  400900000 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   3, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",        674400000,  133600000 }}},
                        Package() { "PSTATE",   4, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_VIDEO_P0",    "ICBID_SLAVE_EBI1",                0,          0 }}},
                    },
                },
                
                //--------------------------------------------------------------------------------------
                //  C4  (qcdxkm8916.sys) - Miracast Power States
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    4,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C4.F0  (qcdxkm8916.sys) - Miracast Power States
                    //
                    //  o State:
                    //  -- MDP footswitch enabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C4.F1  (qcdxkm8916.sys) - Miracast Power States
                    //
                    //  o State
                    //  -- MDP footswitch disabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                        
                        // Actions to take when entering this F-State
                        //
                        Package()
                        {
                            "ENTER",
                            
                            Package() { "PSTATE_SAVE" },
                            Package() { "PSTATE_ADJUST", Package() { 2, 12 }},
                            Package() { "PSTATE_ADJUST", Package() { 3, 32 }},
                            Package() { "PSTATE_ADJUST", Package() { 4, 1 }},
                            
                            // Action:       2 == DISABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }},
                            
                            //                                            Required      NPA Node Name              Enable
                            //                                            --------     ----------------       -----------------
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/xo/cxo",                         0    }},
                        },
                        
                        // Actions to take when exiting this F-State
                        //
                        Package()
                        {
                            "EXIT",
                            
                            //                                            Required      NPA Node Name              Enable
                            //                                            --------     ----------------       -----------------
                            Package() { "REQUIRED_RESOURCE", Package() {      1,       "/xo/cxo",                         1    }},
                            
                            // Action:       1 == ENABLE
                            //
                            //                                   Domain Name          Action
                            //                                   ----------------     ------
                            Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }},
                            
                            Package() { "PSTATE_RESTORE" },
                        },
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 1 },
                    Package() { "PRELOAD_FSTATE", 1 },
                    Package() { "ABANDON_FSTATE", 1 },
                    
                    //----------------------------------------------------------------------------------
                    // C4.PS0 - Miracast: MDP Reset Control
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        0,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       10 == RESETCLOCK_ASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      10,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      10,               0,       1   }},
                            
                            Package()
                            {
                                "DELAY",
                                Package()
                                {
                                    1,           // Delay in milliseconds
                                }
                            },
                            
                            // Action:       11 == RESETCLOCK_DEASSERT
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      11,               0,       1   }},
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      11,               0,       1   }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 0 },
                        Package() { "PREPARE_PSTATE", 0 },
                        Package() { "ABANDON_PSTATE", 0 },
                    },
                    //----------------------------------------------------------------------------------
                    // C4.PS1 - Miracast: MDP Footswitch override
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        1,
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        //
                        //                                                              Domain Name          Action
                        //                                                              ----------------     ------
                        Package() { "PSTATE",   0, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          1    }}},
                        Package() { "PSTATE",   1, Package() { "FOOTSWITCH", Package() { "VDD_MDSS",          2    }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C4.PS2 - Miracast: MDP Core Clock Frequency
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        2,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 0
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            0,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       320000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            1,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       266666667,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            2,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       240000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            3,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       228571429,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            4,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       200000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            5,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       160000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        Package()
                        {
                            "PSTATE",
                            6,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       133333333,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            7,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,       100000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            8,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        85714286,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            9,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        75000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            10,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        60000000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            11,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,        37500000,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",  200000000,          0 }},
                        },
                        
                        Package()
                        {
                            "PSTATE",
                            12,
                            
                            // Action:       3 == SETFREQUENCY
                            // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                            //
                            //                              Clock Name               Action    Frequency   MatchType
                            //                              --------------------     ------    ----------  ---------
                            Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      3,               0,       1   }},
                            
                            //                               Req                                                              IB           AB
                            //                               Type           Master                     Slave                Bytes/Sec    Bytes/Sec
                            //                               ----   -----------------------    ----------------------       ----------   ----------
                            Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_APPSS_PROC",  "ICBID_SLAVE_DISPLAY_CFG",          0,          0 }},
                        },
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 1 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 1 },
                    },
                    //----------------------------------------------------------------------------------
                    // C4.PS3 - Miracast: Display Bandwidth to EBI
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        3,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 1
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   0, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1556676532, 1556676532 }}},
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        //                                                          Req                                                             IB           AB
                        //                                                          Type           Master                     Slave               Bytes/Sec    Bytes/Sec
                        //                                                          ----   -----------------------    ----------------------      ----------   ----------
                        Package() { "PSTATE",   1, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1415160484, 1415160484 }}},
                        Package() { "PSTATE",   2, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1286509530, 1286509530 }}},
                        Package() { "PSTATE",   3, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1169554119, 1169554119 }}},
                        Package() { "PSTATE",   4, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",       1063231017, 1063231017 }}},
                        Package() { "PSTATE",   5, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        966573652,  966573652 }}},
                        Package() { "PSTATE",   6, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        878703320,  878703320 }}},
                        Package() { "PSTATE",   7, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        798821200,  798821200 }}},
                        Package() { "PSTATE",   8, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        726201091,  726201091 }}},
                        Package() { "PSTATE",   9, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        660182810,  660182810 }}},
                        Package() { "PSTATE",  10, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        600166191,  600166191 }}},
                        Package() { "PSTATE",  11, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        545605628,  545605628 }}},
                        Package() { "PSTATE",  12, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        496005116,  496005116 }}},
                        Package() { "PSTATE",  13, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        450913742,  450913742 }}},
                        Package() { "PSTATE",  14, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        409921584,  409921584 }}},
                        Package() { "PSTATE",  15, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        372655985,  372655985 }}},
                        Package() { "PSTATE",  16, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        338778168,  338778168 }}},
                        Package() { "PSTATE",  17, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        307980153,  307980153 }}},
                        Package() { "PSTATE",  18, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        279981957,  279981957 }}},
                        Package() { "PSTATE",  19, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        254529052,  254529052 }}},
                        Package() { "PSTATE",  20, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        231390047,  231390047 }}},
                        Package() { "PSTATE",  21, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        800000000,  212889600 }}},
                        Package() { "PSTATE",  22, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        191231444,  191231444 }}},
                        Package() { "PSTATE",  23, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        173846767,  173846767 }}},
                        Package() { "PSTATE",  24, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        158042516,  158042516 }}},
                        Package() { "PSTATE",  25, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        143675014,  143675014 }}},
                        Package() { "PSTATE",  26, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        130613649,  130613649 }}},
                        Package() { "PSTATE",  27, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        118739681,  118739681 }}},
                        Package() { "PSTATE",  28, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",        107945165,  107945165 }}},
                        Package() { "PSTATE",  29, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         98131968,   98131968 }}},
                        Package() { "PSTATE",  30, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         89210880,   89210880 }}},
                        Package() { "PSTATE",  31, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",         81100800,   81100800 }}},
                        Package() { "PSTATE",  32, Package() { "BUSARB", Package() { 3,     "ICBID_MASTER_MDP",         "ICBID_SLAVE_EBI1",                0,          0 }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 21 },
                        Package() { "PREPARE_PSTATE", 21 },
                        Package() { "ABANDON_PSTATE", 21 },
                    },
                    //----------------------------------------------------------------------------------
                    // C4.PS4 - Miracast clock votes
                    // -- MDP core clock enabled
                    // -- MDP AHB and AXI interface clocks enabled
                    // -- MDP vsync clock enabled
                    // -- SMMU CFG clock enabled
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "PSTATE_SET",
                        4,
                        
                        //----------------------------------------------------------------------------------
                        // P-States at Voltage Level = 2
                        //----------------------------------------------------------------------------------
                        
                        // Action:       1 == ENABLE
                        //               2 == DISABLE
                        // MatchType:    1 == CLOCK_FREQUENCY_HZ_AT_LEAST
                        //
                        //                                                         Clock Name               Action    Frequency   MatchType
                        //                                                         --------------------     ------    ----------  ---------
                        Package() { "PSTATE",   0, Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_vsync_clk",    1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      1,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      1,               0,       1   }}},
                        Package() { "PSTATE",   1, Package() { "CLOCK", Package() { "gcc_mdss_mdp_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_ahb_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_axi_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_mdss_vsync_clk",    2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",      2,               0,       1   }},
                                                   Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",      2,               0,       1   }}},
                        
                        //----------------------------------------------------------------------------------
                        // Default P-States:
                        //     PRELOAD - Use this state until our driver is loaded for the first time.
                        //     PREPARE - Use this state when our driver is about to load.
                        //     ABANDON - Use this state after our driver has been unloaded.
                        //----------------------------------------------------------------------------------
                        //
                        Package() { "PRELOAD_PSTATE", 0 },
                        Package() { "PREPARE_PSTATE", 1 },
                        Package() { "ABANDON_PSTATE", 0 },
                    },
                },
                
                //--------------------------------------------------------------------------------------
                //  C5  (qcdxkm8916.sys) - Dummy Component for WP Workaround
                //
                //  This component does nothing, but is currently required on WP because of an
                //  apparent OS bug.
                //  
                //  In the previous power framework, there were several components that existed only
                //  only to house P-states. These components were voted active at the beginning of
                //  time, and never went idle. As a side-effect of having always-active components,
                //  our driver never left D0.
                //  
                //  In the new power framework, all components have an actual purpose and their
                //  active/idle states have meaning. When the power button is hit and the last of our
                //  components goes idle, we now receive notification of a transition to D3. The
                //  problem, however, is that our display never comes back after this. Once we've
                //  reached this state, we see no VidPn activity from the OS and no attempts to
                //  return the display component to F0.
                //  
                //  As a workaround, we need to keep at least one component active at all times such
                //  that we keep ourselves in D0. If the runtime code finds a component with the name
                //  "ALWAYS_ACTIVE_WP", it adds an additional active vote that is never removed.
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    5,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C5.F0  (qcdxkm8916.sys) - Dummy Component for WP Workaround
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 0 },
                    Package() { "PRELOAD_FSTATE", 0 },
                    Package() { "ABANDON_FSTATE", 0 },
                    
                },
                
                //--------------------------------------------------------------------------------------
                //  C6  (qcdxkm8916.sys) - VidPn Source 0
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    6,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C6.F0  (qcdxkm8916.sys) - VidPn Source 0
                    //
                    //  Indicates that the content of the associated VidPn source is not currently
                    //  static. The HW should continue to refresh any associated displays from this
                    //  source.
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C6.F1  (qcdxkm8916.sys) - VidPn Source 0
                    //
                    //  Indicates that the content of the associated VidPn source is currently static
                    //  and that the HW can stop refreshing any associated displays from this source
                    //  if possible.
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 1 },
                    Package() { "PRELOAD_FSTATE", 1 },
                    Package() { "ABANDON_FSTATE", 1 },
                    
                },
                
                //--------------------------------------------------------------------------------------
                //  C7  (qcdxkm8916.sys) - VidPn Source 1
                //--------------------------------------------------------------------------------------
                //
                Package()
                {
                    "COMPONENT",
                    7,
                    
                    
                    //----------------------------------------------------------------------------------
                    //  C7.F0  (qcdxkm8916.sys) - VidPn Source 1
                    //
                    //  Indicates that the content of the associated VidPn source is not currently
                    //  static. The HW should continue to refresh any associated displays from this
                    //  source.
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        0,
                    },
                    
                    //----------------------------------------------------------------------------------
                    //  C7.F1  (qcdxkm8916.sys) - VidPn Source 1
                    //
                    //  Indicates that the content of the associated VidPn source is currently static
                    //  and that the HW can stop refreshing any associated displays from this source
                    //  if possible.
                    //----------------------------------------------------------------------------------
                    //
                    Package()
                    {
                        "FSTATE",
                        1,
                    },
                    
                    //----------------------------------------------------------------------------------
                    // Default F-States
                    //     INIT    - Assume we're already in this state when the PEP first loads.
                    //     PRELOAD - Use this state until our driver is loaded for the first time.
                    //     ABANDON - Use this state after our driver has been unloaded.
                    //----------------------------------------------------------------------------------
                    //
                    Package() { "INIT_FSTATE", 1 },
                    Package() { "PRELOAD_FSTATE", 1 },
                    Package() { "ABANDON_FSTATE", 1 },
                    
                },
            },
        })
        
        Return (GPCC)
    }
}
