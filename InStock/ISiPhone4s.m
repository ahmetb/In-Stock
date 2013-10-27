//
//  ISiPhone4S.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPhone4s.h"

@implementation ISiPhone4s

+(NSString*)name{
    return @"iPhone 4s";
}

+(NSString *)iconImageName{
    return @"iphone.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomiPhoneColor),
             N(ISIdiomNetworkCarrier)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomiPhoneColor:
            return @[N(ISiPhoneColorBlack), N(ISiPhoneColorWhite)];
        case ISIdiomNetworkCarrier:
            return @[N(ISNetworkCarrierAtt),
                     N(ISNetworkCarrierSprint),
                     N(ISNetworkCarrierVerizon),
                     N(ISNetworkCarrierTmobileContractFree),
                     N(ISNetworkCarrierUnlockedSimFree)];
                     
        default:
            return nil; // no restrictions for the rest
    }
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISiPhoneColor color = [[dict valueForKey:[N(ISIdiomiPhoneColor) stringValue]] integerValue];
    ISNetworkCarrier carrier = [[dict valueForKey:[N(ISIdiomNetworkCarrier) stringValue]] integerValue];
    
    const int base = 257;
    int sku = base;
    sku += (color == ISiPhoneColorBlack) ? 0 : 1;
    
    sku += (carrier == ISNetworkCarrierAtt) ? 0 :
    (carrier == ISNetworkCarrierSprint) ? 12 :
    (carrier == ISNetworkCarrierVerizon) ? 2 :
    (carrier == ISNetworkCarrierTmobileContractFree) ? 4 : 6; // (unlocked);
    
    return [NSString stringWithFormat:@"MF%dLL/A", sku];
}

@end
