//
// Copyright (c) 2015, Qualcomm Technologies, Inc. All rights reserved.
//

//
// data_common.asl file: Data components, extracted from Common/dsdt_common.asl. This file goes in 8916_MTP_WP.
//


////
//// Modembridge Driver
////
Device (MBRG)
{
	Name (_HID, "QCOM2145")
}

////
//// Remote AT Command Processor Driver
////
Device (RMAT)
{
	Name (_HID, "QCOM2155")
}

////
//// rmnetbridge
////
Device (RMNT)
{
	Name (_HID, "QCOM2148")
}