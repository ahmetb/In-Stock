//
//  ISiPhone5c.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPhone5c.h"


@implementation ISiPhone5c

+(NSString*)name{
    return @"iPhone 5c";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomiPhoneColor),
             N(ISIdiomMobileDeviceCapacity),
             N(ISIdiomNetworkCarrier)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomiPhoneColor:
            return @[N(ISiPhoneColorWhite),
                     N(ISiPhoneColorPink),
                     N(ISiPhoneColorYellow),
                     N(ISiPhoneColorBlue),
                     N(ISiPhoneColorGreen)
                     ];
        case ISIdiomMobileDeviceCapacity:
            return @[N(ISMobileDeviceCapacity16GB),
                     N(ISMobileDeviceCapacity32GB)];
        case ISIdiomNetworkCarrier:
            return @[N(ISNetworkCarrierAtt),
                     N(ISNetworkCarrierSprint),
                     N(ISNetworkCarrierVerizon),
                     N(ISNetworkCarrierTmobileContractFree),
                     N(ISNetworkCarrierUnlockedSimFree),
                     ];
        default:
            return nil; // no restrictions for the rest
    }
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISiPhoneColor color = [[dict valueForKey:[N(ISIdiomiPhoneColor) stringValue]] integerValue];
    ISMobileDeviceCapacity model = [[dict valueForKey:[N(ISIdiomMobileDeviceCapacity) stringValue]] integerValue];
    ISNetworkCarrier carrier = [[dict valueForKey:[N(ISIdiomNetworkCarrier) stringValue]] integerValue];
    
    const int skuBase16GB = 493;
    const int skuBase32GB = 129;
    const int kColor = 1;

    int sku = (model == ISMobileDeviceCapacity16GB) ? skuBase16GB : skuBase32GB;
    
    int colorFactor = (color == ISiPhoneColorWhite) ? 0 :
                        (color == ISiPhoneColorYellow) ? 1 :
                        (color == ISiPhoneColorBlue) ? 2 :
                        (color == ISiPhoneColorGreen) ? 3 : 4; // (...Pink)
    sku += colorFactor * kColor;
    
    int carrFactor;
    NSString* baseFormat;
    if (model == ISMobileDeviceCapacity16GB){
        baseFormat = @"ME%dLL/A";
        carrFactor = (carrier == ISNetworkCarrierAtt) ? 12 :
        (carrier == ISNetworkCarrierSprint) ? 72 :
        (carrier == ISNetworkCarrierVerizon) ? 60 :
        (carrier == ISNetworkCarrierTmobileContractFree) ? 36 : 0; //(..UnlockedSimFree)
    } else { // 32 GB
        baseFormat = @"ME%dLL/A";
        carrFactor = (carrier == ISNetworkCarrierAtt) ? 5 :
        (carrier == ISNetworkCarrierSprint) ? 30 :
        (carrier == ISNetworkCarrierVerizon) ? 25 :
        (carrier == ISNetworkCarrierTmobileContractFree) ? 15 : 0; //(..UnlockedSimFree)
    }
    sku += carrFactor;
    return [NSString stringWithFormat:baseFormat, sku];
}

@end
