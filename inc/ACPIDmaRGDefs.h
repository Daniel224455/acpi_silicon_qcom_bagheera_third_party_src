/*++

Copyright (c) 2011, Qualcomm Technologies Inc. All rights reserved.


Module Name:

    ACPIDmaRG.h

Abstract:

    Definitions for the DMA Resource Group in the CSRT

Author:

    Muralidhar Krishnamoorthy 06-22-2011

Environment:

    Firmware.

Revision History:

--*/

#pragma once

#pragma pack(push, 1)

#define BAM_MAX_EE 4

#define CSRT_RG_DEVICE_ID_DMA        0x1002
#define CSRT_RG_DEVICE_ID_DMA_BAM    0x1005

/* DMA Resource Group Version
   -- Change this if the ADM DMA Resource Group
   -- changes 
 */ 
#define ADM_RG_REV 0 

/* Bam DMA Resource Group Version 
   -- Change this if any of the elements defined for the BAM Resource Group 
   -- changes.
*/ 
#define BAM_RG_REV 0 

//------------------------------------------------------------------------
// DMA ADM Resource Group
//------------------------------------------------------------------------

/*
 * number of CRCIs available on ADM3 contollers
 */
#define ADM_CRCI_NUM 16

/*
 * ADM controller resource descriptor
 */
typedef struct {
    CSRT_RESOURCE_DESCRIPTOR_HEADER Header;
    UINT32 AdmInd;
    UINT64 Address;
    UINT32 Gsi;
    UINT32 ChannelCount;
    UINT32 MinimumRequestLine;
    UINT32 MaximumRequestLine;
} RD_ADM;

/*
 * ADM channel resource descriptor
 */
typedef struct {
    CSRT_RESOURCE_DESCRIPTOR_HEADER Header;
    UINT32 AdmInd;
    UINT32 ChannelInd;
    UINT32 CrciMask;
} RD_ADM_CHAN;

/*
 * Resource Descriptor Macro for ADM contoller
 */
#define RD_ADM_DEF(_ID, _IND, _ADDR, _GSI, _CHAN_CNT, _MIN_REQ_LINE)      \
    sizeof(RD_ADM),                                                       \
    CSRT_RD_TYPE_DMA,                                                     \
    CSRT_RD_SUBTYPE_DMA_CONTROLLER,                                       \
    _ID,                         /* ADM contoleer resource ID */          \
    _IND,                        /* ADM contoleer index */                \
    _ADDR,                       /* Base physicaladdress of ADM */        \
    _GSI,                        /* ADM interrupt ID */                   \
    _CHAN_CNT,                   /* number of channels */                 \
    _MIN_REQ_LINE,               /* min reuqest line */                   \
    _MIN_REQ_LINE+ADM_CRCI_NUM-1 /* max reuqest line */                   \

/*
 * Resource Descriptor Macro for ADM channel
 */
#define RD_ADM_CHAN_DEF(_ID, _ADM_IND, _CHAN_IND, _CRCI_MASK)             \
    sizeof(RD_ADM_CHAN),                                                  \
    CSRT_RD_TYPE_DMA,                                          \
    CSRT_RD_SUBTYPE_DMA_CHANNEL,                               \
    _ID,                         /* channel resource ID */                \
    _ADM_IND,                    /* ADM contoleer index */                \
    _CHAN_IND,                   /* channel index within controller */    \
    _CRCI_MASK                   /* mask of mapped CRCIs */               \


//------------------------------------------------------------------------
// DMA BAM Resource Group
//------------------------------------------------------------------------

/*
 * Type of the BAM device - required to perform additional configurations
 */
typedef enum {
    BAM_TYPE_NONE=0,   /* Ordinary BAM */
    BAM_TYPE_DML=1,    /* BAM with Peripheral DML interface */
    BAM_TYPE_DMA=2,    /* BAM with DMA loopback engine*/
    BAM_TYPE_FORCE32BIT=0xFFFFFFFF
}BAM_TYPE;

/*
 * Resource Descriptor for a BAM Device
 */

typedef struct _RD_BAM{
   CSRT_RESOURCE_DESCRIPTOR_HEADER Header;
   BAM_TYPE Type;        /* Type of peripheral associated with the BAM */
   UINT64 PeriphAddress;  /* Base Address of the peripheral that needs special config */
   UINT32 PeriphSize;     /* Size of the peripheral in bytes */
   UINT64 Address;       /* Base Address of the BAM */
   UINT32 Size;          /* Size of the BAM in bytes */
   UINT32 Irq;           /* IRQ number of the BAM */
   UINT32 ExecEnv;       /* Execution Environment Index of the BAM */
   UINT32 MinRequestLine; /* System-wide unique Minimum Request Line */
   UINT32 MaxRequestLine; /* System-wide unique Maximum Request Line */
}RD_BAM, *PRD_BAM;

typedef struct _SECBAMCFG
{
    UINT32 PipeMask;  /* Mask of the Pipes belonging to an EE */
    UINT32 Vmid;      /* Vmid of the EE */
}SECBAM_CFG, *PSECBAM_CFG;

typedef struct _RD_SECBAM
{
    RD_BAM RdBam;          /* Default Resource Descriptor of BAM */
    UINT32 NumExecEnvs;    /* Maximum number of EEs supported by the BAM */
    SECBAM_CFG SecCfg[BAM_MAX_EE]; /* Security config for each EE */
}RD_SECBAM, *PRD_SECBAM;

/*
 * Mode to indicate Producer or Consumer in System or BAM Mode
 */
typedef enum
{
	PRODUCER = 0x1, /* The pipe can be written (producer mode) */
	CONSUMER = 0x0  /* The pipe can be read (consumer mode) */
}BAM_DIR_TYPE;

/*
 * Operating Mode for a BAM Device
 */
typedef enum
{
    BAM2BAM = 0x0,   /* The pipe operates in Bam2Bam mode */
    SYSTEM  = 0x1     /* The pipe operates in System mode */
}BAM_MODE_TYPE;

/*
 * Resource Descriptor for a BAM Pipe
 */
typedef struct _RD_BAM_PIPE{
   CSRT_RESOURCE_DESCRIPTOR_HEADER Header;
   UINT32       PipeIndex;     /* Index of the pipe                                */
   BAM_DIR_TYPE Direction;     /* Direction of the pipe - Producer or Consumer     */
   BAM_MODE_TYPE Mode;          /* Mode of the Pipe - System or Bam2Bam             */
   UINT32       IrqMask;       /* IRQ Mask - Default :                             */
   UINT32       DescFifoSize;  /* Size of the descriptor FIFO                      */
   UINT32       DataFifoAddrPa;/* Size of the data FIFO - Only for BAM to BAM Mode */
   UINT32       DataFifoSize;  /* Addr of the data FIFO - Only for BAM to BAM Mode */  
}RD_BAM_PIPE, *PRD_BAM_PIPE;

/*
 * Resource Group CSRT Header Macro for the BAM Group
 */
#define RG_BAM_HEADER(_TYPE, _DEVID, _SHARED_SIZE) \
    sizeof(_TYPE),                  /* Resource Group Length */\
    SIGNATURE4('Q','C','O','M'),    /* VendorId              */\
    0,                              /* SubvendorId           */\
    _DEVID,                         /* DeviceId              */\
    0,                              /* SubdeviceId           */\
    BAM_RG_REV,                              /* Revision              */\
    0,                              /* Reserved              */\
    _SHARED_SIZE                    /* Size of shared area   */\


/*
 * Resource Descriptor CSRT Header Macro for a BAM Device
 */
#define RD_BAM_HEADER_DEF(_TYPEDEF, _TYPE, _SUBTYPE, _GUID) \
   sizeof(_TYPEDEF),                             /* Length of Descriptor, including size of header. */ \
   CSRT_RD_TYPE_##_TYPE,               /* Type, one of ACPI_CSRT_RESOURCE_TYPE_*          */ \
   CSRT_RD_SUBTYPE_##_TYPE##_##_SUBTYPE, /* Subtype, one of ACPI_CSRT_RESOURCE_SUBTYPE_     */ \
   _GUID                                         /* Unique (within Resource Group) Identifier       */

/*
 * Resource Descriptor Macro for a BAM Device
 */
#define RD_BAM_DEF(_GUID, _BAMTYPE, _PERIPHADDR, _PERIPHSIZE, _ADDR, _SIZE, _IRQ,_EE, _MINREQ,_MAXREQ) \
   RD_BAM_HEADER_DEF(RD_BAM,DMA,CONTROLLER,_GUID),                        \
   _BAMTYPE,  /* Type of peripheral associated with the BAM */               \
   _PERIPHADDR,/* Base Address of the peripheral that needs special config */ \
   _PERIPHSIZE,/* Size of the peripheral in bytes */ \
   _ADDR, /* Base Address of the BAM */                \
   _SIZE, /* Size of the BAM in bytes */ \
   _IRQ,  /* IRQ number of the BAM */                  \
   _EE,    /* Execution Environment Index of the BAM */ \
   _MINREQ, /* System-wide unique Minimum Request Line */ \
   _MAXREQ  /* System-wide unique Maximum Request Line */ 

#define RD_SECBAM_DEF(_GUID, _BAMTYPE, _PERIPHADDR, _PERIPHSIZE, _ADDR, _SIZE, _IRQ,_EE, _MINREQ,_MAXREQ) \
   RD_BAM_HEADER_DEF(RD_SECBAM,DMA,CONTROLLER,_GUID),                        \
   _BAMTYPE,  /* Type of peripheral associated with the BAM */               \
   _PERIPHADDR,/* Base Address of the peripheral that needs special config */ \
   _PERIPHSIZE,/* Size of the peripheral in bytes */ \
   _ADDR, /* Base Address of the BAM */                \
   _SIZE, /* Size of the BAM in bytes */ \
   _IRQ,  /* IRQ number of the BAM */                  \
   _EE,    /* Execution Environment Index of the BAM */ \
   _MINREQ, /* System-wide unique Minimum Request Line */ \
   _MAXREQ  /* System-wide unique Maximum Request Line */ 

#define RD_SECBAM_CFG(_NUM_EES, _EE0_PMASK, _EE0_VMID, _EE1_PMASK, _EE1_VMID, _EE2_PMASK, _EE2_VMID, _EE3_PMASK, _EE3_VMID) \
    _NUM_EES,   /* */ \
    _EE0_PMASK, /* Mask of pipes belonging to EE0 */ \
    _EE0_VMID,  /* VMID for EE0 */ \
    _EE1_PMASK, /* Mask of pipes belonging to EE1 */ \
    _EE1_VMID,  /* VMID for EE1 */ \
    _EE2_PMASK, /* Mask of pipes belonging to EE2 */ \
    _EE2_VMID,  /* VMID for EE2 */ \
    _EE3_PMASK, /* Mask of pipes belonging to EE3 */ \
    _EE3_VMID   /* VMID for EE3 */

/*
 * Resource Descriptor Macro for a BAM Pipe
 */
#define RD_BAM_PIPE_DEF(_GUID, _PIPENUM,_DIR,_MODE,_IRQMASK,_DESCSIZE,_DATAPA,_DATASIZE) \
    RD_BAM_HEADER_DEF(RD_BAM_PIPE,DMA,CHANNEL,_GUID),                        \
    _PIPENUM,        /* Index of the pipe                                */ \
    _DIR,            /* Direction of the pipe - Producer or Consumer     */ \
    _MODE,           /* Mode of the Pipe - System or Bam2Bam             */ \
    _IRQMASK,        /* IRQ Mask - Default :                             */ \
    _DESCSIZE,       /* Size of the descriptor FIFO                      */ \
    _DATAPA,         /* Size of the data FIFO - Only for BAM to BAM Mode */ \
    _DATASIZE        /* Addr of the data FIFO - Only for BAM to BAM Mode */ 

#pragma pack(pop)

