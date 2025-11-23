/**
 * This file contains debugger and debugger power resource information used by
 * the PEP driver.
 */
Scope(\_SB.PEP0)
{
    Method(LDBG){
        return(NDBG)
    }
    
    Name( NDBG, 
        /**
         * The debuggers package is used by PEP to detect when a debugger is connected,
         * turn on the required power resources for a debugger and to turn off all 
         * debugger related resources when not in use (this logic is encompassed in PEP).
         *
         * The expected hiearchy of this package:
         * DEBUGGERS
         *      TYPE
         *          String = SERIAL, USB2.0, USB3.0
         *          INSTANCES
         *              The instancepath of the drivers which the debugger impersonates
         *          DEBUG_ON
         *              The resources that need to be turned on for the debugger to work
         *              for the given controller type (SERIAL/USB2.0/USB3.0)
         *          DEBUG_OFF
         *              The resources to turn off when no debugger is connected for this
         *              debugger type and no HLOS driver is loaded for any one of the given
         *              HLOS types. The implementation for this feature is documented within
         *              PEP.
         *
         */
        package(){
            "DEBUGGERS",
            package()
            {
                "TYPE",
                "SERIAL",
                package()
                {
                    "INSTANCES",
                    "\\_SB.UAR2",
                },
                
                package()
                {
                    "DEBUG_ON",
                    package(){ "CLOCK", package(){ "gcc_blsp1_uart2_apps_clk", 1}},
                    package(){ "CLOCK", package(){ "gcc_blsp1_ahb_clk", 1}},
                },
                
                package()
                {
                    "DEBUG_OFF",
                }
            },
            
            package()
            {
                "TYPE",
                "USB2.0",
                package()
                {
                    "INSTANCES",
                    "\\_SB.URS0",
                },
                
                package()
                {
                    "DEBUG_ON",
                    
                    Package() {"REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 19200}},

                    package()
                    {
                        "PMICVREGVOTE",                 // PMICVREGVOTE resource
                        package()                       //Vote for L20 @3.075v
                        {    
                            "PPP_RESOURCE_ID_LDO13_A",  // Voltage Regulator ID
                            1,                          // Voltage Regulator type 1 = LDO
                            3075000,                    // Voltage = 3.075 V
                            16000,                      // Peak Current = 16 mA
                            1,                          // SW Enable = Enable
                            0,                          // Pin Enable = None
                            1,                          // SW Power Mode = NPM
                            0,                          // Pin Power Mode = None
                            0,                          // Bypass Enable = Allowed
                            0,                          // Head Room
                        },
                    },

                    package()
                    {
                        "PMICVREGVOTE",                   // PMICVREGVOTE resource
                        package()                         // Vote for L10 @1.8v
                        {
                            "PPP_RESOURCE_ID_LDO7_A",     // Voltage Regulator ID
                            1,                            // Voltage Regulator type = LDO   
                            1800000,                      // Voltage = 1.800 V
                            19000,                        // Peak Current = 19 mA
                            1,                            // SW Enable = Enable
                            0,                            // Pin Enable = None
                            1,                            // SW Power Mode = NPM
                            0,                            // Pin Power Mode = None
                            0,                            // Bypass Enable = Allowed
                            0,                            // Head Room
                        },
                    },
                },
                
                package()
                {
                    "DEBUG_OFF",

                    Package() {"REQUIRED_RESOURCE", package() { 1, "/clk/pcnoc", 0}},

                    package()
                    {
                        "PMICVREGVOTE",                 // PMICVREGVOTE resource
                        package()                       // Vote for L20 @0v
                        {    
                            "PPP_RESOURCE_ID_LDO13_A",  // Voltage Regulator ID
                            1,                          // Voltage Regulator type 1 = LDO
                            0,                          // Voltage = 0 V
                            0,                          // Peak Current = 0 mA
                            0,                          // SW Enable = Enable
                            0,                          // Pin Enable = None
                            1,                          // SW Power Mode = NPM
                            0,                          // Pin Power Mode = None
                            0,                          // Bypass Enable = Allowed
                            0,                          // Head Room
                        },
                    },

                    package()
                    {
                        "PMICVREGVOTE",                   // PMICVREGVOTE resource
                        package()                         // Vote for L10 @0v
                        {
                            "PPP_RESOURCE_ID_LDO7_A",     // Voltage Regulator ID
                            1,                            // Voltage Regulator type = LDO   
                            0,                            // Voltage = 0 V
                            0,                            // Peak Current = 0 mA
                            1,                            // SW Enable = Enable
                            0,                            // Pin Enable = None
                            1,                            // SW Power Mode = NPM
                            0,                            // Pin Power Mode = None
                            0,                            // Bypass Enable = Allowed
                            0,                            // Head Room
                        },
                    },
                }
            },
            
            package()
            {
                "TYPE",
                "USB3.0",
                package()
                {
                    "INSTANCES",
                },
                
                package()
                {
                    "DEBUG_ON",
                },
                
                package()
                {
                    "DEBUG_OFF",
                }
            }
        })
}
