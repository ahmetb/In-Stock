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
#import <FlatUIKit/UITableViewCell+FlatUI.h>


@implementation ISProductsViewController

bool wasCancel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.products = @[
                      @[
                          [ISiPhone4s class],
                          [ISiPhone5s class],
                          [ISiPhone5c class],
                        ],
                      ];
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
    [[cell textLabel] setText: [product name]];
    return cell;
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!idioms || [idioms count] == 0){
        [self performSegueWithIdentifier:kSegueAvailability sender:self];
    } else {
        [self showActionSheetForIdiom:self.currentIdiomIndex];
    }
}

#pragma mark Action sheet operations and delegation

-(void) showActionSheetForIdiom:(NSInteger)idiomIndex {
    self.currentIdiomIndex = idiomIndex;
    
    ISIdiom idiom = [[[self currentIdioms] objectAtIndex:idiomIndex] integerValue];
    NSArray* options = [self.selectedProduct applicableOptionsForIdiom:idiom];
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

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    ISIdiom idiom = [[[self currentIdioms] objectAtIndex:self.currentIdiomIndex] integerValue];
    NSArray* options = [self.selectedProduct applicableOptionsForIdiom:idiom];
    
    if (buttonIndex == [options count]){
        NSLog(@"cancel");
        wasCancel = true;
    } else {
        wasCancel = false;
        NSArray* options = [self.selectedProduct applicableOptionsForIdiom:idiom];
        NSInteger option = [[options objectAtIndex:buttonIndex] integerValue];
        NSLog(@"%@: %@", [ISIdioms titleForIdiom:idiom], [ISIdioms nameForOption:option inIdiom:idiom]);
        [self.currentDeviceIdioms setValue:N(option) forKey:[N(idiom) stringValue]];
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (wasCancel)
        return;
    
    if ([[self currentIdioms] count] == self.currentIdiomIndex + 1){
        self.currentSku = [self.selectedProduct skuNameForIdiomsAndValues:self.currentDeviceIdioms];
        NSLog(@"finished. SKU = %@", self.currentSku);
        [self performSegueWithIdentifier:kSegueAvailability sender:self];
    } else {
        // show next idiom
        [self showActionSheetForIdiom:self.currentIdiomIndex + 1];
    }
}

#pragma mark Segue methods

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kSegueAvailability]){
        [[segue destinationViewController] setSku:self.currentSku];
    } else {
        NSLog(@"unprepared segue %@", [segue identifier]);
    }
}

@end
