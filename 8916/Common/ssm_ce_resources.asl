//===========================================================================
//                           <crypto_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by pep drivers.
//
//
//   Copyright (c) 2010-2011 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================



Scope(\_SB_.PEP0) 
{
    // CRYPTO 
    Method(SSMD)
    {
        Return(CSCC)
    }   
   
    Name(CSCC,
    Package ()
    { 
        Package()
        {
            "DEVICE",
            "\\_SB.SSM",
            Package()
            {
                   "COMPONENT",
                   0x0, // Component 0.
                   Package()
                   {
                       "FSTATE",
                       0x0, // f0 state
                       package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO_CORE0", "ICBID_SLAVE_EBI1", 200000000, 200000000}},
                       package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_ahb_clk",  // Clock name
                                   1,             // Enable
                                   0,             // na
                                   2,             // Match: Most
                               }
                           },                        
                           package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_axi_clk",  // Clock name
                                   1,             // Enable
                                   0,             // na
                                   2,             // Match: Most
                               }
                           },
                           package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_clk",  // Clock name
                                   8,             // 8: Enable and set
                                   100000000,     // Freq: 100 MHz
                                   4,             // Match: 4, exact
                               }
                           },
                   },

                   Package()
                   {
                       "FSTATE",
                       0x1, // f1 state
                       //package() {"REQUIRED_RESOURCE", package() { 0, "/clk/snoc", 0x0}},
                       //package() {"REQUIRED_RESOURCE", package() { 0, "/clk/cnoc", 0x0}},
                       package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO_CORE0", "ICBID_SLAVE_EBI1", 0, 0}},
                          package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_ahb_clk",  // Clock name
                                   2,             // Disable
                                   0,             // na
                                   1,             // Match: Least
                               }
                           },
                           package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_axi_clk",  // Clock name
                                   2,             // Disable
                                   0,             // na
                                   1,             // Match: Least
                               }
                           },
                           package()
                           {
                               "CLOCK", // Clock resource
                               package()
                               {
                                   "gcc_ce1_clk",  // Clock name
                                   2,             // Disable
                                   0,             // na
                                   1,             // Match: Least
                               }
                           },         
                   },    
            },

            Package()
            {
               "COMPONENT",
                0x1, // Component 1.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                        //package() {"REQUIRED_RESOURCE", package() { 1, "/clk/snoc", 0xffffffff}},
                        //package() {"REQUIRED_RESOURCE", package() { 1, "/clk/cnoc", 0xffffffff}},
                        package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO_CORE1", "ICBID_SLAVE_EBI1", 200000000, 200000000}},         
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_ahb_clk",  // Clock name
                                1,             // 1: Enable 
                                0,             // Freq: NA
                                2,             // Match: 2, at most
                            }
                        },                        
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_axi_clk",  // Clock name
                                1,             // 1: Enable 
                                0,             // Freq: NA
                                2,             // Match: 2, at most
                            }
                        },
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_clk",  // Clock name
                                8,             // 8: Enable and set
                                100000000,     // Freq: 100 Mhz
                                4,             // Match: 4, exact
                            }
                        },
                },

                Package()
                {
                    "FSTATE",
                    0x1, // f1 state
                        //package() {"REQUIRED_RESOURCE", package() { 0, "/clk/snoc", 0x0}},
                        //package() {"REQUIRED_RESOURCE", package() { 0, "/clk/cnoc", 0x0}},      
                        package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO_CORE1", "ICBID_SLAVE_EBI1", 0, 0}},
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_ahb_clk",  // Clock name
                                2,             // Disable
                                0,             // na
                                1,             // Match: Least
                            }
                        },

                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_axi_clk",  // Clock name
                                2,             // Disable
                                0,             // na
                                1,             // Match: Least
                            }
                        },
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_ce2_clk",  // Clock name
                                2,             // Disable
                                0,             // na
                                1,             // Match: Least
                            }
                        },
                },
            },
        },
        /////////////////////////////////////////////////////////////////////////////////////
    })      
   
}
