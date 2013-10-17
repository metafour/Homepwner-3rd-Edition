//
//  DateViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 10/16/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "DateViewController.h"
#import "BNRItem.h"

@interface DateViewController ()

@end

@implementation DateViewController

@synthesize item, datePicker;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    [datePicker setDate:[item dateCreated]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [item setDateCreated:[datePicker date] ];
}

@end
