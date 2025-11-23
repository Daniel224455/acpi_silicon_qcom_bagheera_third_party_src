Name (PCFG, 
  Buffer() {"<?xml version=\1.0\ encoding=\utf-8\?>
    <PanelName>ADV7533</PanelName>
    <PanelDescription>ADV7533 DSI2HDMI (1920x1080 24bpp)</PanelDescription>
    <Group id='EDID Configuration'>
        <ManufactureID>0xAF0D</ManufactureID>
        <ProductCode>0x0011</ProductCode>
        <SerialNumber>0x000000</SerialNumber>
        <WeekofManufacture>0x09</WeekofManufacture>
        <YearofManufacture>0x13</YearofManufacture>
        <EDIDVersion>1</EDIDVersion>
        <EDIDRevision>3</EDIDRevision>
        <VideoInputDefinition>0x80</VideoInputDefinition>
        <HorizontalScreenSize>0x16</HorizontalScreenSize>
        <VerticalScreenSize>0x0D</VerticalScreenSize>
        <DisplayTransferCharacteristics>0x78</DisplayTransferCharacteristics>
        <FeatureSupport>0xA</FeatureSupport>
        <Red.GreenBits>0xCF</Red.GreenBits>
        <Blue.WhiteBits>0x45</Blue.WhiteBits>
        <RedX>0x90</RedX>
        <RedY>0x59</RedY>
        <GreenX>0x57</GreenX>
        <GreenY>0x95</GreenY>
        <BlueX>0x29</BlueX>
        <BlueY>0x1f</BlueY>
        <WhiteX>0x50</WhiteX>
        <WhiteY>0x54</WhiteY>
        <EstablishedTimingsI>0x0</EstablishedTimingsI>
        <EstablishedTimingsII>0x0</EstablishedTimingsII>
        <ManufacturesTiming>0x0</ManufacturesTiming>
        <StandardTimings1/>
        <StandardTimings2/>
        <StandardTimings3/>
        <StandardTimings4/>
        <StandardTimings5/>
        <StandardTimings6/>
        <StandardTimings7/>
        <SignalTimingInterface/>
    </Group>
    <Group id='Active Timing'>
        <HorizontalActive units='Dot Clocks'>1920</HorizontalActive>
        <HorizontalFrontPorch units='Dot Clocks'>88</HorizontalFrontPorch>
        <HorizontalBackPorch units='Dot Clocks'>148</HorizontalBackPorch>
        <HorizontalSyncPulse units='Dot Clocks'>44</HorizontalSyncPulse>
        <HorizontalSyncSkew units='Dot Clocks'>0</HorizontalSyncSkew>
        <HorizontalLeftBorder units='Dot Clocks'>0</HorizontalLeftBorder>
        <HorizontalRightBorder units='Dot Clocks'>0</HorizontalRightBorder>
        <VerticalActive units='Dot Clocks'>1080</VerticalActive>
        <VerticalFrontPorch units='Lines'>4</VerticalFrontPorch>
        <VerticalBackPorch units='Lines'>36</VerticalBackPorch>
        <VerticalSyncPulse units='Lines'>5</VerticalSyncPulse>
        <VerticalSyncSkew units='Lines'>0</VerticalSyncSkew>
        <VerticalTopBorder units='Lines'>0</VerticalTopBorder>
        <VerticalBottomBorder units='Lines'>0</VerticalBottomBorder>
        <InvertDataPolarity>False</InvertDataPolarity>
        <InvertVsyncPolairty>False</InvertVsyncPolairty>
        <InvertHsyncPolarity>False</InvertHsyncPolarity>
        <BorderColor>0x0</BorderColor>
    </Group>
    <Group id='Display Interface'>
        <InterfaceType units='QDI_DisplayConnectType'>8</InterfaceType>
        <InterfaceColorFormat units='QDI_PixelFormatType'>3</InterfaceColorFormat>
    </Group>
    <Group id='DSI Interface'>
        <DSIChannelId units='DSI_Channel_IDType'>1</DSIChannelId>
        <DSIVirtualId units='DSI_Display_VCType'>0</DSIVirtualId>
        <DSIColorFormat units='DSI_ColorFormatType'>36</DSIColorFormat>
        <DSITrafficMode units='DSI_TrafficModeType'>0</DSITrafficMode>
        <DSILanes units='integer'>4</DSILanes>
        <DSIHsaHseAfterVsVe units='Bool'>False</DSIHsaHseAfterVsVe>
        <DSILowPowerModeInHFP units='Bool'>False</DSILowPowerModeInHFP>
        <DSILowPowerModeInHBP units='Bool'>False</DSILowPowerModeInHBP>
        <DSILowPowerModeInHSA units='Bool'>False</DSILowPowerModeInHSA>
        <DSILowPowerModeInBLLPEOF units='Bool'>False</DSILowPowerModeInBLLPEOF>
        <DSILowPowerModeInBLLP units='Bool'>False</DSILowPowerModeInBLLP>
        <DSIRefreshRate units='integer Q16.16'>0x3C0000</DSIRefreshRate>
        <DSIPhyDCDCMode units='Bool'>False</DSIPhyDCDCMode>
    </Group>
    <DSII2CSlaveAddressList units='int'>0x39 0x3C</DSII2CSlaveAddressList>
    <DSII2CI2CNumOfSlaves units='int'>0x2</DSII2CI2CNumOfSlaves>
    <DSII2CFrequency units='int'>0x190</DSII2CFrequency>
    <DSII2CGSBIPort units='int'>0x4</DSII2CGSBIPort>"})
	
Name (PCF1, 
  Buffer() {"<?xml version=\1.0\ encoding=\utf-8\?>	
	<PanelName>ADV7533</PanelName>
	<PanelDescription>ADV7533 DSI2HDMI (1280x720 24bpp)</PanelDescription>
	<Group id='EDID Configuration'>
		<ManufactureID>0xAF0D</ManufactureID>
		<ProductCode>0x0011</ProductCode>
		<SerialNumber>0x000000</SerialNumber>
		<WeekofManufacture>0x09</WeekofManufacture>
		<YearofManufacture>0x13</YearofManufacture>
		<EDIDVersion>1</EDIDVersion>
		<EDIDRevision>3</EDIDRevision>
		<VideoInputDefinition>0x80</VideoInputDefinition>
		<HorizontalScreenSize>0x16</HorizontalScreenSize>
		<VerticalScreenSize>0x0D</VerticalScreenSize>
		<DisplayTransferCharacteristics>0x78</DisplayTransferCharacteristics>
		<FeatureSupport>0xA</FeatureSupport>
		<Red.GreenBits>0xCF</Red.GreenBits>
		<Blue.WhiteBits>0x45</Blue.WhiteBits>
		<RedX>0x90</RedX>
		<RedY>0x59</RedY>
		<GreenX>0x57</GreenX>
		<GreenY>0x95</GreenY>
		<BlueX>0x29</BlueX>
		<BlueY>0x1f</BlueY>
		<WhiteX>0x50</WhiteX>
		<WhiteY>0x54</WhiteY>
		<EstablishedTimingsI>0x0</EstablishedTimingsI>
		<EstablishedTimingsII>0x0</EstablishedTimingsII>
		<ManufacturesTiming>0x0</ManufacturesTiming>
		<StandardTimings1/>
		<StandardTimings2/>
		<StandardTimings3/>
		<StandardTimings4/>
		<StandardTimings5/>
		<StandardTimings6/>
		<StandardTimings7/>
		<SignalTimingInterface/>
	</Group>
	<Group id='Active Timing'>
		<HorizontalActive units='Dot Clocks'>1280</HorizontalActive>
		<HorizontalFrontPorch units='Dot Clocks'>110</HorizontalFrontPorch>
		<HorizontalBackPorch units='Dot Clocks'>220</HorizontalBackPorch>
		<HorizontalSyncPulse units='Dot Clocks'>40</HorizontalSyncPulse>
		<HorizontalSyncSkew units='Dot Clocks'>0</HorizontalSyncSkew>
		<HorizontalLeftBorder units='Dot Clocks'>0</HorizontalLeftBorder>
		<HorizontalRightBorder units='Dot Clocks'>0</HorizontalRightBorder>
		<VerticalActive units='Dot Clocks'>720</VerticalActive>
		<VerticalFrontPorch units='Lines'>5</VerticalFrontPorch>
		<VerticalBackPorch units='Lines'>20</VerticalBackPorch>
		<VerticalSyncPulse units='Lines'>5</VerticalSyncPulse>
		<VerticalSyncSkew units='Lines'>0</VerticalSyncSkew>
		<VerticalTopBorder units='Lines'>0</VerticalTopBorder>
		<VerticalBottomBorder units='Lines'>0</VerticalBottomBorder>
		<InvertDataPolarity>False</InvertDataPolarity>
		<InvertVsyncPolairty>False</InvertVsyncPolairty>
		<InvertHsyncPolarity>False</InvertHsyncPolarity>
		<BorderColor>0x0</BorderColor>
	</Group>
	<Group id='Display Interface'>
		<InterfaceType units='QDI_DisplayConnectType'>8</InterfaceType>
		<InterfaceColorFormat units='QDI_PixelFormatType'>3</InterfaceColorFormat>
	</Group>
	<Group id='DSI Interface'>
		<DSIChannelId units='DSI_Channel_IDType'>1</DSIChannelId>
		<DSIVirtualId units='DSI_Display_VCType'>0</DSIVirtualId>
		<DSIColorFormat units='DSI_ColorFormatType'>36</DSIColorFormat>
		<DSITrafficMode units='DSI_TrafficModeType'>0</DSITrafficMode>
		<DSILanes units='integer'>3</DSILanes>
		<DSIHsaHseAfterVsVe units='Bool'>False</DSIHsaHseAfterVsVe>
		<DSILowPowerModeInHFP units='Bool'>False</DSILowPowerModeInHFP>
		<DSILowPowerModeInHBP units='Bool'>False</DSILowPowerModeInHBP>
		<DSILowPowerModeInHSA units='Bool'>False</DSILowPowerModeInHSA>
		<DSILowPowerModeInBLLPEOF units='Bool'>False</DSILowPowerModeInBLLPEOF>
		<DSILowPowerModeInBLLP units='Bool'>False</DSILowPowerModeInBLLP>
		<DSIRefreshRate units='integer Q16.16'>0x3C0000</DSIRefreshRate>
		<DSIPhyDCDCMode units='Bool'>False</DSIPhyDCDCMode>
	</Group>
	<DSII2CSlaveAddressList units='int'>0x39 0x3C</DSII2CSlaveAddressList>
	<DSII2CI2CNumOfSlaves units='int'>0x2</DSII2CI2CNumOfSlaves>
	<DSII2CFrequency units='int'>0x190</DSII2CFrequency>
	<DSII2CGSBIPort units='int'>0x4</DSII2CGSBIPort>"})
	
Name (PCF2, 
  Buffer() {"<?xml version='1.0' encoding='utf-8'?>
    <Group id='Main Panel'>
    <PanelName>TDO-HD0466K40002-0810</PanelName>
    <PanelDescription>Command mode 720pHD Truly DSI Panel (720x1280 24bpp)</PanelDescription>

    <Group id='EDID Configuration'>
        <ManufactureID>0xAF0D</ManufactureID>
        <ProductCode>0x0011</ProductCode>
        <SerialNumber>0x000000</SerialNumber>
        <WeekofManufacture>0x09</WeekofManufacture>
        <YearofManufacture>0x13</YearofManufacture>
        <EDIDVersion>1</EDIDVersion>
        <EDIDRevision>3</EDIDRevision>
        <VideoInputDefinition>0x80</VideoInputDefinition>
        <HorizontalScreenSize>0x05</HorizontalScreenSize>
        <VerticalScreenSize>0x0A</VerticalScreenSize>
        <DisplayTransferCharacteristics>0x78</DisplayTransferCharacteristics>
        <FeatureSupport>0xA</FeatureSupport>
        <Red.GreenBits>0xCF</Red.GreenBits>
        <Blue.WhiteBits>0x45</Blue.WhiteBits>
        <RedX>0x90</RedX>
        <RedY>0x59</RedY>
        <GreenX>0x57</GreenX>
        <GreenY>0x95</GreenY>
        <BlueX>0x29</BlueX>
        <BlueY>0x1f</BlueY>
        <WhiteX>0x50</WhiteX>
        <WhiteY>0x54</WhiteY>
        <EstablishedTimingsI>0x0</EstablishedTimingsI>
        <EstablishedTimingsII>0x0</EstablishedTimingsII>
        <ManufacturesTiming>0x0</ManufacturesTiming>
        <StandardTimings1/>
        <StandardTimings2/>
        <StandardTimings3/>
        <StandardTimings4/>
        <StandardTimings5/>
        <StandardTimings6/>
        <StandardTimings7/>
        <SignalTimingInterface/>
    </Group>

    <Group id='Detailed Timing'>
        <HorizontalScreenSizeMM>0x3A</HorizontalScreenSizeMM>
        <VerticalScreenSizeMM>0x67</VerticalScreenSizeMM>
        <HorizontalVerticalScreenSizeMM>0x00</HorizontalVerticalScreenSizeMM>
    </Group> 

    <Group id='Active Timing'>
        <HorizontalActive units='Dot Clocks'>720</HorizontalActive>
        <HorizontalFrontPorch units='Dot Clocks'>164</HorizontalFrontPorch>
        <HorizontalBackPorch units='Dot Clocks'>140</HorizontalBackPorch>
        <HorizontalSyncPulse units='Dot Clocks'>8</HorizontalSyncPulse>
        <HorizontalSyncSkew units='Dot Clocks'>0</HorizontalSyncSkew>
        <HorizontalLeftBorder units='Dot Clocks'>0</HorizontalLeftBorder>
        <HorizontalRightBorder units='Dot Clocks'>0</HorizontalRightBorder>
        <VerticalActive units='Dot Clocks'>1280</VerticalActive>
        <VerticalFrontPorch units='Lines'>6</VerticalFrontPorch>
        <VerticalBackPorch units='Lines'>1</VerticalBackPorch>
        <VerticalSyncPulse units='Lines'>1</VerticalSyncPulse>
        <VerticalSyncSkew units='Lines'>0</VerticalSyncSkew>
        <VerticalTopBorder units='Lines'>0</VerticalTopBorder>
        <VerticalBottomBorder units='Lines'>0</VerticalBottomBorder>
        <InvertDataPolarity>False</InvertDataPolarity>
        <InvertVsyncPolairty>False</InvertVsyncPolairty>
        <InvertHsyncPolarity>False</InvertHsyncPolarity>
        <BorderColor>0x0</BorderColor>
    </Group>

    <Group id='Display Interface'>
        <InterfaceType units='QDI_DisplayConnectType'>9</InterfaceType>
        <InterfaceColorFormat units='QDI_PixelFormatType'>3</InterfaceColorFormat>
        <DisplayRecoveryThreshold>0x3C</DisplayRecoveryThreshold>
        <DisplayPrimaryFlags units='QDI_Panel_FlagsType'>0x00000010<DisplayPrimaryFlags>
        <DisplayPowerSavingOverride>0x2</DisplayPowerSavingOverride>
    </Group>

    <Group id='DSI Interface'>
        <DSIChannelId units='DSI_Channel_IDType'>2</DSIChannelId>
        <DSIVirtualId units='DSI_Display_VCType'>0</DSIVirtualId>
        <DSIColorFormat units='DSI_ColorFormatType'>36</DSIColorFormat>
        <DSITrafficMode units='DSI_TrafficModeType'>1</DSITrafficMode>
        <DSILanes units='integer'>4</DSILanes>
        <DSIHsaHseAfterVsVe units='Bool'>False</DSIHsaHseAfterVsVe>
        <DSILowPowerModeInHFP units='Bool'>False</DSILowPowerModeInHFP>
        <DSILowPowerModeInHBP units='Bool'>False</DSILowPowerModeInHBP>
        <DSILowPowerModeInHSA units='Bool'>False</DSILowPowerModeInHSA>
        <DSILowPowerModeInBLLPEOF units='Bool'>False</DSILowPowerModeInBLLPEOF>
        <DSILowPowerModeInBLLP units='Bool'>True</DSILowPowerModeInBLLP>
        <DSIRefreshRate units='integer Q16.16'>0x3C0000</DSIRefreshRate>
        <DSIPhyDCDCMode units='Bool'>True</DSIPhyDCDCMode>
        <DSIEnterULPSPowerDown units='Bool'>True</DSIEnterULPSPowerDown>
        <DSITEUsingDedicatedTEPin units='Bool'>True</DSITEUsingDedicatedTEPin> 
        <DSIBitClkScalePercent  uints='Percent'>15</DSIBitClkScalePercent>
    </Group>

    <DSIInitSequence>
        15 FF EE
        15 26 08
        15 26 00
        15 FF 00
        FF 0A
        15 BA 03
        15 C2 08
        15 FF 01
        15 FB 01
        15 00 4A
        15 01 33
        15 02 53
        15 03 55
        15 04 55
        15 05 33
        15 06 22
        15 08 56
        15 09 8F
        15 36 73
        15 0B 9F
        15 0C 9F
        15 0D 2F
        15 0E 24
        15 11 83
        15 12 03
        15 71 2C
        15 6F 03
        15 0F 0A
        15 FF 05
        15 FB 01
        15 01 00
        15 02 82
        15 03 82
        15 04 82
        15 05 30
        15 06 33
        15 07 01
        15 08 00
        15 09 46
        15 0A 46
        15 0D 0B
        15 0E 1D
        15 0F 08
        15 10 53
        15 11 00
        15 12 00
        15 14 01
        15 15 00
        15 16 05
        15 17 00
        15 19 7F
        15 1A FF
        15 1B 0F
        15 1C 00
        15 1D 00
        15 1E 00
        15 1F 07
        15 20 00
        15 21 06
        15 22 55
        15 23 4D
        15 2D 02
        15 28 01
        15 2F 02
        15 83 01
        15 9E 58
        15 9F 6A
        15 A0 01
        15 A2 10
        15 BB 0A
        15 BC 0A
        15 32 08
        15 33 B8
        15 36 01
        15 37 00
        15 43 00
        15 4B 21
        15 4C 03
        15 50 21
        15 51 03
        15 58 21
        15 59 03
        15 5D 21
        15 5E 03
        15 6C 00
        15 6D 00
        15 FB 01
        15 FF 01
        15 FB 01
        15 75 00
        15 76 7D
        15 77 00
        15 78 8A
        15 79 00
        15 7A 9C
        15 7B 00
        15 7C B1
        15 7D 00
        15 7E BF
        15 7F 00
        15 80 CF
        15 81 00
        15 82 DD
        15 83 00
        15 84 E8
        15 85 00
        15 86 F2
        15 87 01
        15 88 1F
        15 89 01
        15 8A 41
        15 8B 01
        15 8C 78
        15 8D 01
        15 8E A5
        15 8F 01
        15 90 EE
        15 91 02
        15 92 29
        15 93 02
        15 94 2A
        15 95 02
        15 96 5D
        15 97 02
        15 98 93
        15 99 02
        15 9A B8
        15 9B 02
        15 9C E7
        15 9D 03
        15 9E 07
        15 9F 03
        15 A0 37
        15 A2 03
        15 A3 46
        15 A4 03
        15 A5 56
        15 A6 03
        15 A7 66
        15 A9 03
        15 AA 7A
        15 AB 03
        15 AC 93
        15 AD 03
        15 AE A3
        15 AF 03
        15 B0 B4
        15 B1 03
        15 B2 CB
        15 B3 00
        15 B4 7D
        15 B5 00
        15 B6 8A
        15 B7 00
        15 B8 9C
        15 B9 00
        15 BA B1
        15 BB 00
        15 BC BF
        15 BD 00
        15 BE CF
        15 BF 00
        15 C0 DD
        15 C1 00
        15 C2 E8
        15 C3 00
        15 C4 F2
        15 C5 01
        15 C6 1F
        15 C7 01
        15 C8 41
        15 C9 01
        15 CA 78
        15 CB 01
        15 CC A5
        15 CD 01
        15 CE EE
        15 CF 02
        15 D0 29
        15 D1 02
        15 D2 2A
        15 D3 02
        15 D4 5D
        15 D5 02
        15 D6 93
        15 D7 02
        15 D8 B8
        15 D9 02
        15 DA E7
        15 DB 03
        15 DC 07
        15 DD 03
        15 DE 37
        15 DF 03
        15 E0 46
        15 E1 03
        15 E2 56
        15 E3 03
        15 E4 66
        15 E5 03
        15 E6 7A
        15 E7 03
        15 E8 93
        15 E9 03
        15 EA A3
        15 EB 03
        15 EC B4
        15 ED 03
        15 EE CB
        15 EF 00
        15 F0 ED
        15 F1 00
        15 F2 F3
        15 F3 00
        15 F4 FE
        15 F5 01
        15 F6 09
        15 F7 01
        15 F8 13
        15 F9 01
        15 FA 1D
        15 FF 02
        15 FB 01
        15 00 01
        15 01 26
        15 02 01
        15 03 2F
        15 04 01
        15 05 37
        15 06 01
        15 07 56
        15 08 01
        15 09 70
        15 0A 01
        15 0B 9D
        15 0C 01
        15 0D C2
        15 0E 01
        15 0F FF
        15 10 02
        15 11 31
        15 12 02
        15 13 32
        15 14 02
        15 15 60
        15 16 02
        15 17 94
        15 18 02
        15 19 B5
        15 1A 02
        15 1B E3
        15 1C 03
        15 1D 03
        15 1E 03
        15 1F 2D
        15 20 03
        15 21 3A
        15 22 03
        15 23 48
        15 24 03
        15 25 57
        15 26 03
        15 27 68
        15 28 03
        15 29 7B
        15 2A 03
        15 2B 90
        15 2D 03
        15 2F A0
        15 30 03
        15 31 CB
        15 32 00
        15 33 ED
        15 34 00
        15 35 F3
        15 36 00
        15 37 FE
        15 38 01
        15 39 09
        15 3A 01
        15 3B 13
        15 3D 01
        15 3F 1D
        15 40 01
        15 41 26
        15 42 01
        15 43 2F
        15 44 01
        15 45 37
        15 46 01
        15 47 56
        15 48 01
        15 49 70
        15 4A 01
        15 4B 9D
        15 4C 01
        15 4D C2
        15 4E 01
        15 4F FF
        15 50 02
        15 51 31
        15 52 02
        15 53 32
        15 54 02
        15 55 60
        15 56 02
        15 58 94
        15 59 02
        15 5A B5
        15 5B 02
        15 5C E3
        15 5D 03
        15 5E 03
        15 5F 03
        15 60 2D
        15 61 03
        15 62 3A
        15 63 03
        15 64 48
        15 65 03
        15 66 57
        15 67 03
        15 68 68
        15 69 03
        15 6A 7B
        15 6B 03
        15 6C 90
        15 6D 03
        15 6E A0
        15 6F 03
        15 70 CB
        15 71 00
        15 72 19
        15 73 00
        15 74 36
        15 75 00
        15 76 55
        15 77 00
        15 78 70
        15 79 00
        15 7A 83
        15 7B 00
        15 7C 99
        15 7D 00
        15 7E A8
        15 7F 00
        15 80 B7
        15 81 00
        15 82 C5
        15 83 00
        15 84 F7
        15 85 01
        15 86 1E
        15 87 01
        15 88 60
        15 89 01
        15 8A 95
        15 8B 01
        15 8C E1
        15 8D 02
        15 8E 20
        15 8F 02
        15 90 23
        15 91 02
        15 92 59
        15 93 02
        15 94 94
        15 95 02
        15 96 B4
        15 97 02
        15 98 E1
        15 99 03
        15 9A 01
        15 9B 03
        15 9C 28
        15 9D 03
        15 9E 30
        15 9F 03
        15 A0 37
        15 A2 03
        15 A3 3B
        15 A4 03
        15 A5 40
        15 A6 03
        15 A7 50
        15 A9 03
        15 AA 6D
        15 AB 03
        15 AC 80
        15 AD 03
        15 AE CB
        15 AF 00
        15 B0 19
        15 B1 00
        15 B2 36
        15 B3 00
        15 B4 55
        15 B5 00
        15 B6 70
        15 B7 00
        15 B8 83
        15 B9 00
        15 BA 99
        15 BB 00
        15 BC A8
        15 BD 00
        15 BE B7
        15 BF 00
        15 C0 C5
        15 C1 00
        15 C2 F7
        15 C3 01
        15 C4 1E
        15 C5 01
        15 C6 60
        15 C7 01
        15 C8 95
        15 C9 01
        15 CA E1
        15 CB 02
        15 CC 20
        15 CD 02
        15 CE 23
        15 CF 02
        15 D0 59
        15 D1 02
        15 D2 94
        15 D3 02
        15 D4 B4
        15 D5 02
        15 D6 E1
        15 D7 03
        15 D8 01
        15 D9 03
        15 DA 28
        15 DB 03
        15 DC 30
        15 DD 03
        15 DE 37
        15 DF 03
        15 E0 3B
        15 E1 03
        15 E2 40
        15 E3 03
        15 E4 50
        15 E5 03
        15 E6 6D
        15 E7 03
        15 E8 80
        15 E9 03
        15 EA CB
        15 FF 01
        15 FB 01
        15 FF 02
        15 FB 01  
        15 FF 04
        15 FB 01
        15 FF 00
        05 11 
        FF 64
        15 FF EE
        15 12 50
        15 13 02
        15 6A 60
        15 FF 00
        FE 00 00 00
        05 29
        15 35 00
    </DSIInitSequence>
    <DSITermSequence>
        05 28 00
        FF 32
        05 10 00
        FF 78
    </DSITermSequence>

     <Group id='Backlight Configuration'>
        <BacklightType units='QDI_Panel_BacklightType'>1</BacklightType>
        <BacklightPmicModel units='QDI_PMICDeviceIdType'>11</BacklightPmicModel>
        <BacklightPmicControlType units='QDI_PmicModuleControlType'>0</BacklightPmicControlType>
        <BacklightPMICNum units='int'>0</BacklightPMICNum>
        <BacklightPMICBankSelect units='int'>0</BacklightPMICBankSelect>
        <BacklightPmicPWMSizeinBits units='integer'>6</BacklightPmicPWMSizeinBits>
        <BacklightPmicPWMGlitchRemoval units='Bool'>True</BacklightPmicPWMGlitchRemoval>
        <BacklightPMICPWMFrequency units='Hz'>50000</BacklightPMICPWMFrequency>
        <BacklightSteps units='Percentage'>100</BacklightSteps>
        <BacklightDefault units='Percentage'>80</BacklightDefault>
        <BacklightLowPower units='Percentage'>40</BacklightLowPower>
    </Group>

    <Group id='Connection Configuration'>
        <Display1Reset1Info>DSI_PANEL_RESET, 0, 10, 1</Display1Reset1Info>
    </Group>
</Group>"})