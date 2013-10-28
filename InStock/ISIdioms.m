//
//  ISIdioms.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISIdioms.h"

@implementation ISIdioms

+(NSString*)titleForIdiom:(ISIdiom)idiom{
    id names = @{
                 N(ISIdiomMobileDeviceCapacity) : @"Choose a model",
                 N(ISIdiomMacBookScreenSize) : @"Select display size",
                 N(ISIdiomMacMiniConfiguration) : @"Select your Mac mini",
                 N(ISIdiomiMacConfiguration) : @"Select your iMac",
                 N(ISIdiomMacProConfiguration) : @"Select your Mac Pro",
                 N(ISIdiomMacBookProConfiguration) : @"Select your MacBook Pro",
                 N(ISIdiomMacBookAirConfiguration) : @"Select your MacBook Air",
                 N(ISIdiomiPhoneColor) : @"Select a color",
                 N(ISIdiomiPadType) : @"Choose a model",
                 N(ISIdiomNetworkCarrier) : @"Select a wireless plan",
                 };
    NSString* name = [names objectForKey:N(idiom)];
    
    if(!name){
        NSLog(@"title for idiom not found.");
    }
    return name;

}

+(NSString*)nameForOption:(NSInteger)option inIdiom:(ISIdiom)idiom{
    id names = @{
         N(ISIdiomMobileDeviceCapacity): @{
                 N(ISMobileDeviceCapacity8GB) : @"8 GB",
                 N(ISMobileDeviceCapacity16GB) : @"16 GB",
                 N(ISMobileDeviceCapacity32GB) : @"32 GB",
                 N(ISMobileDeviceCapacity64GB) : @"64 GB",
                 N(ISMobileDeviceCapacity128GB) : @"128 GB"
                 },
         N(ISIdiomiPhoneColor): @{
                 N(ISiPhoneColorBlack) : @"Black",
                 N(ISiPhoneColorBlue) : @"Blue",
                 N(ISiPhoneColorGold) : @"Gold",
                 N(ISiPhoneColorGreen) : @"Green",
                 N(ISiPhoneColorPink) : @"Pink",
                 N(ISiPhoneColorSilver) : @"Silver",
                 N(ISiPhoneColorSpaceGray) : @"Space Gray",
                 N(ISiPhoneColorWhite) : @"White",
                 N(ISiPhoneColorYellow) : @"Yellow"
                 },
         N(ISIdiomNetworkCarrier): @{
                 N(ISNetworkCarrierAtt) : @"AT&T",
                 N(ISNetworkCarrierVerizon) : @"Verizon",
                 N(ISNetworkCarrierSprint) : @"Sprint",
                 N(ISNetworkCarrierTmobileContractFree) : @"T-Mobile (Unlocked)",
                 N(ISNetworkCarrierUnlockedSimFree) : @"SIM-Free (Unlocked)",
                 N(ISNetworkCarrierTmobile) : @"T-Mobile"
                 },
         N(ISIdiomiPadType): @{
                 N(ISiPadTypeWifi) : @"Wi-Fi only",
                 N(ISiPadTypeWifiCellular) : @"Wi-Fi + Cellular"
                 },
         N(ISIdiomMacBookScreenSize): @{
                 N(ISMacBookScreenSize11inch) : @"11-inch Display",
                 N(ISMacBookScreenSize13inch) : @"13-inch Display",
                 N(ISMacBookScreenSize15inch) : @"15-inch Display"
                 },
         N(ISIdiomMacMiniConfiguration): @{
                 N(ISMacMiniConfiguration2_3GHz) : @"2.3 GHz i5",
                 N(ISMacMiniConfiguration2_5GHz) : @"2.5 GHz i5",
                 N(ISMacMiniConfiguration2_3GHzWithOsXServer) : @"2.3 GHz i7 with OS X Server"
                 },
         N(ISIdiomMacProConfiguration): @{
                 N(ISMacProConfiguration4Core) : @"Quad-core processor",
                 N(ISMacProConfiguration6Core) : @"6-core processor",
                 },
         N(ISIdiomMacProConfiguration): @{
                 N(ISMacProConfiguration4Core) : @"Quad-core processor",
                 N(ISMacProConfiguration6Core) : @"6-core processor",
                 },
         N(ISIdiomiMacConfiguration): @{
                 N(ISiMacConfiguration21_5inch2_7GHz) : @"21-inch 2.7 GHz",
                 N(ISiMacConfiguration21_5inch2_9GHz) : @"21-inch 2.9 GHz",
                 N(ISiMacConfiguration27_5inch3_2GHz) : @"27-inch 3.2 GHz",
                 N(ISiMacConfiguration27_5inch3_4GHz) : @"27-inch 3.4 GHz",
                 },
         N(ISIdiomMacBookProConfiguration): @{
                 N(ISMacBookProConfiguration2_4GHz_i5_4GBMemory_128GBDisk) : @"2.4GHz i5 / 4GB RAM / 128 GB",
                 N(ISMacBookProConfiguration2_4GHz_i5_8GBMemory_256GBDisk) : @"2.4GHz i5 / 8GB RAM / 256 GB",
                 N(ISMacBookProConfiguration2_6GHz_i5_8GBMemory_512GBDisk) : @"2.6GHz i5 / 8GB RAM / 512 GB",
                 N(ISMacBookProConfiguration2_0GHz_i7_8GBMemory_256GBDisk) : @"2.0GHz i7 / 8GB RAM / 256 GB",
                 N(ISMacBookProConfiguration2_3GHz_i7_16GBMemory_512GBDisk) : @"2.3GHz i7 / 16GB RAM / 512 GB"
                 },
         N(ISIdiomMacBookAirConfiguration): @{
                 N(ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_128GBDisk) : @"1.3GHz i5 / 4GB RAM / 128 GB",
                 N(ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_256GBDisk) : @"1.3GHz i5 / 4GB RAM / 256 GB",
                 }
                };
    
    NSString* name = [[names objectForKey:N(idiom)] objectForKey:N(option)];
    
    if(!name){
        NSLog(@"name for option not found.");
    }
    
    return name;
}

@end
