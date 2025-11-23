//===========================================================================
//                           <ocmem_resources.asl>
// DESCRIPTION
//   This file contans the resources needed by ocmem driver.
//
//
//   Copyright (c) 2010-2011 by Qualcomm Technologies Inc.  All Rights Reserved.
//   Qualcomm Confidential and Proprietary
//
//===========================================================================
Scope(\_SB.PEP0){
    // OCMEM
    Method(OCMD){
        Return(OCCC)
    }
    Name(OCCC, 
    Package(){
        Package(){
            "DEVICE", 
            "\\_SB.OMEM", 
            //--------------------------------------------------------------------------------------
            //  Component 0   - OCMEM Core Resource clock F-States
            //--------------------------------------------------------------------------------------
            //
            Package(){
                "COMPONENT", 
                0, 
                Package(){ "FSTATE", 0, package(){ "REQUIRED_RESOURCE", package(){ 1, "/clk/ocmem", 1, },},}, 
                Package(){ "FSTATE", 1, package(){ "REQUIRED_RESOURCE", package(){ 1, "/clk/ocmem", 0, },},}, 
                Package(){ "STOP_FSTATE", 0, }, 
            },
            //--------------------------------------------------------------------------------------
            //  Component 1   - OCMEM NOC CLOCK F-States
            //--------------------------------------------------------------------------------------
            //
            Package(){
                "COMPONENT", 
                1, 
                Package(){ "FSTATE", 0, }, 
                Package(){ "FSTATE", 1, }, 
                Package(){ "STOP_FSTATE", 0, }, 
            },
        },
    })
}
