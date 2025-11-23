        //
        // SMMU Driver
        //

        Device (MMU0)
        {
            // This is the SMMU the MDP/Display.

            Name (_HID, "HID_MMU0")
            Name (_UID, 0)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFD928000, 0xB000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {105}   // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {79}    // osmmu_CIrpt[1] - index 1 interrupt will be mapped to NS CB0 by TZ
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {78}    // osmmu_CIrpt[0] - index 0 interrupt will be mapped to S CB1+ by TZ
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {80}    // osmmu_CIrpt[2] - this interrupt is not expected to ever fire
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("DE2EAA3D-0FA5-45E9-AC9D-A494C6C04D7C"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure -- to be changed to secure when TZ comes in
                    0x00                //Context index 2: unsecure -- to be changed to secure when TZ comes in
                })
            }

            // This OFFI method returns a buffer that describes the layout of
            // the SMMU register space. Each entry corresponds to page number
            // from the base address (from _CRS) for the register group
            // specified in the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-MDP.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }

        Device (MMU1)
        {
            // This is the SMMU for the VFE/Camera

            Name (_HID, "HID_MMU0")
            Name (_UID, 1)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDA44000, 0xB000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {94}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {96}    // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {97}    // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {98}    // osmmu_CIrpt[2]

                })
            }

            Method (GUID)
            {
                Return ( ToUUID ("C00DE5A5-E6E0-4DD7-B8C3-2B71AB6FCA15"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure
                    0x00                //Context index 2: unsecure
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-VFE-CPP.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank VFE0
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank VFE1
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }

        Device (MMU2)
        {
            // This is the SMMU for JPEG.

            Name (_HID, "HID_MMU0")
            Name (_UID, 2)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDA64000, 0xB000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {99}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {101}    // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {102}    // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {103}    // osmmu_CIrpt[2]

                })
            }

            Method (GUID)
            {
                Return (ToUUID ("84A989BD-145D-4985-83BD-1A80829B5030"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x04,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure
                    0x00,               //Context index 2: unsecure
                    0x00                //Context index 2: unsecure
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-JPEG.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x02,   // Stream mapping table entry
                        0x0002, // Stream ID
                        0x0000, // Stream Mask
                        0x02    // Context bank
                    },
                    
                    Package ()
                    {
                        0x03,   // Stream mapping table entry
                        0x0003, // Stream ID
                        0x0000, // Stream Mask
                        0x03    // Context bank
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }           
        }

        Device (MMU3)
        {
            // This is the SMMU for Oxili

            Name (_HID, "HID_MMU0")
            Name (_UID, 3)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDB10000, 0xB000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {70}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {272}   // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {273}   // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {274}   // osmmu_CIrpt[2]
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("9833C712-3292-4FFB-B0F4-2BD20E1F7F66"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure -- to be changed to secure when TZ comes in.
                    0x00                //Context index 2: unsecure -- to be changed to secure when TZ comes in.
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-Gfx.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank (Not specified in the document, need to confirm).
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }

        Device (MMU4)
        {
            // This is the SMMU for Venus/Video.

            Name (_HID, "HID_MMU0")
            Name (_UID, 4)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDC84000, 0xD000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {77}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {74}    // osmmu_CIrpt[1] - index 1 interrupt will be mapped to NS CB0 by TZ
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {75}    // osmmu_CIrpt[0] - index 0 interrupt will be mapped to S CB1+ by TZ
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {73}    // osmmu_CIrpt[2] - this interrupt will never fire since unused
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("C461B828-B8AD-4113-939A-8934272F9102"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            
            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x05,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure tbd: secure
                    0x00,               //Context index 2: unsecure tbd: secure
                    0x00,               //Context index 3: unsecure tbd: secure
                    0x00                //Context index 4: unsecure tbd: secure
                })
            }

            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.
            
            Method (S2CB)
            {
                // Data from MMU-Config-Venus.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0021, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x02,   // Stream mapping table entry
                        0x0022, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x03,   // Stream mapping table entry
                        0x0023, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x04,   // Stream mapping table entry
                        0x0024, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x05,   // Stream mapping table entry
                        0x0048, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },
                    
                    Package ()
                    {
                        0x06,   // Stream mapping table entry
                        0x0049, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x07,   // Stream mapping table entry
                        0x004A, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x08,   // Stream mapping table entry
                        0x004B, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x09,   // Stream mapping table entry
                        0x0069, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x0A,   // Stream mapping table entry
                        0x006A, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x0B,   // Stream mapping table entry
                        0x006B, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x0C,   // Stream mapping table entry
                        0x0025, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x0D,   // Stream mapping table entry
                        0x0027, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x0E,   // Stream mapping table entry
                        0x0045, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },
                    
                    Package ()
                    {
                        0x0F,   // Stream mapping table entry
                        0x0047, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },
                    
                    Package ()
                    {
                        0x10,   // Stream mapping table entry
                        0x0065, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },
                    
                    Package ()
                    {
                        0x11,   // Stream mapping table entry
                        0x0067, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x12,   // Stream mapping table entry
                        0x0400, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x13,   // Stream mapping table entry
                        0x0421, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x14,   // Stream mapping table entry
                        0x0422, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x15,   // Stream mapping table entry
                        0x0423, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x16,   // Stream mapping table entry
                        0x0424, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },
                    
                    Package ()
                    {
                        0x17,   // Stream mapping table entry
                        0x0448, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x18,   // Stream mapping table entry
                        0x0449, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x19,   // Stream mapping table entry
                        0x044A, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x1A,   // Stream mapping table entry
                        0x044B, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x1B,   // Stream mapping table entry
                        0x0469, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x1C,   // Stream mapping table entry
                        0x046A, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x1D,   // Stream mapping table entry
                        0x046B, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x1E,   // Stream mapping table entry
                        0x0425, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },
                    
                    Package ()
                    {
                        0x1F,   // Stream mapping table entry
                        0x0600, // Stream ID
                        0x0000, // Stream Mask
                        0x02    // Context bank
                    },
                    
                    Package ()
                    {
                        0x20,   // Stream mapping table entry
                        0x0606, // Stream ID
                        0x0000, // Stream Mask
                        0x02    // Context bank
                    },
                    
                    Package ()
                    {
                        0x21,   // Stream mapping table entry
                        0x0425, // Stream ID
                        0x0000, // Stream Mask
                        0x03    // Context bank
                    },

                    Package ()
                    {
                        0x22,   // Stream mapping table entry
                        0x0427, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x23,   // Stream mapping table entry
                        0x0445, // Stream ID
                        0x0000, // Stream Mask
                        0x03    // Context bank
                    },

                    Package ()
                    {
                        0x24,   // Stream mapping table entry
                        0x0447, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },

                    Package ()
                    {
                        0x25,   // Stream mapping table entry
                        0x0465, // Stream ID
                        0x0000, // Stream Mask
                        0x03    // Context bank
                    },

                    Package ()
                    {
                        0x26,   // Stream mapping table entry
                        0x0467, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    },
                    
                    Package ()
                    {
                        0x27,   // Stream mapping table entry
                        0x0500, // Stream ID
                        0x0000, // Stream Mask
                        0x04    // Context bank
                    }
                })
            }
            Method (XPUE) 
            {
                Name (BUFF, Buffer ()
                {
                    0x01 //XPU is enabled
                })
                Return (BUFF)
            }
        }

        

        Device (MMU5)
        {
            // This is the SMMU for RICA

            Name (_HID, "HID_MMU0")
            Name (_UID, 5)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDF24000, 0xB000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {180}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {177}   // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {178}   // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {179}   // osmmu_CIrpt[2]
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("E1A63DD8-FB00-42E0-B174-DC801EA1E4F7"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure.
                    0x00                //Context index 2: unsecure.
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-RICA_Elessar.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    },

                    Package ()
                    {
                        0x02,   // Stream mapping table entry
                        0x0002, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x03,   // Stream mapping table entry
                        0x0003, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x04,   // Stream mapping table entry
                        0x0004, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x05,   // Stream mapping table entry
                        0x0005, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },
                    
                    Package ()
                    {
                        0x06,   // Stream mapping table entry
                        0x0007, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x07,   // Stream mapping table entry
                        0x0008, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank
                    },

                    Package ()
                    {
                        0x08,   // Stream mapping table entry
                        0x0010, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x09,   // Stream mapping table entry
                        0x0011, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x0A,   // Stream mapping table entry
                        0x0012, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x0B,   // Stream mapping table entry
                        0x0013, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x0C,   // Stream mapping table entry
                        0x0014, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x0D,   // Stream mapping table entry
                        0x0015, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },

                    Package ()
                    {
                        0x0E,   // Stream mapping table entry
                        0x0017, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },
                    
                    Package ()
                    {
                        0x0F,   // Stream mapping table entry
                        0x0018, // Stream ID
                        0x0000, // Stream Mask
                        0x01    // Context bank
                    },
                    
                    Package ()
                    {
                        0x10,   // Stream mapping table entry
                        0x001B, // Stream ID
                        0x0000, // Stream Mask
                        0x02    // Context bank
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }


        Device (MMU6)
        {
            // This is the SMMU for CPP

            Name (_HID, "HID_MMU0")
            Name (_UID, 6)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFDA84000, 0xA000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {296}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {295}   // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {298}   // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {299}   // osmmu_CIrpt[2]
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("BF8F998B-7DD4-4D92-B3AF-33F1F8ED3EF1"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure -- to be changed to secure when TZ comes in.
                    0x00                //Context index 2: unsecure -- to be changed to secure when TZ comes in.
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-Gfx.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    },

                    Package ()
                    {
                        0x01,   // Stream mapping table entry
                        0x0001, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    },

                    Package ()
                    {
                        0x02,   // Stream mapping table entry
                        0x0002, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }


        


        Device (MMU7)
        {
            // This is the SMMU for FD

            Name (_HID, "HID_MMU0")
            Name (_UID, 7)

            // When testing on 8960, delete the _CRS method. This will cause
            // the driver to use a chunk of RAM.

            Method (_CRS, 0x0, NotSerialized)
            {
                Return (ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite, 0xFD864000, 0xA000)
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {346}    // osmmu_PMIrpt
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {349}   // osmmu_CIrpt[0]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {350}   // osmmu_CIrpt[1]
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {351}   // osmmu_CIrpt[2]
                })
            }

            Method (GUID)
            {
                Return (ToUUID ("AD65697C-AF56-4B4C-97DA-3308CB1E788C"))
            }

            // Some information that is in the CTXI method can also be drawn
            // from the IDR. We can implement code to use IDR to get this info
            // to supplement or corraborate the ACPI info.

            Method (CTXI)
            {
                Return (Buffer ()
                {
                    0x03,               //Number of Smmu contexts
                    0x00,               //Context index 0: 0 - unsecure 1 - secure
                    0x00,               //Context index 1: unsecure
                    0x00                //Context index 2: unsecure
                })
            }
            
            // This method returns a buffer that describes the layout of the
            // SMMU register space. Each entry corresponds to page number from
            // the base address (from _CRS) for the register group specified in
            // the comments to the right.

            Method (OFFI)
            {
                Return (Buffer ()
                {
                    0x00,                // Global 0 page offset from Base Address
                    0x01,                // Global 1 page offset from Base Address
                    0x02,                // Implementation defined page offset from Base Address
                    0x03,                // Perf page offset from base address
                    0x04,                // SSD page offset from base address
                    0x08                 // CB page offset from base address
                })
            }

            // The S2CB method returns a package that describes the stream to
            // context bank mapping that allows the SMMU driver to initialize
            // the SMMU so that the core's transaction stream will be mapped to
            // the correct context bank.

            Method (S2CB)
            {
                // Data from MMU-Config-Gfx.xlsx, MMU-Strm-Map tab.

                // The length of the package indicates the number of stream to
                // context bank entires to program.

                Return (Package ()
                {
                    Package ()
                    {
                        0x00,   // Stream mapping table entry
                        0x0000, // Stream ID
                        0x0000, // Stream Mask
                        0x00    // Context bank (Not specified in the document, need to confirm).
                    }
                })
            }
            
            Method (XPUE) {
                Name (BUFF, Buffer ()
                {
                    0x00 //XPU is disabled
                })
                Return (BUFF)
            }
        }