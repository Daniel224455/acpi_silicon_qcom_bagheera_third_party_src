//===========================================================================
//                           <subsys_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by subsystem drivers.
//
//
//   Copyright (c) 2010-2011 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================


Scope(\_SB_.PEP0) 
{
	
    // Subsystem Drivers
    Method(SPMD)
    {
        Return(SPCC)
    }	
	
	
    Name(SPCC,
    Package ()
    { 
        Package()
        {
            "DEVICE",
            "\\_SB.AMSS",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                },
				Package()
				{
					"PSTATE",
					0x0, // P0 state
					
					// VDDCX //
					Package() { 
					"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_cx",
						4, //Corner Vote
						},
					},

					Package() { 
					"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_mx",
						4, //Corner Vote
						},
					},
					Package(){ 
					"CLOCK", 
						Package(){ 
						"gcc_boot_rom_ahb_clk", // Clock Name - gcc_boot_rom_ahb_clk
						1, // Action - 1 - Enable
						0, // Frequency - 0
						2, // Match Type - At Most (Hz)
						},
					},
				},
				Package(){
					"PSTATE",
					1, 
					Package(){ 
					"CLOCK", 
						Package(){ 
						"gcc_boot_rom_ahb_clk", // Clock Name - gcc_boot_rom_ahb_clk
						2, // Action - 2 - Disable
						0, // Frequency - 0
						2, // Match Type - At Most (Hz)
						},
					},
					Package() { 
						"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_cx",
						0, //Corner Vote
						},
					},
					Package() { 
					"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_mx",
						0, //Corner Vote
						},
					},
				},
                Package(){
					"PSTATE",
					2,
                },
            },
            Package()
            {
                "DSTATE",
                0x0, // D0 state
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
            }
        },
        
///////////////////////////////////////////////////////////////////////////////
//////
        
        // WCN Device
	Package()
        {
            "DEVICE",
            "\\_SB.RIVA",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
                },
                Package()
                {
                    "PSTATE",
                    0x0, // P0 state
                    //vote for HFPLL which internally votes for the SR2PLL, we don't need to vote LDO7 for SR2PLL later
                    Package() { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 1}}, 
                    //  NOTES
                    //     The order of the VREGs here is important. We vote for the switchers followed  
                    //     by the LDO that supplies internal components (memories, digital) then finally the WCN chip.
                    //     It is important that WCN VDD_IO (1.8V) and VDD_XO is supplied BEFORE 1.3V and 1.2V supplies to IRIS
                    //     The order of the 1.3V and 1.2V can be in any order after that 
                    //

					Package() { 
					"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_cx",
						4, //Corner Vote
						},
					},

					Package()
					{
						"PMICVREGVOTE", // PMICVREGVOTE resource
						Package()
						{              
							"PPP_RESOURCE_ID_SMPS3_A",    // Feeds Rhea Analog,VDDA_WLAN 
							2,                          // Voltage Regulator type = SMPS
							1300000,                    // Voltage in microvolts = 1.3V
							1800000,                   // Peak current in microamps = 1.8A
							1, // Force enable from s/w
							0, // Disable pin control enable
							0, // Power mode - AUTO
							0, // Disable pin control power mode
							0, // Bypass allowed - default
							5, // Frequency - 3.20 MHz
							0, // Freq reason - none
							0, // Quiet Mode - disable
							0, // Corner Mode - none
							0, // head room voltage
						},
					},
					 
                    
                    // Internal memories power
					Package() { 
					"REQUIRED_RESOURCE", 
						Package() {
						1, //Required Resource - 1 or Non Required Resource - 0
						"/pmic/client/rail_mx",
						4, //Corner Vote
						},
					},
                    
                    //
                    // EXTERNAL IRIS WCN3xxx power sequencing STARTS HERE
                    //

                    // ***** STEP 1. 1.8V VDD_IO IS THE FIRST LDO THAT MUST TURN ON **********
                    //
					Package()
					{
						"PMICVREGVOTE", // PMICVREGVOTE resource
						Package()
						{              
							"PPP_RESOURCE_ID_LDO5_A", // VDD_1P8V to WCN3xxx
							1,          // Voltage Regulator type = LDO
							1800000,    // Voltage in microvolts = 1.8V
							23000,       // Peak current in microamps = 23ma
							1, // force enable from software
							0, // disable pin control enable
							1, // power mode - Normal Power Mode
							0, // power mode pin control - disable
							0, // bypass mode allowed
							0, // head room voltage
						},
					},                             
                    
                    // ***** STEP 2. 1.8V for XO  **********
                    // ** on 8916, WCNSS gets a clock from RFCLK2 buffered CXO 

                    // LDO7 powers both SR2 PLL circuit as well as the Rhea clock circuit
                    // We need to vote LDO7 for Rhea clock here even HFPLL internally vote for LDO7 for SR2PLL
                    // This is just to be "proper", so that all resources are voted on for each circuit that needs it. 
                    // There is no harm in voting again. These are proxy votes.

					Package()
					{
						"PMICVREGVOTE", // PMICVREGVOTE resource
						Package()
						{              
							"PPP_RESOURCE_ID_LDO7_A", //  Rhea clock, VDD_XO_1P8V
							1,          // Voltage Regulator type = LDO
							1800000,    // Voltage in microvolts = 1.8V
							8000,       // Peak current in microamps = 5mA
							1, // force enable from software
							0, // disable pin control enable
							1, // power mode - Normal Power Mode
							0, // power mode pin control - disable
							0, // bypass mode allowed
							0, // head room voltage
						},
					},             

					
                               
                  
                    // ***** STEP 4. ALL the following rails can power up in any order **********
                    //      NOTE: for 8916 there is NO 1.2V rail (optional)
                    //         				
                                
					Package()
					{
						"PMICVREGVOTE", // PMICVREGVOTE resource
						Package()
						{              
							"PPP_RESOURCE_ID_LDO9_A", // Rhea PA, VDD_3P3V
							1,          // Voltage Regulator type = LDO
							3300000,    // Voltage in microvolts = 3.3V
							515000,     // Peak current in microamps = 515mA
							1, // force enable from software
							0, // disable pin control enable
							1, // power mode - Normal Power Mode
							0, // power mode pin control - disable
							0, // bypass mode allowed
							0, // head room voltage
						},
					},
                    
                    /* STEP 5. Enable clock LAST */
                    //need to check PEP User's guide for this

					package()
					{
						"PMICVREGVOTE", // PMIC VREG resource
						package()
						{									
							"PPP_RESOURCE_ID_CXO_BUFFERS_RFCLK2_A", // Enable CXO RFLCLK2 buffer
							6, // Voltage Regulator type 6 = CXO Buffer
							1, // SW Enable = Enable
							0, // Pin Enable = None
						},
					},

                    // NOTE: the TLMMGPIO settings are to configure just the 5 -wire interface to config the external
                    // WCN3xxx tranceiver.
             
					package()
					{
						"TLMMGPIO", 
						package()
						{
							40,   // PIN number
							1,   // State = active
							1,   // Function select = GPIO
							1,   // direction = Output
							1,   // Pull value = Pull down
							2,   // Drive Strength = 6mA
						},
					},             
					package()
					{
						"TLMMGPIO", 
						package()
						{
							41,   // PIN number
							1,   // State = active
							1,   // Function select = GPIO
							1,   // direction = Output
							1,   // Pull value = Pull down
							2,   // Drive Strength = 6mA
						},
					},
					package()
					{
						"TLMMGPIO", 
						package()
						{
							42,   // PIN number
							1,   // State = active
							1,   // Function select = GPIO
							1,   // direction = Output
							1,   // Pull value = Pull down
							2,   // Drive Strength = 6mA
						},
					},
					package()
					{
						"TLMMGPIO", 
						package()
						{
							43,   // PIN number
							1,   // State = active
							1,   // Function select = GPIO
							1,   // direction = Output
							1,   // Pull value = Pull down
							2,   // Drive Strength = 6mA
						},
					},
					package()
					{
						"TLMMGPIO", 
						package()
						{
							44,   // PIN number
							1,   // State = active
							1,   // Function select = GPIO
							1,   // direction = Output
							1,   // Pull value = Pull down
							2,   // Drive Strength = 6mA
						},
					},                                                                             
				},
                Package()
                {
                    "PSTATE",
                    0x1, // P1 state

                    Package() { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 0}}, 
					
                    //
                    //  VOTE off resources to WCN3xxx in reverse order from P0 state above 
                    //   
                    
                    // disable clock first
                    package()	
                    {
                    	"PMICVREGVOTE", // PMIC VREG resource
                    	package()
                    	{									
                    		"PPP_RESOURCE_ID_CXO_BUFFERS_RFCLK2_A", // CXO RFLCLK2 buffer
                    		6, // Voltage Regulator type 6 = CXO Buffer
                    		0, // SW Enable = Disable
                    		0, // Pin Enable = None
                    	},
                    },

                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {              
                            "PPP_RESOURCE_ID_LDO9_A", // Rhea PA 
                            1,          // Voltage Regulator type = LDO
                            0, // Voltage in microvolts = 
                            0, // Peak current in microamps 
                            0, // force enable from software
                            0,    // disable pin control enable
                            1,    // power mode - Normal Power Mode
                            0,     // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },             

                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {              
                            "PPP_RESOURCE_ID_LDO7_A",  //  VDD 1.8V XO to WCN3xxx
                            1, // Voltage Regulator type = LDO
                            0, // Voltage in microvolts = 
                            0, // Peak current in microamps = 
                            0, // force enable from software
                            0, // disable pin control enable
                            0, // power mode - Low Power Mode
                            0, // power mode pin control - disable
                            0, // bypass mode allowed
                            0, // head room voltage
                        },
                    },
                    
                    Package()
                    {
                        "PMICVREGVOTE", // PMICVREGVOTE resource
                        Package()
                        {              
                            "PPP_RESOURCE_ID_LDO5_A", // VDD_1P8V to WCN3xxx
                            1, // Voltage Regulator type = LDO
                            0, // Voltage in microvolts = 
                            0, // Peak current in microamps = 
                            0, // force enable from software
                            0, // disable pin control enable
                            1, // power mode - Normal Power Mode
                            0, // power mode pin control - disable
                            0, // bypass mode allowed
                            0, // head room voltage
                        },
                    },                   
 
                    // Internal memories power
                   Package() { 
                        "REQUIRED_RESOURCE", 
                        Package() {
                            1, //Required Resource - 1 or Non Required Resource - 0
                            "/pmic/client/rail_mx",
                            0, 
                        },
                   },            

                         
                     Package()
                     {
                         "PMICVREGVOTE", // PMICVREGVOTE resource
                         Package()
                         {              
                            "PPP_RESOURCE_ID_SMPS3_A",    //Rhea Analog, VDDA_WLAN
                            2, // Voltage Regulator type = SMPS
                            0, // Voltage in microvolts = 1.3V
                            0, // Peak current in microamps = 2A
                            0, // Force enable from s/w
                            0, // Disable pin control enable
                            0, // Power mode - AUTO
                            0, // Disable pin control power mode
                            0, // Bypass allowed - default
                            5, // Frequency - 3.20 MHz
                            0, // Freq reason - none
                            0, // Quiet Mode - disable
                            0, // Corner Mode - none
                            0, // head room voltage
                        },
                    },

                    Package() { 
                        "REQUIRED_RESOURCE", 
                         Package() {
                             1, //Required Resource - 1 or Non Required Resource - 0
                             "/pmic/client/rail_cx",
                             0, 
                         },
                   },
                   
                },
	        },                                                             
                Package()
                {
                    "DSTATE",
                    0x0, // D0 state
				},             
				Package()
                {
                    "DSTATE",
                    0x3, // D3 state
				}
			},
    })	
    
}
