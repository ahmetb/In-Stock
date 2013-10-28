//
//  ISiPadMini.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPadMini.h"

@implementation ISiPadMini

+(NSString*)name{
    return @"iPad mini";
}

+(NSString *)iconImageName{
    return @"ipad.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomiPhoneColor),
             N(ISIdiomiPadType),
             N(ISIdiomNetworkCarrier)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    switch (idiom) {
        case ISIdiomiPhoneColor:
            return @[N(ISiPhoneColorSpaceGray), N(ISiPhoneColorSilver)];
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
    ISiPadType type = [[dict valueForKey:[N(ISIdiomiPadType) stringValue]] integerValue];
    ISNetworkCarrier carrier = [[dict valueForKey:[N(ISIdiomNetworkCarrier) stringValue]] integerValue];
    
    switch (type) {
        case ISiPadTypeWifi:
            switch (color) {
                case ISiPhoneColorSpaceGray:
                    return @"MF342LL/A";
                case ISiPhoneColorSilver:
                    return @"MD531LL/A";
                default:{
                    NSLog(@"unhandled color");
                }
            }
        case ISiPadTypeWifiCellular:
            switch (color) {
                case ISiPhoneColorSpaceGray:
                    switch (carrier) {
                        case ISNetworkCarrierAtt:
                            return @"MF442LL/A";
                        case ISNetworkCarrierSprint:
                            return @"MF453LL/A";
                        case ISNetworkCarrierTmobile:
                            return @"MF743LL/A";
                        case ISNetworkCarrierVerizon:
                            return @"MF450LL/A";
                        default:
                            NSLog(@"unhandled carrier");
                            break;
                    }
                case ISiPhoneColorSilver:
                    switch (carrier) {
                        case ISNetworkCarrierAtt:
                            return @"MD537LL/A";
                        case ISNetworkCarrierSprint:
                            return @"ME218LL/A";
                        case ISNetworkCarrierTmobile:
                            return @"MF746LL/A";
                        case ISNetworkCarrierVerizon:
                            return @"MD543LL/A";
                        default:
                            NSLog(@"unhandled carrier");
                            break;
                    }
                default:{
                    NSLog(@"unhandled color");
                }
            }
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
