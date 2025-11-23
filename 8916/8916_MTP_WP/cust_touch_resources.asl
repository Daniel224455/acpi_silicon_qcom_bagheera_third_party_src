

///////////////////////////////////////////////////////////////////////////////
//
//     Touch Resources for Touch Detection Driver (TDD)
//
///////////////////////////////////////////////////////////////////////////////

Scope(\_SB_.PEP0)
{
  
    Method(LPMD)
    {
        Return(LPCC)
    }    
    
    Name(LPCC,
    Package ()
    {  
        // Touch Detection Driver (TDD)
        Package()
        {
            "DEVICE",
            "\\_SB.TDD1",

            ///////////////////////////////////////////////////////////////////////////////
            //     First Entry (TSC1) of TDD
            ///////////////////////////////////////////////////////////////////////////////
            Package()
            {
                "COMPONENT",
                0x0, // Component 0.
                Package()
                {
                   "FSTATE",
                    0,
                },
                Package()
                {
                   "FSTATE",
                    1,
                },
                Package()
                {
                   "PSTATE",
                    0,
                    
                    package()
                    {
                      "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                      package()
                      {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                      },
                    },
                    package()
                    {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Atmel Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Atmel Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Atmel may need needs ~22 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         25,  // 25 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "PSTATE",
                 1,     
                 // Atmel Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Atmel Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
        },

        ///////////////////////////////////////////////////////////////////////////////
        //     Second Entry (TSC2) of TDD
        ///////////////////////////////////////////////////////////////////////////////
        Package()
        {
            "COMPONENT",
            1, // Component 1.
            Package()
            {
               "FSTATE",
               0,
            },
            Package()
            {
               "FSTATE",
               1,
            },
            Package()
            { 
               "PSTATE",
               0, // P0 state
               package()
               {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Synaptics Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Synaptics Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Synaptics may need needs ~200 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         200,  // 200 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "PSTATE",
                  1, // P1 state    
                 // Synaptics Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Synaptics Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },
 
         ///////////////////////////////////////////////////////////////////////////////
         //     Third Entry (TSC3) of TDD
         ///////////////////////////////////////////////////////////////////////////////
         Package()
         {
              "COMPONENT",
              2, // Component 2.
              Package()
              {
                 "FSTATE",
                  0,
              },
              Package()
              {
                 "FSTATE",
                  1,
              },
              Package()
              { 
                 "PSTATE",
                  0, // P0 state
                  package()
                  {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // FocalTech Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Focaltech Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // FocalTech may need needs ~200 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         200,  // 200 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "PSTATE",
                  1, // P1 state    
                 // FocalTech Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // FocalTech Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },

         ///////////////////////////////////////////////////////////////////////////////
         //     Fourth Entry (TSC4) of TDD
         ///////////////////////////////////////////////////////////////////////////////

         Package()
         {
             "COMPONENT",
             3, // Component 3.
             Package()
             {
                "FSTATE",
                 0,
             },
             Package()
             {
                "FSTATE",
                 1,
             },
             Package()
             { 
                "PSTATE",
                0, // P0 state
                package()
                {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Cypress Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Cypress Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Cypress may need needs ~100 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         100,  // 100 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "PSTATE",
                  1, // P1 state    
                 // Cypress Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Cypress Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },    

         ///////////////////////////////////////////////////////////////////////////////
         //     Customer Driver Entry for TDD
         ///////////////////////////////////////////////////////////////////////////////

         // Add your entry to TDD here

       },         
    }
    )    
}


///////////////////////////////////////////////////////////////////////////////
//
//     Touch Resources for TSC Entryes
//
//////////////////////////////////////////////////////////////////////////////

Scope(\_SB_.PEP0) 
{
    Method(LPMX)
    {
        Return(LPXC)
    }
        
    Name(LPXC,
    Package(){

        ///////////////////////////////////////////////////////////////////////////////
        //
        //     Touch Resources for QCOM TSC1
        //
        ///////////////////////////////////////////////////////////////////////////////

        Package()
        {
             "DEVICE",
             "\\_SB.TSC1",
             Package()
             { 
                 "DSTATE",
                 0x0, // D0 state
                 package()
                 {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Atmel Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Atmel Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Atmel may need needs ~22 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         25,  // 25 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "DSTATE",
                 0x3, // D3 state    
                 // Atmel Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Atmel Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },


         ///////////////////////////////////////////////////////////////////////////////
         //
         //     Touch Resources for QCOM TSC2
         //
         ///////////////////////////////////////////////////////////////////////////////

         Package()
         {
             "DEVICE",
             "\\_SB.TSC2",
             Package()
             { 
                 "DSTATE",
                 0x0, // D0 state
                 package()
                 {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Synaptics Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Synaptics Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Synaptics may need needs ~200 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         200,  // 200 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "DSTATE",
                 0x3, // D3 state    
                 // Synaptics Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Synaptics Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },

 
         ///////////////////////////////////////////////////////////////////////////////
         //
         //     Touch Resources for QCOM TSC3
         //
         ///////////////////////////////////////////////////////////////////////////////
         Package()
         {
             "DEVICE",
             "\\_SB.TSC3",
             Package()
             { 
                 "DSTATE",
                 0x0, // D0 state
                 package()
                 {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // FocalTech Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Focaltech Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // FocalTech may need needs ~200 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         200,  // 200 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "DSTATE",
                 0x3, // D3 state    
                 // FocalTech Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // FocalTech Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },


         ///////////////////////////////////////////////////////////////////////////////
         //
         //     Touch Resources for QCOM TSC4
         //
         ///////////////////////////////////////////////////////////////////////////////

         Package(){
         // Touch LVS1
         Package()
         {
             "DEVICE",
             "\\_SB.TSC4",
             Package()
             { 
                 "DSTATE",
                 0x0, // D0 state
                 package()
                 {
                     "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         3,   // Pull Up 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 package()
                 {
                     "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: NOT active = 0x0
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Cypress Power source LDO6  (For I2C- PullUps)
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         1800000,  // Voltage is in micro volts ( 1.8V )
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 // Cypress Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,        // Voltage Regulator type = LDO
                         2850000,  // 2.75V Voltage is in micro volts (2.85V)
                         10000,    // Peak current in microamps (10ma)
                         1,        // force enable from software
                         0,        // disable pin control enable
                         1,        // power mode - Normal Power Mode
                         0,        // power mode pin control - disable
                         0,        // bypass mode allowed
                         0,        // head room voltage
                     },
                 },
                 package()
                 {
                     "DELAY", // Hold the RESET line LOW after power up for 2ms
                     package()
                     {
                         2,  // 2 Milsec delay
                     }
                 },
                 // Drive RESET Line High
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource TS_RESET 
                     package()
                     {                                    
                         12,  // PIN number = 12
                         1,   // State: active = 0x1
                         0,   // Function select = 0
                         1,   // direction = Output.
                         0,   // NO Pull 
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Cypress may need needs ~100 ms to be ready for comm
                 package()
                 {
                     "DELAY", 
                     package()
                     {
                         100,  // 100 Milsec delay
                     }
                 },
             },
             Package()
             {
                 "DSTATE",
                 0x3, // D3 state    
                 // Cypress Power source LDO17
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO17_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },
                 // Cypress Power source LDO6  (For I2C- PullUps) 
                 package()
                 {
                     "PMICVREGVOTE",   // PMICVREGVOTE resource
                     package()
                     {
                         "PPP_RESOURCE_ID_LDO6_A", // VREG ID
                         1,      // Voltage Regulator type = LDO
                         0,      // Voltage is in micro volts
                         0,      // Peak current in microamps
                         0,      // force disable from software
                         0,      // disable pin control enable
                         0,      // power mode - Low Power Mode
                         0,      // power mode pin control - disable
                         0,      // bypass mode allowed
                         0,      // head room voltage
                     },
                 },                 
                 // RESET pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource RESET
                     package()
                     {                                    
                         12,  // PIN number = 12
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
                 // Interrupt pin - power save mode 
                 package()
                 {
                     "TLMMGPIO", // TLMMGPIO resource INT
                     package()
                     {                                    
                         13,  // PIN number = 13
                         0,   // State: IN active = 0x0
                         0,   // Function select = 0
                         0,   // direction = Input.
                         1,   // Pull Down
                         0,   // Drive Strength: 0x0 = 2mA
                     },
                 },
             },
         },
         }


          ///////////////////////////////////////////////////////////////////////////////
          //
          //     Touch Resources for Customer Touch Driver (Refarance entry)
          //
          ///////////////////////////////////////////////////////////////////////////////

        // Package(){
        // // Touch LVS1
        // Package()
        // {
        //     "DEVICE",
        //     "\\_SB.TSC5", //This should match with customer TSC entry
        //     Package()
        //     { 
        //         "DSTATE",
        //         0x0, // D0 state
        //         package()
        //         {
        //             "TLMMGPIO", // GPIO13, TLMMGPIO resource INT
        //             package()
        //             {                                    
        //                 13,  // PIN number = 13
        //                 0,   // State: NOT active = 0x0
        //                 0,   // Function select = 0
        //                 0,   // direction = Input.
        //                 3,   // Pull Up 
        //                 0,   // Drive Strength: 0x0 = 2mA
        //             },
        //         },
        //         package()
        //         {
        //             "TLMMGPIO", // GPIO12, TLMMGPIO resource RESET
        //             package()
        //             {                                    
        //                 12,  // PIN number = 12
        //                 0,   // State: NOT active = 0x0
        //                 0,   // Function select = 0
        //                 1,   // direction = Output.
        //                 0,   // NO Pull 
        //                 0,   // Drive Strength: 0x0 = 2mA
        //             },
        //         },
        //         // Power source LDO6  (For I2C- PullUps)
        //         package()
        //         {
        //             "PMICVREGVOTE",   // PMICVREGVOTE resource
        //             package()
        //             {
        //                 "PPP_RESOURCE_ID_LDO6_A", // VREG ID
        //                 1,        // Voltage Regulator type = LDO
        //                 1800000,  // Voltage is in micro volts ( 1.8V )
        //                 10000,    // Peak current in microamps (10ma)
        //                 1,        // force enable from software
        //                 0,        // disable pin control enable
        //                 1,        // power mode - Normal Power Mode
        //                 0,        // power mode pin control - disable
        //                 0,        // bypass mode allowed
        //                 0,        // head room voltage
        //             },
        //         },
        //         // Power source LDO17
        //         package()
        //         {
        //             "PMICVREGVOTE",   // PMICVREGVOTE resource
        //             package()
        //             {
        //                 "PPP_RESOURCE_ID_LDO17_A", // VREG ID
        //                 1,        // Voltage Regulator type = LDO
        //                 2850000,  // 2.75V Voltage is in micro volts (2.85V)
        //                 10000,    // Peak current in microamps (10ma)
        //                 1,        // force enable from software
        //                 0,        // disable pin control enable
        //                 1,        // power mode - Normal Power Mode
        //                 0,        // power mode pin control - disable
        //                 0,        // bypass mode allowed
        //                 0,        // head room voltage
        //             },
        //         },
        //         package()
        //         {
        //             "DELAY", // Hold the RESET line LOW after power up for 2ms
        //             package()
        //             {
        //                2  // This may vary on customer TSC
        //             }
        //         },
        //         // Drive RESET Line High
        //         package()
        //         {
        //             "TLMMGPIO", // TLMMGPIO resource TS_RESET 
        //             package()
        //             {                                    
        //                 12,  // PIN number = 12
        //                 1,   // State: active = 0x1
        //                 0,   // Function select = 0
        //                 1,   // direction = Output.
        //                 0,   // NO Pull 
        //                 0,   // Drive Strength: 0x0 = 2mA
        //             },
        //         },
        //         // Cypress may need needs ~100 ms to be ready for comm
        //         package()
        //         {
        //             "DELAY", 
        //             package()
        //             {
        //                 100,  // 100 Milsec delay. This may vary on customer TSC
        //             }
        //         },
        //     },
        //     Package()
        //     {
        //         "DSTATE",
        //         0x3, // D3 state    
        //         // Power source LDO17
        //         package()
        //         {
        //             "PMICVREGVOTE",   // PMICVREGVOTE resource
        //             package()
        //             {
        //                 "PPP_RESOURCE_ID_LDO17_A", // VREG ID
        //                 1,      // Voltage Regulator type = LDO
        //                 0,      // Voltage is in micro volts
        //                 0,      // Peak current in microamps
        //                 0,      // force disable from software
        //                 0,      // disable pin control enable
        //                 0,      // power mode - Low Power Mode
        //                 0,      // power mode pin control - disable
        //                 0,      // bypass mode allowed
        //                 0,      // head room voltage
        //             },
        //         },
        //         // Power source LDO6  (For I2C- PullUps) 
        //         package()
        //         {
        //             "PMICVREGVOTE",   // PMICVREGVOTE resource
        //             package()
        //             {
        //                 "PPP_RESOURCE_ID_LDO6_A", // VREG ID
        //                 1,      // Voltage Regulator type = LDO
        //                 0,      // Voltage is in micro volts
        //                 0,      // Peak current in microamps
        //                 0,      // force disable from software
        //                 0,      // disable pin control enable
        //                 0,      // power mode - Low Power Mode
        //                 0,      // power mode pin control - disable
        //                 0,      // bypass mode allowed
        //                 0,      // head room voltage
        //             },
        //         },                 
        //         // RESET pin - power save mode 
        //         package()
        //         {
        //             "TLMMGPIO", // TLMMGPIO resource RESET
        //             package()
        //             {                                    
        //                 12,  // PIN number = 12
        //                 0,   // State: IN active = 0x0
        //                 0,   // Function select = 0
        //                 0,   // direction = Input.
        //                 1,   // Pull Down
        //                 0,   // Drive Strength: 0x0 = 2mA
        //             },
        //         },
        //         // Interrupt pin - power save mode 
        //         package()
        //         {
        //             "TLMMGPIO", // TLMMGPIO resource INT
        //             package()
        //             {                                    
        //                 13,  // PIN number = 13
        //                 0,   // State: IN active = 0x0
        //                 0,   // Function select = 0
        //                 0,   // direction = Input.
        //                 1,   // Pull Down
        //                 0,   // Drive Strength: 0x0 = 2mA
        //             },
        //         },
        //     },
        // },
        // }
    })
}




