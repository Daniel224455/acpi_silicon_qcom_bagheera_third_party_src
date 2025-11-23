//
// OCMEM Driver
//

Device (OMEM)
{
    Name (_HID, "HID_OMEM")
    Name (_UID, 0)
    Name (_DEP, Package()
    {
        \_SB_.PEP0
    })
        
    Method (GUID)
    {
        Return (ToUUID ("0BDB4206-6A68-4E0E-A4E6-079946BE378C"))
    }
    
    Method (_CRS, 0x0, NotSerialized)
    {
        Name (RBUF, ResourceTemplate ()
        {
            // OCMEM and DM register address space
            Memory32Fixed (ReadWrite, 0xFDD00000, 0x00004000)
            
            // BR register address space
            Memory32Fixed (ReadWrite, 0xFE039000, 0x00000400)
            
            // DM Interrupt Resource o_ocmem_dm_nonsec_irq
            Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {109}
        })
        Return (RBUF)
    }
    
    // The CLNT method returns a package that describes the clients of OCMEM
    Method (CLNT)
    {
        // Data from MMU-Config-VFE-CPP.xlsx, MMU-Strm-Map tab.
        
        // The length of the package indicates the number of stream to
        // context bank entires to program.
        Return (Package ()
        {
            //Each package here represents an OCMEM client
            Package ()
            {
                    0x01,           // Client ID OCMEM_CLIENT_GRAPHICS
                    0x64,           // Client Priority
                    0xFEC00000,     // BufferStartAddress.  This is the physical ocmem address base
                    0x01,           // Addressing property of this client. 1==Direct Addressing, 2==Offset Addressing, 3==System Addressing
                    0x00180000,     // Client Max Size
                    0x0,            // Operating mode wide/thin 0x0/0x1
                    0x0,            // Memory allocation region start index 
                    0x2,            // Memory allocation region end index
                    0x0,            // Memory allocation macro start index
                    0x3,             // Memory allocation macro end index
                    0x0             // OCMEM NOC CLOCK control bit 0x0==Do not vote for NOC clock for this client
            },
            
            Package ()
            {
                    0x02,           // Client ID OCMEM_CLIENT_VIDEO
                    0x44,           // Client Priority
                    0xFED00000,     // BufferStartAddress
                    0x02,           // 2==Offset Addressing
                    0x00080000,     // Client Max Size
                    0x0,            // Operating mode wide/thin 0x0/0x1
                    0x3,            // Memory allocation region start index 
                    0x3,            // Memory allocation region end index
                    0x0,            // Memory allocation macro start index
                    0x3,             // Memory allocation macro end index
                    0x1             //  OCMEM NOC CLOCK control bit 0x1==Vote for NOC clock for this client
            }
        })
    }
    
    // The BRRT method returns a package that describes the Branch Remapper settings for each client
    Method (BRRT)
    {
            
    } 
    
    // The MEMI method returns a package that describes the memory partition of OCMEM
    Method (MEMI)
    {
        Return (Package ()
        {
            // Each package here represents an OCMEM client
            Package ()
            {
                0x04,           // Number of Regions. 8994 is 4
                0x200,          // Size of each region in KB. Total 2m for 8994. Each region is 512KB
                0x40,           // Size/Granularity of each memory macro.  Each memory macro is 64KB for 8994
                0x02,           // Number of OSWs (Slave Ways).  2 for 8994
                0xFEC00000,     // OCMEM SRAM base physical address
                0x0,            // OCMEM_GFX_START_ADDRESS
                0x100,          // OCMEM_GFX_END_ADDRESS
                0x00            // Enable TZ support 0==FALSE, 1==TRUE
            }
        })
    }
}