//
//  DetailViewController.m
//  Homepwner
//
//  Created by Camron Schwoegler on 10/16/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import "DetailViewController.h"
#import "BNRItem.h"
#import "DateViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

@synthesize item;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[self navigationItem] setTitle:[item itemName]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [nameField setText:[item itemName]];
    [serialField setText:[item serialNumber]];
    [valueField setText:[NSString stringWithFormat:@"%d",[item valueInDollars]]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateLabel setText:[dateFormatter stringFromDate:[item dateCreated]]];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // resign first responder
    [[self view] endEditing:YES];
    
    // write changes back to store
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialField text]];
    [item setValueInDollars:[[valueField text] integerValue]];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[self navigationItem] setRightBarButtonItem:nil];
}

- (IBAction)changeDate:(id)sender
{
    DateViewController *dvc = [[DateViewController alloc] init];
    [dvc setItem:item];
    [[dvc datePicker] setDate:[item dateCreated]];
    [[self navigationController] pushViewController:dvc animated:YES];
}

#pragma mark accessors

- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

@end
