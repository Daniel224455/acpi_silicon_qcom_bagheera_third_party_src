//--------------------------------------------------------------------------------------------------
// Copyright (c) 2012-2015 Qualcomm Technologies, Inc.  All Rights Reserved.
// Qualcomm Technologies Proprietary and Confidential.
//--------------------------------------------------------------------------------------------------

//--------------------------------------------------------------------------------------------------
// This file contains all graphics ACPI Device Configuration Information and Methods
//
// !!WARNING: This is an auto-generated file and should NOT be edited by hand!!
//            This file contains several interdependent ACPI methods that are all generated from
//            a single XML source.  Items in this file should not be updated manually, as they
//            will be overwritten by the auto-generated output.  Instead, modifications should be
//            made to the XML source, such that they are applied across all relevant tables.
//--------------------------------------------------------------------------------------------------

Device (GPU0)
{
    Name (_HID, "HID_GPU0")
    Name (_CID, "ACPI\HID_GPU0")
    Name (_UID, 0)
    Name (_CLS, 0x0003000000000000)

    // Expose the internal monitor device to allow it to be used in a thermal zone
    // for thermal mitigation.
    //
    Device (MON0)
    {
        Method(_ADR)
        {
            // 0 is always the address assigned for the internal monitor.
            //
            Return(0)
        }
    }

    Name (_DEP, Package()
    {
        \_SB_.GTCU,
        \_SB_.ATCU,
        \_SB_.PEP0,
        \_SB_.PMIC,
    })
    
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            // MDP register/memory space
            //
            Memory32Fixed(ReadWrite, 0x01A00000, 0x00100000)
    
            // MMSS_MISC register/memory space
            //
            Memory32Fixed(ReadWrite, 0x0193E020, 0x00000008)
    
            // MDP Interrupt, vsync
            //
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {104}
    
            // GPU register space
            //
            Memory32Fixed(ReadWrite, 0x01C00000, 0x00010000)
    
            // GPU memory mapping for shader
            //
            Memory32Fixed(ReadWrite, 0x01C10000, 0x00010000)
    
            // GPU Interrupt
            //
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {65}
    
            // VIDC register address space
            //
            Memory32Fixed(ReadWrite, 0x01D00000, 0x00100000)
    
            // VIDC Interrupt
            //
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {76}
    
            // TLMM GPIO used to reset the DSI panel
            //
            GpioIo(Exclusive, PullUp, 0, 0, , "\\_SB.GIO0", ,) {25}
        })
        Return (RBUF)
    }
    
    //------------------------------------------------------------------------------
    // Resource Auxiliary Info
    // This method is a companion method to the main _CRS resource method.  It
    // includes information for each resource, such as the owning component, a
    // string identifier, etc.
    //------------------------------------------------------------------------------
    //
    Method (RESI, 0x0, NotSerialized)
    {
        Name (RINF, Package()
        {
            3,                               // Table Format Major Version
            0,                               // Table Format Minor Version
            
            // MDP register/memory space
            //
            Package()
            {
                "RESOURCE",
                "MDP_REGS",                  // Resource Name
                "DISPLAY",                   // Owning Component
            },
            
            // MMSS_MISC register/memory space
            //
            Package()
            {
                "RESOURCE",
                "MMSS_MISC_REGS",            // Resource Name
                "DISPLAY",                   // Owning Component
            },
            
            // MDP Interrupt, vsync
            //
            Package()
            {
                "RESOURCE",
                "VSYNC_INTERRUPT",           // Resource Name
                "DISPLAY",                   // Owning Component
            },
            
            // GPU register space
            //
            Package()
            {
                "RESOURCE",
                "GFX_REGS",                  // Resource Name
                "GRAPHICS",                  // Owning Component
            },
            
            // GPU memory mapping for shader
            //
            Package()
            {
                "RESOURCE",
                "GFX_SHADER_MEMORY",         // Resource Name
                "GRAPHICS",                  // Owning Component
            },
            
            // GPU Interrupt
            //
            Package()
            {
                "RESOURCE",
                "GFX_INTERRUPT",             // Resource Name
                "GRAPHICS",                  // Owning Component
            },
            
            // VIDC register address space
            //
            Package()
            {
                "RESOURCE",
                "VIDEO_REGS_LOWER",          // Resource Name
                "VIDEO",                     // Owning Component
            },
            
            // VIDC Interrupt
            //
            Package()
            {
                "RESOURCE",
                "VIDC_INTERRUPT",            // Resource Name
                "VIDEO",                     // Owning Component
            },
            
            // TLMM GPIO used to reset the DSI panel
            //
            Package()
            {
                "RESOURCE",
                "DSI_PANEL_RESET",           // Resource Name
                "DISPLAY",                   // Owning Component
            },
        })
        
        Return (RINF)
    }
    
    //------------------------------------------------------------------------------
    // Graphics Engines and Display Config
    // This method encapsulates all per-platform configuration data for engines and
    // the display.  This method consists of two sub-packages.  The first package
    // encapsulates all configuration information for the supported engines.  The
    // second package encapsulates all display configuration data.
    //------------------------------------------------------------------------------
    //
    Method (ENGS)
    {
        Name (EBUF, Package()
        {
            3,           // Table Format Major Version
            1,           // Table Format Minor Version
            0x001C0009,  // XML Common/Platform Source File Revision (16.16)
            
            //------------------------------------------------------------------------------
            // Graphics Engine List
            // This package enumerates all of the expected engines that should be enumerated
            // on this platform, as well as engine-specific configuration data.  This
            // includes resource assignments, power component assignments, MMU IDs,
            // and even chip family information.
            //------------------------------------------------------------------------------
            //
            Package()
            {
                "ENGINES",
                3,                          // Number of engines
                
                Package()
                {
                    "ENGINE",
                    "GRAPHICS",                   // Engine String Identifier
                    "Adreno3XX",                  // Chip Family Identifier
                    1,                            // Index of Primary Power Component
                    1,                            // P-State Set Index of Footswitch override
                    0,                            // P-State Set Index of Reset
                    Package()
                    {
                        "PNPMMUID",
                        ToUUID("53191EB7-5909-4972-8F7C-7E47B450BE94"),
                    },
                    Package()
                    {
                        "QUERYMMUID",
                        ToUUID("9833C712-3292-4FFB-B0F4-2BD20E1F7F66"),
                    },
                    Package()
                    {
                        "PERF_CONTROLS",
                        Package()
                        {                                       // GRAPHICS_CORE_CLOCK_CONTROL
                            2,                                  // State Set Index
                            Package()
                            {
                                "LimitForPassiveCooling",       // Property Name
                                0x00000001,                     // Value
                            },
                        },
                    },
                    Package()
                    {
                        "THERMAL_DOMAINS",
                        "GPU",
                        "GPU_ALT",
                    },
                    Package()
                    {
                        "PROPERTIES",
                        3,                        // Number of properties
                        Package()
                        {
                            "GmemBaseAddr",       // Property Name
                            0x00000000,           // Value
                        },
                        Package()
                        {
                            "GmemSize",           // Property Name
                            0x00020000,           // Value
                        },
                        Package()
                        {
                            "SMMUCount",          // Property Name
                            0x00000001,           // Value
                        },
                    },
                },
                
                Package()
                {
                    "ENGINE",
                    "ROTATOR",                    // Engine String Identifier
                    "MDP5.x",                     // Chip Family Identifier
                    2,                            // Index of Primary Power Component
                    1,                            // P-State Set Index of Footswitch override
                    0,                            // P-State Set Index of Reset
                    Package()
                    {
                        "PERF_CONTROLS",
                        Package()
                        {                                       // ROTATOR_CORE_CLOCK_CONTROL
                            2,                                  // State Set Index
                        },
                        Package()
                        {                                       // ROTATOR_AXI_BANDWIDTH_CONTROL
                            3,                                  // State Set Index
                        },
                    },
                    Package()
                    {
                        "THERMAL_DOMAINS",
                    },
                },
                
                Package()
                {
                    "ENGINE",
                    "VIDEO",                      // Engine String Identifier
                    "Venus",                      // Chip Family Identifier
                    3,                            // Index of Primary Power Component
                    1,                            // P-State Set Index of Footswitch override
                    0,                            // P-State Set Index of Reset
                    Package()
                    {
                        "PERF_CONTROLS",
                        Package()
                        {                                       // VIDEO_CORE_CLOCK_CONTROL_DEC
                            2,                                  // State Set Index
                        },
                        Package()
                        {                                       // VIDEO_CORE_CLOCK_CONTROL_ENC
                            3,                                  // State Set Index
                        },
                        Package()
                        {                                       // VIDEO_DEC_AXI_PORT0_BW
                            4,                                  // State Set Index
                        },
                        Package()
                        {                                       // VIDEO_ENC_AXI_PORT0_BW
                            5,                                  // State Set Index
                        },
                    },
                    Package()
                    {
                        "THERMAL_DOMAINS",
                    },
                    Package()
                    {
                        "PROPERTIES",
                        1,                        // Number of properties
                        Package()
                        {
                            "DecMaxFps",          // Property Name
                            0x0000001E,           // Value
                        },
                    },
                },
            },
            
            //------------------------------------------------------------------------------
            // Display Info Package
            // This package enumerates all resources assigned to the display.  Additionally,
            // this routine includes any display configuration data, such as hotplug
            // support.
            //------------------------------------------------------------------------------
            //
            Package()
            {
                "DISPLAYS",
                "MDP5.x",                   // Chip Family Identifier
                2,                          // Number of displays
            
                Package()
                {
                    "DISPLAY",
                    "INTERNAL1",            // Display Name
                    
                    0,                      // Index of Display Power Component
                    1,                      // P-State Set Index of Footswitch override
                    0,                      // P-State Set Index of reset
                    
                    Package()
                    {
                        "PERF_CONTROLS",
                        Package()
                        {                                        // INTERNAL1_SCAN_CONTROL
                            2,                                   // State Set Index
                        },
                        Package()
                        {                                        // INTERNAL1_CORE_CLOCK_CONTROL
                            3,                                   // State Set Index
                        },
                        Package()
                        {                                        // INTERNAL1_EBI_BANDWIDTH
                            4,                                   // State Set Index
                        },
                    },
                    Package()
                    {
                        "THERMAL_DOMAINS",
                    },
                },
                Package()
                {
                    "DISPLAY",
                    "WIRELESSDISPLAY1",     // Display Name
                    
                    4,                      // Index of Display Power Component
                    1,                      // P-State Set Index of Footswitch override
                    0,                      // P-State Set Index of reset
                    
                    Package()
                    {
                        "PERF_CONTROLS",
                        Package()
                        {                                        // WIRELESSDISPLAY1_CORE_CLOCK_CONTROL
                            2,                                   // State Set Index
                        },
                        Package()
                        {                                        // WIRELESSDISPLAY1_EBI_BANDWIDTH
                            3,                                   // State Set Index
                        },
                        Package()
                        {                                        // WIRELESSDISPLAY1_CLOCK_CONTROL
                            4,                                   // State Set Index
                        },
                    },
                    Package()
                    {
                        "THERMAL_DOMAINS",
                    },
                },
            
                Package()
                {
                    "RESOURCES",
                    Package()
                    {
                        "PNPMMUID",
                        ToUUID("36079AE4-78E8-452D-AF50-0CFF78B2F1CA"),
                    },
                    Package()
                    {
                        "QUERYMMUID",
                        ToUUID("DE2EAA3D-0FA5-45E9-AC9D-A494C6C04D7C"),
                    },
                    Package()
                    {
                        "PROPERTIES",
                        2,                        // Number of properties
                        Package()
                        {
                            "LimitScalingModes",  // Property Name
                            0x00000002,           // Value
                        },
                        Package()
                        {
                            "DisableHDMI",        // Property Name
                            0x00000001,           // Value
                        },
                    },
                },
            },
        })
        
        Return (EBUF)
    }
    
    //------------------------------------------------------------------------------
    // Graphics Thermal Management Details
    //------------------------------------------------------------------------------
    //
    Method (TMDT)
    {
        Name (RBUF, Package()
        {
            1,        // Table Format Major Version
            0,        // Table Format Minor Version
            
            // Thermal Domain Definitions
            //
            Package()
            {
                "THERMAL_DOMAINS",
                2,    // Num Thermal Domains
                
                //                          Thermal Zone
                //          Domain Name    Interface Name  Endpoints
                //          -------------  --------------  -----------------------
                Package() { "GPU",         "GPU0",         Package() { "GRAPHICS", } },
                Package() { "GPU_ALT",     "GPU0.AVS0",    Package() { "GRAPHICS", } },
            }
        })
        
        Return (RBUF)
    }
    
    //------------------------------------------------------------------------------
    // Graphics PEP Component List
    // This method is a companion method to the graphics entries inside PEP's DCFG
    // method.  It includes the same components, generated from a single XML source,
    // with any additional information required to be passed to dxgkrnl.
    //------------------------------------------------------------------------------
    //
    Method (PMCL)
    {
        Name (RBUF, Package()
        {
            3,    // Table Format Major Version
            1,    // Table Format Minor Version
            8,    // Number of power components
            
            //----------------------------------------------------------------------------------
            //  C0 - Internal Display Power States
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                0,                                                      // Component Index
                Buffer()
                {
                    0x91, 0x59, 0x13, 0x2C, 0x91, 0x43, 0x33, 0x46,     // GUID: {2C135991-4391-4633-90B1-FA96F2E2CC04}
                    0x90, 0xB1, 0xFA, 0x96, 0xF2, 0xE2, 0xCC, 0x04
                },
            
                "PRIMDISPLAY_POWER_STATES",                             // Common Name
                "HW_BLOCK_MDP",                                         // Hw Block associated with this component
            
                Package()
                {
                    "DISPLAY",                                          // Dxgkrnl Component Type
                    "INTERNAL1",
                },
            
                2,                                                      // Number of F-States
                5,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       2  },
                Package() { "FSTATE",  1,   "PWR_OFF",          1,           1,       1  },
                
                //----------------------------------------------------------------------------------
                // C0.PS0 - Internal Display: MDP Reset Control
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    0,                                                   // P-State Set Index
                    "INTERNAL1_RESET",            
                    "*",                                                 // HW Revisions
                    "RESET",                                             // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Do Nothing
                    Package() { "PSTATE",   1,            0,     2 },   // Reset Display Core
                },
                
                //----------------------------------------------------------------------------------
                // C0.PS1 - Internal Display: MDP Footswitch override
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    1,                                                   // P-State Set Index
                    "INTERNAL1_FOOTSWITCH_OVERRIDE",
                    "*",                                                 // HW Revisions
                    "FOOTSWITCH_OVERRIDE",                               // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Footswitch On
                    Package() { "PSTATE",   1,            0,     2 },   // Footswitch Off
                },
                
                //----------------------------------------------------------------------------------
                // C0.PS2 - Internal Display: Power states for MDP scan-out HW
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    2,                                                   // P-State Set Index
                    "INTERNAL1_SCAN_CONTROL",     
                    "*",                                                 // HW Revisions
                    "DISPLAY_SOURCE_SCAN_CTRL",                           // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Vote for MDP scan-out resources
                    Package() { "PSTATE",   1,            0,     2 },   // Remove votes for MDP scan-out resources
                },
                
                //----------------------------------------------------------------------------------
                // C0.PS3 - Internal Display: MDP Core Clock Frequency
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    3,                                                   // P-State Set Index
                    "INTERNAL1_CORE_CLOCK_CONTROL",
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    13,                                                  // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    320000000,     0 },
                    Package() { "PSTATE",   1,    266666667,     1 },
                    Package() { "PSTATE",   2,    240000000,     1 },
                    Package() { "PSTATE",   3,    228571429,     1 },
                    Package() { "PSTATE",   4,    200000000,     1 },
                    Package() { "PSTATE",   5,    160000000,     1 },
                    Package() { "PSTATE",   6,    133333333,     2 },
                    Package() { "PSTATE",   7,    100000000,     2 },
                    Package() { "PSTATE",   8,     85714286,     2 },
                    Package() { "PSTATE",   9,     75000000,     2 },
                    Package() { "PSTATE",  10,     60000000,     2 },
                    Package() { "PSTATE",  11,     37500000,     2 },
                    Package() { "PSTATE",  12,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C0.PS4 - Internal Display: Display Bandwidth to EBI
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    4,                                                   // P-State Set Index
                    "INTERNAL1_EBI_BANDWIDTH",    
                    "*",                                                 // HW Revisions
                    "BANDWIDTH",                                         // Resource Type
                    33,                                                  // Num P-States in Set
                    4,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,   1556676532,     1 },
                    Package() { "PSTATE",   1,   1415160484,     2 },
                    Package() { "PSTATE",   2,   1286509530,     2 },
                    Package() { "PSTATE",   3,   1169554119,     2 },
                    Package() { "PSTATE",   4,   1063231017,     2 },
                    Package() { "PSTATE",   5,    966573652,     2 },
                    Package() { "PSTATE",   6,    878703320,     2 },
                    Package() { "PSTATE",   7,    798821200,     2 },
                    Package() { "PSTATE",   8,    726201091,     2 },
                    Package() { "PSTATE",   9,    660182810,     2 },
                    Package() { "PSTATE",  10,    600166191,     2 },
                    Package() { "PSTATE",  11,    545605628,     2 },
                    Package() { "PSTATE",  12,    496005116,     2 },
                    Package() { "PSTATE",  13,    450913742,     2 },
                    Package() { "PSTATE",  14,    409921584,     2 },
                    Package() { "PSTATE",  15,    372655985,     2 },
                    Package() { "PSTATE",  16,    338778168,     2 },
                    Package() { "PSTATE",  17,    307980153,     2 },
                    Package() { "PSTATE",  18,    279981957,     2 },
                    Package() { "PSTATE",  19,    254529052,     2 },
                    Package() { "PSTATE",  20,    231390047,     2 },
                    Package() { "PSTATE",  21,    210354589,     2 },
                    Package() { "PSTATE",  22,    191231444,     2 },
                    Package() { "PSTATE",  23,    173846767,     2 },
                    Package() { "PSTATE",  24,    158042516,     2 },
                    Package() { "PSTATE",  25,    143675014,     2 },
                    Package() { "PSTATE",  26,    130613649,     2 },
                    Package() { "PSTATE",  27,    118739681,     2 },
                    Package() { "PSTATE",  28,    107945165,     2 },
                    Package() { "PSTATE",  29,     98131968,     2 },
                    Package() { "PSTATE",  30,     89210880,     2 },
                    Package() { "PSTATE",  31,     81100800,     2 },
                    Package() { "PSTATE",  32,            0,     2 },
                },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C1 - 3D Graphics Engine Power States
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                1,                                                      // Component Index
                Buffer()
                {
                    0xB5, 0xF1, 0xBD, 0x30, 0xF7, 0x28, 0x0C, 0x4C,     // GUID: {30BDF1B5-28F7-4C0C-AC47-273DD1401E11}
                    0xAC, 0x47, 0x27, 0x3D, 0xD1, 0x40, 0x1E, 0x11
                },
            
                "GRAPHICS_POWER_STATES",                                // Common Name
                "HW_BLOCK_GRAPHICS",                                    // Hw Block associated with this component
            
                Package()
                {
                    "ENGINE",                                           // Dxgkrnl Component Type
                    "GRAPHICS",
                },
            
                3,                                                      // Number of F-States
                3,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       3  },
                Package() { "FSTATE",  1,   "CLK_OFF",      10000,           0,       2  },
                Package() { "FSTATE",  2,   "PWR_OFF",     100000,           0,       1  },
                
                //----------------------------------------------------------------------------------
                // C1.PS0 - 3D Graphics Core P-State Set: Reset
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    0,                                                   // P-State Set Index
                    "GRAPHICS_RESET",             
                    "*",                                                 // HW Revisions
                    "RESET",                                             // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Do Nothing
                    Package() { "PSTATE",   1,            0,     2 },   // Reset Graphics Core
                },
                
                //----------------------------------------------------------------------------------
                // C1.PS1 - 3D Graphics Core P-State Set: Footswitch override
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    1,                                                   // P-State Set Index
                    "GRAPHICS_FOOTSWITCH_OVERRIDE",
                    "*",                                                 // HW Revisions
                    "FOOTSWITCH_OVERRIDE",                               // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Footswitch On
                    Package() { "PSTATE",   1,            0,     2 },   // Footswitch Off
                },
                
                //----------------------------------------------------------------------------------
                // C1.PS2 - 3D Graphics Core P-State Set: Core Clock Frequency
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    2,                                                   // P-State Set Index
                    "GRAPHICS_CORE_CLOCK_CONTROL",
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    4,                                                   // Num P-States in Set
                    2,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    400000000,     0 },
                    Package() { "PSTATE",   1,    310000000,     1 },
                    Package() { "PSTATE",   2,    200000000,     2 },
                    Package() { "PSTATE",   3,            0,     2 },
                },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C2 - Rotator Engine Power States
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                2,                                                      // Component Index
                Buffer()
                {
                    0xF5, 0xFB, 0x5F, 0x4D, 0x91, 0xD7, 0xCD, 0x41,     // GUID: {4D5FFBF5-D791-41CD-89CB-0154129BA607}
                    0x89, 0xCB, 0x01, 0x54, 0x12, 0x9B, 0xA6, 0x07
                },
            
                "ROTATOR_POWER_STATES",                                 // Common Name
                "HW_BLOCK_MDP",                                         // Hw Block associated with this component
            
                Package()
                {
                    "ENGINE",                                           // Dxgkrnl Component Type
                    "ROTATOR",
                },
            
                3,                                                      // Number of F-States
                4,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       3  },
                Package() { "FSTATE",  1,   "CLK_OFF",      10000,           0,       2  },
                Package() { "FSTATE",  2,   "PWR_OFF",     100000,           0,       1  },
                
                //----------------------------------------------------------------------------------
                // C2.PS0 - Rotator Core P-State Set: Reset
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    0,                                                   // P-State Set Index
                    "ROTATOR_RESET",              
                    "*",                                                 // HW Revisions
                    "RESET",                                             // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Do Nothing
                    Package() { "PSTATE",   1,            0,     2 },   // Reset MDP Core
                },
                
                //----------------------------------------------------------------------------------
                // C2.PS1 - Rotator Core P-State Set: Footswitch override
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    1,                                                   // P-State Set Index
                    "ROTATOR_FOOTSWITCH_OVERRIDE",
                    "*",                                                 // HW Revisions
                    "FOOTSWITCH_OVERRIDE",                               // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Footswitch On
                    Package() { "PSTATE",   1,            0,     2 },   // Footswitch Off
                },
                
                //----------------------------------------------------------------------------------
                // C2.PS2 - Rotator Core P-State Set: Rotator Core Clock Frequency
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    2,                                                   // P-State Set Index
                    "ROTATOR_CORE_CLOCK_CONTROL", 
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    13,                                                  // Num P-States in Set
                    6,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    320000000,     0 },
                    Package() { "PSTATE",   1,    266666667,     1 },
                    Package() { "PSTATE",   2,    240000000,     1 },
                    Package() { "PSTATE",   3,    228571429,     1 },
                    Package() { "PSTATE",   4,    200000000,     1 },
                    Package() { "PSTATE",   5,    160000000,     1 },
                    Package() { "PSTATE",   6,    133333333,     2 },
                    Package() { "PSTATE",   7,    100000000,     2 },
                    Package() { "PSTATE",   8,     85714286,     2 },
                    Package() { "PSTATE",   9,     75000000,     2 },
                    Package() { "PSTATE",  10,     60000000,     2 },
                    Package() { "PSTATE",  11,     37500000,     2 },
                    Package() { "PSTATE",  12,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C2.PS3 - Rotator Core P-State Set: Rotator Bandwidth to EBI
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    3,                                                   // P-State Set Index
                    "ROTATOR_AXI_BANDWIDTH_CONTROL",
                    "*",                                                 // HW Revisions
                    "BANDWIDTH",                                         // Resource Type
                    15,                                                  // Num P-States in Set
                    0xFFFFFFFF,                                          // Initial P-State (i.e. none)
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,   2560000000,     0 },
                    Package() { "PSTATE",   1,   2133333336,     1 },
                    Package() { "PSTATE",   2,   1920000000,     1 },
                    Package() { "PSTATE",   3,   1828571432,     1 },
                    Package() { "PSTATE",   4,   1600000000,     1 },
                    Package() { "PSTATE",   5,   1280000000,     1 },
                    Package() { "PSTATE",   6,   1064000000,     2 },
                    Package() { "PSTATE",   7,    800000000,     2 },
                    Package() { "PSTATE",   8,    685680000,     2 },
                    Package() { "PSTATE",   9,    600000000,     2 },
                    Package() { "PSTATE",  10,    480000000,     2 },
                    Package() { "PSTATE",  11,    300000000,     2 },
                    Package() { "PSTATE",  12,    200000000,     2 },
                    Package() { "PSTATE",  13,    100000000,     2 },
                    Package() { "PSTATE",  14,            0,     2 },
                },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C3 - Video Engine Power States
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                3,                                                      // Component Index
                Buffer()
                {
                    0x1A, 0xBB, 0xE1, 0xD0, 0x3D, 0x70, 0xE8, 0x4B,     // GUID: {D0E1BB1A-703D-4BE8-B450-64A4FBFCA6A8}
                    0xB4, 0x50, 0x64, 0xA4, 0xFB, 0xFC, 0xA6, 0xA8
                },
            
                "VIDEO_POWER_STATES",                                   // Common Name
                "HW_BLOCK_VIDEO",                                       // Hw Block associated with this component
            
                Package()
                {
                    "ENGINE",                                           // Dxgkrnl Component Type
                    "VIDEO",
                },
            
                3,                                                      // Number of F-States
                6,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       3  },
                Package() { "FSTATE",  1,   "CLK_OFF",      10000,           0,       2  },
                Package() { "FSTATE",  2,   "PWR_OFF",     100000,           0,       1  },
                
                //----------------------------------------------------------------------------------
                // C3.PS0 - Video Core P-State Set: Reset
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    0,                                                   // P-State Set Index
                    "VIDEO_RESET",                
                    "*",                                                 // HW Revisions
                    "RESET",                                             // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Do Nothing
                    Package() { "PSTATE",   1,            0,     2 },   // Reset Video Core
                },
                
                //----------------------------------------------------------------------------------
                // C3.PS1 - Video Core P-State Set: Footswitch override
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    1,                                                   // P-State Set Index
                    "VIDEO_FOOTSWITCH_OVERRIDE",  
                    "*",                                                 // HW Revisions
                    "FOOTSWITCH_OVERRIDE",                               // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Footswitch On
                    Package() { "PSTATE",   1,            0,     2 },   // Footswitch Off
                },
                
                //----------------------------------------------------------------------------------
                // C3.PS2 - Video Core Performance: Core Clock Frequency for Decoder
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    2,                                                   // P-State Set Index
                    "VIDEO_CORE_CLOCK_CONTROL_DEC",
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    4,                                                   // Num P-States in Set
                    2,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    228000000,     0 },
                    Package() { "PSTATE",   1,    160000000,     1 },
                    Package() { "PSTATE",   2,    100000000,     2 },
                    Package() { "PSTATE",   3,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C3.PS3 - Video Core Performance: Core Clock Frequency for Encoder
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    3,                                                   // P-State Set Index
                    "VIDEO_CORE_CLOCK_CONTROL_ENC",
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    4,                                                   // Num P-States in Set
                    3,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    228000000,     0 },
                    Package() { "PSTATE",   1,    160000000,     1 },
                    Package() { "PSTATE",   2,    100000000,     2 },
                    Package() { "PSTATE",   3,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C3.PS4 - Video Decoder Performance: Port0 Bandwidth to EBI
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    4,                                                   // P-State Set Index
                    "VIDEO_DEC_AXI_PORT0_BW",     
                    "*",                                                 // HW Revisions
                    "BANDWIDTH",                                         // Resource Type
                    5,                                                   // Num P-States in Set
                    3,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,   1725600000,     0 },
                    Package() { "PSTATE",   1,   1084160000,     0 },
                    Package() { "PSTATE",   2,    298900000,     1 },
                    Package() { "PSTATE",   3,     99600000,     2 },
                    Package() { "PSTATE",   4,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C3.PS5 - Video Encoder Performance: Port0 Bandwidth to EBI
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    5,                                                   // P-State Set Index
                    "VIDEO_ENC_AXI_PORT0_BW",     
                    "*",                                                 // HW Revisions
                    "BANDWIDTH",                                         // Resource Type
                    5,                                                   // Num P-States in Set
                    0xFFFFFFFF,                                          // Initial P-State (i.e. none)
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,   1725600000,     0 },
                    Package() { "PSTATE",   1,   1453760000,     0 },
                    Package() { "PSTATE",   2,    400900000,     1 },
                    Package() { "PSTATE",   3,    133600000,     2 },
                    Package() { "PSTATE",   4,            0,     2 },
                },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C4 - Miracast Power States
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                4,                                                      // Component Index
                Buffer()
                {
                    0x5C, 0x10, 0xA9, 0xD9, 0x19, 0x8F, 0xA3, 0x41,     // GUID: {D9A9105C-8F19-41A3-8B02-3CA73E80FCD3}
                    0x8B, 0x02, 0x3C, 0xA7, 0x3E, 0x80, 0xFC, 0xD3
                },
            
                "MIRACAST_POWER_STATES",                                // Common Name
                "HW_BLOCK_MDP",                                         // Hw Block associated with this component
            
                Package()
                {
                    "DISPLAY",                                          // Dxgkrnl Component Type
                    "WIRELESSDISPLAY1",
                },
            
                2,                                                      // Number of F-States
                5,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       2  },
                Package() { "FSTATE",  1,   "PWR_OFF",          1,           1,       1  },
                
                //----------------------------------------------------------------------------------
                // C4.PS0 - Miracast: MDP Reset Control
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    0,                                                   // P-State Set Index
                    "WIRELESSDISPLAY1_RESET",     
                    "*",                                                 // HW Revisions
                    "RESET",                                             // Resource Type
                    2,                                                   // Num P-States in Set
                    0,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Do Nothing
                    Package() { "PSTATE",   1,            0,     2 },   // Reset MDP Core
                },
                
                //----------------------------------------------------------------------------------
                // C4.PS1 - Miracast: MDP Footswitch override
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    1,                                                   // P-State Set Index
                    "WIRELESSDISPLAY1_FOOTSWITCH_OVERRIDE",
                    "*",                                                 // HW Revisions
                    "FOOTSWITCH_OVERRIDE",                               // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Footswitch Override On
                    Package() { "PSTATE",   1,            0,     2 },   // Footswitch Override Off
                },
                
                //----------------------------------------------------------------------------------
                // C4.PS2 - Miracast: MDP Core Clock Frequency
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    2,                                                   // P-State Set Index
                    "WIRELESSDISPLAY1_CORE_CLOCK_CONTROL",
                    "*",                                                 // HW Revisions
                    "CORE_CLOCK",                                        // Resource Type
                    13,                                                  // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,    320000000,     0 },
                    Package() { "PSTATE",   1,    266666667,     1 },
                    Package() { "PSTATE",   2,    240000000,     1 },
                    Package() { "PSTATE",   3,    228571429,     1 },
                    Package() { "PSTATE",   4,    200000000,     1 },
                    Package() { "PSTATE",   5,    160000000,     1 },
                    Package() { "PSTATE",   6,    133333333,     2 },
                    Package() { "PSTATE",   7,    100000000,     2 },
                    Package() { "PSTATE",   8,     85714286,     2 },
                    Package() { "PSTATE",   9,     75000000,     2 },
                    Package() { "PSTATE",  10,     60000000,     2 },
                    Package() { "PSTATE",  11,     37500000,     2 },
                    Package() { "PSTATE",  12,            0,     2 },
                },
                
                //----------------------------------------------------------------------------------
                // C4.PS3 - Miracast: Display Bandwidth to EBI
                //----------------------------------------------------------------------------------
                //
                Package()
                {
                    "PSTATE_SET",
                    3,                                                   // P-State Set Index
                    "WIRELESSDISPLAY1_EBI_BANDWIDTH",
                    "*",                                                 // HW Revisions
                    "BANDWIDTH",                                         // Resource Type
                    33,                                                  // Num P-States in Set
                    21,                                                  // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,   1556676532,     1 },
                    Package() { "PSTATE",   1,   1415160484,     2 },
                    Package() { "PSTATE",   2,   1286509530,     2 },
                    Package() { "PSTATE",   3,   1169554119,     2 },
                    Package() { "PSTATE",   4,   1063231017,     2 },
                    Package() { "PSTATE",   5,    966573652,     2 },
                    Package() { "PSTATE",   6,    878703320,     2 },
                    Package() { "PSTATE",   7,    798821200,     2 },
                    Package() { "PSTATE",   8,    726201091,     2 },
                    Package() { "PSTATE",   9,    660182810,     2 },
                    Package() { "PSTATE",  10,    600166191,     2 },
                    Package() { "PSTATE",  11,    545605628,     2 },
                    Package() { "PSTATE",  12,    496005116,     2 },
                    Package() { "PSTATE",  13,    450913742,     2 },
                    Package() { "PSTATE",  14,    409921584,     2 },
                    Package() { "PSTATE",  15,    372655985,     2 },
                    Package() { "PSTATE",  16,    338778168,     2 },
                    Package() { "PSTATE",  17,    307980153,     2 },
                    Package() { "PSTATE",  18,    279981957,     2 },
                    Package() { "PSTATE",  19,    254529052,     2 },
                    Package() { "PSTATE",  20,    231390047,     2 },
                    Package() { "PSTATE",  21,    212889600,     2 },
                    Package() { "PSTATE",  22,    191231444,     2 },
                    Package() { "PSTATE",  23,    173846767,     2 },
                    Package() { "PSTATE",  24,    158042516,     2 },
                    Package() { "PSTATE",  25,    143675014,     2 },
                    Package() { "PSTATE",  26,    130613649,     2 },
                    Package() { "PSTATE",  27,    118739681,     2 },
                    Package() { "PSTATE",  28,    107945165,     2 },
                    Package() { "PSTATE",  29,     98131968,     2 },
                    Package() { "PSTATE",  30,     89210880,     2 },
                    Package() { "PSTATE",  31,     81100800,     2 },
                    Package() { "PSTATE",  32,            0,     2 },
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
                    4,                                                   // P-State Set Index
                    "WIRELESSDISPLAY1_CLOCK_CONTROL",
                    "*",                                                 // HW Revisions
                    "DISPLAY_SOURCE_SCAN_CTRL",                           // Resource Type
                    2,                                                   // Num P-States in Set
                    1,                                                   // Initial P-State
                
                    //                                        Voltage
                    //                     ID       Value      Level
                    //                     ---    ----------   -----
                    Package() { "PSTATE",   0,            1,     2 },   // Vote for all Miracast clocks
                    Package() { "PSTATE",   1,            0,     2 },   // Remove votes for all Miracast clocks
                },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C5 - Dummy Component for WP Workaround
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                5,                                                      // Component Index
                Buffer()
                {
                    0xDF, 0x0B, 0xD4, 0x8D, 0xBD, 0x6F, 0xED, 0x45,     // GUID: {8DD40BDF-6FBD-45ED-8538-711D434B6BA1}
                    0x85, 0x38, 0x71, 0x1D, 0x43, 0x4B, 0x6B, 0xA1
                },
            
                "ALWAYS_ACTIVE_WP",                                     // Common Name
                "HW_BLOCK_NONE",                                        // Hw Block associated with this component
            
                Package()
                {
                    "UNMANAGED",                                        // Dxgkrnl Component Type
                },
            
                1,                                                      // Number of F-States
                0,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       1  },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C6 - VidPn Source 0
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                6,                                                      // Component Index
                Buffer()
                {
                    0x7D, 0x41, 0xA9, 0x64, 0x41, 0x18, 0xAD, 0x45,     // GUID: {64A9417D-1841-45AD-A705-3A246E607FFC}
                    0xA7, 0x05, 0x3A, 0x24, 0x6E, 0x60, 0x7F, 0xFC
                },
            
                "VIDPN_SOURCE_0",                                       // Common Name
                "HW_BLOCK_NONE",                                        // Hw Block associated with this component
            
                Package()
                {
                    "DISPLAY_SOURCE",                                   // Dxgkrnl Component Type
                    0,                                                  // VidPN Source ID
                },
            
                2,                                                      // Number of F-States
                0,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       1  },
                Package() { "FSTATE",  1,   "PWR_OFF",          1,           1,       0  },
                
            },
            
            //----------------------------------------------------------------------------------
            //  C7 - VidPn Source 1
            //----------------------------------------------------------------------------------
            //
            Package()
            {
                "COMPONENT",
                7,                                                      // Component Index
                Buffer()
                {
                    0xF7, 0x71, 0xF4, 0x00, 0xEC, 0xAE, 0x62, 0x44,     // GUID: {00F471F7-AEEC-4462-91FF-5AAB1B652F03}
                    0x91, 0xFF, 0x5A, 0xAB, 0x1B, 0x65, 0x2F, 0x03
                },
            
                "VIDPN_SOURCE_1",                                       // Common Name
                "HW_BLOCK_NONE",                                        // Hw Block associated with this component
            
                Package()
                {
                    "DISPLAY_SOURCE",                                   // Dxgkrnl Component Type
                    1,                                                  // VidPN Source ID
                },
            
                2,                                                      // Number of F-States
                0,                                                      // Number of P-State Sets
            
                //                          Logical     Transition   Residency   Nominal
                //                    ID   Power State   Latency    Requirement   Power
                //                    ---  -----------  ----------  -----------  -------
                Package() { "FSTATE",  0,    "ALL_ON",          0,           0,       1  },
                Package() { "FSTATE",  1,   "PWR_OFF",          1,           1,       0  },
                
            },
        })
        
        Return (RBUF)
    }
    
    // Include Display ACPI extensions, which include panel configuration (_ROM) method
    //
    Include("display.asl")
    
    NAME(_DOD, Package()
    {
        0x00024321,
    })
    
    // Enumeration and device info for the AVStream child driver
    //
    Device (AVS0)
    {
        // The address for this device (Same as in _DOD, above)
        //
        Name(_ADR, 0x00024321)
    
        Method (_CRS, 0x0, NotSerialized)
        {
            Name (RBUF, ResourceTemplate ()
            {
            })
            Return (RBUF)
        }
    
        Name (_DEP, Package()
        {
            \_SB_.ATCU,
            \_SB_.VFE0
        })
    
    }
    
    //------------------------------------------------------------------------------
    // Child Device Info
    // This method includes information for child devices
    //------------------------------------------------------------------------------
    //
    Method (CHDV)
    {
        Name (CHIF, Package()
        {
            1,                                           // Number of Child devices
            Package()
            {
                "CHILDDEV",
                0,                                       // Child ID
                0x24321,                                 // ACPI UID
                "QCOM_AVStream_8974",                    // Hardware ID
                0,                                       // Instance ID
                "Qualcomm Camera AVStream Mini Driver",  // Device Text
    
                Package()
                {
                    "COMPATIBLEIDS",
                    2,                                   // Number of Compatible IDs
                    "VEN_QCOM&DEV__AVSTREAM",            // Compatible ID 1
                    "QCOM_AVSTREAM",                     // Compatible ID 2
                },
            },
        })
        Return (CHIF)
    }
    
    Method (REGR)
    {
        Name (RBUF, Package()
        {
            Package()
            {
                "ForceMaxPerf",          
                0,
            },
            Package()
            {
                "ForceActive",           
                0,
            },
            Package()
            {
                "PreventPowerCollapse",  
                0,
            },
            Package()
            {
                "DisableThermalMitigation",
                0,
            },
            Package()
            {
                "LeafPTPacking",         
                2,
            },
            Package()
            {
                "GRAPHICS",         
                Package()
                {
                    "DCVS",             
                    Package()
                    {
                        "Enable",                      // 0 = FALSE, 1 = TRUE
                        1,
                    },
                    Package()
                    {
                        "IncreaseFilterBw",            // Hz / 65536
                        131072,
                    },
                    Package()
                    {
                        "DecreaseFilterBw",            // Hz / 65536
                        13107,
                    },
                    Package()
                    {
                        "TargetBusyPct",               // Percentage
                        85,
                    },
                    Package()
                    {
                        "SampleRate",                  // Hz
                        60,
                    },
                    Package()
                    {
                        "TargetBusyPctOffscreen",      // Percentage
                        75,
                    },
                    Package()
                    {
                        "SampleRateOffscreen",         // Hz
                        20,
                    },
                    Package()
                    {
                        "GpuResetValue",               // Hz
                        300000000,
                    },
                },
            },
            Package()
            {
                "DISPLAY",          
                Package()
                {
                    "Wireless",         
                    Package()
                    {
                        "DisablePowerManagement",      // 0 = resources dynamically voted, 1 = resources retained
                        0,
                    },
                    Package()
                    {
                        "MaximumRequiredAb",           // AB required for 1280x720@30Hz
                        212889600,
                    },
                    Package()
                    {
                        "EnableSoftVsync",             // 0 = Hardware Vsync, 1 = Software Vsync
                        1,
                    },
                },
            },
        })
        
        Return (RBUF)
    }
}
