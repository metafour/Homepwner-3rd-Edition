//
//  DetailViewController.h
//  Homepwner
//
//  Created by Camron Schwoegler on 10/16/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
}

@property (nonatomic, strong) BNRItem *item;

- (IBAction)changeDate:(id)sender;

@end
