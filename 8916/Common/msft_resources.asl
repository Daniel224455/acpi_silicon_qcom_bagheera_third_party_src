//===========================================================================
//                           <msft_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by microsoft drivers.
//
//
//   Copyright (c) 2010-2011 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================


Scope(\_SB_.PEP0) 
{

    // MICROSOFT

    Method(MPMD)
    {
        Return(MPCC)
    }	
	
	
    Name(MPCC,
    Package ()
    { 
    })	
}