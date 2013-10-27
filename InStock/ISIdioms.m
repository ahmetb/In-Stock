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
                 N(ISIdiomMacMini) : @"Select your Mac mini",
                 N(ISIdiomiMacConfiguration) : @"Select your iMac",
                 N(ISIdiomMacProConfiguration) : @"Select your Mac Pro",
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
                 N(ISNetworkCarrierUnlockedSimFree) : @"SIM-Free (Unlocked)"
                 },
         N(ISIdiomiPadType): @{
                 N(ISiPadTypeWifi) : @"Wi-Fi only",
                 N(ISiPadTypeWifiCellular) : @"Wi-Fi + 3G"
                 },
         N(ISIdiomMacBookScreenSize): @{
                 N(ISMacBookScreenSize11inch) : @"11-inch Display",
                 N(ISMacBookScreenSize13inch) : @"13-inch Display",
                 N(ISMacBookScreenSize15inch) : @"15-inch Display"
                 },
         N(ISIdiomMacMini): @{
                 N(ISMacMini2_3GHz) : @"2.3 GHz processor",
                 N(ISMacMini2_5GHz) : @"2.5 GHz processor",
                 N(ISMacMini2_3GHzWithOsXServer) : @"2.3 GHz with OS X Server"
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
                 }
                };
    
    NSString* name = [[names objectForKey:N(idiom)] objectForKey:N(option)];
    
    if(!name){
        NSLog(@"name for option not found.");
    }
    
    return name;
}

@end
