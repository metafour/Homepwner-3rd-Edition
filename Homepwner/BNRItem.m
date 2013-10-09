//
//  BNRItem.m
//  RandomPossessions
//
//  Created by Camron Schwoegler on 9/17/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "BNRItem.h"

@implementation BNRItem

#pragma mark synthesize

@synthesize itemName, serialNumber, valueInDollars, dateCreated, containedItem, container;

# pragma mark class methods

+ (id)randomItem
{
    NSArray *randomAdjectiveList = [NSArray arrayWithObjects:@"Fluffy", @"Rusty", @"Shiny", nil];
    
    NSArray *randomNounList = [NSArray arrayWithObjects:@"Bear", @"Spork", @"Mac", nil];
    
    NSInteger adjectiveIndex = rand() % [randomAdjectiveList count];
    NSInteger nounIndex = rand() % [randomNounList count];
    
    NSString *randomName = [NSString stringWithFormat:@"%@ %@", [randomAdjectiveList objectAtIndex:adjectiveIndex], [randomNounList objectAtIndex:nounIndex]];
    
    int randomValue = rand() % 100;
    
    NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c", '0' + rand() % 10, 'A' + rand() % 26, '0' + rand() % 10, 'A' + rand() % 26, '0' + rand() % 10 ];
    
    BNRItem *newItem = [[self alloc] initWithItemName:randomName valueInDollars:randomValue serialNumber:randomSerialNumber];
    
    return newItem;
}

# pragma mark initializers

- (id)initWithItemName:(NSString *)name
        valueInDollars:(int)value
          serialNumber:(NSString *)sNumber
{
    self = [super init];

    if (self) {
        [self setItemName:name];
        [self setValueInDollars:value];
        [self setSerialNumber:sNumber];
        dateCreated = [[NSDate alloc] init];
    }
    
    return self;
}

- (id)initWithItemName:(NSString *)name
          serialNumber:(NSString *)sNumber
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:sNumber];
}

- (id)init
{
    return [self initWithItemName:@"Item" valueInDollars:0 serialNumber:@""];
}

- (id)initWithItemName:(NSString *)name
{
    return [self initWithItemName:name valueInDollars:0 serialNumber:@""];
}

# pragma mark accessors

//- (void)setItemName:(NSString *)str
//{
//    itemName = str;
//}
//- (NSString *)itemName
//{
//    return itemName;
//}
//
//- (void)setSerialNumber:(NSString *)str
//{
//    serialNumber = str;
//}
//- (NSString *)serialNumber
//{
//    return serialNumber;
//}
//
//- (void)setValueInDollars:(int)i
//{
//    valueInDollars = i;
//}
//- (int)valueInDollars
//{
//    return valueInDollars;
//}

- (void)setContainedItem:(BNRItem *)i
{
    containedItem = i;
    
    // When given an item to contain, the contained
    // item will be given a pointer to its container
    [i setContainer:self];
}

//- (BNRItem *)containedItem
//{
//    return containedItem;
//}
//
//- (void)setContainer:(BNRItem *)i
//{
//    container = i;
//}
//
//- (BNRItem *)container
//{
//    return container;
//}
//
//- (NSDate *)dateCreated
//{
//    return dateCreated;
//}

# pragma mark overrides

- (NSString *)description
{
    return [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
                                itemName,
                                serialNumber,
                                valueInDollars,
                                dateCreated];
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

@end
