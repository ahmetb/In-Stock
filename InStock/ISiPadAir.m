//
//  ISiPadAir.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPadAir.h"

@implementation ISiPadAir


+(NSString*)name{
    return @"iPad Air";
}

+(NSString *)iconImageName{
    return @"ipad.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomiPhoneColor),
             N(ISIdiomMobileDeviceCapacity),
             N(ISIdiomiPadType),
             N(ISIdiomNetworkCarrier)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomiPhoneColor:
            return @[N(ISiPhoneColorSpaceGray), N(ISiPhoneColorSilver)];
        case ISIdiomMobileDeviceCapacity:
            return @[N(ISMobileDeviceCapacity16GB),
                     N(ISMobileDeviceCapacity32GB),
                     N(ISMobileDeviceCapacity64GB),
                     N(ISMobileDeviceCapacity128GB)];
        case ISIdiomiPadType:
            return @[N(ISiPadTypeWifi), N(ISiPadTypeWifiCellular)];
        case ISIdiomNetworkCarrier:
            return @[N(ISNetworkCarrierAtt),
                     N(ISNetworkCarrierSprint),
                     N(ISNetworkCarrierTmobile),
                     N(ISNetworkCarrierVerizon)];
        default:
            return nil; // no restrictions for the rest
    }
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    ISiPhoneColor color = [[dict valueForKey:[N(ISIdiomiPhoneColor) stringValue]] integerValue];
    ISMobileDeviceCapacity model = [[dict valueForKey:[N(ISIdiomMobileDeviceCapacity) stringValue]] integerValue];
    ISiPadType type = [[dict valueForKey:[N(ISIdiomiPadType) stringValue]] integerValue];
    ISNetworkCarrier carrier = [[dict valueForKey:[N(ISIdiomNetworkCarrier) stringValue]] integerValue];
    
    switch (type) {
        case ISiPadTypeWifi:
            switch (model) {
                case ISMobileDeviceCapacity16GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"MD785LL/A" : @"MD788LL/A";
                case ISMobileDeviceCapacity32GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"MD786LL/A" : @"MD789LL/A";
                case ISMobileDeviceCapacity64GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"MD787LL/A" : @"MD790LL/A";
                default: //case ISMobileDeviceCapacity128GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"ME898LL/A" : @"ME906LL/A";
            }
        default: //case ISiPadTypeWifiCellular:
            switch (carrier) {
                case ISNetworkCarrierAtt:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"ME991LL/A" : @"ME997LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF003LL/A" : @"MF529LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF009LL/A" : @"MF012LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF015LL/A" : @"MF018LL/A";
                    }
                    break;
                case ISNetworkCarrierSprint:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF020LL/A" : @"MF021LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF024LL/A" : @"MF025LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF026LL/A" : @"MF027LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF028LL/A" : @"MF029LL/A";
                    }
                    break;
                case ISNetworkCarrierTmobile:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF496LL/A" : @"MF502LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF520LL/A" : @"MF527LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF534LL/A" : @"MF539LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF558LL/A" : @"MF563LL/A";
                    }
                    break;
                default: //case ISNetworkCarrierVerizon:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"ME993LL/A" : @"ME999LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF004LL/A" : @"MF532LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF010LL/A" : @"MF013LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF016LL/A" : @"MF019LL/A";
                    }
                    break;
            }
            break;
    }
    return @"Invalid";
}

+(BOOL)shouldAskIdiom:(ISIdiom)idiom forIdiomsAndValues:(NSDictionary*)responses{
    if (idiom == ISIdiomNetworkCarrier){
        // Do not ask for carrier on Wi-Fi only iPad.
        if ([[responses valueForKey:[N(ISIdiomiPadType) stringValue]] integerValue] == ISiPadTypeWifi){
            return NO;
        }
    }
    return YES;
}

@end
