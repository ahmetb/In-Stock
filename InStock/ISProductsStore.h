//
//  ISProductsStore.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

#define iProductName 0
#define iProductSku 1

@interface ISProductsStore : NSObject

+(NSArray*)savedProducts;
+(void)removeProductAtIndex:(NSUInteger)index;
+(void)saveProductWithName:(NSString*)productName sku:(NSString*)productSku;

+(void)setLastUsedProductName:(NSString*)productName;
+(NSArray*)lastUsedProduct;

@end
