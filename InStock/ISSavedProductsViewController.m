//
//  ISSavedProductsViewController.m
//  InStock
//
//  Created by Ahmet Alp Balkan on 10/27/13.
//  Copyright (c) 2013 Luminous Apps. All rights reserved.
//

#import "ISSavedProductsViewController.h"
#import "ISProductsStore.h"
#import "ISAvailabilityViewController.h"
#import "ISProductsViewController.h"

#define kSegueNewProduct @"NewProduct"

@implementation ISSavedProductsViewController

NSString* newSku;
NSString* newName;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)dismiss:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[ISProductsStore savedProducts] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ProductCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    NSUInteger i = indexPath.row;
    NSString* name = [[[ISProductsStore savedProducts] objectAtIndex:i] objectAtIndex:iProductName];
    NSString* lastProductName = [[ISProductsStore lastUsedProduct] objectAtIndex:iProductName];
    BOOL isLastUsed = [name isEqualToString:lastProductName];
    
    [[cell textLabel] setText:name];
    [cell setAccessoryType: (isLastUsed ? UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone)];
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // all items are deletable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NSString* name = [[[ISProductsStore savedProducts] objectAtIndex:indexPath.row] objectAtIndex:iProductName];
        NSString* lastProductName = [[ISProductsStore lastUsedProduct] objectAtIndex:iProductName];
        BOOL wasLastUsed = [name isEqualToString:lastProductName];
        
        [ISProductsStore removeProductAtIndex:indexPath.row];
        
        if (wasLastUsed){
            if ([[ISProductsStore savedProducts] count] > 0){
                // if there is only one left, make it last used.
                id lastProduct = [[ISProductsStore savedProducts] objectAtIndex:0];
                [ISProductsStore setLastUsedProductName: [lastProduct objectAtIndex:iProductName]];
            }
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id product = [[ISProductsStore savedProducts] objectAtIndex:indexPath.row];
    NSString* name = [product objectAtIndex:0/*name*/];
    NSString* sku = [product objectAtIndex:1/*sku*/];
    newSku = sku;
    // Set as last used product
    [ISProductsStore setLastUsedProductName:name];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismiss:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:kSegueNewProduct]){
        [[segue destinationViewController] setIsNewProductRequested:YES];
    }
}
                       
@end
