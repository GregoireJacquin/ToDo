//
//  DatePickerViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 08/10/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()
{
    UILabel *dateLabel;
}

@end
@implementation DatePickerViewController
@synthesize date;
@synthesize delegate;
@synthesize tableView;
@synthesize datePicker;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.datePicker setDate:[NSDate date]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    tableView = nil;
    datePicker = nil;
    dateLabel = nil;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)done
{
    self.date = date;
    [self updateDateLabel];
    [self.delegate datePicker:self didPickDate:date];
}

- (void)cancel
{
    [self.delegate datePickerDidCancel:self];
}
- (void)dateChanged
{
    self.date = [datePicker date];
    [self updateDateLabel];
}
- (void) updateDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    dateLabel.text = [formatter stringFromDate:date];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *) tableView:(UITableView *)theTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [theTableView dequeueReusableCellWithIdentifier:@"DateCell"];
    
    dateLabel = (UILabel *) [cell viewWithTag: 1000];
    [self updateDateLabel];
    
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 77;
}
@end
