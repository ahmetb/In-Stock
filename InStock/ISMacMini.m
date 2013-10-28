//
//  ISMacMini.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/28/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISMacMini.h"

@implementation ISMacMini

+(NSString*)name{
    return @"Mac Mini";
}

+(NSString *)iconImageName{
    return @"laptop.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomMacMiniConfiguration)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomMacMiniConfiguration:
            return @[N(ISMacMiniConfiguration2_3GHz),
                     N(ISMacMiniConfiguration2_5GHz),
                     N(ISMacMiniConfiguration2_3GHzWithOsXServer)];
        default:
            break;
    }
    NSLog(@"unhandled idiom: %d", (int)idiom);
    return nil;
}


+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISMacMiniConfiguration config = [[dict valueForKey:[N(ISIdiomMacMiniConfiguration) stringValue]] integerValue];
    switch (config) {
        case ISMacMiniConfiguration2_3GHz:
            return @"MD387LL/A";
        case ISMacMiniConfiguration2_5GHz:
            return @"MD388LL/A";
        case ISMacMiniConfiguration2_3GHzWithOsXServer:
            return @"MD389LL/A";
        default:
            break;
    }
    NSLog(@"Invalid MacBook Pro Retina configuration");
    return nil;
}

@end
