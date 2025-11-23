//
// MPROC Drivers (PIL Driver and Subsystem Drivers)
//

// 
// RPE Crash Dump Injector (CDI) Driver
//
// Note: CDI HW ID on 8974 QCOM245B
Device (CDI)
{
    Name (_DEP, Package(0x2)
    {
        \_SB_.PILC,
        \_SB_.RPEN
    })
    Name (_HID, "HID_CDI")

    //
    // Memory regions to be included in crash dump file for 8916
    //
    Name (RUNS, Package ()
    {
        Package ()
        {
            // Subsystem Name
            "SharedIMEM", 

            //GUID of SharedIMEM Subsystem 
            ToUUID ("6FAE2F68-3B80-4931-8E0E-E30A3580F14C"),

            // Force Ignore
            0,

            // Unlock type
            0,

            // Number of Memory runs
            1, 

            //  First run start address
            0x08600000,

            // First run Size
            0x1000

        }, // end of SharedIMEM region

         Package ()
        {
            // Subsystem Name
            "TZ_LOG", 

            //GUID of TZ_LOG Subsystem 
            ToUUID ("AA795F4D-3B0A-44A4-BB84-B7ECF3EE056A"),

            // Force Ignore
            0,

            // Unlock type
            0,

            // Number of Memory runs
            1, 

            //  First run start address
            0x08600720,

            // First run Size
            0x1000

        }, // end of TZ_LOG region


        Package ()
        {
            // Subsystem Name
            "RPM", 

            //GUID of RPM Subsystem 
            ToUUID ("7F8E50DC-FAD4-4A31-A243-3AB83708E49F"),

            // Force Ignore
            0,

            // Unlock type
            1,

            // Number of Memory runs
            3, 

            //  First run start address
            0x200000,

            // First run Size
            0x24000,

            //  Second run start address
            0x290000,

            // Second run Size
            0x10000,

            //  Third run start address
            0x60000,

            // Third run Size
            0x6000

        }, // end of RPM region      
        
    })

    //
    // CDIC - CDI Configuration
    //
    Name (CDIC, Package ()
    {
        Package ()
        {
            // Clock Management On/Off
            1,
            
            // WDOG On/Off
            1,
            
            // WDOG TMR Base Address
            0x0B017000
        }
    })
}

// 
// RPE Subsystem Notifier (RPEN) 
//
// Note: RPEN HW ID on 8974 QCOM245C
Device (RPEN)
{
    Name (_HID, "HID_RPEN")
}


//
// Peripheral Image Loader (PIL) Driver
//
Device (PILC)
{
    Name (_HID, "HID_PILC")

    Method (ACPO)
    {
        Name(PKGG, Package()
        {
            Package ()
            {
                // Represents MBA subsystem
                0x00000000, // Address
                0x00000000, // Length
                ToUUID ("BA58766D-ABF2-4402-88D7-90AB243F6C77")
            }
        })

        // Copy ACPI globals for Address for this subsystem into above package for use in driver
        Store (RMTB, Index(DeRefOf(Index (PKGG, 0)), 0))
        Store (RMTX, Index(DeRefOf(Index (PKGG, 0)), 1))
        
        Return (PKGG)
    }
    
    //
    // Memory region address and offset of IMEM region
    //
    Method (IMEM)
    {
        Return( Package ()
        {
            0x08600000,
            0x94C
        })
        }

    //
    // MSA image load type info
    //
    Method (MSAL)
    {
        Return( Package ()
        {
            0x01, // MSA image load types (0 Legacy - Encryption enables for MBA and PMI, 1 Raw - Raw MBA Load, 2 Unified Encryption: No decryption calls from PIL)
    })
}

    //
    // PIL Gaint Carveout Memory (PGCM)
    //
    Name (PGCM, Package ()
    {
       Package ()
       {
            0x86800000, // Carveout Base Address
            0x06500000  // Carveout Length
       },
       
    })

    //
    // PILC - PIL General Platform-specific Configuration
    //
    Method (PILC)
    {
        Return( Package ()
        {
            0 // GCC_APCS_CLOCK_BRANCH_ENA_VOTE_PHY
        })
    }
}


//
// ADSP Driver: removed for 8916
//

//
// AMSS Driver: Used for loading the modem binaries
//
Device (AMSS)
{
    Name (_DEP, Package()
    {
        \_SB_.PEP0,
        \_SB_.SMD0,
        \_SB_.PILC,
        \_SB_.RPEN,
    \_SB_.RFS0
    })

    Name (_HID, "HID_AMSS")

    // child devices
    Method (CHLD)
    {
        // EFICHIPINFO_ID_APQ8016 = 247 (see uefi/rel/9.0/edk2/qcompkg/include/protocol/efichipinfo.h)
        If(Lequal(\_SB_.SOID, 247))
        {
            Return ( Package()
            {
                // Don't remove the audio stack on APQ devices
                Package() {"AMSS\\QCOM242D", 0x0000002a, 1,1,1}, 
            })
        }
        else
        {
            Return ( Package()
            {
                // This package is {HWID, Device type (as definied in ntddk.h), Instance ID, Suprise remove on SSR,Child removal type (0-Dont Remove Child, 1-SelfManagedIoCleanup, 2 - Surprise removal)}
                Package() {"AMSS\\QCOM242D", 0x0000002a, 1,1,1}, 
                //MBB
                Package() {"QCMS\\QCOM0EA0", 0x0000002b, 1,0,1}, // For Modem shutdown cases we need to set Child Removal type as 0x01 for MBB
                Package() {"QCMS\\QCOM0EA0", 0x0000002b, 2,0,1},
            })
        }
    }

    // Flag to enable modem shutdown (1 is enabled, 0 is disabled)
    Method (SHUT)
    {
        // EFICHIPINFO_ID_APQ8016 = 247 (see uefi/rel/9.0/edk2/qcompkg/include/protocol/efichipinfo.h)
        If(Lequal(\_SB_.SOID, 247))
        {
            // Modem shutdown is handled by SUBSYS on this platform
            Return ( Package() {1} )
        }
        else
        {
            // Modem shutdown is NOT handled by SUBSYS on this platform
            Return ( Package() {0} )
        }
    }

    // Default SSR Enabled flag (can be overridden via the SSR registry keys)
    Method (SSRE)
    {
        Return ( Package() {1} )
    }

    Method (_CRS, 0x0, NotSerialized)
    {
    Name (RBUF, ResourceTemplate ()
    {
        // Inbound interrupt from Q6SW dog bite:
        // q6ss_wdog_exp_irq = SYS_apcsQgicSPI[24] = 56
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {56}
    })

    Return (RBUF)
    }

   	Method(BUFF)
	{
		 Return (Package()
		 {
			 0x8E700000,  // EBI_Start address
			 0xA0000000,  // EBI_END Address
			 0x0          // Boundary value
		})
	}
   
    //
    // Mappings from performance percentage to thermal mitigation level
    //
    Method (VLMT, 0x0, NotSerialized) {
        Name (RBUF, Package ()
        {
            //           Percent(<=), TM level,
            //           -----        ----------
            Package () { 33,          3 },
            Package () { 66,          2 },
            Package () { 99,          1 },
            Package () { 100,         0 }
        })
        Return (RBUF)
    }

    Include("audio_bus.asl")
}

//
// QMUX
//
Device (QMUX)
{
    Name (_HID, "QCOM244F")
}

//SECTION: BTFTM
Device (FTM0)
{
   Name (_HID, "QCOM2462")
}
//END SECTION: BTFTM

//
// Qualcomm WCN Driver: Used to load Pronto image
//
Device (RIVA)
{
    Name (_DEP, Package()
    {
        \_SB_.PEP0,
        \_SB_.SMD0,
        \_SB_.PILC,
        \_SB_.RPEN
    })
    Name (_HID, "QCOM242A")

    // Pronto WCSS  o_wcss_apss_wdog_bite_and_reset_rdy SYS_apcsQgicSPI[149] 
    //      u_main/u_qgic/spi[149] 181 

    // SS Dogbite interrupt   
    Method (_CRS, 0x0, NotSerialized) 
    {
        Name (RBUF, ResourceTemplate ()
        {
            // Inbound interrupt from wcnss dog bite:
            // marm_dog_expired = SYS_sicSPI(149) = 181
            Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {181}
        })
        Return (RBUF)
    }

    // child devices
    Method (CHLD)
    {
        // Here is where we would define more HWIDs for additional bus components
        Return ( Package()
        {
            // This package is {HWID, Device type (as defined in ntddk.h), Instance ID, Surprise remove on SSR,Child removal type (0-Dont Remove Child, 1-SelfManagedIoCleanup, 2 - Surprise removal)}
            Package() {"QWCN\\QCOM245D", 0x00000041, 1, 1,1},     // Bluetooth
            Package() {"QWCN\\QCOM2450", 0x00000012, 1, 1,1},     // WLAN
            Package() {"QWCN\\QCOM2150", 0x00000025, 1, 1,1},     // FM
        })
    } 

    // Default SSR Enabled flag (can be overridden via the SSR registry keys)
    Method (SSRE)
    {
        Return ( Package() {1} )
    }
    
	OperationRegion(WOPR, 0x80, 0, 0x10)
	Field(WOPR, DWordAcc, NoLock, Preserve)
	{
		, 32, WTRG, 32
	}

    PowerResource(WRST, 0x5, 0x0)  
    {   
        //   
        // Dummy _ON, _OFF, and _STA methods. All power resources must have these   
        // three defined.   
        //   
        Method(_ON, 0x0, NotSerialized)   
        {   
        }   
        Method(_OFF, 0x0, NotSerialized)   
        {   
        }   
        Method(_STA, 0x0, NotSerialized)   
        {   
            Return(0)
        }   
        Method(_RST, 0x0, NotSerialized)   
        {    
            //    
            // Perform reset of the BT, WLAN, and FM devices    
            //
			// NOTE: This OpRegion is for triage purposes only.
			//       The _RST method shouldn't perform any reset
			//       operation as these are handled by the RIVA
			//       device.
			Store(0xABCD, WTRG)
        }  
    } 
 
    // This is a NOOP power resource. It is used as a placeholder to unlink Bluetooth from WLAN and FM PLDR.
    PowerResource(WRS1, 0x5, 0x0)  
    {  
        Method(_ON, 0x0, NotSerialized)  
        {  
        }  
        Method(_OFF, 0x0, NotSerialized)  
        {  
        }  
        Method(_STA, 0x0, NotSerialized)  
        {  
            Return(0)
        }  
        Method(_RST, 0x0, NotSerialized)  
        {    
        }  
    }
 
    // Bluetooth
    Include("wcnss_bt.asl")

    // WLAN
    Include("wcnss_wlan.asl")
        
    // FMT
    Include("wcnss_fm.asl")
}

//
// QMI Service manager
//
Device (QSM)
{
    Name (_HID, "HID_QSM")

    Name (_DEP, Package(0x4)
    {
        \_SB_.SMD0,
        \_SB_.IPC0,
        \_SB_.PILC,
        \_SB_.RPEN
    })

    //
    // DHMS client memory config
    //
    Method (_CRS, 0x0, NotSerialized) {
        Name (RBUF, ResourceTemplate ()
        {
            // UEFI memory bank for DHMS clients
            // Note: must match order of flagged for carveout packages below
            Memory32Fixed(ReadWrite, 0x8CD00000, 0x00600000) 
        })
        Return (RBUF)
    }

    //
    // DHMS client config
    //
    Name (DHMS, Package ()
    {
        //Package () 
        //{
            // Subsystem Name
            //"GPS", 

            // GUID of GPS Memory Region for crashdump
            //ToUUID ("65A7C5AB-EC97-4e09-9C6A-E47F183B22B5"),

            // Max CMA size, 0 = Use carveout
            //0 

        //}, // end of GPS region

        Package ()
        {
            // Subsystem Name
            "Diag", 

            // no crash-dump for diag
            ToUUID ("00000000-0000-0000-0000-000000000000"),

            // Max CMA size, 0 = Use carveout
            0 

        }, // end of Diag region
    })
}

