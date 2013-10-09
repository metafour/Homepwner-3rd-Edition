//
//  BNRItemStore.m
//  Homepwner
//
//  Created by Camron Schwoegler on 10/9/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@implementation BNRItemStore

#pragma mark class methods

+ (BNRItemStore *)sharedStore
{
    static BNRItemStore *sharedStore = nil;
    
    if (!sharedStore) {
        sharedStore = [[super allocWithZone:nil] init];
    }
    
    return sharedStore;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

#pragma mark instance methods

- (id)init
{
    self = [super init];
    
    if (self) {
        allItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (NSArray *)itemsGreaterThan:(NSInteger)value
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (BNRItem *item in allItems) {
        if ([item valueInDollars] > value) {
            [array addObject:item];
        }
    }
    
    return array;
}

- (NSArray *)itemsLessThan:(NSInteger)value
{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    for (BNRItem *item in allItems) {
        if ([item valueInDollars] < value) {
            [array addObject:item];
        }
    }

    return array;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    
    [allItems addObject:p];
    
    return p;
}

- (NSInteger)numOfItemsGreaterThan:(NSInteger)value
{
    NSInteger count = 0;
    
    for (int i = 0; i < [allItems count]; i++) {
        if ([[allItems objectAtIndex:i] valueInDollars] > value) {
            count++;
        }
    }
    
    return count;
}

- (NSInteger)numOfItemsLessThan:(NSInteger)value
{
    NSInteger count = 0;
    
    for (int i = 0; i < [allItems count]; i++) {
        if ([[allItems objectAtIndex:i] valueInDollars] < value) {
            count++;
        }
    }
    
    return count;
}
@end
