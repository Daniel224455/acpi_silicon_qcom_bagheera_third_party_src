//
// Copyright (c) 2011,2014-2015 Qualcomm Technologies Inc. All rights reserved.
//

// 
// Secure Channel Manager (SCM) Driver
//
Device (SCM0)
{
    
	Name (_DEP, Package(0x1) {
		\_SB_.PEP0,
    })
	
	Name (_HID, "HID_SCM0")
    Name (_UID, 0)
 
}

//
// TrEE Driver
//
Device (TREE)
{
    Name (_HID, "HID_TREE")
    Name (_UID, 0)
}
