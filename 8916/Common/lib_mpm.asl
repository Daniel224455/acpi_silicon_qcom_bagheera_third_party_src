Scope(\_SB.PEP0)
{
	Method(LMPM){
        return(NMPM)
    }
    
    Name( NMPM, package(){
			
            package(){
                "MPM_SCALAR_CONFIG",
                package(){
                    /// RPM msg ram
                    0x00060000, //< Base physical address
                    0x00004000, //< Map Size
                    
                    /// vMPM interrupt
                    0x0B011000, //< APCS_ALIAS0_APSS_GLB
                    0x00001000, //< GLB map size
                    
                    /// vMPM data structures offset
                    /// in RPM msg ram
                    0x000001D0, 
                }
            },
            
            package(){
                "MPM_INTERRUPT_CONFIG",
                package(){
                    /// Data Format:
                    /// { MPM_IRQ, LOCAL_IRQ, IRQ_TYPE, TRIGGER_TYPE, [optional] TRIGGER_OVERRIDE }
                    ///
                    /// @param MPM_IRQ                  MPM Irq number (0-63)
                    /// @param LOCAL_IRQ                GPIO or QGIC IRQ number
                    /// @param IRQ_TYPE                 0 for QGIC, 1 for GPIO
                    ///
                    /// @param TRIGGER_TYPE             0-4; Set when MPM is init; will be overriden by HLOS values
                    ///                                 0 = LEVEL_LOW
                    ///                                 1 = RISING_EDGE
                    ///                                 2 = FALLING_EDGE
                    ///                                 3 = DUAL_EDGE
                    ///                                 4 = LEVEL HIGH
                    ///
                    /// @param [opt] TRIGGER_OVERRIDE   0-1
                    ///                                 0 = Program with HLOS given trigger type
                    ///                                 1 = Program with trigger type listed here
                    
                    /// @todo   Fill these in with correct values during MPM bringup/verification
                    ///         Expected wakeup sources are USB, SDC and Power Button
                    
                    package(){ 28,  38, 1, 4 }, // MPM_MPM_SDCard Detection GPIO#38
                    package(){ 62, 222, 0, 4 }, // MPM_MPM_SPMI_WAKE_ISR
                }
            },
        })
}