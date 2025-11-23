//
// The PEP Device & Driver Related Configuration
//

Device (PEP0)
{
    Name (_HID, "QCOM2425")
    Name (_CID, "PNP0D80")

    Name(_CRS, ResourceTemplate ()
    {
        // List interrupt resources in the order they are used in PEP_Driver.c

        // TSENS threshold interrupt
        Interrupt(ResourceConsumer, Level, ActiveHigh, ExclusiveAndWake, , , ) {216}

        // Inbound interrupt from rpm:
        //rpm_to_kpss_ipc_irq0 = SYSApcsQgicSpi168 = 200
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {200}

        //rpm_to_kpss_ipc_irq0 = SYSApcsQgicSpi169 = 201   (MPM)
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {201}

        //rpm_to_kpss_ipc_irq0 = SYSApcsQgicSpi171 = 203   (wakeup)
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {203}

        // CPR
        Interrupt(ResourceConsumer, Edge, ActiveHigh, Exclusive, , , ) {47}

    })

    // need 20 char and 1 D state info
    Field(\_SB.ABD.ROP1, BufferAcc, NoLock, Preserve)
    {
        /* Connection Object  - 0x007C is the unique identifier */
        Connection(I2CSerialBus( 0x0001,,0x0,, "\\_SB.ABD",,,,)),
        AccessAs(BufferAcc, AttribRawBytes(21)),
        FLD0, 168
    }
    //Get port to connect to
    Method(GEPT)
    {
        Name(BUFF, Buffer(4){})
        CreateByteField(BUFF, 0x00, STAT)
        CreateWordField(BUFF, 0x02, DATA)
        Store(0x1, DATA) //in this example we will connect to ABDO
        Return(DATA)
    }

    Name(ROST, 0x0)
    // Number of CPUs to Park
    Method(NPUR, 0x1, NotSerialized)
    {
        Store(Arg0, Index(\_SB_.AGR0._PUR, 1))
        Notify(\_SB_.AGR0, 0x80)
    }
    // ACPI method to return intr descriptor
    Method(INTR, 0x0, NotSerialized) {
      Name(RBUF, Package()
          {
          // Version
          0x00000002,
          // Number of hosts
          0x00000001,
          // number of memory regions
          0x00000003,
          // number of IPC registers
          0x00000001,

          // Rpm: APCS_IPC(0)
          // Host = SMEM_RPM
          0x00000006,
          // Physical address
          0x0B011008,
          // Value
          0x00000001,
          // Reserved
          0x00000000,

          // Shared memory
          // Start address
          0x86300000,
          // Size
          0x00100000,
          // Reserved
          0x00000000,
          // Reserved
          0x00000000,

          // MSG RAM
          // Start address
          0x00060000,
          // Size
          0x00004000,
          // Reserved
          0x00000000,
          // Reserved
          0x00000000,

          // IMEM or TZ_WONCE
          // Start address
          0x0193D000,
          // Size
          0x00000008,
          // Reserved
          0x00000000,
          // Reserved
          0x00000000,

          // IPC register 1
          // Physical addr
          0x0B011008,
          // Reserved
          0x00000000,
          // Reserved
          0x00000000,
          // Reserved
          0x00000000,
          })
      Return (RBUF)
    }

    Method(CRTC)
    {
        return (CTRX)
    }

    Name(CTRX,
            Package()
            {
            // Methods (names are reversed) that are critical to
            // system boot
            //"MMVD",         //Method to return Discrete Vreg Mapping Package
            "DSGP",         // System Default Configuration, SDFR
            "NCDA",         // Read the VADC channel names
            "CCGP",         // CPU Configuration
            //"MTPS",         //Read the speaker calibration related parameters
            "CPGP",         //Method to return CPU cap for DCVS Package
            "DMPP",         // PEP resources (usually dummy devices required for power mgmt)
            "GBDL",         // Debugger configuration -- must be below DSGP (reading SDFR)
            "SRDL",         // Default resources -- must be below DSGP (reading SDFR)
        }
    )

    Method(STND)
    {
        return (STNX)
    }

    Name(STNX,
        Package()
        {
            // Power resources for devices
            // Names are reversed (so method OCMD becomes DMCO)
            //
            // Following format must be followed for name:
            // DMxx -- Exists on QCOM SoC. Will use normal PoFX for power mgmt
            // XMxx -- Exists off QCOM SoC and uses legacy power mgmt (_PS1, _PS2, etc)
            //
            // The files where these methods are declared must be included
            // at the bottom of this file and must exists inside the scope: \_SB.PEP0

            //"DMCO",         //OCMEM
            //"DMDS",            //SDC1 Device
            "DMPA",         //AUDIO
            "DMPC",         //CAMERA
            "DMPB",         //COREBSP
            "DMSB",         //BUSES
            "DMPG",         //GRAPHICS
            "DMPS",            //SUBSYSTEMDRIVERS
            "DMRC",         //CRYPTO
            "DMCS",         //SCM
            "DMPL",         //PLATFORM
            //"DMWE",         //EXTERNAL WIRELESS CONNECTIVITY
            "DMMS",         //SMMU
            "DMMT",            //SMMUTestClient
            //"DMTB",         //BAMTestClient
            "DMDQ",         //QDSS
            "XMPN",         //SENSORS
            //"DMPM",         //MSFT
            //"DMPO",         //OEM
              // Method to return ExSoc config packages
          // PEP Get ExSOC package
            // Must declare method + named package pair in relevant *_resources.asl file

            "XMPC", //CAMERA EX-Soc
            "XMPL", // PLATFORM
             })

    Method(ADCN)
    {
        return (VADL)
    }

    Name(VADL,
        Package()
        {
        //   Channel Names       HID's
        // -----------------------------------------
            "PMIC_THERM",    //QCOM248C
            "BATT_THERM",   //QCOM248D
            "PA_THERM",    //QCOM248E
        }

    )

    //
    // Core topology
    //
    Method(CTPM){
        Name( CTPN, package(){
			"CORE_TOPOLOGY",
            4,  // A7SS cluster
        })

        return(CTPN)
    }

    // CPU/Core Configurations Packages
    Name(CCFG,
        Package ()
        {
            //  Post computex cpu names
            Package ()
            {
                "\\_SB.CPU0",
                0x10, // CPU0.
            },
            Package ()
            {
                "\\_SB.CPU1",
                0x11, // CPU1.
            },
            Package ()
            {
                "\\_SB.CPU2",
                0x12, // CPU1.
            },
            Package ()
            {
                "\\_SB.CPU3",
                0x13, // CPU1.
            },
        })


    // Method to return CPU configuration packages
    // PEP Get CPU Configuration
    Method(PGCC)
    {
        Return(CCFG)
    }

    // CPU cap for DCVS Packages
    Name(DCVS,0x0)

    // Method to return CPU cap for DCVS Package
    Method(PGDS)
    {
        Return(DCVS)
    }


    // PPP Supported Resources Package
    Name (PPPP,
    Package()
    {
        // Resource ID                                // Set Interface Type                           // Get Interface Type                           // Test Interface Type
        //------------------------                  -----------------------------------------       -----------------------------------------       -----------------------------------------
        Package() { "PPP_RESOURCE_ID_SMPS1_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_SMPS2_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_SMPS3_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_SMPS4_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },

        Package() { "PPP_RESOURCE_ID_LDO1_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO2_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO3_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO4_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO5_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO6_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO7_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO8_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO9_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO10_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO11_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO12_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO13_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO14_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO15_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO16_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO17_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO18_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO19_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_LDO20_A",                    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },

        Package() { "PPP_RESOURCE_ID_CXO_BUFFERS_BBCLK1_A",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_CXO_BUFFERS_BBCLK2_A",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_CXO_BUFFERS_RFCLK1_A",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_CXO_BUFFERS_RFCLK2_A",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },
        Package() { "PPP_RESOURCE_ID_CXO_BUFFERS_SLEEPCLK1_A",    "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_RPM_TEST", },

        Package() { "PPP_RESOURCE_ID_PMIC_GPIO_DV1",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_PMIC_GPIO_DV2",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_PMIC_GPIO_DV3",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },

        Package() { "PPP_RESOURCE_ID_PMIC_MPP_DV1",                "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_PMIC_MPP_DV2",                "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_PMIC_MPP_DV3",                "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF_TEST", },

        Package() { "PPP_RESOURCE_ID_TLMM_GPIO_DV1",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_TLMM_GPIO_DV2",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF_TEST", },
        Package() { "PPP_RESOURCE_ID_TLMM_GPIO_DV3",            "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF",        "PM_RESOURCE_SERVICE_INTERFACE_TYPE_PMIC_KMDF", "PM_RESOURCE_SERVICE_INTERFACE_TYPE_TLMM_KMDF_TEST", },
    })

    // Method to return PPP Package
    Method(PPPM)
    {
        Return (PPPP)
    }

    // Method to return System Default config packages
    Name (PRRP,
    Package()
    {
        // Resource type range                  Initial supported resource                  Last supported resource
        //--------------------                  --------------------------                  -------------------------
        "PPP_RESOURCE_RANGE_INFO_SMPS_A",          "PPP_RESOURCE_ID_SMPS1_A",                  "PPP_RESOURCE_ID_SMPS4_A",
        "PPP_RESOURCE_RANGE_INFO_LDO_A",           "PPP_RESOURCE_ID_LDO1_A",                   "PPP_RESOURCE_ID_LDO20_A",
        "PPP_RESOURCE_RANGE_INFO_CXO_BUFFERS_A",   "PPP_RESOURCE_ID_CXO_BUFFERS_BBCLK1_A",     "PPP_RESOURCE_ID_CXO_BUFFERS_SLEEPCLK1_A",
        "PPP_RESOURCE_RANGE_INFO_CXO_CLOCK_A",     "PPP_RESOURCE_ID_CXO_CLOCK_A",              "PPP_RESOURCE_ID_CXO_CLOCK_A",
        "PPP_RESOURCE_RANGE_INFO_PMIC_GPIO_DV",    "PPP_RESOURCE_ID_PMIC_GPIO_DV1",            "PPP_RESOURCE_ID_PMIC_GPIO_DV3",
        "PPP_RESOURCE_RANGE_INFO_PMIC_MPP_DV",     "PPP_RESOURCE_ID_PMIC_MPP_DV1",             "PPP_RESOURCE_ID_PMIC_MPP_DV3",
        "PPP_RESOURCE_RANGE_INFO_TLMM_GPIO_DV",    "PPP_RESOURCE_ID_TLMM_GPIO_DV1",            "PPP_RESOURCE_ID_TLMM_GPIO_DV3",

    })

    // Method to return Pep Ppp Resource Range Package
    Method(PPRR)
    {
        Return (PRRP)
    }


    // Method to return System Default config packages
    // PEP Get System Default package
    Method(PGSD)
    {
        Return(SDFR)
    }

    // Full PEP Device Package
    Name(FPDP,0x0)

    // Method to return Full PEP Managed Device List Package
    Method(FPMD)
    {
        Return(FPDP)
    }


    //
    // PEP Processor Performance configuration
    // CPU cap for DCVS Packages
    Name(PPPC,0x0)

    // Method to return CPU cap for DCVS Package
    Method(PGPC)
    {
        Return(PPPC)
    }

    // XO\VDD MIN and Apps Powercollapse LED Package
    //Name(PPLG,0x0)

    // CPR data
    Name(CPRD,
        Package()
        {
            Package()
            {
                Package() { "info", "CPR ACPI config table" },
                Package() { "chip_id", 206 }, // CHIPINFO_ID_MSM8916
                Package() { "chip_version", 1 },
                Package()
                {
                    Package() { "instance_num", 0 },
                    Package() { "num_clients", 1 },
                    Package() { "apc_rail_name", "/vdd/apc0" },
                    Package() { "measurement_period_ms", 5 },
                    Package() { "pmic_step_size", 12500 },
                    Package() { "step_quotient", 26 },
                    Package() { "max_pmic_step_up", 1 },
                    Package() { "max_pmic_step_dn", 1 },
                    Package() { "up_threshold", 0 },
                    Package() { "dn_threshold", 2 },
                    Package() { "consecutive_up", 0 },
                    Package() { "consecutive_dn", 2 },
                    Package() { "clamp_timer_interval", 0 },
                    Package() { "rbcpr_base_addr", 0x0B018000 },
                    Package() { "rbcpr_size", 0x164 },
                    Package() { "security_control_base_addr", 0x00058000 },
                    Package() { "security_control_size", 0x8000 },
                    Package() { "target_quotient_multiplier", 1},
                    Package() { "quotient_offset_multiplier", 1},
                    Package() { "hw_errata_flag", 0 },
                    Package() { "workitem_affinity", 0x0 },
                },
            },
        }
    )

    // Method to return CPR data
    Method(CPRM)
    {
        Return(CPRD)
    }


}

// Data required by PEP
Include("lib_mpm.asl")
Include("pep_libSPM.asl")
Include("pep_vddresources.asl")
Include("pep_dbgSettings.asl")
Include("pep_defaults.asl")
Include("pep_idle.asl")

// Resources by area
Include("audio_resources.asl")
//Include("ocmem_resources.asl")
Include("graphics_resources.asl")
Include("msft_resources.asl")
Include("oem_resources.asl")
Include("subsys_resources.asl")
Include("pep_resources.asl")
Include("corebsp_resources.asl");
Include("cust_touch_resources.asl");
Include("crypto_resources.asl");
Include("scm_resources.asl");
Include("qdss_resources.asl");
Include("BearSmmu_resources.asl");
Include("cust_sensors_resources.asl");
