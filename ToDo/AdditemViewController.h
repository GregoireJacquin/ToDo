//
//  AddItemViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 11/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckListItem.h"
@class AddItemViewController;

@protocol AddItemViewControllerDelegate <NSObject>

- (void)AddItemViewControllerDidCancel:(AddItemViewController *)controller;
- (void)AddItemViewController:(AddItemViewController *)controller didFinishAddingItem:(CheckListItem *)item;

@end

@interface AddItemViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (strong, nonatomic) id <AddItemViewControllerDelegate> delegate;

- (IBAction)cancel;
- (IBAction)done;
@end
