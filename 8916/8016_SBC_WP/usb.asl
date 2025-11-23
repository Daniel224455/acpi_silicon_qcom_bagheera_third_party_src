//
// Copyright (c) 2015, Qualcomm Technologies Inc. All rights reserved.
//

//
// USB Role Switch
//
Device(URS0)
{
    Name(_HID, "HID_HRS1") // QCOM24B7
    Name(_DEP, Package(0x1)
    {
        \_SB_.PEP0
    })
    Name(_CCA, Zero) // Cache-incoherent bus-master, Hardware does not manage cache coherency
    Name(_S0W, 3)
    Name (REG, 0)    // Declare register object

    Name(_CRS, ResourceTemplate() {
        // Controller register address space
        Memory32Fixed (ReadWrite, 0x078D9000, 0x00000300)
        // VBUS GPIO IRQ (cable attach/detach)
        GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullDown, 0, "\\_SB.GIO0") {0x79} // 121
    })

    // Controller register memory
    OperationRegion (UCDR, SystemMemory, 0x078D9000, 0x00001000 )
    Field (UCDR, WordAcc, NoLock, Preserve)
    {
        Offset(0x44),   // skip to register 44h
        SCRA, 32,       // scratch
        Offset(0x90),   // skip to register 90h
        AHBB, 32,       // Ahb_burst
        Offset(0x98),   // skip to register 98h
        AHBM, 32,       // Ahb_mode
        Offset(0x9C),   // skip to register 9Ch
        GENC, 32,       // Gen_config
        Offset(0xA0),   // skip to register A0h
        GETC, 32,       // Gen_config
        Offset(0x140),  // skip to register 140h
        UCMD, 32,      // USB command reg
        Offset(0x170),  // skip to register 170h
        ULPI, 32,       // ULPI port access
        Offset(0x184),  // skip to register 184h
        PTSC, 32,       // port status control
        Offset(0x1A8),  // skip to register 1A8h
        MODE, 32,        // usb mode
        Offset(0x278),
        CTRL, 32
    }

    // TLMM GPIO register memory
    OperationRegion (TCDR, SystemMemory, 0x01000000, 0x00300000)
    Field (TCDR, DWordAcc, NoLock, Preserve)
    {
        // GPIO #121
        Offset(0x00079000),   // skip to register h00
        GCFG, 32,             // GPIO configuraiton
        Offset(0x00079004),   // skip to register h04
        GSTS, 32,             // GPIO status
        Offset(0x00079008),   // skip to register h08
        ICFG, 32,             // GPIO Interrupt configuration
        Offset(0x0007900C),   // skip to register h0C
        ISTS, 32,             // GPIO Interrupt status
    }

    // Device Specific Method takes 4 args:
    //  Arg0 : Buffer containing a UUID [16 bytes]
    //  Arg1 : Integer containing the Revision ID
    //  Arg2 : Integer containing the Function Index
    //  Arg3 : Package that contains function-specific arguments
    Method (_DSM, 0x4, NotSerialized)
    {
        Name (RET, 0);  // Name (RET, Buffer(1){0}); // Declare return object

        // UUID selector
        switch(ToBuffer(Arg0)) {
            // URS interface identifier
            case(ToUUID("14EB0A6A-79ED-4B37-A8C7-84604B55C5C3")) {
                // Function selector
                switch(Arg2) {
                    // Function 0: Return supported functions, based on revision
                    case(0) {
                        switch(Arg1) {
                            // Revision0: function {1,2} supported
                            case(0) { Return(0x03); Break; }
                            default { Return(Zero); Break; }
                        }
                        // default
                        Return (0x00); Break;
                    }

                    // Function 1: Initialize VBUS interrupt, return VBUS low
                    case(1) {
                                                         // no configuration required on this target
                        Store(GSTS, REG);                // read GPIO status
                        And(REG, 0x01, REG);             // mask value (bit0); 0=grounded, 1=asserted
                        Store(LEqual(REG,0), RET);       // set boolean return value
                        Return(RET); Break;
                    }

                    // Function 2: Handle VBUS interrupt, return VBUS low
                    case(2) {
                                                         // no handling required on this target
                        Store(GSTS, REG);                // read GPIO status
                        And(REG, 0x01, REG);             // mask value (bit0); 0=grounded, 1=asserted
                        Store(LEqual(REG,0), RET);       // set boolean return value
                        Return(RET); Break;
                    }

                    default { Return(Zero); Break; }
                } // Function
                Break;
            }
            default { Return(Zero); Break; }
        } // UUID
    } // _DSM

    // Dynamically enumerated device (host mode stack) on logical USB bus
    Device(USB0)
    {
        Name(_ADR, 0)
        Name(_S0W, 3)
        Name(_CRS, ResourceTemplate() {
            // Interrupt usb1_hs_irq
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0xA6}
            // Interrupt usb1_hs_async_wakeup_irq
            Interrupt(ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, ) {0xAC}
            // PMIC GPIO#3 - USB Hub reset
            GpioIo(Exclusive, PullUp, 0, 0, , "\\_SB.PM01", , , , RawDataBuffer() { 0x1, 0xFF, 0xFF, 0xFF}) {0x610}
            // PMIC GPIO#4 - USB MUX software select
            GpioIo(Exclusive, PullUp, 0, 0, , "\\_SB.PM01", , , , RawDataBuffer() { 0x1, 0xFF, 0xFF, 0xFF}) {0x618}
         })

        //
        // _UBF method invoked from EHCI driver
        //
        Method (_UBF, 0x0, NotSerialized) {
            Store(0x13, MODE);               // set host mode & disable streaming  [HPG 5.3.7]
            Store(PTSC, REG);                // read PORTSC status
            Store(OR(REG,0x2),PTSC);         // clear current PORTSC status
            Store(0x08, AHBM);               // use AHB xtor ctrl structs non-posted, data xfer posted  [HPG 5.3.2.2]
            Store(0x00, AHBB);               // needs to be 0 if 0x98 is 0  [HPG 5.3.2.1]
            Store(0x0C90, GENC);             // enable PE_RX_BUF_PENDING_EN, DSC_PE_RST_EN.  [HPG 5.3.2.3]
        }
    } // USB0

    // Dynamically enumerated device (peripheral mode stack) on logical USB bus
    Device(UFN0)
    {
        Name(_ADR, 1)
        Name(_S0W, 3)
        Name(_CRS, ResourceTemplate() {
            // Interrupt usb1_hs_irq
            Interrupt(ResourceConsumer, Level, ActiveHigh, Exclusive, , , ) {0xA6}
            // Interrupt usb1_hs_async_wakeup_irq
            Interrupt(ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, ) {0xAC}
            // Attach Interrupt
            GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullUp, 0, "\\_SB.PM01",,,,RawDataBuffer(){0x21, 0x1, 0x2, 0x19}) {0x1002}
            // Detach Interrupt
            GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullUp, 0, "\\_SB.PM01",,,,RawDataBuffer(){0x20, 0x1, 0x2, 0x19}) {0x1001}
            // PMIC GPIO#3 - USB Hub reset
            GpioIo(Exclusive, PullUp, 0, 0, , "\\_SB.PM01", , , , RawDataBuffer() { 0x1, 0xFF, 0xFF, 0xFF}) {0x610}
            // PMIC GPIO#4 - USB MUX software select
            GpioIo(Exclusive, PullUp, 0, 0, , "\\_SB.PM01", , , , RawDataBuffer() { 0x1, 0xFF, 0xFF, 0xFF}) {0x618}
        })

        //
        // _UBF method invoked from USBFn driver
        //
        Method (_UBF, 0x0, NotSerialized) {
            Store(0x02, MODE);               // set device mode & disable streaming [HPG 5.3.7]
            Store(PTSC, REG);                // read PORTSC status
            Store(OR(REG,0x2),PTSC);         // clear current PORTSC status
            Store(0x08, AHBM);               // use AHB xtor ctrl structs non-posted, data xfer posted [HPG 5.3.2.2]
            Store(0x00, AHBB);               // needs to be 0 if 0x98 is 0 [HPG 5.3.2.1]
            Store(0x0CB0, GENC);             // Enable PE_RX_BUF_PENDING_EN, DSC_PE_RST_EN. [HPG 5.3.2.3]
            Store(0x000D3C32, CTRL);         // Enable external vbus configuration in the LINK.
            Store(0x60960003, ULPI);         // Enable VBUSVLDEXTSEL and VBUSVLDEXT_SET [HPG 5.3.3, 5.3.9]
            Store(GETC, REG);                // read GENC2 status
            Store(OR(REG,0x80), GETC);       // Enable SESS_VLD [HPG 5.3.3]
            Store(UCMD, REG);                // read USBCMD register
            Store(OR(REG,0x2000000), UCMD);  // Set SESS_VLD bit 19 [HPG 5.3.3]
            Store(0x39, SCRA);               // TBD
        }

        // Device Specific Method takes 4 args:
        //  Arg0 : Buffer containing a UUID [16 bytes]
        //  Arg1 : Integer containing the Revision ID
        //  Arg2 : Integer containing the Function Index
        //  Arg3 : Package that contains function-specific arguments
        Method (_DSM, 0x4, NotSerialized)
        {
            // UUID selector
            switch(ToBuffer(Arg0)) {
                // UFX interface identifier
                case(ToUUID("FE56CFEB-49D5-4378-A8A2-2978DBE54AD2")) {
                    // Function selector
                    switch(Arg2) {
                        // Function 0: Return supported functions, based on revision
                        case(0) {
                            // Version selector
                            switch(Arg1) {
                                // Revision0: functions {0,1} supported
                                case(0) { Return(Buffer(){0x03}); Break; }
                                default { Return(Buffer(){0x01}); Break; }
                            }
                            // default
                            Return (Buffer(){0x00}); Break;
                        }

                        // Function 1: Return number of supported USB PHYSICAL endpoints
                        // ChipIdea core configured to support 8 IN/8 OUT EPs, including EP0
                        case(1) { Return(16); Break; }

                        default { Return (Buffer(){0x00}); Break; }
                    } // Function
                } // {FE56CFEB-49D5-4378-A8A2-2978DBE54AD2}

                // QCOM specific interface identifier
                case(ToUUID("18DE299F-9476-4FC9-B43B-8AEB713ED751")) {
                    // Function selector
                    switch(Arg2) {
                        // Function 0: Return supported functions, based on revision
                        case(0) {
                            // Version selector
                            switch(Arg1) {
                                // Revision0: functions {0,1} supported
                                case(0) { Return(Buffer(){0x03}); Break; }
                                default { Return(Buffer(){0x01}); Break; }
                            }
                            // default 
                            Return (Buffer(){0x00}); Break;
                        }

                        // Function 1: Return device capabilities bitmap
                        //   Bit  Description
                        //   ---  -------------------------------
                        //     0  Superspeed Gen1 supported
                        //     1  PMIC VBUS detection supported
                        //     2  USB PHY interrupt supported
                        //     3  Type-C supported
                        case(1) { Return(0x02); Break; }

                        default { Return (Buffer(){0x00}); Break; }
                    } // Function
                } // {18DE299F-9476-4FC9-B43B-8AEB713ED751}

                default { Return (Buffer(){0x00}); Break; }
            } // UUID
        } // _DSM

        //
        // The recommended PHY register values. The following values of PHY
        // will be configured if OEMs do not overwrite the values.
        //
        Method(PHYC, 0x0, NotSerialized) {
           Name (CFG0, Package()
           {
                //         PHY_IFC, PHY REG ADDR, Value
                //         -------------------------------
                Package() {0x0,         0x80,         0x74}, //ULPI, USB_OTG_HS_PARAM_OVER_REG_A_ADDR, USB_OTG_HS_PARAM_OVER_REG_A_RST_VAL
                                                             //QCTDD01859310 - PARAM_OVER_REG_A.COMPDISTUNE b'111'
        //        Package() {0x0,         0x81,         0x38}, //ULPI, USB_OTG_HS_PARAM_OVER_REG_B_ADDR, 0x38 (SQRXTUNE is set to 0x3)
        //        Package() {0x0,         0x82,         0x24}, //ULPI, USB_OTG_HS_PARAM_OVER_REG_C_ADDR, USB_OTG_HS_PARAM_OVER_REG_C_RST_VAL
        //        Package() {0x0,         0x83,         0x13}, //ULPI, USB_OTG_HS_PARAM_OVER_REG_D_ADDR, USB_OTG_HS_PARAM_OVER_REG_D_RST_VAL
           })
           Return (CFG0)
        }
    } // UFN0
} // URS0

