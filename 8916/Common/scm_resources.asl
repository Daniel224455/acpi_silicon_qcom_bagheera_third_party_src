Scope(\_SB_.PEP0) 
{

    // CRYPTO 
    Method(SCMD)
    {
        Return(SCCC)
    }	
	
	
    Name(SCCC,
    Package ()
    { 
	    //Device QsecureMSM Data
        Package()
        {
            "DEVICE",
            "\\_SB.SCM0",
			Package()
			{
                "COMPONENT",
                0x0, // Component 2.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                        package() {"REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc"  , 100000}},  //NEEDS REVISIT on the value
                        //package() { "BUSARB", Package() { 3, "ICBID_MASTER_CRYPTO", "ICBID_SLAVE_EBI1", 200000000, 200000000}}, //NEEDS REVISIT on the value
                        package()
                        {
                            "CLOCK", // Clock resource
                            package()
                            {
                                "gcc_crypto_ahb_clk",  // Clock name
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
                                "gcc_crypto_axi_clk",  // Clock name
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
                                "gcc_crypto_clk",  // Clock name
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
			},
		}
	})
}