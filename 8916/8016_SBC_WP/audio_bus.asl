//
// Copyright (c) 2011-2017, Qualcomm Technologies Inc. All rights reserved.
//
// This file contains the Audio Drivers 
// ACPI device definitions, configuration and look-up tables.
// 

// 
//ADCM
//make ADCM as 1st child of AMSS device.
Device (ADCM)
{
    // HID values are present in Qualcomm.HID.props under <WDKRoot>MSBuild\Qualcomm
    // Parent of ADCM shall defined this ( Refer mproc.asl or slimbus.asl)
    // AMSS in bear family and Slimbus in Badger family makes below entry
    // HID_ACD = QCOM242D
    // Name (_HID, "HID_ACD")
    
    // Address object for acpi device enumerated device (ADCM) on parent device bus
    // Used to identify multiple child if present
    Name (_ADR, 0)
	
    // Method to indicate usage of SMMU by LPASS
    Method (SMMU)
    {
        Name (CFG, Package()
        {
            Package()
            {
                0x0,      // 0 means no SMMU, 1 means SMMU used
                0x0,      // SMMU Start address - don;t care if Smmu is not present
                0x0,      // SMMU End address - don;t care if Smmu is not present
            },
        })
        RETURN(CFG)    
    }  
	
	// ACDB Parameters Info
	Method (ACDB)
	{
		Name (CFG, Package()
		{
			Package()
			{
				0x2000,      // ACDB Data Buffer Size
				0x60,        // audio_device_id_max_num   				
                0x1,         //PVC support status.1-supported 0-not supported
			},
		})
		RETURN(CFG)    
	}
	
        //Avtimer base addresses and time conversions
	Method (AVTI)
	{
		Name (CFG, Package()
		{	
			Package() 
			{
				0x07706000,   // LPASS_LPASS_AVTIMER_BASE
				0x07706010,   // LPASS_AVTIMER_TIMER_MSB
				0x0770600C,   // LPASS_AVTIMER_TIMER_LSB
				0x0000001b,   // Conversion factor while passing back AVTimer ticks, factor=1, for 8974, 8x10, 8x26, 9x25. and 27 for 8916, 9x35, 8994.
			},
		})
		RETURN(CFG)    
	}
	
	//Dolby Package Info.
	Method (DOLI)
	{
		Name (CFG, Package()
		{	
			Package() 
			{
				0x2,     // Licensing method. (0x0 - no license, 0x1 - licenseing with DSP stitching, 0x2 - licenseing with ACDB)
				0x0,     // Dolby_mid
			},
		})
		RETURN(CFG)    
	}
	
	//EBI Memory Info.
	Method (MEMI)
	{
		Name (CFG, Package()
		{	
			// Contiguous PMEM buffer allocation configuration parameters
			// Audio Drivers will query ADCM Driver using IOCTL for getting Contiguous Physical Memory Buffer Configuration like EBI/Cache type
			// Single place for changing these parameters across the audio drivers for a particular chip set
			Package()
			{
				0x8CC00000,   // EBI_Start_Address_LSW
				0,            // EBI_START_Address_MSW
				0xA0000000,	  // EBI_End_Address_LSW
				0,            // EBI_End_Address_MSW
				0,            // Boundary_Address_Multiple_LSW
				0,            // Boundary_Address_Multiple_MSW
				2,            // MEMORY_CACHE_TYPE_WRITE_COMBINED
			},
		})
		RETURN(CFG)    
	}
	

	// Contiguous Physical Memory Pre-allocation Requirements for ADCM Device(CPMR)
	METHOD(CPMR)
	{
		Name(CFG, Package()
		{
			// Memory Configuration
			Package()
			{
				1,          // Memory Allocation Model; Options: 0 - SMMU Approach/1 - Subsystem driver pre-allocation/2 - Internal Allocation (using MmAllocatexxx MSFT API;)
				Buffer()   // Device Interface GUID
				{
					0x4c, 0xa3, 0x51, 0x5f, 0x34, 0x68, 0x9D, 0x47,     // Device Interface GUID: {5F51A34C-6834-479D-9EA2-EAFA622524BA}
					0x9e, 0xa2, 0xea, 0xfa, 0x62, 0x25, 0x24, 0xba      
				},
				1,          // Number of Buffer allocation types
				0,          // SVA Buffer Index
				1,          // Number of Pre-allocated Buffers for SVA
				0x8C000, 	// 560k bytes - Sound Model Library Preallocated buffer size
			},
		})
		Return (CFG)
	}
		
	Method (CHLD)
	{
		Return (Package()
		{
		    // Syntax: Name of Parent Device (ADCM)\\HID value (HID_XXX) of AUDD driver
			// HID values are present in Qualcomm.HID.props under <WDKRoot>MSBuild\Qualcomm
			// HID_AUDD = QCOM242E
			"ADCM\\HID_AUDD"
		})
	}  

//
// AUDD controller
//
Device (AUDD)
{
                // Name (_HID, "QCOM242E")
                // Name (_UID, 1)
                Name (_ADR, 0)
	
		//Name (_DEP, Package(0x2)
                //{
                //	  \_SB_.SLM1,
                //	  \_SB_.ADCM, 
                //	  \_SB_.PEP0
                //})	
	
	Method (_CRS, 0x0, NotSerialized) 
	{
		/*
		* GPIO Definitions
		*/
		
		Name (RBUF, ResourceTemplate () 
		{
			//TOMBAK_DIGITAL_INT_RT_STS 0x0001F010, ID = {slave id}{perph id}{int}
			// Insertion-Removal interrupt. 7th bit = {1}{1111 0000}{111} = 0xF87
			GpioInt(Edge, ActiveHigh, Shared, PullNone, 0, "\\_SB.PM01", , , , ){0xF87}
			//ELECTRICAL_INS_REM_DET.int = 6 = {110} , id = 0xF86
			GpioInt(Edge, ActiveHigh, Exclusive, PullNone, 0, "\\_SB.PM01", , , , ){0xF86}
			// Button press interrupts. int = 5 = {101} , id = 0xF85
			GpioInt(Edge, ActiveHigh, Exclusive, PullNone, 0, "\\_SB.PM01", , , , ){0xF85}
			// Button release interrupt. int = 4 = {100} , id = 0xF84
			GpioInt(Edge, ActiveHigh, Exclusive, PullNone, 0, "\\_SB.PM01", , , , ){0xF84}	
			//ELECTRICAL_INS_REM_DET1. int = 3 = {011} , id = 0xF83
			GpioInt(Edge, ActiveHigh, Exclusive, PullNone, 0, "\\_SB.PM01", , , , ){0xF83}
		})
		
		/*
		* SPMI peripherals
		*/
		Name(NAM, Buffer() {"\\_SB.SPMI"})

		// CODEC_DIGITAL
		Name(PON1, Buffer() 
		{
			0x8E,       // SPB Descriptor
			0x13, 0x00, // Length including NAM above
			0x01,       // +0x00 SPB Descriptor Revision
			0x00,       // +0x01 Resource Source Index
			0xC1,       // +0x02 Bus type - vendor defined values are in the range 0xc0-0xff
			0x02,       // +0x03 Consumer + controller initiated
			0x01, 0xF0, // +0x04 Type specific flags . Slave id, Upper8 bit address
			0x01,       // +0x06 Type specific revision
			0x00, 0x00  // +0x07 type specific data length
						// +0x09 - 0xd bytes for NULL-terminated NAM
						// Length = 0x13
		})

		// CODEC_ANALOG
		Name(PON2, Buffer() 
		{
			0x8E,       // SPB Descriptor
			0x13, 0x00, // Length including NAM above
			0x01,       // +0x00 SPB Descriptor Revision
			0x00,       // +0x01 Resource Source Index
			0xC1,       // +0x02 Bus type - vendor defined values are in the range 0xc0-0xff
			0x02,       // +0x03 Consumer + controller initiated
			0x01, 0xF1, // +0x04 Type specific flags . Slave id, Upper8 bit address
			0x01,       // +0x06 Type specific revision
			0x00, 0x00  // +0x07 type specific data length
						// +0x09 - 0xd bytes for NULL-terminated NAM
						// Length = 0x13
		})

		// unused cores
		// CDC_BOOST_FREQ - 0x01,0xF2 
		// CDC_NCP_FREQ - 0x01,0xF3
		Name(END, Buffer() {0x79, 0x00})
		
		/*Concatenation method used to return a single value from ACPI methods
		//if PON1,PON2,PON3 are resources under NAM and RBUF is another resource used under same Method
		// we can use the below concept to concatenate strings and return a single value 
		// {PON1, NAM, PON2, NAM, PON3, NAM, RBUF} : Resources
		// {Local1, Local2, Local3, RBUF} : After first concatenation
		// {Local4, Local5} : After second level Concatenation
		// {Local0} : Result
		//If we do not use RBUF in above examples and just have resources like
		// PON1, PON2 and PON3 under same segment NAM
		// then we need to concatenate the segment END like stated below
		// {PON1, NAM, PON2, NAM, PON3, NAM, END}
		*/

		Concatenate(PON1, NAM, Local1)
		Concatenate(PON2, NAM, Local2)
		Concatenate(Local1, Local2, Local3)
		Concatenate(Local3, RBUF, Local0)

		Return(Local0)
	}
	
	//Buffer Size method
	Method(BFSZ)
	{
		Name(SIZE, Package()
		{
			2048 //Size of the buffer to read entries from ACPI. The same buffer size will be used to read both GPIO and Power Profiles tables. This entry should be the maximum of the size required by the GPIO Table and the Power Profiles table. 
		})
		Return(SIZE)
	}
	

	//Number of components in PEP 
	Method(PWRC)
	{
		Name(PWRA, Package()
		{
			7
		})
		Return(PWRA)
	}

	//Bus Info method
	Method(BUSI)
	{
		Name(BUSS, Package()
		{
			//Bus type: 0 - SLIMBUS,1 - I2S, 2-AHB_IF, 3-SPMI
			3 ,
			//starting AHBI register address 
			0x200
		})
		Return(BUSS)
	}

	//Word Select Master Info
	Method(WSMI)
	{
		Name(WSMD, Package()
		{
			//WS type: 0 - Codec Slave,1 - Rx Only Codec Master, 2 - Tx only Codec Master, 3 - RX and TX codec Master.
			1 ,
			//Codec BitsperSample - Only valid if Codec is not WS Slave.
			25
		})
		Return(WSMD)
	}

	//Codec Initialization Parameters Info 
	Method(CIPI)
	{
		Name(CIPD, Package()
		{
			1,	//MajorVersion ,1 for Helicon and tombak
			0,	//MinorVersion ,0 for Helicon and tombak
			0,	//IHGPIO ,0 
			0,	//mclk_speed ,0 MCLK_SPD_9_6_MHZ // 1 for MCLK_SPD_12_288_MHZ
			0x010001, //mclk2_speed unused for 1.0. 0x010001=EXT_MCLK2_11_2896_MHZ,0x010002=EXT_MCLK2_22_5792_MHZ,0x010004=EXT_MCLK2_45_1584_MHZ 
            1, //vdd_buck ,0 for VDD_BUCK_1P8V,1 for VDD_BUCK_2P15V,2 for VDD_BUCK_1P8V_2P15V
            0,  // 1= CPE available, 0 = CPE absent			
			0, // Flag to indicate whether VBAT is required. //VBATT Is supported only on 8952 with external tasha lite and 8996 tasha codecs,requires 3.1 codec version	
			//following parameters are unused for major.minor = 1.0
			1, //MBHC required status.
			0, //ignore_irqs
			0, //slaves intf,0 for no slaves, 1 for I2C, 2 for SWR
			1, //prevent swr sleep, 1 for preventing sleep, 0 for allowing swr to sleep
			0, //wcd instance offset
		})
		Return(CIPD)
	}

	// Info on register values that have to be altered
	Method(RPNF)
	{
		Name(REGV, Package()
		{
			//                             
			//          Register address, Mask,     value,    stage (place where it has to be modified in the driver) , muxid/afeportid
			//          stage valid values: DRIVER_INIT = 0,
			//												   DEVICE_ACTIVATE =1
			//												   DEVICE_ENABLE = 2
			//                                                 DEVICE_ACQUIRE = 3
			//                                                 DEVICE_RELEASE = 4
			//                                                 DEVICE_DISABLE = 5
			//                                                 DEVICE_DEACTIVATE =6
			//                                                 DRIVER_DEINIT = 7
			// 								DEVICE_AFE_PCM_I2S_MUX_SELECT = 8
			// 								DEVICE_AFE_PORT_SELECT = 9			
			//         for stage is DEVICE_AFE_PCM_I2S_MUX_SELECT
			//		   Mux id valid values:	PRI_MODE_I2S_PCM_MUXSELECT = 1,
			//  							SEC_MODE_I2S_PCM_MUXSELECT = 2,
			//  							TER_MODE_I2S_PCM_MUXSELECT = 3,
			//  							QUAD_MODE_I2S_PCM_MUXSELECT= 4,	
			//          -----------     --------- 	----     ------------------------
			//Package() { 0x07702004,    	0xFFFFF,  	0x30300,  9 , 0x00001000}, //For primary mi2s mux value: 0x30300
			Package() { 0x07702004,    	0x00000100,  	0x00000100,  0 , 0}, //For primary mi2s mux value: 0x34300
			Package() { 0x07702000,   	0x00220002,  	0x00220002, 0 , 0}, //For Internal codec value: 0x00220002, external codec value: 0x00220002, WSCodecMaster value: 0x00000000
		})
		Return(REGV)
	}

	//GPIO Method
	Method(GPNF)
	{
		//GPIO Table
		Name(GPIO, Package()
		{
			//Format: Package(){GPIOUID, INDEX, INITIALVALUE}
			//GPIO UID: Unique Identification number for GPIOs. GPIOUIDs 0 - 5 is reserved for Tabla Driver internal usage. OEMs can add/remove/change the GPIO UIDS > 5
			//INDEX: Index of the GPIO in the ResourceTemplate
			//INITIALVALUE: Initial Default/Functional Value that the driver needs to set for that particular GPIO, provided it is an output GPIO in the driver
			//
			//************GPIOUID Mappings: **********//
			//GPIOUID    Mapped GPIO
			//--------    -----------
			//   0          RESET (Reserved)

			//Package(){ 0, 0, 0}, //RESET
		})
		Return(GPIO)
	}
	
	Method (CHLD)
	{
		Name(CH, Package()
		{				
				// Syntax: Name of Parent Device (AUDD)\\HID value (HID_XXX) of MBHC driver
				// HID_MBHC = QCOM2468
				"AUDD\\HID_MBHC",
				// Syntax: Name of Parent Device (AUDD)\\HID value (HID_XXX) of QCRT driver
				//HID_QCRT = QCOM2451
				"AUDD\\HID_QCRT",
		})
		Return(CH)
	}

	//Power profiles Method
	Method(PPNF)
	{
		//Power profiles
		Name(PP, Package()
		{
			//Format: Package(){POWER_PROFILE_TYPE , POWER_PACKAGES...}
			//POWER_PROFILE_TYPE: 0 for COMMON_POWER_PROFILES, 1 for DEVICE_SPECIFIC_POWER_PROFILES
			//POWER_PACKAGES: Package(){  GROUPID/DEVICEID , POWERREQUIRED, ... }
			//GROUPID:  0 for Common_Power_Profile, 1 for TX_Group_Common_Power_Profile and 2 for RX_Group_Common_Power_Profile
			//			If none of the device specific power profile is available then one of these power profiles will be applied based on the direction of the device
			//			Common power profile will be anyways applicable to all during bootup.
			//DEVICEID: Device Id defined in AudioDeviceIDs.h for which the Power Profile applies
			//POWERREQUIRED: {POWERTYPE, COMPONENT/GPIO UID/ACPI_METHOD, STAGE} 
			//POWERTYPE: 0 for PEP, 1 for GPIO specified in GPIO package above, 2 for ACPI METHOD, 3 for PMIC CLOCK
			//COMPONENT: Used when POWERTYPE is PEP. Specifies the Component number in PEP.asl
			//              Component 0 is reserved in PEP.asl for managing the following: 
			//                     lcc_cdc_i2s_spkr_osr_clk, TLMMGPIO, PM_VREG_RESOURCE_ID_SMPS5, PM_VREG_RESOURCE_ID_SMPS4, PM_VREG_RESOURCE_ID_LDO11
			//GPIOUID: GPIO defined in Package GPIO above. Should be > 5 as 0 to 5 are reserved for Codec Driver's internal use
			//ACPI_METHOD: Used when Power type is ACPI METHOD Specifies which ACPI method to use
			//Note: the second field is not used the power type is PMIC CLOCK
			//STAGE: Using two stages (New stages need code changes in the driver)
			//           During device bringup: Stage 0: Before Device Acquire, Stage 1: After device Enable
			//           During device teardown: Stage 1: Before Device Disable, Stage 0: After device Release

			//Common Power profiles - If device specific power profile is not defined for a device one of these power profiles will be applied
			  Package()
			  {
				0,		//POWER_PROFILE_TYPE
				Package(){  0, Package(){0, 6, 1}, Package(){3, 21, 1} }, 
			  },
			  Package()
			  {
				2,		//POWER_PROFILE_TYPE
				Package(){  46, Package(){0, 6, 1}, Package(){0,7,1}, Package(){3, 21, 1} }, 
			  },

			//Device Specific Power Profiles

		})
		Return(PP)
	}
// 
//MBHC
//
Device (MBHC)
{
	// Name (_HID, "QCOM2468")    
	// Name (_UID, 0)	
	//Name (_DEP, Package(0x1)
	//{
	//	  \_SB_.AUDD
	//})
	Name (_ADR, 0)

	Method (_CRS, 0x0, NotSerialized) 
	{
		Name (RBUF, ResourceTemplate ()
		{

		})
		Return (RBUF)
	}

	//Buffer Size method
	Method(BFSZ)
	{
		Name(SIZE, Package()
		{
			2048 //Size of the buffer to read entries from ACPI  
		})
		Return(SIZE)
	}


	//GPIO Method
	Method(GPNF)
	{
		//GPIO Table
		Name(GPIO, Package()
		{
			// Format: Package(){ GPIOUID, INDEX, INITIALVALUE}
			// INDEX: Index of the GPIO in the ResourceTemplate in DSDT.ASL
			// GPIO UID: Unique Identification number for GPIOs in MBHC source code
			// INITIALVALUE: Initial Default/Functional Value that the driver needs to set for that particular GPIO, provided it is an output GPIO in the driver
			//
			// GPIOUID Mapping in MBHC SW Driver Code
			// GPIOUID     Mapped GPIO
			// -------     -----------
			// Index 0-3 indicates actual index in DSDT table

		})
		Return(GPIO)
	}
} // end Device (MBHC)

//
//QC - WaveRT
//
Device (QCRT)
{
    //Name (_DEP, Package(0x2)
    //{
    //		\_SB_.ADCM,
    // 		\_SB_.AUDD
    //})
    //Name (_HID, "QCOM2451")

    Name (_ADR, 1)
         
    // Contiguous Physical Memory Allocation Requirements(CPMR) for QCRT(Miniport) Device
	METHOD(CPMR)
	{
		Name(CFG, Package()
        {
            // Memory Configuration
            Package(9)
            {
                1,          // Memory Allocation Model; Options: 0 - SMMU Approach/1 - Subsystem driver pre-allocation/2 - MmAllocatexxx MSFT API;
				Buffer()    // Pre-Allocation Buffer Device Interface GUID
				{
					0x6c, 0x4c, 0x2e, 0x8c, 0x3e, 0xba, 0x5a, 0x41,     // Device Interface GUID: {8C2E4C6C-BA3E-415A-8BC8-33EC5EE7A77C}
					0x8b, 0xc8, 0x33, 0xec, 0x5e, 0xe7, 0xa7, 0x7c      
				},
                2,          // Number of Buffer allocation types
                0,          // MINIPORT_PREALLOCATED_BUFFER_TYPE_OFFLOAD
                1,          // Number of MINIPORT_PREALLOCATED_BUFFER_TYPE_OFFLOAD buffers
                0x31000,    // MINIPORT_PREALLOCATED_BUFFER_TYPE_OFFLOAD buffer size (Includes 8KB internal requirement)
                1,          // MINIPORT_PREALLOCATED_BUFFER_TYPE_HOST
                0,          // Number of MINIPORT_PREALLOCATED_BUFFER_TYPE_HOST buffers, recommended: 2
				0,          // MINIPORT_PREALLOCATED_BUFFER_TYPE_HOST buffer size, recommended: 0x8000
            },
        })
        Return (CFG)
	}
	

} // end Device (QCRT)                  
} // end Device (AUDD)                                                     
} // end Device (ADCM)
