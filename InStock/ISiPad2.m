//
//  ISiPad2.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISiPad2.h"

@implementation ISiPad2


+(NSString*)name{
    return @"iPad 2";
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
            return @[N(ISiPhoneColorBlack), N(ISiPhoneColorWhite)];
        case ISIdiomiPadType:
            return @[N(ISiPadTypeWifi), N(ISiPadTypeWifiCellular)];
        case ISIdiomNetworkCarrier:
            return @[N(ISNetworkCarrierAtt),
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
                case ISiPhoneColorBlack:
                    return @"MC954LL/A";
                case ISiPhoneColorWhite:
                    return @"MC989LL/A";
                default:{
                    NSLog(@"unhandled color");
                }
            }
        case ISiPadTypeWifiCellular:
            switch (color) {
                case ISiPhoneColorBlack:
                    switch (carrier) {
                        case ISNetworkCarrierAtt:
                            return @"MC957LL/A";
                        case ISNetworkCarrierVerizon:
                            return @"MC755LL/A";
                        default:
                            NSLog(@"unhandled carrier");
                            break;
                    }
                case ISiPhoneColorWhite:
                    switch (carrier) {
                        case ISNetworkCarrierAtt:
                            return @"MC992LL/A";
                        case ISNetworkCarrierVerizon:
                            return @"MC985LL/A";
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
