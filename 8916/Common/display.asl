//--------------------------------------------------------------------------------------------------
// Copyright (c) 2012-2014 Qualcomm Technologies, Inc.  All Rights Reserved.
// Qualcomm Technologies Proprietary and Confidential.
//--------------------------------------------------------------------------------------------------
//
// This file contains the ACPI Extensions for Display Adapters
//


///
// _ROM Method - Used to retrieve proprietary ROM data
//
Method (_ROM, 3, NotSerialized) {

   // Include panel specific ROM data
   Include("panelcfg.asl")

   //======================================================================================
   //  Based on the panel Id(Arg2), store the buffer object into Local2
   //
   //  IMPORTANT:
   //       PCFG is buffer name for all default panel configurations
   //       All other dynamically detected panel configurations must not use this name
   //======================================================================================
   Switch (  ToInteger (Arg2) )
   {
        // 720p Truly video mode panel.
        Case (0x900000) {
            Store (PCF1, Local2)
        }
        // 720p Truly video mode panel.(to be removed after UEFI promotion)
        Case (0x008000 ) {
            Store (PCF1, Local2)
        } 
        //JDI 1080p Panel
        Case (0x030305) {
            Store (PCFG, Local2)
        }
		// //JDI 1080p Panel
        Default {
            Store (PCFG, Local2)
        }
   }

   // Ensure offset does not exceed the buffer size 
   // otherwise return a Null terminated buffer
   If (LGreaterEqual(Arg0, Sizeof(Local2)))
   {
      Return( Buffer(){0x0} )
   }
   Else
   {
        // Make a local copy of the offset
      Store(Arg0, Local0)        
   }

   // Ensure the size requested is less than 4k
   If (LGreater(Arg1, 0x1000))
   {
      Store(0x1000, Local1)
   }
   else
   {
      Store(Arg1, Local1)
   }

   // Finaly ensure the total size does not exceed the size of the buffer
   if (LGreater(Add(Local0, Local1), Sizeof(Local2)))
   {
       // Calculate the maximum size we can return
       Subtract(Sizeof(Local2), Local0, Local1);
   }

   // Multiply offset and size by 8 to convert to bytes and create the RBuf
   CreateField(Local2, Multiply(0x8, Local0), Multiply(0x8, Local1), RBUF)

   Return(RBUF)
}


//
// IGC method - panel inverse gamma correction table.
//
// The buffer contains inverse gamma correction data for 3 color components, each with 256 16-bit integers.
// The buffer size is 3*256*2 = 1536 bytes.
// each table entry is represend by a 16-bit integer and data format in the buffer is described below:
//
// +--- 16 bits ---+--- 16 bits ---+--- 16 bits ---+---------+--- 16 bits ---+   0
// |    Red[0]     |    Red[1]     |    Red[2]     |   ...   |    Red[255]   |
// +---------------+---------------+---------------+---------+---------------+   512
// |    Green[0]   |    Green[1]   |    Green[2]   |   ...   |    Green[255] |
// +---------------+---------------+---------------+---------+---------------+   1024
// |    Blue[0]    |    Blue[1]    |    Blue[2]    |   ...   |    Blue[255]  |
// +---------------+---------------+---------------+---------+---------------+   1536
//
Method (PIGC, 2, NotSerialized) {
    // Create response buffer
    Name (RBUF, Buffer() {0x0} )

    // Arg0 - Panel ID 
    
    // Arg1 - Data size  


    // Return the packet data
    Return(RBUF)
}


//
// PCC method - panel color correction matrix
//
// The buffer contains color correction coefficients for 3 color components, each with 11 64-bit integers.
// The buffer size is 3*11*8 = 264 bytes.
// each coefficient in the matrix is represented by a long long integer (64-bit), and data format in the 
// buffer is described below:
//
// +--- 8 bytes ---+--- 8 bytes ---+--- 8 bytes ---+-----------+--- 8 bytes ---+    0
// |    Red[0]     |    Red[1]     |    Red[2]     |    ...    |    Red[10]    |
// +---------------+---------------+---------------+-----------+---------------+    88
// |   Green[0]    |   Green[1]    |   Green[2]    |    ...    |   Green[10]   |
// +---------------+---------------+---------------+-----------+---------------+    176
// |    Blue[0]    |    Blue[1]    |    Blue[2]    |    ...    |    Blue[10]   |
// +---------------+---------------+---------------+-----------+---------------+    264
//
Method (PPCC, 2, NotSerialized) {
    // Create response buffer
    Name (RBUF, Buffer() {0x0} )

    // Arg0 - Panel ID 
    
    // Arg1 - Data size  


    // Return the packet data
    Return(RBUF)
}


//
// PGC method - panel gamma correction table
//
// there're thee components and each with 16 gamma correction segments. Each segment is defined
// as below with parameters, and each parameter is represented by a 32-bit integer (DWORD):
//
// +--4 bytes--+--4 bytes--+--4 bytes--+--4 bytes--+
// |  enable   |   start   |   gain    |   offset  |        one gamma correction segment(16 bytes)
// +-----------+-----------+-----------+-----------+
//
// +--- 16 bytes ---+--- 16 bytes ---+--- 16 bytes ---+-----------+--- 16 bytes ---+    0
// |   red_seg[0]   |  red_seg[1]    |  red_seg[2]    |    ...    |  red_seg[15]   |
// +----------------+----------------+----------------+-----------+----------------+    256
// |  green_seg[0]  |  green_seg[1]  |  green_seg[2]  |    ...    |  green_seg[15] |
// +----------------+----------------+----------------+-----------+----------------+    512
// |   blue_seg[0]  |   blue_seg[1]  |   blue_seg[2]  |    ...    |   blue_seg[15] |
// +----------------+----------------+----------------+-----------+----------------+    768
//
Method (PGCT, 2, NotSerialized) {
    // Create response buffer
    Name (RBUF, Buffer() {0x0} )

    // Arg0 - Panel ID 
    
    // Arg1 - Data size  



    // Return the packet data
    Return(RBUF)
}


//
// HSIC method - HSIC settings
//
// Hue, Saturation, Intensity, Contrast levels, the first parameter enable/disable HSIC control,
// followed by HSIC level values, each level ranges from -100 to 100, represented by a 32-bit integer:
//
// +--4 bytes--+--4 bytes--+--4 bytes--+--4 bytes--+--4 bytes--++
// |  Enable   |    Hue    | Saturation| Intensity |  Contrast  |
// +-----------+-----------+-----------+-----------+-----------++
//
//
Method (HSIC, 2, NotSerialized) {
    // Create response buffer
    Name (RBUF, Buffer() {0x0} )


    // Arg0 - Panel ID 
    
    // Arg1 - Data size  



    // Return the packet data
    Return(RBUF)
}



//
// PGMT - panel gamut mapping table
//
//   This method returns the gamut mapping table for a panel.
//
//   There are three components. Each component has 8 tables and a total of 729 entries. 
//   Each value is represented by a 16-bit integer:
//
//   Table ID     Entries 
//      0           125 
//      1           100
//      2            80
//      3           100
//      4           100
//      5            80
//      6            64
//      7            80   
//
// +----- 2 bytes -----+----- 2 bytes ------+----- 2 bytes -----+-----------+----- 2 bytes -------+    
// | red_comp[0][0]    |   red_comp[0][1]   |  red_comp[0][2]   |    ...    |  red_comp[7][79]    |    
// +-------------------+--------------------+-------------------+---------------------------------+    
// | green_comp[0][0]  |  green_comp[0][1]  | green_comp[0][2]  |    ...    |  green_comp[7][79]  |
// +-------------------+--------------------+-------------------+---------------------------------+        
// | blue_comp[0][0]   |  blue_comp[0][1]   | blue_comp[0][2]   |    ...    |  blue_comp[7][79]   |
// +-------------------+--------------------+-------------------+---------------------------------+    
//
Method (PGMT, 2, NotSerialized) {
    // Create response buffer
    Name (TBUF, Buffer() {0x0} )


   // Ensure offset does not exceed the buffer size 
   // otherwise return a Null terminated buffer
   If (LGreaterEqual(Arg0, Sizeof(TBUF)))
   {
	    Return( Buffer(){0x0} )
   }
   Else
   {
        // Make a local copy of the offset
	    Store(Arg0, Local0)        
   }
    
   // Arg1 - Data size  
   // Ensure the size requested is less than 4k
   If (LGreater(Arg1, 0x1000))
   {
	    Store(0x1000, Local1)
   }
   else
   {
	    Store(Arg1, Local1)
   }

   // Finaly ensure the total size does not exceed the size of the buffer
   if (LGreater(Add(Local0, Local1), Sizeof(TBUF)))
   {
       // Calculate the maximum size we can return
       Subtract(Sizeof(TBUF), Local0, Local1);
   }

   // Multiply offset and size by 8 to convert to bytes and create the RBUF
   CreateField(TBUF, Multiply(0x8, Local0), Multiply(0x8, Local1), RBUF)


    // Return the packet data
    Return(RBUF)
}



//
// PGRT - panel gamma response table
//
//   This method returns the Gamma response table for a panel.
//   The table is given in 2 arrays, one representing the x axis or grayscale and other 
//   representing the y axis or luminance. 
//
//   The table is given in a 256 entries array, where the first entry value represents
//   the luminance (Y) achieved when displaying black on the screen (shade value is 0
//   for all R, G and B) and the last entry represents the luminance (Y) achieved when 
//   displaying white on the screen (shade value is 255 for all R, G and B).
// 
//   The array must be 256 entries.
//
//   The range of each entry must be from 0 to 0xffff
//
//   Values are least significant byte first. E.g. {0x01, 0x00} represents 0x1 and
//   {0x02, 0x01} represents 0x0102
//
// +--- 2 bytes ---+--- 2 bytes ---+--- 2 bytes ---+-----------+--- 2 bytes ---+ 
// |     Y[0]      |     Y[1]      |     Y[2]      |    ...    |     Y[255]    |
// +---------------+---------------+---------------+-----------+---------------+ 
Method (PGRT, 2, NotSerialized) {
  Name (RBUF, Buffer() {0x0})

  // Arg0 - Panel ID 
    
  // Arg1 - Data size  

  
  // Return the packet data
  Return(RBUF)
}


//
// PBRT - panel backlight response table
//
//   This method returns the Backlight response table for a panel.
//   The table is given in a 256 entries array, where the first entry value represents
//   the backlight level (BL) to achieve 0 luminance and the last entry represents  
//   the highest backlight level to achieve the maximum desired luminance. 
//   In other words, this array serves as a map from luminance to backlight levels,
//   where the index is the desired luminance level and the value (or output) is 
//   the backlight level to be sent to the hardware (backlight controller).
// 
//   The array must be 256 entries.
//
//   The range of each entry must be from 0 to 0xffff
//
//   Values are least significant byte first. E.g. {0x01, 0x00} represents 0x1 and
//   {0x02, 0x01} represents 0x0102
//
// +--- 2 bytes ---+--- 2 bytes ---+--- 2 bytes ---+-----------+--- 2 bytes ---+ 
// |    BL[0]      |    BL[1]      |    BL[2]      |    ...    |    BL[255]    |
// +---------------+---------------+---------------+-----------+---------------+ 
Method (PBRT, 2, NotSerialized) {
  Name (RBUF, Buffer() {0x0})

  // Arg0 - Panel ID 
   
  // Arg1 - Data size  

  
  // Return the packet data
  Return(RBUF)
}


// Include panel specific configuration for backlight control packets
//
Include("backlightcfg.asl")
