//
//  ISMacBookProRetina.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISMacBookProRetina.h"

@implementation ISMacBookProRetina

+(NSString*)name{
    return @"Macbook Pro Retina";
}

+(NSString *)fullName{
    return @"Macbook Pro with Retina";
}

+(NSString *)iconImageName{
    return @"laptop.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomMacBookScreenSize), N(ISIdiomMacBookProConfiguration)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomMacBookScreenSize:
            return @[N(ISMacBookScreenSize13inch),
                     N(ISMacBookScreenSize15inch)];
        default:
            break;
    }
    NSLog(@"unhandled idiom: %d", (int)idiom);
    return nil;
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom inIdiomsAndValues:(NSDictionary *)responses{
    if (idiom == ISIdiomMacBookProConfiguration) {
        ISMacBookScreenSize size = [[responses valueForKey:[N(ISIdiomMacBookScreenSize) stringValue]] integerValue];
        
        switch (size) {
            case ISMacBookScreenSize13inch:
                return @[N(ISMacBookProConfiguration2_4GHz_i5_4GBMemory_128GBDisk),
                         N(ISMacBookProConfiguration2_4GHz_i5_8GBMemory_256GBDisk),
                         N(ISMacBookProConfiguration2_6GHz_i5_8GBMemory_512GBDisk)];
            default:
                return @[N(ISMacBookProConfiguration2_0GHz_i7_8GBMemory_256GBDisk),
                         N(ISMacBookProConfiguration2_3GHz_i7_16GBMemory_512GBDisk)];
         }
    }
    return [self applicableOptionsForIdiom:idiom];
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISMacBookProConfiguration config = [[dict valueForKey:[N(ISIdiomMacBookProConfiguration) stringValue]] integerValue];
    switch (config) {
        case ISMacBookProConfiguration2_4GHz_i5_4GBMemory_128GBDisk:
            return @"ME864LL/A";
        case ISMacBookProConfiguration2_4GHz_i5_8GBMemory_256GBDisk:
            return @"ME865LL/A";
        case ISMacBookProConfiguration2_6GHz_i5_8GBMemory_512GBDisk:
            return @"ME866LL/A";
        case ISMacBookProConfiguration2_0GHz_i7_8GBMemory_256GBDisk:
            return @"ME293LL/A";
        case ISMacBookProConfiguration2_3GHz_i7_16GBMemory_512GBDisk:
            return @"ME294LL/A";
        default:
            break;
    }
    NSLog(@"Invalid MacBook Pro Retina configuration");
    return nil;
}

@end
