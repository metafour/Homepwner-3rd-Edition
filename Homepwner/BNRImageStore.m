//
//  BNRImageStore.m
//  Homepwner
//
//  Created by Camron Schwoegler on 10/29/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "BNRImageStore.h"

@implementation BNRImageStore

+(BNRImageStore *)sharedStore
{
    static BNRImageStore *imageStore = nil;
    
    if (!imageStore) {
        imageStore = [[super allocWithZone:nil] init];
    }
    
    return imageStore;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedStore];
}

- (id)init
{
    self = [super init];
    if (self) {
        dictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)setImage:(UIImage *)i forKey:(NSString *)s
{
    [dictionary setObject:i forKey:s];
}

-(UIImage *)imageForKey:(NSString *)s
{
    return [dictionary objectForKey:s];
}

-(void)deleteImageForKey:(NSString *)s
{
    if (!s)
        return;
    
    [dictionary removeObjectForKey:s];
}


-(NSUInteger)count
{
    return [dictionary count];
}

@end
