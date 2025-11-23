Scope(\_SB.PEP0)
{
	Method(LSPM){
        return(NSPM)
    }
    
    Name( NSPM, package(){
			"SPM_CONFIG",
            5, // number of cores
            1, // number of clusters
            package(){
                "SPM_CLUSTER_CONFIG",
                5, // cluster 0
            },
            package(){
                "SPM_PHYS_CONFIG",
                // A53
                0x0B089000, // CLUS0_C0
                0x0B099000,
                0x0B0A9000,
                0x0B0B9000,
                0x0B012000, // L2_0
            },
            package(){
                "SPM_QCHANNEL_CONFIG",
                // A53
                0x00000000, // CLUS0_C0
                0x00000000, 
                0x00000000, 
                0x00000000, 
                0x00000000, // L2_0
            },
            package(){
                "SPM_GLB_CONFIG",
                0x0B011000, // A53 Cluster 
            }
		})
}
