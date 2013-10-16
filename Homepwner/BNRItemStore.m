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
        allItems = [[NSMutableArray alloc] initWithObjects:@"No more items!", nil];
    }
    
    return self;
}

- (NSArray *)allItems
{
    return allItems;
}

- (BNRItem *)createItem
{
    BNRItem *p = [BNRItem randomItem];
    
    [allItems insertObject:p atIndex:[allItems indexOfObject:[allItems lastObject]]];
    
    return p;
}

- (void)removeItem:(BNRItem *)item
{
    [allItems removeObjectIdenticalTo:item];
}
- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to
{
    if (from == to) {
        return;
    }
    
    BNRItem *item = [allItems objectAtIndex:from];
    
    [allItems removeObjectAtIndex:from];
    
    [allItems insertObject:item atIndex:to];
}
@end
