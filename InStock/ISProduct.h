//
//  ISProduct.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISIdioms.h"

@protocol ISProduct <NSObject>

+(NSString*)name;
+(NSArray*)applicableIdioms;
+(NSArray*)applicableOptionsForIdiom:(ISIdiom)idiom;
+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)responses;

@optional
+(NSString*)fullName;
+(NSString*)iconImageName;
+(NSArray*)applicableOptionsForIdiom:(ISIdiom)idiom inIdiomsAndValues:(NSDictionary*)responses;
+(BOOL)shouldAskIdiom:(ISIdiom)idiom forIdiomsAndValues:(NSDictionary*)responses;

@end
