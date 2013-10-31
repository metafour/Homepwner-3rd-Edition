//
//  BNRImageStore.h
//  Homepwner
//
//  Created by Camron Schwoegler on 10/29/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BNRImageStore : NSObject
{
    NSMutableDictionary *dictionary;
}

+(BNRImageStore *)sharedStore;

-(void)setImage:(UIImage *)i forKey:(NSString *)key;
-(UIImage *)imageForKey:(NSString *)s;
-(void)deleteImageForKey:(NSString *)s;
-(NSUInteger)count;

@end
