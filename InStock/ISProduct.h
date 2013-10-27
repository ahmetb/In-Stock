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
+(NSString*)skuNameForIdiomsAndValues:(NSDictionary*)dict;

@end
