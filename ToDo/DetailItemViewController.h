//
//  AddItemViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 11/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListItem.h"
#import "DatePickerViewController.h"
@class DetailItemViewController;

@protocol DetailItemViewControllerDelegate <NSObject>

- (void)DetailItemViewControllerDidCancel:(DetailItemViewController *)controller;
- (void)DetailItemViewController:(DetailItemViewController *)controller didFinishAddingItem:(CheckListItem *)item;
- (void)DetailItemViewController:(DetailItemViewController *)controller didFinishEditItem:(CheckListItem *)item;

@end

@interface DetailItemViewController : UITableViewController <UITextFieldDelegate, DatePickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) id <DetailItemViewControllerDelegate> delegate;
@property (strong, nonatomic) CheckListItem *itemToEdit;
@property (strong, nonatomic) IBOutlet UILabel *dueDateLabel;
@property (strong, nonatomic) IBOutlet UISwitch *switchControl;
- (IBAction)switchChanged:(id)sender;
- (IBAction)cancel;
- (IBAction)done;
@end
