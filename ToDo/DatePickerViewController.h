//
//  DatePickerViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 08/10/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DatePickerViewController;

@protocol DatePickerViewControllerDelegate  <NSObject>
- (void) datePickerDidCancel:(DatePickerViewController *)controller;
- (void) datePicker:(DatePickerViewController *)controller didPickDate:(NSDate *)date;
@end

@interface DatePickerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, weak) id <DatePickerViewControllerDelegate> delegate;
@property (nonatomic, strong) NSDate *date;

- (IBAction) cancel;
- (IBAction) done;
- (IBAction) dateChanged;

@end
