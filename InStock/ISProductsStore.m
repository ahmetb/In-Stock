//
//  ISProductsStore.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISProductsStore.h"

@implementation ISProductsStore

#pragma mark - Consolidated app settings storage

+(void)saveSettingObject:(id)object forKey:(NSString*)key{
    [[NSUserDefaults standardUserDefaults] setObject:object forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(id)settingObjectForKey:(NSString*)key{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

#pragma mark - Saved Product Choice Settings

#define kSettingProducts @"Products"

+(NSArray*)savedProducts {
    return [self settingObjectForKey:kSettingProducts];
}

+(void)setSavedProducts:(NSArray*)products{
    [self saveSettingObject:products forKey:kSettingProducts];
}

+(void)removeProductAtIndex:(NSUInteger)index{
    id arr = [NSMutableArray arrayWithArray:[self savedProducts]];
    [arr removeObjectAtIndex:index];
    [self setSavedProducts:arr];
}

+(void)saveProductWithName:(NSString*)productName sku:(NSString*)productSku{
    id products = [self savedProducts];
    if (!products){
        products = [NSArray array];
    }
    products = [NSMutableArray arrayWithArray:products];
    [products addObject:@[productName, productSku]];
    [self setSavedProducts:products];
}


#pragma mark - Last Used Product Setting

#define kSettingLastProduct @"LastProduct"

+(void)setLastUsedProductName:(NSString*)productName{
    [self saveSettingObject:productName forKey:kSettingLastProduct];
}

+(NSArray*)lastUsedProduct{
    id productName = [self settingObjectForKey:kSettingLastProduct];
    if (productName){
        for (NSArray* p in [self savedProducts]) {
            if ([[p objectAtIndex:iProductName]/* name */ isEqualToString:productName]){
                return p;
            }
        }
    }
    return nil;
}

#pragma mark - Zip Code Setting

#define kSettingZipCode @"PostalCode"

+(NSString*)userZipCode{
    return [self settingObjectForKey:kSettingZipCode];
}

 +(void)setUserZipCode:(NSString*)zipCode{
     [self saveSettingObject:zipCode forKey:kSettingZipCode];
 }

@end
