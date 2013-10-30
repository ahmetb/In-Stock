//
//  ISAppDelegate.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISAppDelegate.h"
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>
#import <FlatUIKit/FlatUIKit.h>

@implementation ISAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return YES;
}

@end
