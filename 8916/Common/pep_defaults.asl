/**
 * This file contains default resource information. These are applied at either
 * PEP boot time, on the ScreenOn event or on demand by the PEP driver.
 */
Scope(\_SB.PEP0)
{
    Method(LDRS){
        return(NDRS)
    }
    
    Name( NDRS, 
        /**
         * The default resources package is used by PEP to handle system default resources.
         * Rather than having to declare them all in the SDF declaration, you define resources
         * separately and annotate them by functionality. At runtime, the parsed resources
         * will be placed into separate components within the SDF device node.
         *
         * The expected hiearchy of this package:
         * DEFAULT_RESOURCES
         *      (WORKAROUND|OPTIMIZATION)
         *      String = Name
         *          For debugging and querying -- keep it short
         *      String = "BOOT", "SCREENON", "DEMAND"
         *          When to activate these resources
         *      RESOURCES
         *          The list of resources to activate for this set workaround / optimization
         *
         */
        package(){
            "DEFAULT_RESOURCES",
            
            package()
            {
                "WORKAROUND",
                "OXILI_BLOCK",
                "DEMAND",
                
                package(){
                    "RESOURCES",
                    
                    //workaround on 8916 for QDSS Time stamp issue , Keep OXILI Block ON
                        
                    // Action:       1 == ENABLE
                    //                                   Domain Name          Action
                    //                                   ----------------     ------
                    Package() { "FOOTSWITCH", Package() { "VDD_OXILI",         1    }},
                },
            },
        })
}
