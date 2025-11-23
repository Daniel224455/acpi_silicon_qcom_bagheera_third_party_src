//===========================================================================
//                           <BearSmmu_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by BearSmmu driver.
//
//
//   Copyright (c) 2013 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================

Scope(\_SB_.PEP0)
{
    // BearSmmu Resources
    //
    Method(SMMD)
    {
        Return(SMCC)
    }

    Name(SMCC, Package ()
    {
        //ATCU Resources
        Package()
        {
            "DEVICE",
            "\\_SB.ATCU",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.

                Package()
                {
                    "FSTATE",
                    0x0,
                    
                    package() { "REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 100000 }},
                    
                    // Action:       1 == ENABLE
                    // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //
                    //                              Clock Name                       Action     Frequency   MatchType
                    //                              --------------------             ------     ----------  ---------
                    Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",              1,            0,         1    }},
                    Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",              1,            0,         1    }},
                },

                Package()
                {
                    "FSTATE",
                    0x1,                 
                      
                    // Action:       2 == DISABLE
                    // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //
                    //                              Clock Name                       Action     Frequency   MatchType
                    //                              --------------------             ------     ----------  ---------
                    Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",              2,           0,          0    }},
                    Package() { "CLOCK", Package() { "gcc_apss_tcu_clk",              2,           0,          0    }},
                    
                    package() { "REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 0 }},                    
                },
            },
        },

        // GTCU Resources
        Package()
        {
            "DEVICE",
            "\\_SB.GTCU",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.

                Package()
                {
                    "FSTATE",
                    0x0,
                    
                    package() { "REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 100000 }},
                    
                    // Action:       1 == ENABLE
                    // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //
                    //                              Clock Name                       Action     Frequency   MatchType
                    //                              --------------------             ------     ----------  ---------
                    Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",               1,           0,          1    }},
                    Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",               1,           0,          1    }},
                    Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",                1,           0,          1    }},
                    
                },

                Package()
                {
                    "FSTATE",
                    0x1,
                 
                      
                    // Action:       2 == DISABLE
                    // MatchType:    3 == CLOCK_FREQUENCY_HZ_CLOSEST
                    //
                    //                              Clock Name                       Action     Frequency   MatchType
                    //                              --------------------             ------     ----------  ---------
                    Package() { "CLOCK", Package() { "gcc_gtcu_ahb_clk",               2,           0,          0    }},
                    Package() { "CLOCK", Package() { "gcc_smmu_cfg_clk",               2,           0,          0    }},
                    Package() { "CLOCK", Package() { "gcc_gfx_tcu_clk",                2,           0,          0    }},
                    
                    package() { "REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 0 }},                    
                },
            },
        },
        
    })
}