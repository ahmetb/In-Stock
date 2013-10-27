//
//  ISProductsViewController.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <FlatUIKit/FlatUIKit.h>

@interface ISProductsViewController : UITableViewController <UIActionSheetDelegate>


@property (nonatomic, retain) NSArray* products;

@property (nonatomic, retain) id selectedProduct;
@property (nonatomic, retain) NSArray* currentIdioms;
@property (nonatomic, assign) NSInteger currentIdiomIndex;
@property (nonatomic, retain) NSMutableDictionary* currentDeviceIdioms;

@end
