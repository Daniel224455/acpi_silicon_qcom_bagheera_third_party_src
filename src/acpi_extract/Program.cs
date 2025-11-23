//
// This program will extract the data segment from a DLL. It's is used for
// writing ACPI tables.
// 
// Copyright (c) 2001 - 2008 by QUALCOMM Technologies, Incorporated.  All Rights Reserved.
//

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Runtime.InteropServices;

using BYTE   = System.Byte;
using WORD   = System.UInt16;
using DWORD  = System.UInt32;
using LONG   = System.UInt32;

using UINT8  = System.Byte;
using UINT32 = System.UInt32;
using UINT64 = System.UInt64;

namespace acpi_extract
{
    // WinNT.h
    public unsafe struct IMAGE_DOS_HEADER
    {      // DOS .EXE header
        public WORD e_magic;                     // Magic number
        public WORD e_cblp;                      // Bytes on last page of file
        public WORD e_cp;                        // Pages in file
        public WORD e_crlc;                      // Relocations
        public WORD e_cparhdr;                   // Size of header in paragraphs
        public WORD e_minalloc;                  // Minimum extra paragraphs needed
        public WORD e_maxalloc;                  // Maximum extra paragraphs needed
        public WORD e_ss;                        // Initial (relative) SS value
        public WORD e_sp;                        // Initial SP value
        public WORD e_csum;                      // Checksum
        public WORD e_ip;                        // Initial IP value
        public WORD e_cs;                        // Initial (relative) CS value
        public WORD e_lfarlc;                    // File address of relocation table
        public WORD e_ovno;                      // Overlay number
        public fixed WORD e_res[4];              // Reserved words
        public WORD e_oemid;                     // OEM identifier (for e_oeminfo)
        public WORD e_oeminfo;                   // OEM information; e_oemid specific
        public fixed WORD e_res2[10];            // Reserved words
        public LONG e_lfanew;                    // File address of new exe header
    }

    public struct IMAGE_NT_HEADERS32
    {
        public DWORD Signature;
        public IMAGE_FILE_HEADER FileHeader;
        public IMAGE_OPTIONAL_HEADER32 OptionalHeader;
    }

    public struct IMAGE_FILE_HEADER
    {
        public WORD Machine;
        public WORD NumberOfSections;
        public DWORD TimeDateStamp;
        public DWORD PointerToSymbolTable;
        public DWORD NumberOfSymbols;
        public WORD SizeOfOptionalHeader;
        public WORD Characteristics;
    }

    public unsafe struct IMAGE_OPTIONAL_HEADER32
    {
        //
        // Standard fields.
        //

        public WORD Magic;
        public BYTE MajorLinkerVersion;
        public BYTE MinorLinkerVersion;
        public DWORD SizeOfCode;
        public DWORD SizeOfInitializedData;
        public DWORD SizeOfUninitializedData;
        public DWORD AddressOfEntryPoint;
        public DWORD BaseOfCode;
        public DWORD BaseOfData;

        //
        // NT additional fields.
        //

        public DWORD ImageBase;
        public DWORD SectionAlignment;
        public DWORD FileAlignment;
        public WORD MajorOperatingSystemVersion;
        public WORD MinorOperatingSystemVersion;
        public WORD MajorImageVersion;
        public WORD MinorImageVersion;
        public WORD MajorSubsystemVersion;
        public WORD MinorSubsystemVersion;
        public DWORD Win32VersionValue;
        public DWORD SizeOfImage;
        public DWORD SizeOfHeaders;
        public DWORD CheckSum;
        public WORD Subsystem;
        public WORD DllCharacteristics;
        public DWORD SizeOfStackReserve;
        public DWORD SizeOfStackCommit;
        public DWORD SizeOfHeapReserve;
        public DWORD SizeOfHeapCommit;
        public DWORD LoaderFlags;
        public DWORD NumberOfRvaAndSizes;
        // IMAGE_NUMBEROF_DIRECTORY_ENTRIES == 16
        //public fixed byte DataDirectory[sizeof(IMAGE_DATA_DIRECTORY)*16];

        //public fixed IMAGE_DATA_DIRECTORY DataDirectory[16];

        public IMAGE_DATA_DIRECTORY DataDirectory0;
        public IMAGE_DATA_DIRECTORY DataDirectory1;
        public IMAGE_DATA_DIRECTORY DataDirectory2;
        public IMAGE_DATA_DIRECTORY DataDirectory3;
        public IMAGE_DATA_DIRECTORY DataDirectory4;
        public IMAGE_DATA_DIRECTORY DataDirectory5;
        public IMAGE_DATA_DIRECTORY DataDirectory6;
        public IMAGE_DATA_DIRECTORY DataDirectory7;
        public IMAGE_DATA_DIRECTORY DataDirectory8;
        public IMAGE_DATA_DIRECTORY DataDirectory9;
        public IMAGE_DATA_DIRECTORY DataDirectory10;
        public IMAGE_DATA_DIRECTORY DataDirectory11;
        public IMAGE_DATA_DIRECTORY DataDirectory12;
        public IMAGE_DATA_DIRECTORY DataDirectory13;
        public IMAGE_DATA_DIRECTORY DataDirectory14;
        public IMAGE_DATA_DIRECTORY DataDirectory15;
    }

    public struct IMAGE_DATA_DIRECTORY
    {
        public uint VirtualAddress;
        public uint Size;
    }

    public unsafe struct IMAGE_SECTION_HEADER
    {
        public fixed BYTE Name[8];
        [StructLayout(LayoutKind.Explicit)]
        public struct _Misc
        {
            [FieldOffset(0)]
            public DWORD PhysicalAddress;
            [FieldOffset(0)]
            public DWORD VirtualSize;
        }
        public _Misc Misc;
        public DWORD VirtualAddress;
        public DWORD SizeOfRawData;
        public DWORD PointerToRawData;
        public DWORD PointerToRelocations;
        public DWORD PointerToLinenumbers;
        public WORD NumberOfRelocations;
        public WORD NumberOfLinenumbers;
        public DWORD Characteristics;
    }

    public unsafe struct ACPI_HEADER
    {
        public UINT32 Signature;
        public UINT32 Length;
        public UINT8 Revision;
        public UINT8 Checksum;
        public fixed UINT8 OEMID[6];
        public UINT64 OEMTableID;
        public UINT32 OEMRevision;
        public UINT32 CreatorID;
        public UINT32 CreatorRevision;
    }

    class Program
    {
        public const ushort IMAGE_FILE_MACHINE_THUMB = 0x01c2;
        public const ushort IMAGE_FILE_MACHINE_ARM   = 0x01c0;     // ARM Little-Endian
        public const ushort IMAGE_FILE_MACHINE_ARMV7 = 0x01c4;     // TODO: V7 is a guess - verify
        public const ushort IMAGE_DOS_SIGNATURE      = 0x5A4D;     // MZ

        static unsafe void Main(string[] args)
        {
            if (args.Length != 2)
            {
                throw new Exception("Usage: extract_acpi.exe <input file path> <output file Path>");
            }

            FileInfo fi = new FileInfo(args[0]);
            byte[] buffer = new byte[fi.Length];
            FileStream fs = File.OpenRead(args[0]);
            fs.Read(buffer, 0, buffer.Length);
            fs.Close();

            fixed (byte* pBuffer = buffer)
            {
                IMAGE_DOS_HEADER* pImageDosHeader = (IMAGE_DOS_HEADER*)pBuffer;

                if (pImageDosHeader->e_magic != IMAGE_DOS_SIGNATURE)
                {
                    throw new Exception("Unexpected file type: " + pImageDosHeader->e_magic);
                }

                IMAGE_NT_HEADERS32* pImageNtHeaders = (IMAGE_NT_HEADERS32*)(pImageDosHeader->e_lfanew + pBuffer);

                if (pImageNtHeaders->FileHeader.Machine != IMAGE_FILE_MACHINE_THUMB &&
                    pImageNtHeaders->FileHeader.Machine != IMAGE_FILE_MACHINE_ARM &&
                    pImageNtHeaders->FileHeader.Machine != IMAGE_FILE_MACHINE_ARMV7
                    )
                {
                    throw new Exception("Unexpected machine type: " + pImageNtHeaders->FileHeader.Machine);
                }

                byte* p = (byte*)&(pImageNtHeaders->OptionalHeader);
                p += sizeof(IMAGE_OPTIONAL_HEADER32);
                IMAGE_SECTION_HEADER* pImageSectionHeader = (IMAGE_SECTION_HEADER*)p;

                int i = 0;
                for (; i < pImageNtHeaders->FileHeader.NumberOfSections; i++)
                {
                    if ((
                        (char)pImageSectionHeader->Name[0] == '.' &&
                        (char)pImageSectionHeader->Name[1] == 'd' &&
                        (char)pImageSectionHeader->Name[2] == 'a' &&
                        (char)pImageSectionHeader->Name[3] == 't' &&
                        (char)pImageSectionHeader->Name[4] == 'a'
                        ))
                    {
                        byte* pTable = (byte*)pBuffer + pImageSectionHeader->PointerToRawData;
                        ACPI_HEADER* pHeader = (ACPI_HEADER*)pTable;

                        if (pHeader->Length > pImageSectionHeader->SizeOfRawData)
                        {
                            throw new Exception("Corrupt table!");
                        }

                        DWORD sectionSize = 0;
                        if (pImageSectionHeader->Misc.VirtualSize < pImageSectionHeader->SizeOfRawData)
                        {
                            sectionSize = pImageSectionHeader->Misc.VirtualSize;
                        }
                        else
                        {
                            sectionSize = pImageSectionHeader->SizeOfRawData;
                        }

                        FileStream fsOut = File.Open(args[1], FileMode.Create);
                        fsOut.Write(buffer, (int)(pTable - pBuffer), (int)sectionSize);
                        fsOut.Close();

                        break;
                    }

                    pImageSectionHeader++;
                }

                if (pImageNtHeaders->FileHeader.NumberOfSections == i)
                {
                    throw new Exception("Table not found!");
                }
            }
        }
    }
}
