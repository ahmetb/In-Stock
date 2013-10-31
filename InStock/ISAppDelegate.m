//
//  ISAppDelegate.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISAppDelegate.h"
#import <GAI.h>
#import <GAIFields.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@implementation ISAppDelegate

-(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [self initializeGoogleAnalytics];
    return YES;
}


static NSString *const kGaPropertyId = @"UA-45321252-1";
-(void)initializeGoogleAnalytics{
    // Set up Google Analytics
    [[GAI sharedInstance] setTrackUncaughtExceptions:YES];
    [[GAI sharedInstance] setDispatchInterval:4]; // secs
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
#ifdef DEBUG
    [[GAI sharedInstance] setDryRun:YES];
    NSLog(@"GA set to dryrun");
#else

#endif
    [[GAI sharedInstance] trackerWithTrackingId:kGaPropertyId]; // set default tracker instance
}

@end
