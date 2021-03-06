//
//  DetailListViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"
@class DetailListViewController;
@class CheckList;

@protocol DetailListViewControllerDelegate <NSObject>

- (void)DetailListViewControllerDidCancel:(DetailListViewController *)controller;
- (void)DetailListViewController:(DetailListViewController *)controller didFinishAddingItem:(CheckList *)checkList;
- (void)DetailListViewController:(DetailListViewController *)controller didFinishEditItem:(CheckList *)checkList;

@end

@interface DetailListViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) id <DetailListViewControllerDelegate> delegate;
@property (strong, nonatomic) CheckList *checkListToEdit;
@property (strong, nonatomic) IBOutlet UIImageView *picker;
- (IBAction)cancel;
- (IBAction)done;

@end
