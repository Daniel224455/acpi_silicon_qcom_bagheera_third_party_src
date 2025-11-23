Scope(\_SB.PEP0)
{
	
    Method(LVDD){
		return(NVDD)
	}
	Name( NVDD, package(){

			package(){
                "PEP_VDD_CX",
                package(){
					"PPP_RESOURCE_ID_SMPS1_A",  // Resource Name 
					2,  // Resource Type : SMPS is 2 and LDO is 1 
					7,  // Total no of Corners 
					4,  // Default Corner vote 
					//Data Format :
					//{   		voltage, peak current,software_enable,pin_enable,software_power_mode, pin_power_mode ,bypass_mode , freq ,freq_reason , quiet_mode , corner_level ,head_room } 
                    package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 1             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 1             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 2             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 3             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 4             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 5             , 0      ,},
					package(){   0     ,  0          , 1             , 0        , 0                 , 0              , 0          , 5    , 0          , 0          , 6             , 0      ,},
					
                }
            },
			package(){
                "PEP_VDD_MX",
                package(){
					"PPP_RESOURCE_ID_LDO3_A",  // Resource Name 
					1,  // Resource Type : SMPS is 2 and LDO is 1 
					7,  // Total no of Corners 
					6,  // Default Corner vote 
					//Data Format :
					//{   		voltage, peak current,software_enable,pin_enable,software_power_mode, pin_power_mode ,bypass_enable  , corner_level,  head_room } 
                    package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 1              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 1              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 2              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 3              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 4              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 5              , 0      ,},
					package(){     0,       0     ,      1             , 0        , 0                 , 0              , 1           , 6              , 0      ,},
					
                }
            },
			package(){
                "PEP_VDD_HFPLL",
                package(){
					"PPP_RESOURCE_ID_LDO7_A",  // Resource Name 
					1,  // Resource Type : SMPS is 2 and LDO is 1 
					3,  // Total no of Corners 
					1,  // Default Corner vote 
					//Data Format :
					//{   		voltage, peak current,software_enable,pin_enable,software_power_mode, pin_power_mode ,bypass_enable , head_room } 
					package(){   0      ,  0          , 0             , 0        , 0                 , 0              , 0          ,  0      ,},
					package(){   1800000,  1800       , 1             , 0        , 0                 , 0              , 0          ,  0      ,},
					package(){   1800000,  19000      , 1             , 0        , 0                 , 0              , 0          ,  0      ,},
                }
            },
	})
}
