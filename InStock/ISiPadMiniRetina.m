//
//  ISiPadMiniRetina.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPadMiniRetina.h"

@implementation ISiPadMiniRetina

+(NSString*)name{
    return @"iPad mini Retina";
}

+(NSString *)fullName{
    return @"iPad mini with Retina Display";
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
                    return (color == ISiPhoneColorSpaceGray) ? @"ME276LL/A" : @"ME279LL/A";
                case ISMobileDeviceCapacity32GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"ME277LL/A" : @"ME280LL/A";
                case ISMobileDeviceCapacity64GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"ME278LL/A" : @"ME281LL/A";
                default: //case ISMobileDeviceCapacity128GB:
                    return (color == ISiPhoneColorSpaceGray) ? @"ME856LL/A" : @"ME860LL/A";
            }
        default: //case ISiPadTypeWifiCellular:
            switch (carrier) {
                case ISNetworkCarrierAtt:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF066LL/A" : @"MF074LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF080LL/A" : @"MF083LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF087LL/A" : @"MF089LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF117LL/A" : @"MF120LL/A";
                    }
                    break;
                case ISNetworkCarrierSprint:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF070LL/A" : @"MF076LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF082LL/A" : @"MF086LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF088LL/A" : @"MF091LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF118LL/A" : @"MF123LL/A";
                    }
                    break;
                case ISNetworkCarrierTmobile:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF519LL/A" : @"MF544LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF552LL/A" : @"MF569LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF575LL/A" : @"MF580LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF585LL/A" : @"MF594LL/A";
                    }
                    break;
                default: //case ISNetworkCarrierVerizon:
                    switch (model) {
                        case ISMobileDeviceCapacity16GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF069LL/A" : @"MF075LL/A";
                        case ISMobileDeviceCapacity32GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF081LL/A" : @"MF084LL/A";
                        case ISMobileDeviceCapacity64GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF086LL/A" : @"MF090LL/A";
                        default: //case ISMobileDeviceCapacity128GB:
                            return (color == ISiPhoneColorSpaceGray) ? @"MF116LL/A" : @"MF121LL/A";
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
