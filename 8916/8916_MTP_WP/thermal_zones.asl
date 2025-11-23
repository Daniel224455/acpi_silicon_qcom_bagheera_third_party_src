//
// Copyright (c) 2014 Qualcomm Technologies, Inc.  All Rights Reserved.
// Qualcomm Technologies Proprietary and Confidential.
//

        //CPU Aggregator Device -- Required for Thermal Parking
        Device(AGR0)
        {
            Name(_HID, "ACPI000C")
            Name(_PUR, Package() {1, 0})
            Method(_OST, 0x3, NotSerialized)
            {
                Store(Arg2, \_SB_.PEP0.ROST)
            }
        }

        // TSENS devices depend on PEP (included in dsdt_common).  Please be CAREFUL on location

        //---------------------------------------------------------------------
        //
        //        Thermal Zones for QC reference hardware     
        //
        //TZ0 - TZ39 are thermal zones developed by QC for reference hardware
        //and can be modified by the OEMs.
        //---------------------------------------------------------------------

        //Thermal zone for CPU TSENS to dial back CPUs at 85C
        ThermalZone (TZ0) {
            Name (_HID, "QCOM24AD")
            Name (_UID, 0)
            Name(_TZD, Package (){\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3})
            Method(_PSV) { Return (3580) }
            Name(_TC1, 1)
            Name(_TC2, 2)
            Name(_TSP, 10)
            Name(_TZP, 0)
        } // end of TZ0

        //Parking Thermal Zone for CPU TSENS at 80C
        ThermalZone (TZ1) {
            Name (_HID, "QCOM24AD")
            Name (_UID, 1)
            Name(_TZD, Package (){\_SB.PEP0})
            Method(_PSV) { Return (3530) }
            Name(_TC1, 4)
            Name(_TC2, 3)
            Name(_TSP, 50)
            Name(_TZP, 0)
            // _DSM - Device Specific Method
            // Arg0: UUID Unique function identifier
            // Arg1: Integer Revision Level
            // Arg2: Integer Function Index (0 = Return Supported Functions)
            // Arg3: Package Parameters
            Method(_DSM, 0x4, NotSerialized) {
                Switch (ToBuffer(Arg0)) {
                    Case (ToUUID("14d399cd-7a27-4b18-8fb4-7cb7b9f4e500")) {
                        Switch (ToInteger(Arg2)) {
                            Case(0) {
                                // _DSM functions 0 and 1 (bits 0 and 1) are supported
                                Return (Buffer() {0x3})
                            }
                            Case (1) {
                                Return (34)  // minimum throttle limit
                            }
                        }
                    }
                }
            }
        } // end of TZ1
    
        //Thermal zone for PMIC_THERM to throttle CPUs at 80C
        ThermalZone (TZ2) {
            Name (_HID, "QCOM248C")
            Name (_UID, 0)
            Name(_TZD, Package (){\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3})
            Method(_PSV) { Return (3530) }
            Name(_TC1, 1)
            Name(_TC2, 2)
            Name(_TSP, 50)
            Name(_TZP, 0)
        } // end of TZ2

        //Thermal zone for PMIC_THERM to shutdown the device at 105C
        ThermalZone (TZ3) {
            Name (_HID, "QCOM248C")
            Name (_UID, 1)
            Name(_TZD, Package (){\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3, \_SB.PEP0})
            Method(_PSV) { Return (3630) }
            Method(_CRT) { Return (3780) }
            Name(_TC1, 4)
            Name(_TC2, 3)
            Name(_TSP, 50)
            Name(_TZP, 0)
        } // end of TZ3

        //Thermal zone to throttle just the WLAN at 85C.
        ThermalZone (TZ5) {
            Name (_HID, "QCOM2472")
            Name (_UID, 0)
            Name(_TZD, Package (){ \_SB.COEX })
            Method(_PSV) { Return (3580) } //85C
            Name(_TC1, 1)
            Name(_TC2, 1)
            Name(_TSP, 10)
            Name(_TZP, 0)
        } // end of TZ5

    //---------------------------------------------------------------------
    //
    //        QC Recommended thermal limits starts
    //
    //TZ80 - TZ98 represent the thermal zones corresponding to QC 
    //recommended thermal limits. These thermal zones must not be removed
    //or tampered with.
    //---------------------------------------------------------------------
        //Thermal zone for TSENS2 at 70C to match the LA thermal limits
        ThermalZone (TZ80) {
            Name (_HID, "QCOM2472")
            Name (_UID, 1)
            Name(_TZD, Package (){
            \_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3})
            Method(_PSV) { Return (3430) }
            Name(_TC1, 1)
            Name(_TC2, 2)                                   
            Name(_TSP, 10)                                  
            Name(_TZP, 0) 
        } // end of TZ80

        //Thermal zone near for TSENS2 to shutdown the system at 85C to match LA
        //thermal limits
        ThermalZone (TZ81) {
            Name (_HID, "QCOM2472")
            Name (_UID, 2)
            Name(_TZD, Package (){
            \_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3, \_SB.PEP0})
            Method(_PSV) { Return (3530) }
            Method(_CRT) { Return (3580) }
            Name(_TC1, 1)
            Name(_TC2, 2)
            Name(_TSP, 10)
            Name(_TZP, 0)
        } // end of TZ81

        // Entry for BCL thermal zone - disabled/commented by default
        // ThermalZone (TZ98) {
            // Name (_HID, "QCOM2486")
            // Name (_UID, 0)
            // Name(_TZD, Package (){
            // \_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3,
            // \_SB.PEP0,\_SB.AMSS, \_SB.GPU0.MON0, \_SB.GPU0, \_SB.PMBM})
            // Method(_PSV) { Return (3530) }
            // Method(_CRT) { Return (3730) }
            // Name(_TC1, 1)
            // Name(_TC2, 2)
            // Name(_TSP, 30)
            // Name(_TZP, 0)
        // } // end of TZ98
        
        //---------------------------------------------------------------------
        //        Critical Thermal Zones for ALL TSENS
        //This sensor aggregates all the 5 on chip TSENS into a single sensor
        //for ACPI thermal manager. By having a critical thermal zone on this
        //"virtual sensor" we don't have to add a critical thermal zone on every
        //sensor and hence reduce the number of thermal zones.
        //---------------------------------------------------------------------
        //Critical Thermal zone on MSM virtual sensor to throttle entire system
        //at 100C Shutdown at 105C.
        ThermalZone (TZ99) {
            Name (_HID, "QCOM24AE")
            Name (_UID, 0)
            Name(_TZD, Package (){
            \_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3, \_SB.PEP0,
            \_SB.AMSS, \_SB.GPU0.MON0, \_SB.GPU0, \_SB.PMBM, \_SB.COEX})
            Method(_PSV) { Return (3730) }
            Method(_CRT) { Return (3780) }
            Name(_TC1, 4)
            Name(_TC2, 3)
            Name(_TSP, 10)
            Name(_TZP, 0)
        } // end of TZ99
    //---------------------------------------------------------------------
    //        QC Recommended thermal limits ends
    //---------------------------------------------------------------------     

    //---------------------------------------------------------------------
    //
    //        Sample Thermal Zones  for OEMs TZ40 - TZ79
    //
    //Sample TSENS thermal zone that can be added on any TSENS
    //---------------------------------------------------------------------
        //ThermalZone (TZ40) {
            //Name (_HID, "QCOM2470")
            //Name (_UID, 0)
            //Name(_TZD, Package (){
            //\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3,
            //\_SB.PEP0, <Your cooling device>})
            //Method(_PSV) { Return (3730) }
            //Method(_CRT) { Return (3780) }
            //Name(_TC1, 1)
            //Name(_TC2, 2)
            //Name(_TSP, 10) //Sampling rate of 1sec
            //Name(_TZP, 0)
        //} // end of TZ10

        //ThermalZone (TZ41) {
            //Name (_HID, "QCOM2470")
            //Name (_UID, 0)
            //Name(_TZD, Package (){
            //\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3,
            //\_SB.PEP0, <Your cooling device>})
            //Method(_PSV) { Return (3730) }
            //Method(_CRT) { Return (3780) }
            //Name(_TC1, 1)
            //Name(_TC2, 2)
            //Name(_TSP, 50) //Sampling rate of 5sec
            //Name(_TZP, 0)
        //} // end of TZ11

        //--------------------------------------------------------------------------//
        //        Sample VADC Thermal zones for OEMs
        //Following are sample thermal zones that use the off chip ADC thermistors
        //they are all currently using CPUs as a cooling device for a lack of better
        //option. The OEMs should change this
        //--------------------------------------------------------------------------//

        //Thermal zone for BATT_THERM
        // ThermalZone (TZ51) {
            // Name (_HID, "QCOM248D")
            // Name (_UID, 0)
            // Name(_TZD, Package (){\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3})
            // Method(_PSV) { Return (3830) }
            // Name(_TC1, 4)
            // Name(_TC2, 3)
            // Name(_TSP, 50)
            // Name(_TZP, 0)
        // } // end of TZ11

        //Thermal zone for PA_THERM
        //Battery needs to be connected for this zone to work properly
        // ThermalZone (TZ52) {
            // Name (_HID, "QCOM248E")
            // Name (_UID, 0)
            // Name(_TZD, Package (){\_SB.CPU0, \_SB.CPU1, \_SB.CPU2, \_SB.CPU3})
            // Method(_PSV) { Return (3430) }
            // Name(_TC1, 4)
            // Name(_TC2, 3)
            // Name(_TSP, 50)
            // Name(_TZP, 0)
        // } // end of TZ12
