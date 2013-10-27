//
//  ISiPhone5s.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPhone5s.h"

@implementation ISiPhone5s

+(NSString*)name{
    return @"iPhone 5s";
}

+(NSString *)iconImageName{
    return @"iphone.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomiPhoneColor),
             N(ISIdiomMobileDeviceCapacity),
             N(ISIdiomNetworkCarrier)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomiPhoneColor:
            return @[N(ISiPhoneColorSpaceGray),
                    N(ISiPhoneColorGold),
                    N(ISiPhoneColorSilver)];
        case ISIdiomMobileDeviceCapacity:
            return @[N(ISMobileDeviceCapacity16GB),
                    N(ISMobileDeviceCapacity32GB),
                     N(ISMobileDeviceCapacity64GB)];
        case ISIdiomNetworkCarrier:
            return @[N(ISNetworkCarrierAtt),
                     N(ISNetworkCarrierSprint),
                     N(ISNetworkCarrierVerizon),
                     N(ISNetworkCarrierTmobileContractFree)];
        default:
            return nil; // no restrictions for the rest
    }
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISiPhoneColor color = [[dict valueForKey:[N(ISIdiomiPhoneColor) stringValue]] integerValue];
    ISMobileDeviceCapacity model = [[dict valueForKey:[N(ISIdiomMobileDeviceCapacity) stringValue]] integerValue];
    ISNetworkCarrier carrier = [[dict valueForKey:[N(ISIdiomNetworkCarrier) stringValue]] integerValue];
    
    const int skuBase = 305;
    const int kColor = 1;
    const int kSize = 3;
    const int kCarrier = 9;
    
    int sku = skuBase;
    int colorFactor = (color == ISiPhoneColorSpaceGray) ? 0 : (color == ISiPhoneColorSilver) ? 1 : 2;
    sku += colorFactor * kColor;
    int sizeFactor = (model == ISMobileDeviceCapacity16GB) ? 0 : (model == ISMobileDeviceCapacity32GB) ? 1 : 2;
    sku += sizeFactor * kSize;
    int carrFactor = (carrier == ISNetworkCarrierAtt) ? 0 :
                        (carrier == ISNetworkCarrierSprint) ? 5 :
                        (carrier == ISNetworkCarrierVerizon) ? 4 : 2; //(t-mobile)
    sku += carrFactor * kCarrier;
    return [NSString stringWithFormat:@"ME%dLL/A", sku];
}

@end
