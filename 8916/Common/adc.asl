/*============================================================================
  FILE:         adc.asl

  OVERVIEW:     This file contains the board-specific configuration info for
                ADC1 - qcadc analog-to-digital converter (ADC): ACPI device
                definitions, interrupt configurations, channel configurations,
                scaling functions, look-up tables, etc.

  DEPENDENCIES: None

                Copyright (c) 2013-2014 Qualcomm Technologies, Inc.
                All Rights Reserved.
                Qualcomm Technologies Confidential and Proprietary.
============================================================================*/
/*============================================================================
  EDIT HISTORY FOR MODULE

  This section contains comments describing changes made to the module.
  Notice that changes are listed in reverse chronological order.  Please
  use ISO format for dates.

  $Header: //source/qcom/qct/platform/winmobile/EA/workspaces/adc.asl#1 $

  when        who  what, where, why
  ----------  ---  -----------------------------------------------------------
  2014-09-24  jjo  Update thermistor polling period to 1 sec.
  2013-12-06  SA  Initial version.

============================================================================*/

/*----------------------------------------------------------------------------
 * QCADC
 * -------------------------------------------------------------------------*/

Device (ADC1)
{
   /*----------------------------------------------------------------------------
    * Dependencies
    * -------------------------------------------------------------------------*/
   Name (_DEP, Package(0x2)
   {
      \_SB_.SPMI,
      \_SB_.PMIC
   })

   /*----------------------------------------------------------------------------
    * HID
    * -------------------------------------------------------------------------*/
   Name (_HID, "QCOM240F")

   /*----------------------------------------------------------------------------
    * ADC Resources
    * -------------------------------------------------------------------------*/
   Method(_CRS)
   {
      /*
       * Interrupts
       */
      Name (INTB, ResourceTemplate()
      {
         // VAdc - EOC
         // ID = {slave id}{perph id}{int} = {0}{0011 0001}{000} = 0x188
         GpioInt(Edge, ActiveHigh, ExclusiveAndWake, PullUp, 0, "\\_SB.PM01", , , , RawDataBuffer(){0x2}){0x188}

         // VAdc TM - All interrupts
         // ID = {slave id}{perph id}{int} = {0}{0011 0100}{000} = 0x1A0
         GpioInt(Edge, ActiveHigh, ExclusiveAndWake, PullUp, 0, "\\_SB.PM01", , , , RawDataBuffer(){0x3}){0x1A0}
      })

      /*
       * SPMI peripherals
       */
      Name(NAM, Buffer() {"\\_SB.SPMI"})

      // VAdc
      Name(PON1, Buffer()
      {
            0x8E,       // SPB Descriptor
            0x13, 0x00, // Length including NAM above
            0x01,       // +0x00 SPB Descriptor Revision
            0x00,       // +0x01 Resource Source Index
            0xC1,       // +0x02 Bus type - vendor defined values are in the range 0xc0-0xff
            0x02,       // +0x03 Consumer + controller initiated
            0x00, 0x31, // +0x04 Type specific flags . Slave id, Upper8 bit address
            0x01,       // +0x06 Type specific revision
            0x00, 0x00  // +0x07 type specific data length
                        // +0x09 - 0xd bytes for NULL-terminated NAM
                        // Length = 0x13
      })

      // VAdc TM
      Name(PON2, Buffer()
      {
            0x8E,       // SPB Descriptor
            0x13, 0x00, // Length including NAM above
            0x01,       // +0x00 SPB Descriptor Revision
            0x00,       // +0x01 Resource Source Index
            0xC1,       // +0x02 Bus type - vendor defined values are in the range 0xc0-0xff
            0x02,       // +0x03 Consumer + controller initiated
            0x00, 0x34, // +0x04 Type specific flags . Slave id, Upper8 bit address
            0x01,       // +0x06 Type specific revision
            0x00, 0x00  // +0x07 type specific data length
                        // +0x09 - 0xd bytes for NULL-terminated NAM
                        // Length = 0x13
      })

      Name(END, Buffer() {0x79, 0x00})

      /* Without interrupts use this because END needs added
      // {PON1, NAM, PON2, NAM, PON3, NAM, END}
      // {Local1, Local2, Local3, END}
      // {Local4, Local5}
      // {Local0}
      Concatenate(PON1, NAM, Local1)
      Concatenate(PON2, NAM, Local2)
      Concatenate(PON3, NAM, Local3)
      Concatenate(Local1, Local2, Local4)
      Concatenate(Local3, END, Local5)
      Concatenate(Local4, Local5, Local0)
      */

      // {PON1, NAM, PON2, NAM, PON3, NAM, INTB}
      // {Local1, Local2, Local3, INTB}
      // {Local4, Local5}
      // {Local0}
      Concatenate(PON1, NAM, Local1)
      Concatenate(PON2, NAM, Local2)
      //Concatenate(PON3, NAM, Local3)
      Concatenate(Local1, Local2, Local3)
      Concatenate(Local3, INTB, Local0)
      //Concatenate(Local4, Local5, Local0)

      Return(Local0)
   }

   /*----------------------------------------------------------------------------
    * Device configuration
    * -------------------------------------------------------------------------*/
   /*
    * General ADC properties
    *
    * bHasVAdc:
    *    Whether or not TM is supported.
    *    0 - Not supported
    *    1 - Supported
    *
    * bHasTM:
    *    Whether or not TM is supported.
    *    0 - Not supported
    *    1 - Supported
    *
    * bHasIAdc:
    *    Whether or not IADC is supported.
    *    0 - Not supported
    *    1 - Supported
    *
    */
   Method (ADDV)
   {
      Return (Package()
      {
         /* .bHasVAdc     */ 1,
         /* .bHasTM       */ 1,
         /* .bHasIAdc     */ 0,
      })
   }

   /*----------------------------------------------------------------------------
    * Voltage ADC (VADC) Configuration
    * -------------------------------------------------------------------------*/
   /*
    * General VADC properties
    *
    * uMasterID:
    *    Master ID to send the interrupt to.
    *
    * uSlaveID:
    *    PMIC which has the VAdc.
    *
    * bUsesInterrupts:
    *    End-of-conversion interrupt mode.
    *    0 - Polling mode
    *    1 - Interrupt mode
    *
    * uMinDigMinor:
    *    Minimum digital version.
    *
    * uMinDigMajor:
    *    Minimum digital version.
    *
    * uMinAnaMinor:
    *    Minimum analog version.
    *
    * uMinAnaMajor:
    *    Minimum analog version.
    *
    * uPerphType:
    *    ADC peripheral type.
    *
    * uPerphSubType:
    *    VADC peripheral subtype.
    *
    * uVrefP_mv:
    *    Positive reference in millivolts for ratiometric cal.
    *
    * uVrefN_mv:
    *    Negative reference in millivolts for ratiometric cal.
    *
    * uVref1_mv:
    *    Reference voltage in millivolts for absolulte cal.
    *    uVref1_mv < uVref2_mv
    *
    * uVref2_mv:
    *    Reference voltage in millivolts for absolulte cal.
    *
    */
   Method (GENP)
   {
      Return (Package()
      {
         /* .uMasterID           */ 0,
         /* .uSlaveID            */ 0,
         /* .bUsesInterrupts     */ 1,
         /* .uMinDigMinor        */ 0,
         /* .uMinDigMajor        */ 0,
         /* .uMinAnaMinor        */ 0,
         /* .uMinAnaMajor        */ 0,
         /* .uPerphType          */ 0x08,
         /* .uPerphSubType       */ 0x09,
         /* .uVrefP_mv           */ 1800,
         /* .uVrefN_mv           */ 0,
         /* .uVref1_mv           */ 625,
         /* .uVref2_mv           */ 1250,
      })
   }

   /*
    * VADC Channel Configuration Table
    *
    * The following table is the list of channels the ADC can read. Channels may
    * be added or removed. Below is a description of each field:
    *
    * sName:
    *    Appropriate string name for the channel from AdcInputs.h.
    *
    * uAdcHardwareChannel:
    *    AMUX channel.
    *
    * uConfigIdx:
    *    Selects which configuration to use from the configuration table zero-
    *    based configuration table e.g. 0 means use the first configuration, 1
    *    means use the second, etc.
    *
    * eSettlingDelay:
    *    Holdoff time to allow the voltage to settle before reading the channel.
    *    0 - VADC_SETTLING_DELAY_0_US
    *    1 - VADC_SETTLING_DELAY_100_US
    *    2 - VADC_SETTLING_DELAY_200_US
    *    3 - VADC_SETTLING_DELAY_300_US
    *    4 - VADC_SETTLING_DELAY_400_US
    *    5 - VADC_SETTLING_DELAY_500_US
    *    6 - VADC_SETTLING_DELAY_600_US
    *    7 - VADC_SETTLING_DELAY_700_US
    *    8 - VADC_SETTLING_DELAY_800_US
    *    9 - VADC_SETTLING_DELAY_900_US
    *    10 - VADC_SETTLING_DELAY_1_MS
    *    11 - VADC_SETTLING_DELAY_2_MS
    *    12 - VADC_SETTLING_DELAY_4_MS
    *    13 - VADC_SETTLING_DELAY_6_MS
    *    14 - VADC_SETTLING_DELAY_8_MS
    *    15 - VADC_SETTLING_DELAY_10_MS
    *
    * eFastAverageMode:
    *    Obtains N ADC readings and averages them together.
    *    0xFFFF - VADC_FAST_AVERAGE_NONE
    *    0 - VADC_FAST_AVERAGE_1_SAMPLE
    *    1 - VADC_FAST_AVERAGE_2_SAMPLES
    *    2 - VADC_FAST_AVERAGE_4_SAMPLES
    *    3 - VADC_FAST_AVERAGE_8_SAMPLES
    *    4 - VADC_FAST_AVERAGE_16_SAMPLES
    *    5 - VADC_FAST_AVERAGE_32_SAMPLES
    *    6 - VADC_FAST_AVERAGE_64_SAMPLES
    *    7 - VADC_FAST_AVERAGE_128_SAMPLES
    *    8 - VADC_FAST_AVERAGE_256_SAMPLES
    *    9 - VADC_FAST_AVERAGE_512_SAMPLES
    *
    * bUseSequencer:
    *    0 - No
    *    1 - Yes
    *
    * uSequencerIdx:
    *    Selects which sequencer configuration to use from the zero-based SEQP
    *    configuration table e.g. 0 means use the first configuration, 1
    *    means use the second, etc.
    *
    * scalingFactor.num:
    *    Numerator of the channel scaling
    *
    * scalingFactor.den:
    *    Denominator of the channel scaling
    *
    * uScalingFunctionName:
    *    The name of the function to call in the ACPI table to perform custom
    *    scaling. The input to the custom scaling function is defined by
    *    eScalingFunctionInput. The output of the custom scaling function is
    *    the physical value.
    *    0 - No scaling function
    *    WXYZ - Where 'WXYZ' is the scaling function name
    *
    *    Note: if both a custon scaling function & interpolation table are used
    *    the custom scaling function is called first.
    *
    * uInverseFunctionName:
    *    The name of the inverse scaling for uScalingFunctionName. This is only
    *    needed if the channel is going to be used for threshold monitoring.
    *    0 - No scaling function
    *    WXYZ - Where 'WXYZ' is the scaling function name
    *
    * eScalingFunctionInput:
    *    Defines which ADC result is passed to the custom scaling function.
    *    0 - VADC_SCALING_FUNCTION_INPUT_PHYSICAL
    *    1 - VADC_SCALING_FUNCTION_INPUT_PERCENT
    *    2 - VADC_SCALING_FUNCTION_INPUT_MICROVOLTS
    *    3 - VADC_SCALING_FUNCTION_INPUT_RAW
    *
    * uInterpolationTableName:
    *    The name of the lookup table in ACPI that will be interpolated to obtain
    *    a physical value. Note that the physical value (which has default units
    *    of millivolts unless custom scaling function is used) is passed as the
    *    input. This value corresponds to the first column of the table. The
    *    scaled output appears in the physical adc result.
    *    0 - No interpolation table
    *    WXYZ - Where 'WXYZ' is the interpolation table name
    *
    * eCalMethod:
    *    Calibration method.
    *    0 - VADC_CAL_METHOD_RATIOMETRIC
    *    1 - VADC_CAL_METHOD_ABSOLUTE
    *
    * uTimeout_us:
    *    Max time to wait for the conversion to take place in microseconds.
    *
    * eMppConfig:
    *    MPP configuration. Default is to use static MPPs, which keep the MPP
    *    mapped to the AMUX channel. Note: ADC on MPSS (if present) also maps
    *    MPPs. Be sure to check the BSP file to make sure there are no conflicts,
    *    i.e. the mapping should be the same.
    *    0 - VADC_CHANNEL_MPP_CONFIG_NONE
    *    1 - VADC_CHANNEL_MPP_CONFIG_STATIC
    *    2 - Reserved
    *
    * uMpp:
    *    The desired MPP input to be mapped as an analog input.
    *    0 - PM_MPP_1
    *    1 - PM_MPP_2
    *    2 - PM_MPP_3
    *    3 - PM_MPP_4
    *    4 - PM_MPP_5
    *    5 - PM_MPP_6
    *    6 - PM_MPP_7
    *    7 - PM_MPP_8
    *    8 - PM_MPP_9
    *    9 - PM_MPP_10
    *    10 - PM_MPP_11
    *    11 - PM_MPP_12
    *
    * uChSelect:
    *    AMUX to which the selected MPP will be routed.
    *    0 - PM_MPP__AIN__CH_AMUX5
    *    1 - PM_MPP__AIN__CH_AMUX6
    *    2 - PM_MPP__AIN__CH_AMUX7
    *    3 - PM_MPP__AIN__CH_AMUX8
    *
    * MPP routing:
    *    Configure MPPs based on the below routing.
    *    MPP -> AMUX
    *     1  ->  5
    *     2  ->  6
    *     3  ->  7
    *     4  ->  8
    *     5  ->  5
    *     6  ->  6
    *     7  ->  7
    *     8  ->  8
    *
    *     Example:
    *     MPP4
    *      - uMpp = 3
    *      - uChSelect = 3
    */
   Method (CHAN)
   {
      Return (Package()
      {
         /* Channel 0: USB_IN */
         Package()
         {
            /* .sName                     */ "USB_IN",
            /* .uAdcHardwareChannel       */ 0x00,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 10,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 1: VCOIN */
         Package()
         {
            /* .sName                     */ "VCOIN",
            /* .uAdcHardwareChannel       */ 0x05,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 3,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 2: VBATT */
         Package()
         {
            /* .sName                     */ "VBATT",
            /* .uAdcHardwareChannel       */ 0x06,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 3,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 3: VBATT_GSM */
         Package()
         {
            /* .sName                     */ "VBATT_GSM",
            /* .uAdcHardwareChannel       */ 0x06,
            /* .uConfigIdx                */ 2,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 1,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 3,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 4: VBATT_FLASH */
         Package()
         {
            /* .sName                     */ "VBATT_FLASH",
            /* .uAdcHardwareChannel       */ 0x06,
            /* .uConfigIdx                */ 2,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 1,
            /* .uSequencerIdx             */ 1,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 3,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 5: VPH_PWR */
         Package()
         {
            /* .sName                     */ "VPH_PWR",
            /* .uAdcHardwareChannel       */ 0x07,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 3,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 6: PMIC_THERM */
         Package()
         {
            /* .sName                     */ "PMIC_THERM",
            /* .uAdcHardwareChannel       */ 0x08,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ PTCF,
            /* .uInverseFunctionName      */ PTCI,
            /* .eScalingFunctionInput     */ 2,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 7: CHG_TEMP */
         Package()
         {
            /* .sName                     */ "CHG_TEMP",
            /* .uAdcHardwareChannel       */ 0x0B,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ PTCF,
            /* .uInverseFunctionName      */ PTCI,
            /* .eScalingFunctionInput     */ 2,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 8: BATT_THERM */
         Package()
         {
            /* .sName                     */ "BATT_THERM",
            /* .uAdcHardwareChannel       */ 0x30,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 1,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ BTTB,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 9: BATT_ID */
         Package()
         {
            /* .sName                     */ "BATT_ID",
            /* .uAdcHardwareChannel       */ 0x31,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 1,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 10: XO_THERM */
         Package()
         {
            /* .sName                     */ "XO_THERM",
            /* .uAdcHardwareChannel       */ 0x3C,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 5,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ XOCF,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 1,
            /* .uInterpolationTableName   */ XTTB,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 11: XO_THERM_GPS */
         Package()
         {
            /* .sName                     */ "XO_THERM_GPS",
            /* .uAdcHardwareChannel       */ 0x3C,
            /* .uConfigIdx                */ 1,
            /* .eSettlingDelay            */ 5,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ XOCF,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 1,
            /* .uInterpolationTableName   */ XTTB,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 12: PA_THERM */
         Package()
         {
            /* .sName                     */ "PA_THERM",
            /* .uAdcHardwareChannel       */ 0x36,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 1,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ SYTB,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 13: VDD */
         Package()
         {
            /* .sName                     */ "VDD",
            /* .uAdcHardwareChannel       */ 0x0F,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 14: GND */
         Package()
         {
            /* .sName                     */ "GND",
            /* .uAdcHardwareChannel       */ 0x0E,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 15: VREF1 */
         Package()
         {
            /* .sName                     */ "VREF1",
            /* .uAdcHardwareChannel       */ 0x0C,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* Channel 16: VREF2 */
         Package()
         {
            /* .sName                     */ "VREF2",
            /* .uAdcHardwareChannel       */ 0x0A,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         }
      })
   }

   /*
    * Calibration Channel Configuration Table
    *
    * These channels provide calibration information for scaling ADC conversions. To
    * scale an ADC result, first, the ADC scales the raw result using the mvVdd &
    * Ground values as the max and min of the scale, which goes from 0 - 0xFFFF
    * (0 - 100%). Next, either ratiometric or absolute calibration is performed:
    *    - ratiometric: the scale 0 - 0xFFFF corresponds to 0 mV - mvVdd
    *    - absolute: vRef1 & vRef2 are used to apply an additional two-point scaling.
    * To complete the scaling process, custom scaling functions and/or lookup tables
    * further scale the physical value.
    *
    * The fields in the following table are configured exactly the same way as the
    * fields in the channel configuration table. The only difference is that the
    * names shown below are optional and do not correspond to entries in AdcInputs.h.
    */
   Method (CBCH)
   {
      Return (Package()
      {
         /* VDD */
         Package()
         {
            /* .sName                     */ "VDD",
            /* .uAdcHardwareChannel       */ 0x0F,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* GND */
         Package()
         {
            /* .sName                     */ "GND",
            /* .uAdcHardwareChannel       */ 0x0E,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 0,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* VREF1 */
         Package()
         {
            /* .sName                     */ "VREF1",
            /* .uAdcHardwareChannel       */ 0x0C,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         },

         /* VREF2 */
         Package()
         {
            /* .sName                     */ "VREF2",
            /* .uAdcHardwareChannel       */ 0x0A,
            /* .uConfigIdx                */ 0,
            /* .eSettlingDelay            */ 0,
            /* .eFastAverageMode          */ 0xFFFF,
            /* .bUseSequencer             */ 0,
            /* .uSequencerIdx             */ 0,
            /* .scalingFactor.num         */ 1,
            /* .scalingFactor.den         */ 1,
            /* .uScalingFunctionName      */ 0,
            /* .uInverseFunctionName      */ 0,
            /* .eScalingFunctionInput     */ 0,
            /* .uInterpolationTableName   */ 0,
            /* .eCalMethod                */ 1,
            /* .uTimeout_us               */ 100000,
            /* .eMppConfig                */ 0,
            /* .uMpp                      */ 0,
            /* .eChSelect                 */ 0
         }
      })
   }

   /*
    * VADC operating modes and decimation filter setup.
    *
    * eDecimationRatio:
    *    0 - VADC_DECIMATION_RATIO_512
    *    1 - VADC_DECIMATION_RATIO_1024
    *    2 - VADC_DECIMATION_RATIO_2048
    *    3 - VADC_DECIMATION_RATIO_4096
    *
    * eClockSelect:
    *    0 - VADC_CLOCK_SELECT_2P4_MHZ
    *    1 - VADC_CLOCK_SELECT_4P8_MHZ
    *    Note: Although register values exist for the 9.6 MHZ and 19.2 MHZ clock
    *    configurations, these clock modes are not supported by the VADC HW.
    *
    * uConversionTime_us:
    *    Conversion time in microseconds.
    */
   Method (CFGS)
   {
      Return (Package()
      {
         /* 0 - VADC_CONFIG_NORMAL. Used for standard AMUX Input Channels. */
         Package()
         {
            /* .eDecimationRatio   */ 1,
            /* .eClockSelect       */ 1,
            /* .uConversionTime_us */ 213
         },
         /* 1 - VADC_CONFIG_SLOW. Slow operating mode. Used for XO THERM GPS for better accuracy. */
         Package()
         {
            /* .eDecimationRatio   */ 3,
            /* .eClockSelect       */ 1,
            /* .uConversionTime_us */ 853
         },
         /* 2 - VADC_CONFIG_FAST. Faster mode. Used for VBATT GSM SYNC. */
         Package()
         {
            /* .eDecimationRatio   */ 0,
            /* .eClockSelect       */ 1,
            /* .uConversionTime_us */ 107
         }
      })
   }

   /*
    * The ADC aribiter features a conversion sequencer. Once the trigger
    * event occurs, the measurement will be performed after the holdoff
    * time. If the trigger doesn't occur the measurement will time out.
    *
    * eHoldoff:
    *    0 - VADC_SEQUENCER_HOLDOFF_25_US
    *    1 - VADC_SEQUENCER_HOLDOFF_50_US
    *    2 - VADC_SEQUENCER_HOLDOFF_75_US
    *    3 - VADC_SEQUENCER_HOLDOFF_100_US
    *    4 - VADC_SEQUENCER_HOLDOFF_125_US
    *    5 - VADC_SEQUENCER_HOLDOFF_150_US
    *    6 - VADC_SEQUENCER_HOLDOFF_175_US
    *    7 - VADC_SEQUENCER_HOLDOFF_200_US
    *    8 - VADC_SEQUENCER_HOLDOFF_225_US
    *    9 - VADC_SEQUENCER_HOLDOFF_250_US
    *    10 - VADC_SEQUENCER_HOLDOFF_275_US
    *    11 - VADC_SEQUENCER_HOLDOFF_300_US
    *    12 - VADC_SEQUENCER_HOLDOFF_325_US
    *    13 - VADC_SEQUENCER_HOLDOFF_350_US
    *    14 - VADC_SEQUENCER_HOLDOFF_375_US
    *    15 - VADC_SEQUENCER_HOLDOFF_400_US
    *
    * eTimeoutTime:
    *    0 - VADC_SEQUENCER_TIMEOUT_TIME_0_MS
    *    1 - VADC_SEQUENCER_TIMEOUT_TIME_1_MS
    *    2 - VADC_SEQUENCER_TIMEOUT_TIME_2_MS
    *    3 - VADC_SEQUENCER_TIMEOUT_TIME_3_MS
    *    4 - VADC_SEQUENCER_TIMEOUT_TIME_4_MS
    *    5 - VADC_SEQUENCER_TIMEOUT_TIME_5_MS
    *    6 - VADC_SEQUENCER_TIMEOUT_TIME_6_MS
    *    7 - VADC_SEQUENCER_TIMEOUT_TIME_7_MS
    *    8 - VADC_SEQUENCER_TIMEOUT_TIME_8_MS
    *    9 - VADC_SEQUENCER_TIMEOUT_TIME_9_MS
    *    10 - VADC_SEQUENCER_TIMEOUT_TIME_10_MS
    *    11 - VADC_SEQUENCER_TIMEOUT_TIME_11_MS
    *    12 - VADC_SEQUENCER_TIMEOUT_TIME_12_MS
    *    13 - VADC_SEQUENCER_TIMEOUT_TIME_13_MS
    *    14 - VADC_SEQUENCER_TIMEOUT_TIME_14_MS
    *    15 - VADC_SEQUENCER_TIMEOUT_TIME_15_MS
    *
    * eTriggerCondition:
    *    0 - VADC_TRIGGER_CONDITION_FALLING_EDGE
    *    1 - VADC_TRIGGER_CONDITION_RISING_EDGE
    *
    * eTriggerInput:
    *    0 - VADC_TRIGGER_INPUT_TRIG_1
    *    1 - VADC_TRIGGER_INPUT_TRIG_2
    *    2 - VADC_TRIGGER_INPUT_TRIG_3
    *    3 - VADC_TRIGGER_INPUT_TRIG_4
    */
   Method (SEQP)
   {
      Return (Package()
      {
         /* 0 - VADC_SEQUENCER_GSM */
         Package()
         {
            /* .eHoldoff          */ 7,
            /* .eTimeoutTime      */ 5,
            /* .eTriggerCondition */ 1,
            /* .eTriggerInput     */ 1,
         },
         /* 1 - VADC_SEQUENCER_FLASH */
         Package()
         {
            /* .eHoldoff          */ 0,
            /* .eTimeoutTime      */ 15,
            /* .eTriggerCondition */ 1,
            /* .eTriggerInput     */ 2,
         }
      })
   }

   /*===========================================================================

     FUNCTION        PTCF

     DESCRIPTION     Scales the ADC result from millivolts to 0.001 degrees
                     Celsius using the PMIC thermistor conversion equation.

     DEPENDENCIES    None

     PARAMETERS      Arg0 [in]  ADC result data (uMicroVolts)

     RETURN VALUE    Scaled result in mDegC

     SIDE EFFECTS    None

   ===========================================================================*/
   Method (PTCF, 1)
   {
      /*
       * Divide by two to convert from microvolt reading to micro-Kelvin.
       *
       * Subtract 273160 to convert the temperature from Kelvin to
       * 0.001 degrees Celsius.
       */
      ShiftRight (Arg0, 1, Local0)
      Subtract (Local0, 273160, Local0)
      Return (Local0)
   }

   /*===========================================================================

     FUNCTION        PTCI

     DESCRIPTION     Inverse of PTCF - scaled PMIC temperature to microvolts.

     DEPENDENCIES    None

     PARAMETERS      Arg0 [in]  temperature in mDegC

     RETURN VALUE    ADC result data (uMicroVolts)

     SIDE EFFECTS    None

   ===========================================================================*/
   Method (PTCI, 1)
   {
      Add (Arg0, 273160, Local0)
      ShiftLeft (Local0, 1, Local0)
      Return (Local0)
   }

   /*===========================================================================

     FUNCTION        XOCF

     DESCRIPTION     Scales the ADC result from millivolts to R_t / R_25 times
                     a factor of 2^14.

     DEPENDENCIES    None

     PARAMETERS      Arg0      [in]  ADC result data (uPercent)

     RETURN VALUE    Scaled result

     SIDE EFFECTS    None

   ===========================================================================*/
   Method (XOCF, 1)
   {
      /* The ratio R_t / R_25 is used to determine the temperature per the
       * mapping table.
       *
       * Here we calculate the ratio of R_t / R_25, where:
       *
       * R_t is the XO thermistor.
       *
       * R_25 is the reference resistor in the voltage divider.
       * V_t is the voltage of the thermistor.
       *
       * V_ref is the XO ADC reference voltage.
       *
       *             V_ref ___
       *                      |
       *                      >
       *                R_25  <   100 kOhms
       *                      >
       *                      |
       *                      |
       *                      |- - - V_t
       *                      |
       *                      >
       *                R_t   <
       *                      >
       *                      |
       *                      |
       *                     Gnd
       *
       * Voltage divider equation
       *     V_t = V_ref * R_t / (R_t + R_25)
       *
       * Solving for R_t
       *     R_t = (V_t * R_25) / (V_ref - V_t)
       *
       * Subtituting into R_t / R_25
       *     R_t / R_25 = V_t / (V_ref - V_t)
       *
       * Names used below:
       *     Local3 = (Local1 + Local2) / (0xFFFF - Local0)
       *
       * The shift factors scale nRt_R25 into units of 2^-14 and the
       * extra term in the numerator provides rounding.
       */

      ShiftLeft (Arg0, 14, Local1)
      Subtract (0xFFFF, Arg0, Local0)
      ShiftRight (Local0, 1, Local2)

      If (LEqual(Local0, Zero))
         {Return (0x7FFFFFFF)}

      Add (Local1, Local2, Local3)
      Divide (Local3, Local0, Local4, Local3)

      If (LGreater(Local3, 0x7FFFFFFF))
         {Return (0x7FFFFFFF)}

      Return (Local3)
   }

   /*
    * Main Battery Thermistor Table
    *
    * The first element is Voltage V_t in mV and the second element is the
    * temperature in degrees Celcius.
    *
    *             V_ref ___  1800 mV
    *                      |
    *                      >
    *                 R_1  <  90.9 kOhms
    *                      >
    *                      |
    *                      |
    *                      |- - - V_t
    *                      |
    *                      >
    *                 R_2  <  16.2 kOhms
    *                      >
    *                      |
    *                      |
    *                      >
    *                 R_t  <  68 kOhms (TH05-3J683F)
    *                      >
    *                      |
    *                      |
    *                     Gnd
    *
    */
   Method (BTTB)
   {
      Return (Package()
      {
         Package(){1632, 0xFFFFFFE2}, // -30
         Package(){1534, 0xFFFFFFEC}, // -20
         Package(){1405, 0xFFFFFFF6}, // -10
         Package(){1254,   0},
         Package(){1094,  10},
         Package(){ 938,  20},
         Package(){ 798,  30},
         Package(){ 681,  40},
         Package(){ 587,  50},
         Package(){ 513,  60},
         Package(){ 457,  70},
         Package(){ 415,  80}
      })
   }

   /*
    * System Thermistor Table
    *
    * The first element is Voltage V_t in mV and the second element is the
    * temperature in mDegC.
    *
    *             V_ref ___  1800 mV
    *                      |
    *                      >
    *                 R_p  <  100 kOhms
    *                      >
    *                      |
    *                      |
    *                      |- - - V_t
    *                      |
    *                      >
    *                 R_t  <  100 kOhms (NTCG104EF104FB)
    *                      >
    *                      |
    *                      |
    *                     Gnd
    *
    */
   Method (SYTB)
   {
      Return (Package()
      {
         Package(){1759, 0xFFFFFFD8}, // -40
         Package(){1742, 0xFFFFFFDD}, // -35
         Package(){1720, 0xFFFFFFE2}, // -30
         Package(){1691, 0xFFFFFFE7}, // -25
         Package(){1654, 0xFFFFFFEC}, // -20
         Package(){1608, 0xFFFFFFF1}, // -15
         Package(){1551, 0xFFFFFFF6}, // -10
         Package(){1484, 0xFFFFFFFB}, // -5
         Package(){1405,   0},
         Package(){1316,   5},
         Package(){1218,  10},
         Package(){1114,  15},
         Package(){1007,  20},
         Package(){ 900,  25},
         Package(){ 796,  30},
         Package(){ 697,  35},
         Package(){ 606,  40},
         Package(){ 522,  45},
         Package(){ 449,  50},
         Package(){ 384,  55},
         Package(){ 327,  60},
         Package(){ 278,  65},
         Package(){ 238,  70},
         Package(){ 201,  75},
         Package(){ 173,  80},
         Package(){ 147,  85},
         Package(){ 126,  90},
         Package(){ 108,  95},
         Package(){  92, 100},
         Package(){  79, 105},
         Package(){  69, 110},
         Package(){  60, 115},
         Package(){  52, 120},
         Package(){  45, 125}
      })
   }

   /*
    * XO Thermistor Table
    *
    * This lookup table is used to convert the XO thermistor reading to temperature
    * in degrees C multiplied by a factor of 1024.
    *
    * The first column in the table is the ratio of Rt' divided by R25 (multiplied
    * by a factor of 2^14).
    *
    * The second column is the temperature in degrees Celsius multiplied by a factor
    * of 1024.
    *
    * Rt' is the resistance of the thermistor at temperature t in parallel with the
    * input impedance of the ADC.
    *
    * R25 is the series resistor. The resistor value should be the same as that
    * of the thermistor at 25 degrees C (100 KOhms in the reference design).
    *
    *             V_ref ___
    *                      |
    *                      >
    *                R_25  <   100 kOhms
    *                      >
    *                      |
    *                      |
    *                      |- - - V_t
    *                      |
    *                      >
    *                R_t   <   100 kOhms (NTCG104EF104FB)
    *                      >
    *                      |
    *                      |
    *                     Gnd
    *
    */
   Method (XTTB)
   {
      Return (Package()
      {
         Package(){696483, 0xFFFF6000}, // -40960
         Package(){649148, 0xFFFF6400}, // -39936
         Package(){605368, 0xFFFF6800}, // -38912
         Package(){564809, 0xFFFF6C00}, // -37888
         Package(){527215, 0xFFFF7000}, // -36864
         Package(){492322, 0xFFFF7400}, // -35840
         Package(){460007, 0xFFFF7800}, // -34816
         Package(){429982, 0xFFFF7C00}, // -33792
         Package(){402099, 0xFFFF8000}, // -32768
         Package(){376192, 0xFFFF8400}, // -31744
         Package(){352075, 0xFFFF8800}, // -30720
         Package(){329714, 0xFFFF8C00}, // -29696
         Package(){308876, 0xFFFF9000}, // -28672
         Package(){289480, 0xFFFF9400}, // -27648
         Package(){271417, 0xFFFF9800}, // -26624
         Package(){254574, 0xFFFF9C00}, // -25600
         Package(){238903, 0xFFFFA000}, // -24576
         Package(){224276, 0xFFFFA400}, // -23552
         Package(){210631, 0xFFFFA800}, // -22528
         Package(){197896, 0xFFFFAC00}, // -21504
         Package(){186007, 0xFFFFB000}, // -20480
         Package(){174899, 0xFFFFB400}, // -19456
         Package(){164521, 0xFFFFB800}, // -18432
         Package(){154818, 0xFFFFBC00}, // -17408
         Package(){145744, 0xFFFFC000}, // -16384
         Package(){137265, 0xFFFFC400}, // -15360
         Package(){129307, 0xFFFFC800}, // -14336
         Package(){121866, 0xFFFFCC00}, // -13312
         Package(){114896, 0xFFFFD000}, // -12288
         Package(){108365, 0xFFFFD400}, // -11264
         Package(){102252, 0xFFFFD800}, // -10240
         Package(){ 96499, 0xFFFFDC00}, //  -9216
         Package(){ 91111, 0xFFFFE000}, //  -8192
         Package(){ 86055, 0xFFFFE400}, //  -7168
         Package(){ 81308, 0xFFFFE800}, //  -6144
         Package(){ 76857, 0xFFFFEC00}, //  -5120
         Package(){ 72660, 0xFFFFF000}, //  -4096
         Package(){ 68722, 0xFFFFF400}, //  -3072
         Package(){ 65020, 0xFFFFF800}, //  -2048
         Package(){ 61538, 0xFFFFFC00}, //  -1024
         Package(){ 58261,      0},
         Package(){ 55177,   1024},
         Package(){ 52274,   2048},
         Package(){ 49538,   3072},
         Package(){ 46962,   4096},
         Package(){ 44531,   5120},
         Package(){ 42243,   6144},
         Package(){ 40083,   7168},
         Package(){ 38045,   8192},
         Package(){ 36122,   9216},
         Package(){ 34308,  10240},
         Package(){ 32592,  11264},
         Package(){ 30972,  12288},
         Package(){ 29442,  13312},
         Package(){ 27995,  14336},
         Package(){ 26624,  15360},
         Package(){ 25333,  16384},
         Package(){ 24109,  17408},
         Package(){ 22951,  18432},
         Package(){ 21854,  19456},
         Package(){ 20807,  20480},
         Package(){ 19831,  21504},
         Package(){ 18899,  22528},
         Package(){ 18016,  23552},
         Package(){ 17178,  24576},
         Package(){ 16384,  25600},
         Package(){ 15631,  26624},
         Package(){ 14916,  27648},
         Package(){ 14237,  28672},
         Package(){ 13593,  29696},
         Package(){ 12976,  30720},
         Package(){ 12400,  31744},
         Package(){ 11848,  32768},
         Package(){ 11324,  33792},
         Package(){ 10825,  34816},
         Package(){ 10354,  35840},
         Package(){  9900,  36864},
         Package(){  9471,  37888},
         Package(){  9062,  38912},
         Package(){  8674,  39936},
         Package(){  8306,  40960},
         Package(){  7951,  41984},
         Package(){  7616,  43008},
         Package(){  7296,  44032},
         Package(){  6991,  45056},
         Package(){  6701,  46080},
         Package(){  6424,  47104},
         Package(){  6160,  48128},
         Package(){  5908,  49152},
         Package(){  5667,  50176},
         Package(){  5439,  51200},
         Package(){  5219,  52224},
         Package(){  5010,  53248},
         Package(){  4810,  54272},
         Package(){  4619,  55296},
         Package(){  4440,  56320},
         Package(){  4263,  57344},
         Package(){  4097,  58368},
         Package(){  3938,  59392},
         Package(){  3785,  60416},
         Package(){  3637,  61440},
         Package(){  3501,  62464},
         Package(){  3368,  63488},
         Package(){  3240,  64512},
         Package(){  3118,  65536},
         Package(){  2998,  66560},
         Package(){  2889,  67584},
         Package(){  2782,  68608},
         Package(){  2680,  69632},
         Package(){  2581,  70656},
         Package(){  2490,  71680},
         Package(){  2397,  72704},
         Package(){  2310,  73728},
         Package(){  2227,  74752},
         Package(){  2147,  75776},
         Package(){  2064,  76800},
         Package(){  1998,  77824},
         Package(){  1927,  78848},
         Package(){  1860,  79872},
         Package(){  1795,  80896},
         Package(){  1736,  81920},
         Package(){  1673,  82944},
         Package(){  1615,  83968},
         Package(){  1560,  84992},
         Package(){  1507,  86016},
         Package(){  1456,  87040},
         Package(){  1407,  88064},
         Package(){  1360,  89088},
         Package(){  1314,  90112},
         Package(){  1271,  91136},
         Package(){  1228,  92160},
         Package(){  1189,  93184},
         Package(){  1150,  94208},
         Package(){  1112,  95232},
         Package(){  1076,  96256},
         Package(){  1042,  97280},
         Package(){  1008,  98304},
         Package(){   976,  99328},
         Package(){   945, 100352},
         Package(){   915, 101376},
         Package(){   886, 102400},
         Package(){   859, 103424},
         Package(){   832, 104448},
         Package(){   807, 105472},
         Package(){   782, 106496},
         Package(){   756, 107520},
         Package(){   735, 108544},
         Package(){   712, 109568},
         Package(){   691, 110592},
         Package(){   670, 111616},
         Package(){   650, 112640},
         Package(){   631, 113664},
         Package(){   612, 114688},
         Package(){   594, 115712},
         Package(){   577, 116736},
         Package(){   560, 117760},
         Package(){   544, 118784},
         Package(){   528, 119808},
         Package(){   513, 120832},
         Package(){   498, 121856},
         Package(){   483, 122880},
         Package(){   470, 123904},
         Package(){   457, 124928},
         Package(){   444, 125952},
         Package(){   431, 126976},
         Package(){   419, 128000},
         Package(){   408, 129024},
         Package(){   396, 130048}
      })
   }

   /*----------------------------------------------------------------------------
    * Voltage ADC Threshold Monitor (VADCTM) Configuration
    * -------------------------------------------------------------------------*/
   /*
    * General VADCTM properties
    *
    * uMasterID:
    *    Master ID to send the interrupt to.
    *
    * uMinDigMinor:
    *    Minimum digital version.
    *
    * uMinDigMajor:
    *    Minimum digital version.
    *
    * uMinAnaMinor:
    *    Minimum analog version.
    *
    * uMinAnaMajor:
    *    Minimum analog version.
    *
    * uPerphType:
    *    ADC peripheral type.
    *
    * uPerphSubType:
    *    VADCTM peripheral subtype.
    *
    * eDecimationRatio:
    *    See CFGS table.
    *
    * eClockSelect:
    *    See CFGS table.
    *
    * uConversionTime_us:
    *    See CFGS table.
    *
    * eSettlingDelay:
    *    See CHAN table.
    *
    * eFastAverageMode:
    *    See CHAN table.
    *
    * eMeasIntervalTime1:
    *    Interval timer 1 periodic value.
    *    0 - VADCTM_MEAS_INTERVAL_TIME1_0_MS
    *    1 - VADCTM_MEAS_INTERVAL_TIME1_1_MS
    *    2 - VADCTM_MEAS_INTERVAL_TIME1_2_MS
    *    3 - VADCTM_MEAS_INTERVAL_TIME1_3P9_MS
    *    4 - VADCTM_MEAS_INTERVAL_TIME1_7P8_MS
    *    5 - VADCTM_MEAS_INTERVAL_TIME1_15P6_MS
    *    6 - VADCTM_MEAS_INTERVAL_TIME1_31P1_MS
    *    7 - VADCTM_MEAS_INTERVAL_TIME1_62P5_MS
    *    8 - VADCTM_MEAS_INTERVAL_TIME1_125_MS
    *    9 - VADCTM_MEAS_INTERVAL_TIME1_250_MS
    *    10 - VADCTM_MEAS_INTERVAL_TIME1_500_MS
    *    11 - VADCTM_MEAS_INTERVAL_TIME1_1_S
    *    12 - VADCTM_MEAS_INTERVAL_TIME1_2_S
    *    13 - VADCTM_MEAS_INTERVAL_TIME1_4_S
    *    14 - VADCTM_MEAS_INTERVAL_TIME1_8_S
    *    15 - VADCTM_MEAS_INTERVAL_TIME1_16_S
    *
    * eMeasIntervalTime2:
    *    Interval timer 2 periodic value.
    *    0 - VADCTM_MEAS_INTERVAL_TIME2_0_MS
    *    1 - VADCTM_MEAS_INTERVAL_TIME2_100_MS
    *    2 - VADCTM_MEAS_INTERVAL_TIME2_200_MS
    *    3 - VADCTM_MEAS_INTERVAL_TIME2_300_MS
    *    4 - VADCTM_MEAS_INTERVAL_TIME2_400_MS
    *    5 - VADCTM_MEAS_INTERVAL_TIME2_500_MS
    *    6 - VADCTM_MEAS_INTERVAL_TIME2_600_MS
    *    7 - VADCTM_MEAS_INTERVAL_TIME2_700_MS
    *    8 - VADCTM_MEAS_INTERVAL_TIME2_800_MS
    *    9 - VADCTM_MEAS_INTERVAL_TIME2_900_MS
    *    10 - VADCTM_MEAS_INTERVAL_TIME2_1_S
    *    11 - VADCTM_MEAS_INTERVAL_TIME2_1P1_S
    *    12 - VADCTM_MEAS_INTERVAL_TIME2_1P2_S
    *    13 - VADCTM_MEAS_INTERVAL_TIME2_1P3_S
    *    14 - VADCTM_MEAS_INTERVAL_TIME2_1P4_S
    *    15 - VADCTM_MEAS_INTERVAL_TIME2_1P5_S
    *
    * eMeasIntervalTime3:
    *    Interval timer 3 periodic value.
    *    0 - VADCTM_MEAS_INTERVAL_TIME3_0_S
    *    1 - VADCTM_MEAS_INTERVAL_TIME3_1_S
    *    2 - VADCTM_MEAS_INTERVAL_TIME3_2_S
    *    3 - VADCTM_MEAS_INTERVAL_TIME3_3_S
    *    4 - VADCTM_MEAS_INTERVAL_TIME3_4_S
    *    5 - VADCTM_MEAS_INTERVAL_TIME3_5_S
    *    6 - VADCTM_MEAS_INTERVAL_TIME3_6_S
    *    7 - VADCTM_MEAS_INTERVAL_TIME3_7_S
    *    8 - VADCTM_MEAS_INTERVAL_TIME3_8_S
    *    9 - VADCTM_MEAS_INTERVAL_TIME3_9_S
    *    10 - VADCTM_MEAS_INTERVAL_TIME3_10_S
    *    11 - VADCTM_MEAS_INTERVAL_TIME3_11_S
    *    12 - VADCTM_MEAS_INTERVAL_TIME3_12_S
    *    13 - VADCTM_MEAS_INTERVAL_TIME3_13_S
    *    14 - VADCTM_MEAS_INTERVAL_TIME3_14_S
    *    15 - VADCTM_MEAS_INTERVAL_TIME3_15_S
    *
    * nThresholdMin_mV:
    *    Minimum threshold in mV.
    *
    * nThresholdMax_mV:
    *    Maximum threshold in mV.
    */
   Method (VTGN)
   {
      Return (Package()
      {
         /* .uMasterID           */ 0,
         /* .uMinDigMinor        */ 0,
         /* .uMinDigMajor        */ 0,
         /* .uMinAnaMinor        */ 0,
         /* .uMinAnaMajor        */ 0,
         /* .uPerphType          */ 0x08,
         /* .uPerphSubType       */ 0x22,
         /* .eDecimationRatio    */ 1,
         /* .eClockSelect        */ 1,
         /* .uConversionTime_us  */ 213,
         /* .eSettlingDelay      */ 5,
         /* .eFastAverageMode    */ 0xFFFF,
         /* .eMeasIntervalTime1  */ 0xF,
         /* .eMeasIntervalTime2  */ 0x1,
         /* .eMeasIntervalTime3  */ 0x1,
         /* .nThresholdMin_mV    */ 50,
         /* .nThresholdMax_mV    */ 1750
      })
   }

   /*
    * VADCTM Measurement Configuration Table
    *
    * The following is a list of periodic measurements that the VADCTM
    * can periodically monitor. Thresholds for these measurements are set
    * in software.
    *
    * sName:
    *    Appropriate string name for the channel from AdcInputs.h.
    *
    * eMeasIntervalTimeSelect:
    *    The interval timer to use for the measurement period.
    *    0 - eMeasIntervalTime1
    *    1 - eMeasIntervalTime2
    *    2 - eMeasIntervalTime3
    */
   Method (VTCH)
   {
      Return (Package()
      {
         /* Meas 0: */
         Package()
         {
            /* .sName                     */ "BATT_THERM",
            /* .eMeasIntervalTimeSelect   */ 2
         },

         /* Meas 1: */
         Package()
         {
            /* .sName                     */ "PMIC_THERM",
            /* .eMeasIntervalTimeSelect   */ 2
         },
      })
   }
}