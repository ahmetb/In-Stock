//
//  ISAvailabilityViewController.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISAvailabilityViewController.h"
#import "ISProductsViewController.h"
#import "ISProductsStore.h"
#import <AFNetworking/AFNetworking.h>

#define kSeguePickProduct @"PickProduct"


@implementation ISAvailabilityViewController

AFHTTPRequestOperationManager* operationManager;
NSArray* stores;
NSString* lastLoadedSku;
NSString* lastPhoneNumber;
NSUInteger lastStoreIndex;
BOOL backFromAd;

CLLocationManager* locationManager;

-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationItem.hidesBackButton = YES;
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];

    if (!operationManager){
        operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://store.apple.com"]];
        id responseSerializer = [AFJSONResponseSerializer serializer];
        id acceptedTypes = [NSMutableSet setWithSet:[responseSerializer acceptableContentTypes]];
        [acceptedTypes addObject:@"application/x-json"];
        [responseSerializer setAcceptableContentTypes:[NSSet setWithSet:acceptedTypes]];
        [operationManager setResponseSerializer:responseSerializer];
        
        NSOperationQueue *operationQueue = operationManager.operationQueue;
        [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"API connectivity on.");
                    [operationQueue setSuspended:NO];
                    break;
                case AFNetworkReachabilityStatusNotReachable:
                default:
                    NSLog(@"API connectivity lost.");
                    [operationQueue setSuspended:YES];
                    break;
            }
        }];
    }
    
    self.banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [self.banner setDelegate:self];
}

-(void)viewWillDisappear:(BOOL)animated {
    [locationManager stopUpdatingLocation];
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    id lastProduct = [ISProductsStore lastUsedProduct];
    if (!lastProduct){
        stores = nil;
        [self.tableView reloadData]; // when devices are removed from bookmarks, remove table view data
        [self setTitle:@"Pick a Product"];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if (backFromAd){ NSLog(@"back from ad"); backFromAd = NO;
        return;
    }
    
    id lastProduct = [ISProductsStore lastUsedProduct];
    
    if (!lastProduct){
        NSLog(@"last device not found. show add screen");
        [self performSegueWithIdentifier:kSeguePickProduct sender:nil];
        return;
    }
    self.sku = [lastProduct objectAtIndex:iProductSku];
    self.title = [lastProduct objectAtIndex:iProductName];
    
    // If location does not exist fetch it by using current location
    if (![ISProductsStore userZipCode]){
        // Retrieve zip code, get user's location
        [self retrieveLocation:nil];
    } else {
        if (![self.sku isEqualToString:lastLoadedSku]){
            stores = nil;
            [self.tableView reloadData]; // show table initially empty before loading a new one
            [self refresh];
        } else {
            NSLog(@"Showing existing sku %@ listing", self.sku);
        }
    }
}

#pragma mark - iAd Delegate

-(void)bannerViewWillLoadAd:(ADBannerView *)banner{
    NSLog(@"Banner upcoming...");
}

-(void)bannerViewDidLoadAd:(ADBannerView *)banner{
    NSLog(@"Banner loaded.");
    [self.tableView setTableHeaderView:self.banner];
}

-(void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error{
}

-(BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave{
    backFromAd = !willLeave;
    return YES;
}

#pragma mark - Location Manager delegate 

-(IBAction)retrieveLocation:(id)sender{
    if (!locationManager){
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    }
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation* lastLocation = [locations lastObject];
    [locationManager stopUpdatingLocation]; // stop collection location
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc] init];
    if (geoCoder){
        [geoCoder reverseGeocodeLocation:lastLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            NSString* zip = [[[placemarks lastObject] addressDictionary] objectForKey:(NSString*)kABPersonAddressZIPKey];
            if (zip){
                NSLog(@"zip code: %@", zip);
                if (![zip isEqualToString:[ISProductsStore userZipCode]]){
                    NSLog(@"new zip code found, refresh.");
                    [ISProductsStore setUserZipCode:zip];
                    [self refresh];
                }
            } else {
                NSLog(@"could not find zip code for location");
            }
        }];
    } else {
        NSLog(@"Error: reverse geocoding not available");
    }
    
    [manager stopUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    switch([error code])
    {
        case kCLErrorNetwork: // general, network-related error
            {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please make sure you are not in airplane mode and connected to internet." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            }
            break;
        case kCLErrorDenied:
            {
            // open url prefs:root=LOCATION_SERVICES
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Allow Location Services" message:@"\nGo to Settings→Privacy→Location and allow this app to use your location" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
            }
            break;
        default:
            {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"We could not retrieve your current location. Try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            NSLog(@"Error code: %d", (int)error.code);
            [alert show];
            }
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [stores count];
}

- (void)refresh {
    NSString* url = @"http://store.apple.com/us/retail/availabilitySearch";
    id params = @{
                  @"parts.0": [self sku],
                  @"zip": [ISProductsStore userZipCode]};
    [operationManager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        lastLoadedSku = self.sku;
        id body = [responseObject objectForKey:@"body"];
        stores = [body objectForKey:@"stores"];
        NSLog(@"%d stores found",(int)[stores count]);
        
        [self.refreshControl endRefreshing];
        [[self tableView] reloadData];
        [[self tableView] scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"request failed");
        // show empty results
        stores = nil;
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        lastLoadedSku = nil;
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"StoreCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIColor* color;
    if ([self isStoreAvailableAtIndex:indexPath.row]){
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        color = [UIColor colorWithRed:0x27/255.0 green:0xae/255.0 blue:0x60/255.0 alpha:1.0f];
        
        // make bold
        [[cell detailTextLabel] setFont:[UIFont boldSystemFontOfSize:cell.detailTextLabel.font.pointSize]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
        color = [UIColor colorWithRed:0xe7/255.0 green:0x4c/255.0 blue:0x3c/255.0 alpha:1.0f];
        
        // reset bold
        [[cell detailTextLabel] setFont:[UIFont systemFontOfSize:cell.detailTextLabel.font.pointSize]];
    }
    [[cell detailTextLabel] setTextColor: ([self isStoreAvailableAtIndex:indexPath.row] ? color : color)];
    
    [[cell textLabel] setText: [self storeNameAtIndex:indexPath.row]];
    [[cell detailTextLabel] setText: [self storeAvailabilityAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self isStoreAvailableAtIndex:indexPath.row]){
        [self callStoreAtIndex:indexPath.row];
    } else {
        // show action sheet
        [self tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

-(void)callStoreAtIndex:(NSUInteger)i{
    NSString* msg = [NSString stringWithFormat:@"Call %@?", [self storePhoneAtIndex:i]];
    NSString* body = [NSString stringWithFormat:@"%@\n%@, %@", [self storeOriginalNameAtIndex:i],
                      [self storeCityAtIndex:i], [self storeStateAtIndex:i]];
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:msg message:body delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Call", nil];
    lastPhoneNumber = [self storePhoneAtIndex:i];
    [alert show];
}

-(void)makeCallToPhoneNumber:(NSString*)phoneNumber{
    // sanitize phone number (replace space with '-')
    NSString* uri = [[@"tel:" stringByAppendingString:phoneNumber]
                stringByReplacingOccurrencesOfString:@" " withString:@"-"];
    id url = [NSURL URLWithString:uri];
    if ([[UIApplication sharedApplication] canOpenURL:url]){
        [[UIApplication sharedApplication] openURL:url];
    } else {
        NSLog(@"device cannot make phone calls");
        [[[UIAlertView alloc]
          initWithTitle:@"Cannot Make Phone Calls"
          message:[@"Your device is not a phone.\nCall " stringByAppendingString:phoneNumber]
          delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
    }
}

#pragma mark - Alert View delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex > 0){
        id number = lastPhoneNumber;
        lastPhoneNumber = nil;
        [self makeCallToPhoneNumber:number];
    }
    lastPhoneNumber = nil;
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    lastPhoneNumber = nil;
}

#pragma mark - Action Sheet source & delegate

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    UIActionSheet* actionSheet = [[UIActionSheet alloc] init];
    actionSheet.title = [self storeOriginalNameAtIndex:indexPath.row];
    actionSheet.delegate = self;
    
    if ([self canMakeCalls])
        [actionSheet addButtonWithTitle:@"Open in Google Maps"];
    
    [actionSheet addButtonWithTitle:@"Open in Maps"];
    [actionSheet addButtonWithTitle:@"Call"];
    
    actionSheet.cancelButtonIndex = [actionSheet addButtonWithTitle:@"Cancel"];
    lastStoreIndex = indexPath.row;
    [actionSheet showInView:self.tableView];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    int base = [self canOpenGoogleMaps] ? 1 : 0;
    if (buttonIndex == base+2){
        NSLog(@"Cancel");
        return;
    }
    
    if ([self canOpenGoogleMaps] && buttonIndex == 0){
        NSString* url = [[NSString stringWithFormat:@"comgooglemaps://?q=%@", [self storeAddressAtIndex:lastStoreIndex]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else if (([self canOpenGoogleMaps] && buttonIndex == 1) || (![self canOpenGoogleMaps] && buttonIndex == 0 )){
        NSString* url = [[NSString stringWithFormat:@"http://maps.apple.com/?q=%@", [self storeAddressAtIndex:lastStoreIndex]] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    } else if (([self canOpenGoogleMaps] && buttonIndex == 2) || (![self canOpenGoogleMaps] && buttonIndex == 1)){
        NSLog(@"Call");
        [self makeCallToPhoneNumber:[self storePhoneAtIndex:lastStoreIndex]];
    }
    
    lastStoreIndex = 0;
}

#pragma mark - Currently Picked Store Provider methods

-(NSDictionary*)storeAtIndex:(NSUInteger)i{
    return [stores objectAtIndex:i];
}

-(NSString*)storeOriginalNameAtIndex:(NSUInteger)i{
    return [[self storeAtIndex:i] objectForKey:@"storeDisplayName"];
}

-(NSString*)storeNameAtIndex:(NSUInteger)i{
    NSString* name = [self storeOriginalNameAtIndex:i];
    
    NSString* appleStoreStr = @"Apple Store, ";
    NSString* newPostfix = @" Store";
    
    if ([name rangeOfString:appleStoreStr options:NSLiteralSearch].location != NSNotFound){
        name = [[name stringByReplacingOccurrencesOfString:appleStoreStr withString:@""] stringByAppendingString:newPostfix];
    }
    return name;
}

-(NSString*)storeCityAtIndex:(NSUInteger)i{
    return [[self storeAtIndex:i] objectForKey:@"city"];
}

-(NSString*)storeStateAtIndex:(NSUInteger)i{
    return [[self storeAtIndex:i] objectForKey:@"state"];
}

-(NSString*)storePhoneAtIndex:(NSUInteger)i{
    return [[self storeAtIndex:i] objectForKey:@"phoneNumber"];
}

-(NSString*)storeAddressAtIndex:(NSUInteger)i{
    id addr = [[self storeAtIndex:i] objectForKey:@"address"];
    NSString* street = [addr objectForKey:@"address2"];
    
    NSString* city = [NSString stringWithFormat:@"%@, %@",
                      [self storeCityAtIndex:i],
                      [self storeStateAtIndex:i]];
    NSString* zip = [addr objectForKey:@"postalCode"];
    return [NSString stringWithFormat:@"%@, %@, %@", street, city, zip];
}

-(NSString*)storeAvailabilityAtIndex:(NSUInteger)i{
    id av = [[[self storeAtIndex:i] objectForKey:@"partsAvailability"] objectForKey:self.sku];
    return [av objectForKey:@"pickupSearchQuote"];
}

-(BOOL)isStoreAvailableAtIndex:(NSUInteger)i{
    id av = [[[self storeAtIndex:i] objectForKey:@"partsAvailability"] objectForKey:self.sku];
    return [[av objectForKey:@"storeSelectionEnabled"] boolValue];
}

#pragma mark - CanOpenURL helpers

-(BOOL)canOpenGoogleMaps{
    NSURL *gMapsUrlBase = [NSURL URLWithString:@"comgooglemaps://"];
    return [[UIApplication sharedApplication] canOpenURL:gMapsUrlBase];
}

-(BOOL)canMakeCalls{
    NSURL *phoneUrlBase = [NSURL URLWithString:@"tel:"];
    return [[UIApplication sharedApplication] canOpenURL:phoneUrlBase];
}

@end
