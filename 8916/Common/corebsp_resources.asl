//===========================================================================
//                           <corebsp_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by core BSP drivers.
//
//
//   Copyright (c) 2010-2015 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================


Scope(\_SB_.PEP0)
{
    Method(BPMD)
    {
        Return(BPCC)
    }

    Name(BPCC,
    Package ()
    {
        /////////////////////////////////////////////////////////////////////////////////////
        
        // USB Role Switch block
        Package()
        {
            "DEVICE",
            "\\_SB.URS0",
            Package()
            {
                "COMPONENT",
                Zero,
                Package()
                {
                    "FSTATE", 0
                },
                Package()
                {
                    "PSTATE_SET", 0, // Set 0 used by URS to manage VBUS

                    Package()
                    {
                        "PSTATE", 0, // P0 - Disable Vbus
                    /*** Enable only on targets supporting PMIC VBUS
                        Package()
                        { "PMICUSBOTG", Package() { "IOCTL_PM_3P_PUBLIC_USB_OTG_ENABLE", 0 } },
                    ***/
                    },
                    Package()
                    {
                        "PSTATE", 1, // P1 - Enable Vbus
                    /*** Enable only on targets supporting PMIC VBUS
                        Package()
                        { "PMICUSBOTG", Package() { "IOCTL_PM_3P_PUBLIC_USB_OTG_ENABLE", 1 } },
                    ***/
                    },
                },
                Package()
                {
                    "PSTATE_SET", 1, // Set 1 not managed by driver - container for preload state

                    Package()
                    {
                        "PSTATE", 0, // Unmanaged, always on resources

                        Package()
                        { "CLOCK", Package() { "gcc_usb2a_phy_sleep_clk", 1, 0, 1 } },
                        // 1 = Enable, 0,1 = FREQ is set via RPM owned NPA Node "/clk/pcnoc" as per PEP recommendations

                        package() 
                        { "CLOCK", package() { "gcc_usb2a_phy_sleep_clk", 9, 8 } },
                        // Mark USB 2.0 Phy Sleep Clock Suppressible 

                        package() 
                        { "CLOCK", package() { "gcc_usb2a_phy_sleep_clk", 9, 12 } }, 
                        // Mark USB 2.0 Phy Sleep Clock Always On
                    },
                    package() 
                    { 
                        "PRELOAD_PSTATE", 0,
                    },
                },
            },

            Package()
            {
                "DSTATE", 0
            },
            Package()
            {
                "DSTATE", 1
            },
            Package()
            {
                "DSTATE", 2
            },
            Package()
            {
                "DSTATE", 3
            }
        },
        
        // USBFn block
        Package()
        {
          "DEVICE",
          "\\_SB.URS0.UFN0",
          Package()
          {
            "COMPONENT", 0,   // Component 0.

            Package()
            {
              "FSTATE", 0 
            },
            
            // P States:
            // P0_USB_ATTACHED_SDP
            // P1_USB_ATTACHED_CDP
            // P2_USB_ATTACHED_DCP 
            // P3_USB_ATTACHED_IDCP
            // P4_USB_SUSPENDED
            // P5_USB_DETACHED
              
            Package()
            { 
              "PSTATE", 0,  // P0_USB_ATTACHED_SDP

              Package()
              { "CLOCK", Package() { "gcc_usb_hs_system_clk", 8, 60, 9 } },
              // 8 = Set & Enable, 60,9 -> Atleast 60 Mhz 
              
              Package()
              { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 1, 0, 1 } },
              // 1 = Enable, 0,1 = FREQ is set via RPM owned NPA Node "/clk/pcnoc" as per PEP recommendations
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 100000 } },
              // 100000 = Clock Frequency is in kHz.
              
              Package()
              { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 1572864000, 62914560 }},
              // 3 = Request type, Type: 3 for Instantaneous & Arbitrated BW, 
              // 1572864000 = Instantaneous BW BytesPerSec = 25 x 62914560; 62914560 = Arbitrated BW BytesPerSec = (480 x 1024 x 1024)/8
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 4 } },
              // 1 = Required; 4 = Default as per PEP recommendation 
              
              Package()
              { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 3075000, 16000, 1, 0, 1, 0, 0, 0 } },
              // 1 = LDO, 3075000 = Vtg in uV, 16000 = Current in uA, 1,0,1 = SW Enable = Enable, Pin Enable = None, SW Power Mode = NPM
              
              // Instead of LDO 7A (1.8V), vote for hfpll1
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 2 } } 
              // 1 = Required, 2 = Corner vote for 1800000 uV/19000uA
            }, // P0

            Package()
            {
              "PSTATE", 1,  // P1_USB_ATTACHED_CDP
              
              //P1 voting is done in P0 state
            }, // P1

            Package()
            { 
              "PSTATE", 2,  // P2_USB_ATTACHED_DCP

              Package()
              { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
              // 0 = To devote  
              
              Package()
              { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 }},
              // 0,0 = No BW request
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 0 } },
              // 0 = To devote
              
              Package()
              { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 0, 0, 0, 0, 1, 0, 0, 0 } },
              // 1 = LDO, 0, 0 = O Volts & Amp, 0 = SW Enable = NotEnable, rest of the fields will not be applicable
              
              // Instead of LDO 7A (1.8V), vote for hfpll1
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 0 } } 
              // 0 = To devote 1.8V rail
            }, // P2

            Package()
            { 
              "PSTATE", 3,  // P3_USB_ATTACHED_IDCP

              Package()
              { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
              // 0 = To devote
              
              Package()
              { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 }},
              // 0,0 = No BW request
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 0 } },
              // 0 = To devote
              
              Package()
              { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 0, 0, 0, 0, 1, 0, 0, 0 } },
              // 1 = LDO, 0, 0 = O Volts & Amp, 0 = SW Enable = NotEnable, rest of the fields will not be applicable
              
              // Instead of LDO 7A (1.8V), devote for hfpll1
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 0 } } 
              // 0 = To devote 1.8V rail
            },  // P3

            Package()
            { 
              "PSTATE", 4,  // P4_USB_SUSPENDED

              Package()
              { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will not be applicable
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
              // 0 = To devote
              
              Package()
              { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 }},
              // 0,0 = No BW request
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 0 } },
              // 0 = To devote
              
              Package()
              { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 3075000, 1000, 1, 0, 1, 0, 0, 0 } },
              // 1 = LDO, 3075000 = Vtg in uV, 16000 = Current in uA, 1,0,1 = SW Enable = Enable, Pin Enable = None, SW Power Mode = NPM
              
              // Instead of LDO 7A (1.8V), vote for hfpll1
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 2 } } 
              // 1 = Required, 2 = Corner vote for 1800000 uV/19000uA
            },  // P4

            Package()
            { 
              "PSTATE", 5,  // P5_USB_DETACHED

              Package()
              { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will be N.A.
              
              Package()
              { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
              // 2 = Disable, rest of the fields will be N.A.
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
              // 0 = To devote
              
              Package()
              { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 }},
              // 0,0 = No BW request
              
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 0 } },
              // 0 = To devote
              
              Package()
              { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 0, 0, 0, 0, 1, 0, 0, 0 } },
              // 1 = LDO, 0, 0 = O Volts & Amp, 0 = SW Enable = NotEnable, rest of the fields will not be applicable
              
              // Instead of LDO 7A (1.8V), devote for hfpll1
              Package()
              { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 0 } } 
              // 0 = To devote
            },  // P5

            // Define Abandon State for USBFn (peripheral) stack ie. Power State invoked when stack unloads/tears down
            package() 
            { 
                "ABANDON_PSTATE", 5,  // Abandon P state defined as P5
            },
            package() 
            { 
                "PREPARE_PSTATE", 0,  // Initialization P state defined as P0
            },
          }, // Comp0

          // D states
          Package()           // D0 state
          { "DSTATE", 0 },
          
          Package()           // D1 state
          { "DSTATE", 1 },
          
          Package()           // D2 state
          { "DSTATE", 2 },
          
          Package()           // D3 state
          { "DSTATE", 3 },
        },
        
        // EHCI block
        Package()
        {
          "DEVICE",
          "\\_SB.URS0.USB0",
          Package()
          {
              "COMPONENT",
              0x0, // Component 0.
              Package()
              {
                  "FSTATE",  0x0, // f0 state
              },
          },

          //D states
          Package() {
            "DSTATE", 0x0, // D0 state (Full power)

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_system_clk", 8, 60, 9 } },
            // 8 = Set & Enable, 60,9 -> Atleast 60 Mhz

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 1, 0, 1 } },
            // 1 = Enable, 0,1 = FREQ is set via RPM owned NPA Node "/clk/pcnoc" as per PEP recommendations

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 100000 } },
            // 100000 = Clock Frequency is in kHz.

            Package()
            { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 1572864000, 62914560 } },
            // 3 = Request type, Type: 3 for Instantaneous & Arbitrated BW,
            // 1572864000 = Instantaneous BW BytesPerSec = 25 x 62914560; 62914560 = Arbitrated BW BytesPerSec = (480 x 1024 x 1024)/8

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 4 } },
            // 1 = Required; 4 = Default as per PEP recommendation

            Package()
            { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 3075000, 16000, 1, 0, 1, 0, 0, 0 } },
            // 1 = LDO, 3075000 = Vtg in uV, 16000 = Current in uA, 1,0,1 = SW Enable = Enable, Pin Enable = None, SW Power Mode = NPM

            // Instead of LDO 7A (1.8V), vote for hfpll1
            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 2 } }
            // 1 = Required, 2 = Corner vote for 1800000 uV/19000uA
          },
          Package() {
            "DSTATE", 0x1, // D1 state
          },
          Package() {
            "DSTATE", 0x2, // D2 State (Abandon state)

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
            // 2 = Disable, rest of the fields will be N.A.

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
            // 2 = Disable, rest of the fields will be N.A.

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
            // 0 = To devote

            Package()
            { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 } },
            // 0,0 = No BW request

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 0 } },
            // 0 = To devote

            Package()
            { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 0, 0, 0, 0, 1, 0, 0, 0 } },
            // 1 = LDO, 0, 0 = O Volts & Amp, 0 = SW Enable = NotEnable, rest of the fields will not be applicable

            // Instead of LDO 7A (1.8V), vote for hfpll1
            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 0 } }
            // 0 = To devote
          },
          Package() {
            "DSTATE", 0x3, // D3 state (Slave device disconnect, host cable is still connected)

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_system_clk", 2, 0, 1 } },
            // 2 = Disable, rest of the fields will be N.A.

            Package()
            { "CLOCK", Package() { "gcc_usb_hs_ahb_clk", 2, 0, 1 } },
            // 2 = Disable, rest of the fields will be N.A.

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/clk/pcnoc", 0 } },
            // 0 = To devote

            Package()
            { "BUSARB", Package() { 3, "ICBID_MASTER_USB_HS", "ICBID_SLAVE_EBI1", 0, 0 } },
            // 0,0 = No BW request

            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/rail_cx", 1 } },
            // 1 = Retention

            Package()
            { "PMICVREGVOTE", Package() { "PPP_RESOURCE_ID_LDO13_A", 1, 3075000, 100, 1, 0, 0, 0, 0, 0 } },
            // 1 = LDO, 3075000 = Vtg in uV, 100 = Current in uA, 1,0,0 = SW Enable = Enable, Pin Enable = None, SW Power Mode = LPM

            // Instead of LDO 7A (1.8V), vote for hfpll1
            Package()
            { "REQUIRED_RESOURCE", Package() { 1, "/pmic/client/hfpll1", 1 } }
            // 1 = Retention
          },

          // Define Abandon State for USB0 (host) stack ie. Power State invoked when stack unloads/tears down
          package()
          {
            "ABANDON_DSTATE",
            2                                                   // Abandon D state defined as D2
          },
        },
        /////////////////////////////////////////////////////////////////////////////////////
        
        // // Storage
         Package()
         {
            "DEVICE",
            "\\_SB.SDC1",
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
                     "FSTATE",
                     0x1, // f0 state
                 },   
            },
            Package()
            {
                "DSTATE",
                0x0, // D0 state
                
                Package()    
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {                                    
                        "PPP_RESOURCE_ID_LDO8_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        2850000,                          // Voltage is in micro volts on 8960
                        400000,                           // Peak current in microamps
                        1,    // force enable from software
                        0,    // disable pin control enable
                        1,    // power mode - Normal Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,    // head room voltage
                    },
                },
                Package()
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {      
                        "PPP_RESOURCE_ID_LDO5_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        1800000,                          // Voltage is in micro volts on 8960
                        60000,                           // Peak current in microamps
                        1,    // force enable from software
                        0,    // disable pin control enable
                        1,    // power mode - Normal Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,     // head room voltage
                    },
                },
    
                package() {"TLMMPORT", package() { 0x10A000, 0x7FFF, 0x1FE4 }},
                //Vote for max bus freq:         Req Type        Master                Slave          IB=5x192MBps   AB=200MBps                                
                package() {"BUSARB", Package() { 3,     "ICBID_MASTER_SDCC_1",   "ICBID_SLAVE_EBI1",   400000000,   200000000}},
                package() {"CLOCK", package() {"gcc_sdcc1_ahb_clk", 1, 100000000, 4}},    
                package() {"CLOCK", package() {"gcc_sdcc1_apps_clk", 8, 200000000, 2}}, 
            },
            Package() {
                "DSTATE",
                0x3, // D3 state
                package() {"CLOCK", package() {"gcc_sdcc1_ahb_clk", 2, 0, 2}},    
                package() {"CLOCK", package() {"gcc_sdcc1_apps_clk", 2, 0, 2}}, 
                package() {"BUSARB", Package() { 3,     "ICBID_MASTER_SDCC_1",   "ICBID_SLAVE_EBI1",   0,   0 }},
                package() {"TLMMPORT", package() { 0x10A000, 0x7FFF, 0xA00 }},
            },
        },
        
        Package()
        {
            "DEVICE",
            "\\_SB.SDC2",
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
                    "FSTATE",
                    0x1, // f0 state
                },

                //
                // Contract with SDBUS for card frequencies
                //
                // P-State      Note 
                // --------     -----  
                // 0 - 19       Reserved (Legacy)
                // 20           Reset to 3.3v signal voltage (max fixed at 2.95v)
                // 21           1.8v signal voltage (max fixed at 1.85v)
                Package(){"PSTATE",       0, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       1, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       2, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       3, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       4, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       5, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       6, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       7, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       8, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",       9, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      10, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      11, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      12, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      13, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      14, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      15, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      16, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      17, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      18, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      19, Package(){"DELAY", package() { 1 }}},
                Package(){"PSTATE",      20, 
                    Package()    
                    {
                        "PMICVREGVOTE",    // PMICVREGVOTE resource
                        Package()
                        {                                    
                            "PPP_RESOURCE_ID_LDO11_A",     // VREG ID
                            1,                             // Voltage Regulator type = LDO
                            0,                       // Voltage is in micro volts on 8974
                            0,                       // Peak current in microamps
                            0,    // force disable from software
                            0,    // disable pin control enable
                            0,    // power mode - Low Power Mode
                            0,    // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },
                    Package()    
                    {
                        "PMICVREGVOTE",    // PMICVREGVOTE resource
                        Package()
                        {                                    
                            "PPP_RESOURCE_ID_LDO12_A",     // VREG ID
                            1,                             // Voltage Regulator type = LDO
                            0,                             // Voltage is in micro volts on 8974
                            0,                             // Peak current in microamps
                            0,    // force disable from software
                            0,    // disable pin control enable
                            0,    // power mode - Low Power Mode
                            0,    // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },
                    Package() {"DELAY", package() { 35 }}, 
                    Package()    
                    {
                        "PMICVREGVOTE",    // PMICVREGVOTE resource
                        Package()
                        {                                    
                            "PPP_RESOURCE_ID_LDO11_A",     // VREG ID
                            1,                             // Voltage Regulator type = LDO
                            2950000,                       // Voltage is in micro volts on 8974
                            400000,                        // Peak current in microamps
                            1,    // force enable from software
                            0,    // disable pin control enable
                            1,    // power mode - Normal Power Mode
                            0,    // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },
                    Package()    
                    {
                        "PMICVREGVOTE",    // PMICVREGVOTE resource
                        Package()
                        {                                    
                            "PPP_RESOURCE_ID_LDO12_A",     // VREG ID
                            1,                             // Voltage Regulator type = LDO
                            2950000,                       // Voltage is in micro volts on 8974
                            50000,                         // Peak current in microamps
                            1,    // force enable from software
                            0,    // disable pin control enable
                            1,    // power mode - Normal Power Mode
                            0,     // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },                    
                    Package() {"DELAY", package() { 35 }}, 
                },
                Package(){"PSTATE",      21, 
                    Package()    
                    {
                        "PMICVREGVOTE",    // PMICVREGVOTE resource
                        Package()
                        {                                    
                            "PPP_RESOURCE_ID_LDO12_A",  // VREG ID
                            1,                          // Voltage Regulator type = LDO
                            1850000,                    // Voltage is in micro volts on 8974
                            50000,                      // Peak current in microamps
                            1,    // force enable from software
                            0,    // disable pin control enable
                            1,    // power mode - Normal Power Mode
                            0,    // power mode pin control - disable
                            0,    // bypass mode allowed
                            0,    // head room voltage
                        },
                    },
                    Package() {"DELAY", package() { 35 }}, 
                },
                Package(){"PSTATE",      22, 
                Package()    
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {                                    
                        "PPP_RESOURCE_ID_LDO11_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        2950000,                          // Voltage is in micro volts on 8960
                        400000,                           // Peak current in microamps
                        1,    // force enable from software
                        0,    // disable pin control enable
                        1,    // power mode - Normal Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,    // head room voltage
                    },
                },
                Package()    
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {                                    
                        "PPP_RESOURCE_ID_LDO12_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        2950000,                          // Voltage is in micro volts on 8960
                        50000,                           // Peak current in microamps
                        1,    // force enable from software
                        0,    // disable pin control enable
                        1,    // power mode - Normal Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,    // head room voltage
                    },
                },
                    Package() {"DELAY", package() { 35 }}, 
            },
                Package(){"PSTATE",      23, 
                Package()    
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {                                    
                        "PPP_RESOURCE_ID_LDO11_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        0,                       // Voltage is in micro volts on 8974
                        0,                           // Peak current in microamps
                        0,    // force disable from software
                        0,    // disable pin control enable
                        0,    // power mode - Low Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,    // head room voltage
                    },
                },
                Package()    
                {
                    "PMICVREGVOTE",    // PMICVREGVOTE resource
                    Package()
                    {                                    
                        "PPP_RESOURCE_ID_LDO12_A",     // VREG ID
                        1,                               // Voltage Regulator type = LDO
                        0,                             // Voltage is in micro volts on 8974
                        0,                           // Peak current in microamps
                        0,    // force disable from software
                        0,    // disable pin control enable
                        0,    // power mode - Low Power Mode
                        0,     // power mode pin control - disable
                        0,    // bypass mode allowed
                        0,    // head room voltage
                    },
                },
                    Package() {"DELAY", package() { 35 }}, 
                },
            },

            Package()
            {
                "DSTATE",
                0x0, // D0 state

                Package(){"PSTATE_ADJUST", Package () { 0, 22 }},    
    
                package() {"TLMMPORT", package() { 0x109000, 0x7FFF, 0x1FE4 }},
                //Vote for max bus freq:         Req Type        Master                Slave          IB=5x192MBps   AB=200MBps                
                package() {"BUSARB", Package() { 3,     "ICBID_MASTER_SDCC_2",   "ICBID_SLAVE_EBI1",   400000000,   200000000}},
                package() {"CLOCK", package() {"gcc_sdcc2_ahb_clk", 1, 100000000, 4}},    
                package() {"CLOCK", package() {"gcc_sdcc2_apps_clk", 8, 200000000, 2}}, 
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
                package() {"CLOCK", package() {"gcc_sdcc2_ahb_clk", 2, 0, 2}},    
                package() {"CLOCK", package() {"gcc_sdcc2_apps_clk", 2, 0, 2}},
                package() {"BUSARB", Package() { 3,     "ICBID_MASTER_SDCC_2",   "ICBID_SLAVE_EBI1",   0,   0 }},
                package() {"TLMMPORT", package() { 0x109000, 0x7FFF, 0xA00 }},
                Package(){"PSTATE_ADJUST", Package () { 0, 23 }},
                
            },
        },
              
        Package()
        {
            "DEVICE",
            "\\_SB.ADSP.SLM1",
            Package()
            {
                "COMPONENT",
                0x0, // Component 0
                Package()
                {
                    "FSTATE",
                    0x0, // f0 state
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
                0x1, // D1 state
            },
            Package()
            {
                "DSTATE",
                0x2, // D2 state
            },
            Package()
            {
                "DSTATE",
                0x3, // D3 state
            },
        },
        /////////////////////////////////////////////////////////////////////////////////////
    })    
    
                    

}
