//
//  ISMacBookAir.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISMacBookAir.h"

@implementation ISMacBookAir

+(NSString *)name{
    return @"MacBook Air";
}

+(NSString *)iconImageName{
    return @"laptop.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomMacBookScreenSize),
             N(ISIdiomMacBookAirConfiguration)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomMacBookScreenSize:
            return @[N(ISMacBookScreenSize11inch),
                     N(ISMacBookScreenSize13inch)];
        case ISIdiomMacBookAirConfiguration:
            return @[N(ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_128GBDisk),
                     N(ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_256GBDisk)];
        default:
            break;
    }
    NSLog(@"unhandled idiom: %d", (int)idiom);
    return nil;
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISMacBookScreenSize size = [[dict valueForKey:[N(ISIdiomMacBookScreenSize) stringValue]] integerValue];
    ISMacBookAirConfiguration config = [[dict valueForKey:[N(ISIdiomMacBookAirConfiguration) stringValue]] integerValue];
    
    switch (size) {
        case ISMacBookScreenSize11inch:
            return (config == ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_128GBDisk) ? @"MD711LL/A" : @"MD712LL/A";
        case ISMacBookScreenSize13inch:
            return (config == ISMacBookAirConfiguration1_3GHz_i5_4GBMemory_128GBDisk) ? @"MD706LL/A" : @"MD761LL/A";
        default:
            break;
    }
    NSLog(@"unhandled MacBook Air screen size");
    return nil;
}

@end
