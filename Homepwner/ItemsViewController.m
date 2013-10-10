//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 10/8/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "ItemsViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@implementation ItemsViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        for (int i = 0; i < 5; i++) {
        [[BNRItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

#pragma mark UITableViewDataSource Protocol methods

// required

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    }
    
    BNRItem *p;
    
    if ([indexPath row] == ([tableView numberOfRowsInSection:[indexPath section]] - 1)) {
        [[cell textLabel] setText:@"No more items!"];
    } else {
        if ([indexPath section] == 0) {
            p = [[[BNRItemStore sharedStore] itemsGreaterThan:49] objectAtIndex:[indexPath row]];
        } else {
            p = [[[BNRItemStore sharedStore] itemsLessThan:50] objectAtIndex:[indexPath row]];
        }
    
        [[cell textLabel] setFont:[UIFont systemFontOfSize:20]];
        [[cell textLabel] setText:[p description]];
    }
    
    return cell;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count;
    
    if (section == 0) {
        count = [[BNRItemStore sharedStore] numOfItemsGreaterThan:49];
    } else {
        count = [[BNRItemStore sharedStore] numOfItemsLessThan:50];
    }
    
    // return 1 more than number of items in section for constant row
    if (count == 0) {
        return 1;
    } else {
        return count + 1;
    }
}

// optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"Value is $50 or greater";
    } else
    {
        return @"Value is less than $50";
    }
}

#pragma mark UITableView Delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [indexPath section];
    NSInteger row = [indexPath row];
    NSInteger rowsInSection = [self tableView:tableView numberOfRowsInSection:section];
//    NSLog(@"Row: %ld, Number of rows in section: %ld", (long)[indexPath row], (long)[tableView numberOfRowsInSection:[indexPath section]]);
//    NSLog(@"Number of sections: %d", [indexPath section]);
    if (row == rowsInSection - 1) {
        return 44.0;
    } else {
        return 60.0;
    }
}
@end