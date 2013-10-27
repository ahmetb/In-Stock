//
//  ISAppDelegate.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

#define IS_appDelegate ((ISAppDelegate *)[[UIApplication sharedApplication] delegate])

@interface ISAppDelegate : UIResponder <UIApplicationDelegate>

extern NSArray* PRODUCTS;

@property (strong, nonatomic) UIWindow *window;

@end
