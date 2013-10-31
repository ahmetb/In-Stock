//
//  ISAvailabilityViewController.h
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <AddressBook/AddressBook.h>
#import <iAd/iAd.h>
#import <GAI.h>
#import <GAIDictionaryBuilder.h>
#import <GAIFields.h>

@interface ISAvailabilityViewController : UITableViewController <UIAlertViewDelegate, UIActionSheetDelegate, CLLocationManagerDelegate, ADBannerViewDelegate>

@property(weak, nonatomic) NSString* sku;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnRefresh;
@property (retain, nonatomic) ADBannerView* banner;

@end
