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
#import "BNRItemStore.h"
#import "BNRImageStore.h"

@implementation DetailViewController

@synthesize item, dismissBlock;

- (id)init
{
    @throw [NSException exceptionWithName:@"Wrong Initializer" reason:@"Use initForNewItem:" userInfo:nil];
}
- (id)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    
    if (self) {
        if (isNew) {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            [[self navigationItem] setRightBarButtonItem:doneItem];
            
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            [[self navigationItem] setLeftBarButtonItem:cancelItem];
        }
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(removeItemImage)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    NSArray *toolbarItems = [NSArray arrayWithObjects:[[toolbar items] objectAtIndex:0],flexibleSpace, deleteButton, nil];
    [toolbar setItems:toolbarItems animated:YES];
    
//    [[self navigationItem] setTitle:[item itemName]];
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
    
    NSString *imageKey = [item imageKey];
    
    // if imageKey is nil or itemImage is nil then clear the UIImageView
    // is this really necessary? If imageKey is nil then itemImage will be nil
    if (imageKey) {
        UIImage *itemImage = [[BNRImageStore sharedStore] imageForKey:imageKey];
        [imageView setImage:itemImage];
    } else {
        [imageView setImage:nil];
    }
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

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        return UIInterfaceOrientationMaskAll;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (IBAction)changeDate:(id)sender
{
    DateViewController *dvc = [[DateViewController alloc] init];
    [dvc setItem:item];
    // This has no effect since the datePicker seems to not exist at this point. Setting the date
    // in the DateViewController object works instead
//    [[dvc datePicker] setDate:[item dateCreated]];
    [[self navigationController] pushViewController:dvc animated:YES];
}

- (IBAction)takePicture:(id)sender
{
    if ([popoverController isPopoverVisible]) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
        return;
    }
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    [ipc setDelegate:self];
    
    // Allow editing of image
    [ipc setAllowsEditing:YES];
    
    // If the device has a camera present view to take a picture
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    } else { // Otherwise present the Photo Library
        [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }

    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        popoverController = [[UIPopoverController alloc] initWithContentViewController:ipc];
        [popoverController setDelegate:self];
        [popoverController presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self presentViewController:ipc animated:YES completion:NULL];
    }

}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)poc
{
    popoverController = nil;
}

- (IBAction)backgroundTapped:(id)sender
{
    [[self view] endEditing:YES];
}

- (void)removeItemImage
{
    [[BNRImageStore sharedStore] deleteImageForKey:[item imageKey]];
    [item setImageKey:nil];
    [imageView setImage:nil];
//    [[self view] setNeedsDisplay];
    
}

- (void)save:(id)sender
{
    [item setItemName:[nameField text]];
    [item setSerialNumber:[serialField text]];
    [item setValueInDollars:[[valueField text] integerValue]];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:item];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

#pragma mark accessors

- (void)setItem:(BNRItem *)i
{
    item = i;
    [[self navigationItem] setTitle:[item itemName]];
}

#pragma mark - UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:textField action:@selector(resignFirstResponder)]];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [[self navigationItem] setRightBarButtonItem:nil];
}

#pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    NSString *imageKey = [item imageKey];
    
    // if imageKey is not nil then we are replacing the item's image
    // remove it so that we save memory
    if (imageKey) {
        [[BNRImageStore sharedStore] deleteImageForKey:imageKey];
    }
    
    CFUUIDRef imageUUID = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef imageUUIDString = CFUUIDCreateString(kCFAllocatorDefault, imageUUID);
    imageKey = (__bridge NSString *)imageUUIDString;
    [item setImageKey:imageKey];
    [[BNRImageStore sharedStore] setImage:image forKey:[item imageKey]];
    CFRelease(imageUUID);
    CFRelease(imageUUIDString);
    [imageView setImage:image];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom]) {
        [popoverController dismissPopoverAnimated:YES];
        popoverController = nil;
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
