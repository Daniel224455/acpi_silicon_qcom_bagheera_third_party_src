//===========================================================================
//                           <audio_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by audio drivers.
//
//
//   Copyright (c) 2010-2011 by QUALCOMM, Incorporated.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================



Scope(\_SB_.PEP0) 
{
	
    // AUDIO 
    Method(APMD)
    {
        Return(APCC)
    }	
	
	
    Name(APCC,
    Package ()
    { 
	
            Package()
            {
                "DEVICE",
            "\\_SB.AMSS.ADCM.AUDD",// AMSS child
    			Package()
    			{
    				"COMPONENT",
    				0x0, // Component 0.
    				Package()
    				{
    					"FSTATE",
    					0x0, // f0 statepackage()
    					Package()
    					{
    						"PMICVREGVOTE",		// PMICVREGVOTE resource
    						Package()
    						{	
    							"PPP_RESOURCE_ID_SMPS4_A", 
    							2,		    // Voltage Regulator type = SMPS
								1800000,	// 1.8V
								500000,		// 500 mA 
    							1,			// Force enable from s/w
								0,	 		// Disable pin control enable
    							0,	 		// Power mode - AUTO
    							0,	 		// Disable pin control power mode
    							0,	 		// Bypass allowed - default
    							5,	 		// Frequency - 1.6 MHz
    							0,	 		// Freq reason - none
    							0,	 		// Quiet Mode - disable
    							0,	 		// Corner Mode - none
    							0,	 		// head room voltage
    						},
    					},
    					
						Package()
    					{
    					   "PMICVREGVOTE",		// PMICVREGVOTE resource
    					   Package()
    					   {
    						  "PPP_RESOURCE_ID_LDO5_A", // Resource ID
    						  1,                        // Voltage Regulator type = LDO
    						  1800000,                  // 1.8V
							  10000,                    // 10mA
    						  1,                        // Force enable from s/w
    						  0,                        // Disable pin control
    						  1,                        // Power mode - NPM
    						  0,                        // Disable pin control power mode
    						  0,                        // Bypass allowed - default
    						  0,                        // head room voltage
    					   },
    					},
						
    					Package()
    					{
    					   "PMICVREGVOTE",		// PMICVREGVOTE resource
    					   Package()
    					   {
							  "PPP_RESOURCE_ID_LDO13_A",// Resource ID
    						  1,                        // Voltage Regulator type = LDO
							  3075000,                  // 3.075V
							  5000,                     // 5mA
    						  1,                        // Force enable from s/w
    						  0,                        // Disable pin control
    						  1,                        // Power mode - NPM
    						  0,                        // Disable pin control power mode
    						  0,                        // Bypass allowed - default
    						  0,                        // head room voltage
    					   },
    					},
                        package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               63,  // PIN number = 63
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               64,  // PIN number = 64
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               65,  // PIN number = 65
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               66,  // PIN number = 66
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               67,  // PIN number = 67
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               68,  // PIN number = 68 
							    1,   // State: active = 0x1
								1,   // Function select = 1              
								1,   // direction = Output.
								0,   // 1: Pull Down
								3,   // Drive Strength: 0x3 = 8mA
							},
						},
    				},

    				Package()
    				{
    					"FSTATE",
    					0x1, // f1 statepackage()
    					Package()	
    					{
    						"PMICVREGVOTE", // PMICVREGVOTE resource
							Package()
    						{	
    							"PPP_RESOURCE_ID_SMPS4_A", 
    							2,		// Voltage Regulator type = SMPS
								0,		// 0V
								0,		// 0 mA 
								0,		// Force enable from s/w
    							0,	 	// Disable pin control enable
    							0,	 	// Power mode - AUTO
    							0,	 	// Disable pin control power mode
    							0,	 	// Bypass allowed - default
								5,	 	// Frequency - 1.6 MHz
    							0,	 	// Freq reason - none
    							0,	 	// Quiet Mode - disable
    							0,	 	// Corner Mode - none
    							0,	 	// head room voltage
    						},
    					},
      
						Package()
    					{
    					   "PMICVREGVOTE",		// PMICVREGVOTE resource
							Package()
    					   {
    						  "PPP_RESOURCE_ID_LDO5_A", // Resource ID
    						  1,                        // Voltage Regulator type = LDO
							  1800000,	                // 1.8mV
							  4000,	                    // 4mA
    						  0,                        // Force enable from s/w
    						  0,                        // Disable pin control
    						  0,                        // Power mode - LPM
    						  0,                        // Disable pin control power mode
    						  0,                        // Bypass allowed - default
    						  0,                        // head room voltage
    					   },
    					},
                        
						Package()
    					{
    					   "PMICVREGVOTE",		// PMICVREGVOTE resource
							Package()
    					   {
    						  "PPP_RESOURCE_ID_LDO13_A", // Resource ID
    						  1,                        // Voltage Regulator type = LDO
							  0,	                    // 0V
							  0,	                    // 0mA
    						  0,                        // Force enable from s/w
    						  0,                        // Disable pin control
    						  0,                        // Power mode - LPM
    						  0,                        // Disable pin control power mode
    						  0,                        // Bypass allowed - default
    						  0,                        // head room voltage
    					   },
                        },
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               63,  // PIN number = 63
							    0,   // State: active = 0x1
								0,   // Function select = 1              
								0,   // direction 0 = Input.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               64,  // PIN number = 64
							    0,   // State: active = 0x1
								0,   // Function select = 1              
								0,   // direction = Input.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               65,  // PIN number = 65
							    0,   // State: active = 0x1
								0,   // Function select = 1              
								0,   // direction = Input.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               66,  // PIN number = 66
							    0,   // State: active = 0x1
								0,   // Function select = 1              
								0,   // direction = Input.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               67,  // PIN number = 67
							    1,   // State: active = 0x1
								0,   // Function select = 1              
								1,   // direction = Output.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},
						package()
                        {
                            "TLMMGPIO", // TLMMGPIO resource 
                            package()
                            {                                    
                               68,  // PIN number = 68 
							    0,   // State: active = 0x1
								0,   // Function select = 1              
								0,   // direction = Input.
								1,   // 1: Pull Down
								0,   // Drive Strength: 0x0= 2mA
							},
						},						
    				},
    			},
			},						
    })
}
