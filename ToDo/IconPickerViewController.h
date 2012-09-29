//
//  IconPickerViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 26/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IconPickerViewController;

@protocol IconPickerViewControllerDelegate <NSObject>

- (void) iconPicker:(IconPickerViewController *)controller didPickerIcon:(NSString *)iconName;
@end

@interface IconPickerViewController : UITableViewController

@property (weak,nonatomic) id <IconPickerViewControllerDelegate> delegate;
@end
