//===========================================================================
//                           <oem_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by oem drivers.
//
//
//   Copyright (c) 2010-2011 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================


Scope(\_SB_.PEP0) 
{
	
    // OEM 
    Method(OPMD)
    {
        Return(OPCC)
    }	
	
	
    Name(OPCC,
    Package ()
    { 
    })
    
}