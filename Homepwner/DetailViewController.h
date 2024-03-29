//
//  DetailViewController.h
//  Homepwner
//
//  Created by Camron Schwoegler on 10/16/13.
//  Copyright (c) 2013 Camron Schwoegler. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BNRItem;

@interface DetailViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>
{
    __weak IBOutlet UITextField *nameField;
    __weak IBOutlet UITextField *serialField;
    __weak IBOutlet UITextField *valueField;
    __weak IBOutlet UILabel *dateLabel;
    __weak IBOutlet UIImageView *imageView;
    __weak IBOutlet UIToolbar *toolbar;
    
    UIPopoverController *popoverController;
}

@property (nonatomic, strong) BNRItem *item;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)changeDate:(id)sender;
- (IBAction)takePicture:(id)sender;
- (IBAction)backgroundTapped:(id)sender;
- (id)initForNewItem:(BOOL)isNew;

@end
