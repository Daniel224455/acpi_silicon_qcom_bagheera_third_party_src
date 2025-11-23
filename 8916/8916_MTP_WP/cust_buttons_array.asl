//
// Copyright (c) 2015 Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the iodevices ACPI device definitions for buttons
//
//
// ===================================================================
// EDIT HISTORY
//
// when        who     what, where, why
// --------    ---     --------------------------------------------
// 04/20/15    vb      Initial Revision for 8x16, 
//                     refactored from iodevices.asl
// ===================================================================
//


//
// Windows-compatible Button Array
//
Device (BTNS)
{
     Name(_HID, "ACPI0011")

     Name(_UID, 0)

     Method (_CRS, 0x0, NotSerialized)
     {
         Name (RBUF, ResourceTemplate ()
         {
              //Power button
              //KPDPWR_ON
              GpioInt(Edge, ActiveBoth, Exclusive, PullDown, 0, "\\_SB.PM01", ,) {0x40}

              //Volume Up button
              //GPIO 107
              GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullUp, 6200, "\\_SB.GIO0", ,) {107}

              //Volume Down button
              //RESIN_ON
              GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullDown, 0, "\\_SB.PM01", ,) {0x41}

              //Camera Focus
              //GPIO 108
              GpioInt(Edge, ActiveBoth, Exclusive, PullUp, 6200, "\\_SB.GIO0", ,) {108}

              //Camera Snapshot
              //GPIO 109
              GpioInt(Edge, ActiveBoth, ExclusiveAndWake, PullUp, 6200, "\\_SB.GIO0", ,) {109}

         })
         Return (RBUF)
     }

     Name(_DSD, Package(2) {
        ToUUID("FA6BD625-9CE8-470D-A2C7-B3CA36C4282E"),
        Package() {
            Package(5) {0,1,0,0x01,0x0D}, // Portable Device Control Application Collection
            Package(5) {1,0,1,0x01,0x81}, // Sleep
            Package(5) {1,1,1,0x0C,0xE9}, // Volume Increment
            Package(5) {1,2,1,0x0C,0xEA}, // Volume Decrement
            Package(5) {1,3,1,0x90,0x20}, // Camera Auto Focus
            Package(5) {1,4,1,0x90,0x21}, // Camera Shutter
        },
     })
}
