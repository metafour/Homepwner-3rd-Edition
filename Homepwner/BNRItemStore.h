//
//  BNRItemStore.h
//  Homepwner
//
//  Created by Camron Schwoegler on 10/9/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BNRItem;

@interface BNRItemStore : NSObject
{
    NSMutableArray *allItems;
}

#pragma mark class methods

+ (BNRItemStore *)sharedStore;

#pragma mark instance methods

- (NSArray *)allItems;
- (BNRItem *)createItem;
- (void)removeItem:(BNRItem *)item;
- (void)moveItemAtIndex:(NSInteger)from toIndex:(NSInteger)to;


@end
