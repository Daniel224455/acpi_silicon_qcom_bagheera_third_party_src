// Copyright (c) 2010-2014, Qualcomm Technologies Inc. All rights reserved.

#pragma once

#include <ACPI.h>
  
#define ACPI_OEM_ID             'Q','C','O','M',' ',' '
#define ACPI_OEM_TABLE_ID       SIGNATURE8('Q','C','O','M','E','D','K','2')
#define ACPI_OEM_REVISION       0x00000001
#define ACPI_CREATOR_ID         SIGNATURE4('Q','C','O','M')
#define ACPI_CREATOR_REVISION   0x00000001

//#define ACPI_VENDOR_ID          ACPI_CREATOR_ID
#define ACPI_VENDOR_ID          SIGNATURE4('Q','C','O','M')

#define SCSS_SYS_POR            0x01
#define HWIO_SCSS_RESET_ADDR    0x009020B4 // msmhwioreg.h

#define AP_CPU_COUNT            2

