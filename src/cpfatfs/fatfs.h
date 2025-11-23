#ifndef __FATFS_H
#define __FATFS_H

/*=================================================================================================

  FAT File system suporting structure header files

GENERAL DESCRIPTION
  This is the header file that contains the definition for all the data structures used
  by the FAT file system utilities

 Copyright (c) 2010 Qualcomm Technologies Incorporated.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary

=================================================================================================*/

/*=================================================================================================

                                 EDIT HISTORY FOR FILE

  This section contains comments describing changes made to the module.
  Notice that changes are listed in reverse chronological order.

  $Header: //deploy/qcom/qct/platform/wpci/prod/woa/acpi/rel/9.2/src/cpfatfs/fatfs.h#2 $ 
  $DateTime: 2016/12/10 03:22:14 $ 
  $Author: wmcisvc $

YYYY-MM-DD   who     what, where, why
----------   ---     --------------------------------------------------------------------------
2010-02-09   rh      Initial release

=================================================================================================*/


/*=================================================================================================

                                     Defines

=================================================================================================*/ 

#define TRUE               1
#define FALSE              0
typedef int                boolean;
typedef unsigned int       uint;
typedef unsigned int       uint32;
typedef unsigned char      uint8;

#define GET_LWORD_FROM_BYTE(x)    ((uint32)*(x) | \
                                  ((uint32)*(x+1) << 8) | \
                                  ((uint32)*(x+2) << 16) | \
                                  ((uint32)*(x+3) << 24))

#define PUT_LWORD_TO_BYTE(x, y)   do{*(x) = y & 0xff;     \
                                     *(x+1) = (y >> 8) & 0xff;     \
                                     *(x+2) = (y >> 16) & 0xff;     \
                                     *(x+3) = (y >> 24) & 0xff; }while(0)    


#define SECTOR_SIZE            512
#define FILE_ENTRY_SIZE        32
#define FAT_FILE_NAME_LENGTH   11

#define ATTRIBUTE_READONLY     0x01
#define ATTRIBUTE_HIDDEN       0x02
#define ATTRIBUTE_SYSTEM       0x04
#define ATTRIBUTE_VOL_LABEL    0x08
#define ATTRIBUTE_DIR          0x10
#define ATTRIBUTE_ARCHIVE      0x20


// Basic information contained in the BOOT sector
struct boot_sector_info {
   uint8    oem_name[8];
   uint32   byte_per_sector;
   uint8    sector_per_cluster;
   uint32   reserved_sec_count;
   uint8    num_fat_count;
   uint32   max_root_entries;
   uint32   total_sectors;
   uint8    media_description;
   uint32   sectors_per_fat;
   uint32   sectors_per_track;
   uint32   num_of_heads;
   uint32   sectors_per_alloc;
   uint32   version;
   uint32   root_cluster_num;
   uint32   fs_info_sector;
   uint32   disk_id;
   uint8    volume_label[11];
   uint8    fat_system_type[8];
   uint32   free_cluster;
   uint32   last_alloc;
   uint32   cluster_start_loc;         // Starting location of the first cluster (In sector)
   uint32   root_dir_table_loc;        // Location of the root file table (In sector)
   uint32   curr_dir_table_loc;        // Location of the currently accessed file table (In sector)
   uint32   fat_tbl_1_loc;             // Location of the 1st fat table (In sector)
   uint32   fat_tbl_2_loc;             // Location of the 2nd fat table (In sector)
};

// Basic information contained in a file entry in the directory table
struct dir_table_info {
   uint8    file_name[12];
   uint8    attributes;
   uint8    create_time_ms;
   uint8    create_time[2];
   uint8    create_date[2];
   uint8    access_date[2];
   uint32   ea_index;
   uint8    mod_time[2];
   uint8    mod_date[2];
   uint32   start_cluster;
   uint32   file_size;
};


#endif /* __FATFS_H */
