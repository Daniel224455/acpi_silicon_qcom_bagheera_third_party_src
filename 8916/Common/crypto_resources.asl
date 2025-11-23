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
    Method(CRMD)
    {
        Return(CRCC)
    }	
	
	
    Name(CRCC,
    Package ()
    { 
	//Device QsecureMSM Data
        Package()
        {
            "DEVICE",
            "\\_SB.QBCC",
            
            Package()            
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                    package() {"REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc"  , 100000}},  //100 MHz NEEDS REVISIT on the value
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                                "gcc_prng_ahb_clk",  // Clock name
                                1,             // Enable
                                0,             // na
                                1,             // Match
                        }
                    },                               
                },
                Package()
                {
                    "FSTATE",
                    0x1, // f1 state
                    
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_prng_ahb_clk",  // Clock name
                            2,             // Disable
                            0,             // na
                            1,             // Match
                        }
                     },
                     package() {"REQUIRED_RESOURCE", package() { 0, "/clk/pcnoc"  , 0}}, 
                },
            },
			
	    Package()
        {
		        "COMPONENT",
                0x1, // Component 1. Dedicated Crypto
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
		            package() {"REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc"  , 100000}}, //NEEDS REVISIT on the value
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_crypto_ahb_clk",  // Clock name
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
                            "gcc_crypto_axi_clk",  // Clock name
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
                            "gcc_crypto_clk",  // Clock name
                            1,             // 1: Enable
                            100000000,     // Freq: 100 MHz
                            4,             // Match: 4, exact
                        }
                    },
                    //Attach with Pstate 0 (Highest Power)
                    package(){"PSTATE_ADJUST", Package () { 0, 0 }},
                },

                Package()
                {
                    "FSTATE",
                    0x1, // f1 state
                    //package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 0, 0}},
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                                "gcc_crypto_clk",  // Clock name
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
                                "gcc_crypto_axi_clk",  // Clock name
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
                                "gcc_crypto_ahb_clk",  // Clock name
                                2,             // Disable
                                0,             // na
                                1,             // Match: Least
                        }
                    },
                    package() {"REQUIRED_RESOURCE", package() { 0, "/clk/pcnoc"  , 0}},


                },

                Package()
                {
                    "PSTATE",
                    0x0, // P0 state
                    //Highest power state , vote for max possible frequency, Device should already be in F0, before reaching this state
                    package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 200000000, 200000000}}, //NEEDS REVISIT ON THE VALUES
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_crypto_clk", // Clock name
                            3,             // 3: Set
                            100000000,      // Freq: 100 Mhz
                            4,             // Match: 4, exact
                        }
                    },
                },
                Package()
                {
                    "PSTATE",
                    0x1, // P1 state
                    //Low power state , vote for less frequency, Device should already be in F0, before reaching this state
                    package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 100000000, 100000000}}, //NEEDS REVISIT ON THE VALUES
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_crypto_clk", // Clock name
                            3,             // 3: Set
                            50000000,      // Freq: 50 Mhz
                            4,             // Match: 4, exact
                        }
                    },
                },
                Package()
                {
                    "PSTATE",
                    0x2, // P2 state
                    //Lower power state , vote for least possible frequency, Device should already be in F0, before reaching this state
                    package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 50000000, 50000000}}, //NEEDS REVISIT ON THE VALUES
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_crypto_clk", // Clock name
                            3,             // 3: Set
                            50000000,      // Freq: 50 Mhz
                            4,             // Match: 4, exact
                        }
                    },
                },
                Package()
                {
                    "PSTATE",
                    0x3, // P3 state
                    //Off power state , remove bandwidth votes. Device should transition to this state before going to F1
                    package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 0, 0}},
                    package()
                    {
                        "CLOCK", // Clock resource
                        package()
                        {
                            "gcc_crypto_clk", // Clock name
                            3,             // 3: Set
                            0,             // Freq: 0 Mhz
                            4,             // Match: 4, exact
                        }
                    },
                },
	        },
	    }
    })
}
