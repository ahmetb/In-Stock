//
//  ISProductsViewController.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/26/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISProductsViewController.h"
#import "ISAvailabilityViewController.h"
#import "ISProducts.h"

@implementation ISProductsViewController

bool wasCancel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.products = @[
                      @[
                          [ISiPhone5s class],
                          [ISiPhone5c class],
                          [ISiPhone4s class],
                        ],
                      @[
                          [ISiPadAir class],
                          [ISiPadMini class],
                          [ISiPadMiniRetina class],
                          [ISiPad2 class],
                        ],
                      @[
                          [ISMacBookProRetina class],
                          [ISMacBookPro class],
                          [ISMacBookAir class],
                          [ISMacMini class],
                        ]
                      ];
    
    self.banner = [[ADBannerView alloc] initWithFrame:CGRectZero];
    [self.banner setDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (![ISProductsStore savedProducts] || ![ISProductsStore lastUsedProduct]){
        // hide cancel button if user has to choose
        [[self navigationItem] setRightBarButtonItem:nil];
    } else {
        // restore cancel button
        [[self navigationItem] setRightBarButtonItem:[self btnCancel]];
    }
}

NSDate* start;
-(void)viewDidAppear:(BOOL)animated{
    id tracker = [[GAI sharedInstance] defaultTracker];
    [tracker set:kGAIScreenName value:(NSStringFromClass([self class]))];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
    
    start = [NSDate date];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.products count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[self.products objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    id product = [[self.products objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    NSString* name;
    if ([product respondsToSelector:@selector(fullName)]){
        name = [product fullName];
    } else {
        name = [product name];
    }
    [[cell textLabel] setText: name];
    UIImage* icon = [self imageForProduct:product];
    if (icon){
        [[cell imageView] setImage:icon];
    }
    return cell;
}

-(UIImage*)imageForProduct:(id)product{
    if ([product respondsToSelector:@selector(iconImageName)]){
        return [UIImage imageNamed:[product iconImageName]];
    }
    return nil;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id product = [[self.products objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (!product){
        NSLog(@"Cannot find selected device");
        return;
    }
    NSLog(@"Chosen: %@", [product name]);
    NSArray* idioms = [product applicableIdioms];
    
    self.selectedProduct = product;
    self.currentIdioms = idioms;
    self.currentIdiomIndex = 0;
    self.currentDeviceIdioms = [NSMutableDictionary dictionary];
    self.currentName = [product name];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
 
    [self showActionSheetForIdiom:self.currentIdiomIndex];
}

#pragma mark - Action sheet operations and delegation

-(void) showActionSheetForIdiom:(NSInteger)idiomIndex {
    self.currentIdiomIndex = idiomIndex;
    
    if (self.currentIdiomIndex + 1 > [[self currentIdioms] count]){
        // FINISHED ASKING?
        self.currentSku = [self.selectedProduct skuNameForIdiomsAndValues:self.currentDeviceIdioms];
        NSLog(@"finished. SKU = %@, Name = %@", self.currentSku, self.currentName);
        
        // Save device
        [ISProductsStore saveProductWithName:self.currentName sku:self.currentSku];
        [ISProductsStore setLastUsedProductName:self.currentName];
        self.isNewProductRequested = NO; // reset
        
        id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
        
        // Record user's finishing time for picking a product
        if(start){
            NSTimeInterval took = [[NSDate date] timeIntervalSinceDate:start];
            start = nil;
            [tracker send: [[GAIDictionaryBuilder
                       createTimingWithCategory:@"user_action"
                       interval:[NSNumber numberWithDouble:took]
                       name:@"pick_a_product" label:nil] build]];
        }
        
        // Record picked product name
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"user_action" action:@"picked_product"
                                                               label:[[[self selectedProduct] class] name]
                                                               value:nil] build]];
        
        // Record picked product model
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"user_action" action:@"picked_product_model"
                                                               label:self.currentName
                                                               value:nil] build]];
        
        [self dismiss:nil];
        return;
    } else {
        // SHOW IDIOM
        ISIdiom idiom = [[[self currentIdioms] objectAtIndex:idiomIndex] integerValue];
        
        if ([self.selectedProduct respondsToSelector:@selector(shouldAskIdiom:forIdiomsAndValues:)]){
            BOOL showThisIdioom = [self.selectedProduct shouldAskIdiom:idiom forIdiomsAndValues:self.currentDeviceIdioms];
            if (!showThisIdioom){
                [self showActionSheetForIdiom:self.currentIdiomIndex + 1]; // show next idiom
                return;
            }
        }
        
        NSArray* options = [self applicableOptionsForSelectedProductForIdiom:idiom];
        NSMutableArray* optionTitles = [NSMutableArray arrayWithCapacity:[options count]];
        for (id opt in options) {
            [optionTitles addObject:[ISIdioms nameForOption:[opt integerValue] inIdiom:idiom]];
        }
        
        UIActionSheet* sheet = [[UIActionSheet alloc] init];
        sheet.title = [ISIdioms titleForIdiom:idiom];
        sheet.delegate = self;
        for (NSString* optionTitle in optionTitles) {
            [sheet addButtonWithTitle:optionTitle];
        }
        sheet.cancelButtonIndex = [sheet addButtonWithTitle:@"Cancel"];
        [sheet showInView:self.tableView];
    }
}

-(NSArray*)applicableOptionsForSelectedProductForIdiom:(ISIdiom)idiom {
    if ([self.selectedProduct respondsToSelector:@selector(applicableOptionsForIdiom:inIdiomsAndValues:)]){
        return [self.selectedProduct applicableOptionsForIdiom:idiom inIdiomsAndValues:self.currentDeviceIdioms];
    }
    return [self.selectedProduct applicableOptionsForIdiom:idiom];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    ISIdiom idiom = [[[self currentIdioms] objectAtIndex:self.currentIdiomIndex] integerValue];
    NSArray* options = [self applicableOptionsForSelectedProductForIdiom:idiom];
    
    if (buttonIndex == [options count]){
        wasCancel = YES;
    } else {
        wasCancel = NO;
        NSInteger option = [[options objectAtIndex:buttonIndex] integerValue];
        NSLog(@"%@: %@", [ISIdioms titleForIdiom:idiom], [ISIdioms nameForOption:option inIdiom:idiom]);
        
        [self setCurrentName: [[self.currentName stringByAppendingString:@" "] stringByAppendingString:[ISIdioms nameForOption:option inIdiom:idiom]]];
        [self.currentDeviceIdioms setValue:N(option) forKey:[N(idiom) stringValue]];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (wasCancel)
        return;
    
    [self showActionSheetForIdiom:self.currentIdiomIndex + 1];
}

#pragma mark - Navigation integration methods

-(IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
    id<GAITracker> tracker = [[GAI sharedInstance] defaultTracker];
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"ui_action"
                                                          action:@"cancel_product_pick"
                                                           label:nil
                                                           value:nil] build]];
}

@end
