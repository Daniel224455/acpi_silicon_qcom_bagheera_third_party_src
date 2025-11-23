
Scope(\_SB.PEP0)
{

    Method(UIDL)
    {
        Return(NIDL)
    }    

    Name(NIDL,
    package(){
        "MICROPEP_IDLE",
        0x1, 
        
        package(){
            "LPR",
            "A53Core0", // LPR Name
            0x0, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "C1", // Mode name
                0, // Mode Latency
                0, // Mode BreakEven
                0, // Mode Flags
                0, // Mode TZ Flags
                0, // Mode Clock Flags 
            },
    
            package(){
                "MODE",
                "C3", // Mode name
                5000, // Mode Latency
                7500, // Mode BreakEven
                3, // Mode Flags
                0, // Mode TZ Flags
                1, // Mode Clock Flags 
            },
    
        },
    
        package(){
            "LPR",
            "A53Core1", // LPR Name
            0x1, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "C1", // Mode name
                0, // Mode Latency
                0, // Mode BreakEven
                0, // Mode Flags
                0, // Mode TZ Flags
                0, // Mode Clock Flags 
            },
    
            package(){
                "MODE",
                "C3", // Mode name
                5000, // Mode Latency
                7500, // Mode BreakEven
                3, // Mode Flags
                0, // Mode TZ Flags
                1, // Mode Clock Flags 
            },
    
        },
    
        package(){
            "LPR",
            "A53Core2", // LPR Name
            0x2, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "C1", // Mode name
                0, // Mode Latency
                0, // Mode BreakEven
                0, // Mode Flags
                0, // Mode TZ Flags
                0, // Mode Clock Flags 
            },
    
            package(){
                "MODE",
                "C3", // Mode name
                5000, // Mode Latency
                7500, // Mode BreakEven
                3, // Mode Flags
                0, // Mode TZ Flags
                1, // Mode Clock Flags 
            },
    
        },
    
        package(){
            "LPR",
            "A53Core3", // LPR Name
            0x3, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "C1", // Mode name
                0, // Mode Latency
                0, // Mode BreakEven
                0, // Mode Flags
                0, // Mode TZ Flags
                0, // Mode Clock Flags 
            },
    
            package(){
                "MODE",
                "C3", // Mode name
                5000, // Mode Latency
                7500, // Mode BreakEven
                3, // Mode Flags
                0, // Mode TZ Flags
                1, // Mode Clock Flags 
            },
    
        },
    
        package(){
            "LPR",
            "A53L2", // LPR Name
            0xFFFFFFFF, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "D2", // Mode name
                5000, // Mode Latency
                20000, // Mode BreakEven
                0, // Mode Flags
                3, // Mode TZ Flags
                0, // Mode Clock Flags 
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core0", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core0", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core1", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core1", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core2", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core2", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core3", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core3", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
            },
    
            package(){
                "MODE",
                "D2D", // Mode name
                5000, // Mode Latency
                20000, // Mode BreakEven
                16, // Mode Flags
                2, // Mode TZ Flags
                0, // Mode Clock Flags 
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core0", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core0", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core1", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core1", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core2", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core2", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core3", // Dependency LPR
                        "C1", // Dependency Mode
                        7, // Dependency Type
                    },
    
                    package(){
                        "DEPENDENCY",
                        "A53Core3", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
            },
    
            package(){
                "MODE",
                "D3", // Mode name
                5000, // Mode Latency
                50000, // Mode BreakEven
                0, // Mode Flags
                1, // Mode TZ Flags
                4, // Mode Clock Flags 
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core0", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core1", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core2", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53Core3", // Dependency LPR
                        "C3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
            },
    
        },
    
        package(){
            "LPR",
            "platform", // LPR Name
            0xFFFFFFFF, // LPR Core Mask (0xFFFFFFFF is coordinated)
            
            package(){
                "MODE",
                "xo", // Mode name
                10000, // Mode Latency
                330000, // Mode BreakEven
                32, // Mode Flags
                0, // Mode TZ Flags
                16, // Mode Clock Flags 
                package(){
                    "DEPENDENCY_CONTAINER",
                    
                    package(){
                        "DEPENDENCY",
                        "A53L2", // Dependency LPR
                        "D3", // Dependency Mode
                        7, // Dependency Type
                    },
    
                },
    
            },
    
        },
    
    })
    
}
    
