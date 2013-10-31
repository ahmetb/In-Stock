 //
//  ISMacBookPro.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISMacBookPro.h"

@implementation ISMacBookPro

+(NSString*)name{
    return @"MacBook Pro";
}

+(NSString *)iconImageName{
    return @"laptop.png";
}

+(NSArray *)applicableIdioms{
    return @[N(ISIdiomMacBookScreenSize)];
}

+(NSArray *)applicableOptionsForIdiom:(ISIdiom)idiom{
    return @[N(ISMacBookScreenSize13inch)];
}

+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict {
    return @"MD101LL/A"; // only one exists
}

@end
