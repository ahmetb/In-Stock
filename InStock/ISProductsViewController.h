//
//  ISProductsViewController.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <iAd/iAd.h>

#define kSegueAvailability @"CheckAvailability"

@interface ISProductsViewController : UITableViewController <UIActionSheetDelegate, ADBannerViewDelegate>

@property (nonatomic, assign) BOOL isNewProductRequested;

@property (nonatomic, retain) NSArray* products;

@property (nonatomic, retain) id selectedProduct;
@property (nonatomic, retain) NSArray* currentIdioms;
@property (nonatomic, assign) NSInteger currentIdiomIndex;
@property (nonatomic, retain) NSMutableDictionary* currentDeviceIdioms;
@property (nonatomic, retain) NSString* currentSku;
@property (nonatomic, retain) NSString* currentName;

@property (nonatomic, retain) ADBannerView* banner;

@end
