/*=================================================================================================

  Add a file to a FAT file system 

GENERAL DESCRIPTION
  This program read in a FAT file system in a file and add a file to the 
  specified location.  Currently, only FAT16 file system is supported

 Copyright (c) 2010 Qualcomm Technologies Incorporated.
 All Rights Reserved.
 Qualcomm Confidential and Proprietary

=================================================================================================*/

/*=================================================================================================

                                 EDIT HISTORY FOR FILE

  This section contains comments describing changes made to the module.
  Notice that changes are listed in reverse chronological order.

  $Header: //deploy/qcom/qct/platform/wpci/prod/woa/acpi/rel/9.2/src/cpfatfs/cpfatfs.c#2 $ 
  $DateTime: 2016/12/10 03:22:14 $ 
  $Author: wmcisvc $

YYYY-MM-DD   who     what, where, why
----------   ---     --------------------------------------------------------------------------
2011-04-20   ah      Added time stamp
2010-08-04   rh      Pad the end of the file to multiple of 512 bytes
2010-06-23   rh      Adding ability to create directory
2010-06-17   rh      Correctly detect the length of the file extension
2010-06-04   rh      Initial release

=================================================================================================*/

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "fatfs.h"
#include <sys/stat.h>

FILE *mfpin;

// Buffer of zeroes to append to end of image file for padding up to next
// 512-byte multiple
char buffer_zeroes[512] = {0};

/*================================================================================================

DESCRIPTION
  Convert string into upper case

PARAMETER
  in - input string
  out - output string
  size - length of the string
  
=================================================================================================*/
void make_upper(char *out, char *in, size_t size)
{
   size_t i;

   for(i = 0; i < size; i++)
   {
      if (in[i] >= 'a' && in[i] <= 'z') 
         out[i] = in[i] - ('a' - 'A'); 
      else 
         out[i] = in[i];
   }
}

/*================================================================================================

DESCRIPTION
  Extract and format the file name for 8.3 used by the FAT file system

PARAMETER
  in - input string
  out - output string
  size - length of the string
  
=================================================================================================*/
void extract_file_name(char *out, char *in, size_t size)
{
   size_t i;
   size_t start;
   size_t oi;
   size_t dotloc;

   start = 0;
   dotloc = 1000;       // Some large number so it won't be hit
   for (i = 0;; i++)
   {
      if (in[i] == '\\') start = i + 1;
      if (in[i] == '/') start = i + 1;
      if (in[i] == 0) break;
      if (in[i] == '.') dotloc = i;
   }

   memset (out, ' ', FAT_FILE_NAME_LENGTH);
   out[FAT_FILE_NAME_LENGTH] = 0;
   oi = 0;
   for (i = start;; i++)
   {
      if (in[i] == 0) break;
      // Detect the location of the dot
      if (i == dotloc) 
      {
         oi = 8;
         continue;
      }

      // Conver the file name to upper case
      if (in[i] >= 'a' && in[i] <= 'z') 
         out[oi] = in[i] - ('a' - 'A'); 
      else 
         out[oi] = in[i];

      // See if the file name is longer than 8 character, if so, skip and process the extension
      oi++;
      if ((oi == 8) && (i <= dotloc))
      {
         i = dotloc;
      }
      if (oi > size) break;
   }
}


/*================================================================================================

DESCRIPTION
  Check the user provided file name to see if it fits the 8.3 file name requirement.  If not
  output warning message

PARAMETER
  in - input string
  
=================================================================================================*/
void check_file_name (char *in)
{
   int i;
   int start = 0;
   int end = 0;
   int dotloc = -1;
   int is_name_good = 1;
   char outname[FAT_FILE_NAME_LENGTH];
   char outn[FAT_FILE_NAME_LENGTH];
   char oute[FAT_FILE_NAME_LENGTH];

   for (i = 0;; i++)
   {
      if (in[i] == '\\') start = i + 1;
      if (in[i] == '/') start = i + 1;
      if (in[i] == 0) break;
      if (in[i] == '.') dotloc = i;
   }
   end = i - 1;

   if (dotloc != -1)
   {
      if ((dotloc - start) > 8 || (end - dotloc) > 3)
      {
         is_name_good = 0;
      }
   }
   else
   {
      is_name_good = 0;
   }

   if (!is_name_good)
   {
      // Extract the 8.3 file name
      extract_file_name (outname, in, FAT_FILE_NAME_LENGTH);
      memcpy (outn, outname, 8);
      outn[8] = 0;
      memcpy (oute, outname+8, 3);
      oute[3] = 0;
      // Print out warning message
      printf("WARNING: Input file does not fit the standard 8.3 file name requirement.\n");
      printf("Output file will be renamed to: %s.%s\n", outn, oute);
   }
}

/*================================================================================================

DESCRIPTION
  Read in the boot sector structure

=================================================================================================*/
void read_boot_structure(struct boot_sector_info *boot_info)
{
   uint8 buf[SECTOR_SIZE];
   // Read in the first sector, which is the boot record
   fseek (mfpin, 0, SEEK_SET);
   fread (buf, SECTOR_SIZE, 1, mfpin);

   memcpy(boot_info->oem_name, buf + 0x03, 8);
   boot_info->byte_per_sector = buf[0x0b];
   boot_info->byte_per_sector |= buf[0x0c] << 8;

   boot_info->sector_per_cluster = buf[0x0d];
   
   boot_info->reserved_sec_count = buf[0x0e]; 
   boot_info->reserved_sec_count |= buf[0x0f] << 8; 
   
   boot_info->num_fat_count = buf[0x10];
   
   boot_info->max_root_entries = buf[0x11];
   boot_info->max_root_entries |= buf[0x12] << 8;

   boot_info->media_description = buf[0x15];

   boot_info->sectors_per_fat = buf[0x16];
   boot_info->sectors_per_fat |= buf[0x17] << 8;

   boot_info->sectors_per_track = buf[0x18];
   boot_info->sectors_per_track |= buf[0x19] << 8;

   boot_info->num_of_heads = buf[0x1a];
   boot_info->num_of_heads |= buf[0x1b] << 8;

   boot_info->total_sectors = buf[0x20];
   boot_info->total_sectors |= buf[0x21] << 8;
   boot_info->total_sectors |= buf[0x22] << 16;
   boot_info->total_sectors |= buf[0x23] << 24;

   boot_info->sectors_per_alloc = buf[0x24];
   boot_info->sectors_per_alloc |= buf[0x25] << 8;
   boot_info->sectors_per_alloc |= buf[0x26] << 16;
   boot_info->sectors_per_alloc |= buf[0x27] << 24;

   boot_info->version = buf[0x2a];

   boot_info->root_cluster_num = buf[0x2c];
   boot_info->root_cluster_num |= buf[0x2d] << 8;
   boot_info->root_cluster_num |= buf[0x2e] << 16;
   boot_info->root_cluster_num |= buf[0x2f] << 24;

   boot_info->fs_info_sector = buf[0x30];
   boot_info->fs_info_sector |= buf[0x31] << 8;

   boot_info->disk_id = buf[0x43];
   boot_info->disk_id |= buf[0x44] << 8;
   boot_info->disk_id |= buf[0x45] << 16;
   boot_info->disk_id |= buf[0x46] << 24;

   memcpy (boot_info->volume_label, buf + 0x47, 11);
   memcpy (boot_info->fat_system_type, buf + 0x52, 8);

}


/*================================================================================================

DESCRIPTION
  Print the boot sector structure for debugging

=================================================================================================*/
void print_boot_structure(struct boot_sector_info *boot_info)
{
   printf ("Byte per sector: %d\n", boot_info->byte_per_sector); 
   printf ("Sector per cluster: %d\n", boot_info->sector_per_cluster);
   printf ("Number of FAT: %d\n", boot_info->num_fat_count);
   printf ("Max root entries: %d\n", boot_info->max_root_entries);
   printf ("Reserved sector count: %d\n", boot_info->reserved_sec_count);
   printf ("Size of each FAT table in sectors: %d\n", boot_info->sectors_per_fat);
   printf ("Sectors per track: %d\n", boot_info->sectors_per_track);
   printf ("Number of heads: %d\n", boot_info->num_of_heads);
   printf ("Total sectors: %d\n", boot_info->total_sectors);
   printf ("Sectors per allocation unit: %d\n", boot_info->sectors_per_alloc);
   printf ("Root cluster number: %d\n", boot_info->root_cluster_num);
   printf ("Fat file system type: %s\n", boot_info->fat_system_type);
}

/*================================================================================================

DESCRIPTION
  Calculate some basic parameter for the FAT table

RETURN
  TRUE for success, FALSE otherwise

=================================================================================================*/
int compute_boot_structure(struct boot_sector_info *boot_info)
{
   if (boot_info->byte_per_sector != SECTOR_SIZE) return FALSE;

   boot_info->root_dir_table_loc = boot_info->num_fat_count * boot_info->sectors_per_fat + 
                                   boot_info->reserved_sec_count;

   boot_info->curr_dir_table_loc = boot_info->root_dir_table_loc;

   boot_info->fat_tbl_1_loc = boot_info->reserved_sec_count;

   boot_info->fat_tbl_2_loc = boot_info->reserved_sec_count + boot_info->sectors_per_fat;
   // Set this value to 0 if second FAT table does not exist
   if (boot_info->num_fat_count == 1) boot_info->fat_tbl_2_loc = 0;

   boot_info->cluster_start_loc = boot_info->root_dir_table_loc + 
                                  boot_info->max_root_entries * FILE_ENTRY_SIZE / SECTOR_SIZE;

#ifdef DEBUGMSG
   printf ("Root directory table location: %x\n", boot_info->root_dir_table_loc);
   printf ("1st FAT table location: %x\n", boot_info->fat_tbl_1_loc);
   printf ("2nd FAT table location: %x\n", boot_info->fat_tbl_2_loc);
   printf ("Cluster base location: %x\n", boot_info->cluster_start_loc);
#endif

   return TRUE;
}


/*================================================================================================

DESCRIPTION
  Read in a entry from the file entry table of the current working directory

PARAMETER
  dir_info - Directory file entry description structure

=================================================================================================*/
void read_file_entry(struct boot_sector_info *boot_info, uint32 entry_num, struct dir_table_info *dir_info)
{
   uint8 buf[SECTOR_SIZE];
   uint32 entry_offset;

   entry_offset = boot_info->curr_dir_table_loc * SECTOR_SIZE + entry_num * FILE_ENTRY_SIZE;

   // Read in the first sector, which is the boot record
   fseek (mfpin, entry_offset, SEEK_SET);
   fread (buf, FILE_ENTRY_SIZE, 1, mfpin);

   memcpy (dir_info->file_name, buf, FAT_FILE_NAME_LENGTH);
   dir_info->file_name[FAT_FILE_NAME_LENGTH] = 0;

   dir_info->attributes = buf[0x0b];

   dir_info->create_time_ms = buf[0x0d];
   dir_info->create_time[0] = buf[0x0e];
   dir_info->create_time[1] = buf[0x0f];
   dir_info->create_date[0] = buf[0x10];
   dir_info->create_date[1] = buf[0x11];
   dir_info->access_date[0] = buf[0x12];
   dir_info->access_date[1] = buf[0x13];
   dir_info->ea_index = buf[0x14] | (buf[0x15] << 8);
   dir_info->mod_time[0] = buf[0x16];
   dir_info->mod_time[1] = buf[0x17];
   dir_info->mod_date[0] = buf[0x18];
   dir_info->mod_date[1] = buf[0x19];
   dir_info->start_cluster = buf[0x1a] | (buf[0x1b] << 8);
   dir_info->file_size = buf[0x1c] | (buf[0x1d] << 8) | (buf[0x1e] << 8) | (buf[0x1f] << 8);

#ifdef DEBUGMSG
   printf ("File Name: %s\n", dir_info->file_name);
   printf ("Attributes: %x\n", dir_info->attributes);
   printf ("Starting cluster: %x\n", dir_info->start_cluster);
   printf ("File size: %x\n", dir_info->file_size);
   printf ("Create time: %i %i\n",  dir_info->create_time[0],  dir_info->create_time[1]);
#endif
}

/*================================================================================================

DESCRIPTION
  Update the time fields in a file to the current system time

=================================================================================================*/
void SetFileTime(uint8 *buf)
{
   time_t rawtime;
   struct tm * timeinfo;
   unsigned int tmptime;
   unsigned int tmpdate;

   time(&rawtime);
   timeinfo = localtime ( &rawtime );

   // Time format
   // 15-11	Hours (0-23)
   // 10-5	Minutes (0-59)
   // 4-0	Seconds/2 (0-29)
   tmptime = timeinfo->tm_sec/2;
   tmptime |= (timeinfo->tm_min << 5);
   tmptime |= (timeinfo->tm_hour << 11);

   // Date format
   // 15-9	Year (0 = 1980, 127 = 2107)
   // 8-5	Month (1 = January, 12 = December)
   // 4-0	Day (1 - 31)
   tmpdate = timeinfo->tm_mday;
   tmpdate |= ((timeinfo->tm_mon+1) << 5);
   tmpdate |= ((timeinfo->tm_year-80) << 9);
   
   buf[0x0d] = 0;
   buf[0x0e] = tmptime & 0xff;
   buf[0x0f] = tmptime >> 8;
   buf[0x10] = tmpdate & 0xff;
   buf[0x11] = tmpdate >> 8;
   buf[0x12] = tmpdate & 0xff;
   buf[0x13] = tmpdate >> 8;
   buf[0x16] = tmptime & 0xff;
   buf[0x17] = tmptime >> 8;
   buf[0x18] = tmpdate & 0xff;
   buf[0x19] = tmpdate >> 8;

}

/*================================================================================================

DESCRIPTION
  Add/Write in a entry to the file entry table of the current working directory

=================================================================================================*/
void add_filetbl_entry(struct boot_sector_info *boot_info, struct dir_table_info *dir_info)
{
   uint8 buf[SECTOR_SIZE];
   uint32 entry_offset;
   int max_tab_entries;
   int i;

   max_tab_entries = boot_info->sector_per_cluster * SECTOR_SIZE / FILE_ENTRY_SIZE;
   // Search for an empty file table entry first
   for (i = 0; i < max_tab_entries; i++)
   {
      entry_offset = boot_info->curr_dir_table_loc * SECTOR_SIZE + i * FILE_ENTRY_SIZE;
      fseek (mfpin, entry_offset, SEEK_SET);
      fread (buf, FILE_ENTRY_SIZE, 1, mfpin);
      // If the first byte of the entry is 0, it is the last entry in the directory table
      if (buf[0] == 0x00) break;
   }

   // If the file table is full, just replace the last entry
   if (i >= 31)
   {
      printf("Excedding the directory table size, replacing the last file entry.\n");
   }

   printf("Maximum allowed files per dir is: %d, current pos: %d\n", max_tab_entries, i);

   entry_offset = boot_info->curr_dir_table_loc * SECTOR_SIZE + i * FILE_ENTRY_SIZE;
   fseek (mfpin, entry_offset, SEEK_SET);

   // Read in the first sector, which is the boot record

   memset (buf, 0, sizeof(buf));
   memcpy (buf, dir_info->file_name, FAT_FILE_NAME_LENGTH);

   buf[0x0b] = dir_info->attributes;
   // Need to fill in the times otherwise windows doesn't display it nicely
   SetFileTime(buf);
   buf[0x1a] = dir_info->start_cluster & 0xff;
   buf[0x1b] = (dir_info->start_cluster >> 8) & 0xff;
   buf[0x1c] = dir_info->file_size & 0xff;
   buf[0x1d] = (dir_info->file_size >> 8) & 0xff;
   buf[0x1e] = (dir_info->file_size >> 16) & 0xff;
   buf[0x1f] = (dir_info->file_size >> 24) & 0xff;
   fwrite (buf, FILE_ENTRY_SIZE, 1, mfpin);
}


/*================================================================================================

DESCRIPTION
  Add/Write in a entry to the FAT table

PARAMETER
  cl: Currtne cluster to be updated
  val: Value to update 

=================================================================================================*/
void update_fat_cluster_entry(struct boot_sector_info *boot_info, uint32 cl, uint32 val)
{
   uint8 buf[4];
   uint32 offset;
   uint32 curr_cluster;
   int i;

   offset = boot_info->fat_tbl_1_loc * SECTOR_SIZE;
   offset += cl * 2;                         // 2 bytes per cluster entry for FAT16

   buf[0] = val & 0xff;
   buf[1] = (val >> 8) & 0xff;

   fseek (mfpin, offset, SEEK_SET);
   fwrite (buf, 2, 1, mfpin); 

   offset = boot_info->fat_tbl_2_loc * SECTOR_SIZE;
   offset += cl * 2;                         

   fseek (mfpin, offset, SEEK_SET);
   fwrite (buf, 2, 1, mfpin); 
}


/*================================================================================================

DESCRIPTION
  Traverse the FAT table and find the first free cluster

RETURN
  First free cluster number if successful, 0 otherwise

=================================================================================================*/
uint32 find_first_free_cluster(struct boot_sector_info *boot_info)
{
   uint8 buf[SECTOR_SIZE];
   uint32 offset;
   uint32 i, j;
   uint32 curr_cluster;

   offset = boot_info->fat_tbl_1_loc * SECTOR_SIZE;
   fseek (mfpin, offset, SEEK_SET);

   curr_cluster = 0;

   for(j = 0; j < (boot_info->sectors_per_fat); j++)
   {
      fread (buf, SECTOR_SIZE, 1, mfpin);
      for (i = 0; i < SECTOR_SIZE; i += 2)
      {
         if ((buf[i] == 0) && (buf[i+1] == 0))
         {
            // Check if current cluster exceed the disk size
            if (curr_cluster > (boot_info->total_sectors / boot_info->sector_per_cluster))
               return 0;
            else
               return curr_cluster;
         }
         
         curr_cluster++;
      }
   }
   return 0;
}


/*================================================================================================

DESCRIPTION
  Add a directory into the current directory, update the directory pointer to the new directory

PARAMETER
  dirname - Name of the directory to add
  
RETURN
  TRUE for success, FALSE otherwise

=================================================================================================*/
int add_dir(struct boot_sector_info *boot_info, char *dirname)
{
   int i;
   struct dir_table_info c_entry;      // Current directory entry
   FILE *fpsrc;
   uint32 entry_offset;
   uint32 current_cl;
   uint32 p_entry_cl;                  // Parent directory cluster address
   uint8 buf[SECTOR_SIZE];
   const char curr_dir_name[] = {".          "};
   const char prev_dir_name[] = {"..         "};

   // Fill in the file entry information structure
   memset (&c_entry, 0, sizeof(c_entry));

   c_entry.start_cluster = find_first_free_cluster(boot_info);
   current_cl = c_entry.start_cluster;
   if (c_entry.start_cluster == 0)
   {
      printf ("Insufficient disk space to create directory.\n");
      return FALSE;
   }
   printf ("Adding directory to cluster %x.\n", c_entry.start_cluster);

   // Clean up the cluster that the directory table will be placed
   entry_offset = boot_info->cluster_start_loc + (current_cl - 2) * boot_info->sector_per_cluster;
   fseek (mfpin, entry_offset * SECTOR_SIZE, SEEK_SET);
   memset (buf, 0, SECTOR_SIZE);
   for (i = 0; i < boot_info->sector_per_cluster; i++)
   {
      fwrite(buf, SECTOR_SIZE, 1, mfpin);
   }

   update_fat_cluster_entry (boot_info, current_cl, 0xffff);      // Mark the cluster data

   // Update the parent directory table with the new directory information
   c_entry.attributes = ATTRIBUTE_DIR;
   extract_file_name (c_entry.file_name, dirname, FAT_FILE_NAME_LENGTH);
   add_filetbl_entry (boot_info, &c_entry);

   // Update the new directory table with . and .. information
   p_entry_cl = ((boot_info->curr_dir_table_loc + 2 * boot_info->sector_per_cluster - boot_info->cluster_start_loc ) 
                                               / boot_info->sector_per_cluster);
   // Special case for root directory, which is located before the start of the main storage area
   if (boot_info->curr_dir_table_loc < boot_info->cluster_start_loc)
      p_entry_cl = 0;

   printf("Curr Loc %d, Start Loc %d cluster %d\n", boot_info->curr_dir_table_loc, boot_info->cluster_start_loc, p_entry_cl);

   boot_info->curr_dir_table_loc = entry_offset;
   memcpy (c_entry.file_name, curr_dir_name, sizeof(curr_dir_name));
   add_filetbl_entry (boot_info, &c_entry);

   c_entry.start_cluster = p_entry_cl;
   memcpy (c_entry.file_name, prev_dir_name, sizeof(prev_dir_name));
   add_filetbl_entry (boot_info, &c_entry);
   return TRUE;
}


/*================================================================================================

DESCRIPTION
  Change current working directory to the one specified 

PARAMETER
  dirname - Direcotry name to change into
  
RETURN
  TRUE for success, FALSE otherwise

=================================================================================================*/
int change_dir(struct boot_sector_info *boot_info, char *dirname)
{
   int i;
   struct dir_table_info dir_info;
   uint8 cappath[FAT_FILE_NAME_LENGTH + 1];
   
   extract_file_name (cappath, dirname, FAT_FILE_NAME_LENGTH);

   // Go though the current directory structure and find a matching entry
   for (i = 0; i < boot_info->max_root_entries; i++)
   {
      read_file_entry (boot_info, i, &dir_info);
      // If this entry is the last entry, the first byte of the filename entry is 0
      if (dir_info.file_name[0] == 0) break;
      if (dir_info.attributes & ATTRIBUTE_DIR)
      {
         if (!memcmp(dir_info.file_name, cappath, FAT_FILE_NAME_LENGTH))
         {
            // Note - For FAT16, starting cluster is at 2
            boot_info->curr_dir_table_loc = boot_info->cluster_start_loc + 
                                            (dir_info.start_cluster - 2) * boot_info->sector_per_cluster;
            printf("Found directory: change working directory to: %x.\n", boot_info->curr_dir_table_loc);
            return TRUE;
         }
      }
   }
   printf("FAILED to locate directory (%s), creating new.\n", cappath);

   // Add the new directory and update information
   if (add_dir(boot_info, dirname))
   {
      return TRUE;
   }
   
   printf("FAILED creating new directory.\n");
   return FALSE;
}


/*================================================================================================

DESCRIPTION
  Add a file into the current directory

PARAMETER
  filename - Name of the file to copy the data from
  
RETURN
  TRUE for success, FALSE otherwise

=================================================================================================*/
int add_file(struct boot_sector_info *boot_info, char *filename)
{
   int i;
   struct dir_table_info fentry;    // Current file entry
   FILE *fpsrc;
   uint8 buf[SECTOR_SIZE];
   uint32 filesize;
   uint32 entry_offset;
   uint32 cpcnt;
   uint32 cpend;
   uint32 cl_progress;
   uint32 next_free_cl;
   uint32 current_cl;
   struct stat filestat;

   // Check the size of the file
   if (stat(filename, &filestat))
   {
      printf ("Error while opening the source file\n");
      return FALSE;
   }

   // Fill in the file entry information structure
   memset (&fentry, 0, sizeof(fentry));
   printf("Incoming file size: %d\n", filestat.st_size);
   cpcnt = filestat.st_size / SECTOR_SIZE;
   cpend = filestat.st_size % SECTOR_SIZE;
   fentry.file_size = filestat.st_size;

   extract_file_name (fentry.file_name, filename, FAT_FILE_NAME_LENGTH);
   fentry.attributes = ATTRIBUTE_ARCHIVE;
   fentry.start_cluster = find_first_free_cluster(boot_info);
   if (fentry.start_cluster == 0)
   {
      printf ("Insufficient disk space to copy data file.\n");
      return FALSE;
   }
   printf ("Adding file to cluster %x.\n", fentry.start_cluster);

   // Open the file and fill the location with data
   fpsrc = fopen (filename, "rb");
   if (fpsrc == NULL)
   {
      printf ("Error while opening incoming data file.\n");
      return FALSE;
   }

   // Calculate location to drop the incoming data
   entry_offset = boot_info->cluster_start_loc + 
                  (fentry.start_cluster - 2) * boot_info->sector_per_cluster;
   
   fseek (mfpin, entry_offset * SECTOR_SIZE, SEEK_SET);

   cl_progress = 0;        // Counting fractional cluster 
   current_cl = fentry.start_cluster;
   for (i = 0; i < cpcnt; i++)
   {
      fread(buf, SECTOR_SIZE, 1, fpsrc);
      fwrite(buf, SECTOR_SIZE, 1, mfpin);
      cl_progress++;
      if (cl_progress >= boot_info->sector_per_cluster)
      {
         update_fat_cluster_entry (boot_info, current_cl, 0xffff);      // Premark the cluster data
         next_free_cl = find_first_free_cluster (boot_info);
         // Check to make sure this is a good cluster
         if (next_free_cl == 0)
         {
            printf ("Insufficient disk space to copy data file.\n");
            goto ERROR_RETURN;
         }
         update_fat_cluster_entry (boot_info, current_cl, next_free_cl);      // Update to actual entry
         current_cl = next_free_cl;
         entry_offset = boot_info->cluster_start_loc + 
                        (current_cl - 2) * boot_info->sector_per_cluster;
         fseek(mfpin, entry_offset * SECTOR_SIZE, SEEK_SET);
         cl_progress = 0;
      }
   }

   if (cpend != 0)
   {
      fread(buf, cpend, 1, fpsrc);
      fwrite(buf, cpend, 1, mfpin);
   }

   update_fat_cluster_entry (boot_info, current_cl, 0xffff);      // End of the cluster chain

   // Update the DIR file table
   add_filetbl_entry(boot_info, &fentry);

   fclose (fpsrc);
   return TRUE;

ERROR_RETURN:
   fclose (fpsrc);
   return FALSE;
}


/*================================================================================================

DESCRIPTION
  Write the File System Information Sector 

PARAMETER
  fp - File pointer where the information sector is written to

=================================================================================================*/
void write_fs_info_sector(struct boot_sector_info *boot_info, FILE *fp)
{
   uint8 buf[SECTOR_SIZE];
   /* Clear out the memory buffer first */
   memset (buf, 0x00, SECTOR_SIZE);

   /* Write the FS info sector signature */
   memcpy (buf, "RRaA", 4);
   memcpy (buf+0x1e4, "rrAa", 4);
   /* Boot record signature */
   buf[0x1fe] = 0x55;      
   buf[0x1ff] = 0xAA;
   /* Recent access information */
   buf[0x1e8] = boot_info->free_cluster & 0xff;
   buf[0x1e9] = (boot_info->free_cluster >> 8) & 0xff;
   buf[0x1ea] = (boot_info->free_cluster >> 16) & 0xff;
   buf[0x1eb] = (boot_info->free_cluster >> 24) & 0xff;

   buf[0x1ec] = boot_info->last_alloc & 0xff;
   buf[0x1ed] = (boot_info->last_alloc >> 8) & 0xff;
   buf[0x1ee] = (boot_info->last_alloc >> 16) & 0xff;
   buf[0x1ef] = (boot_info->last_alloc >> 24) & 0xff;
   
   fseek (fp, boot_info->fs_info_sector, SEEK_SET);
   fwrite (buf, SECTOR_SIZE, 1, fp);
}


/*================================================================================================

DESCRIPTION
  Display the program usage and exit

=================================================================================================*/
void display_usage_n_exit()
{
   printf ("cpfatfs <FAT binary image Name> <Outgoing directory name> <Incoming file name>\n");
   printf ("cpfatfs <FAT binary image Name> <Incoming file name>\n");
   printf ("This program will copy a file into a FAT binary image file\n");
   printf ("The program only support FAT16 file system\n");
   printf ("Omitting outgoing directory name will result in placeing the file in the ROOT directory\n");
   exit (2);
}


/*================================================================================================

DESCRIPTION
  This function is the entry point of the application

RETURN VALUE
  None.

=================================================================================================*/
main(int argc, char *argv[])
{
   struct boot_sector_info boot_sec;
   uint32 disk_size;
   uint8 path[15];
   int fill_length;

   if (argc != 4 && argc != 3)
   {
      display_usage_n_exit();
      return 2;
   }

   /* Open the output file */
   mfpin = fopen (argv[1], "rb+");
   if (mfpin == NULL)
   {
      printf("Unable to open input file '%s'.\n", argv[1]);
      return 1;
   }


   read_boot_structure (&boot_sec);
#ifdef DEBUGMSG
   print_boot_structure (&boot_sec);
#endif

   compute_boot_structure (&boot_sec);

   if (argc == 3)
   {
      // Check the file name to be copied fits the 8.3 requirement - if not, print an warning message
      check_file_name (argv[2]); 
      if (!add_file (&boot_sec, argv[2])) goto ERROR_EXIT;
   }
   else if (argc == 4)
   {
      if (!change_dir (&boot_sec, argv[2])) goto ERROR_EXIT;
      check_file_name (argv[3]); 
      if (!add_file (&boot_sec, argv[3])) goto ERROR_EXIT;
   }

   if (fseek(mfpin, 0, SEEK_END) == 0)
   {
      // Pad image up to next multiple of 512-byte
      fill_length = 512 - (ftell(mfpin) % 512);
      if (fill_length > 0)
      {
         fwrite(buffer_zeroes, fill_length, 1, mfpin);
      }
   }
   return 0;

ERROR_EXIT:
   fclose(mfpin);
   return 1;
}
