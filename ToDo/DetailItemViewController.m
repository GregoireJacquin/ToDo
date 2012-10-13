//
//  AddItemViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 11/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "DetailItemViewController.h"

@interface DetailItemViewController ()
{
    NSDate *dueDate;
    NSString *text;
    BOOL shouldRemind;
}

@end

@implementation DetailItemViewController
@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        text = @"";
        shouldRemind = NO;
        dueDate = [NSDate date];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    if(self.itemToEdit != nil)
    {
        self.title = @"Edit item";
    }
    self.textField.text = text;
    self.switchControl.on = shouldRemind;
    [self updateDoneBarButton];
    [self updateDueDateLabel];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)updateDoneBarButton
{
    self.doneBarButton.enabled = ([text length] > 0);
}
- (void)updateDueDateLabel
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    self.dueDateLabel.text = [formatter stringFromDate:dueDate];
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [self setDueDateLabel:nil];
    [self setSwitchControl:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)setItemToEdit:(CheckListItem *)newItem
{
    if(newItem != nil)
    {
        itemToEdit = newItem;
        text = itemToEdit.name;
        shouldRemind = itemToEdit.shouldRemind;
        itemToEdit.dueDate = dueDate;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - TextField delegate
- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    text = [theTextField.text stringByReplacingCharactersInRange:range withString:string];
    [self updateDoneBarButton];
    
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)theTextField
{
    text = theTextField.text;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        return indexPath;
    }
    else
    {
        return 0;
    }
}

#pragma mark ToDo AddItem
- (void) done
{
    if(itemToEdit == NULL)
    {
        CheckListItem *item = [[CheckListItem alloc] init];
        item.name = textField.text;
        item.checked = NO;
        item.dueDate = dueDate;
        item.shouldRemind = self.switchControl.on;
        [item scheduleNotification];
        [delegate DetailItemViewController:self didFinishAddingItem:item];
    }
    else {
        itemToEdit.name = textField.text;
        itemToEdit.shouldRemind = self.switchControl.on;
        itemToEdit.dueDate = dueDate;
        [itemToEdit scheduleNotification];
        [delegate DetailItemViewController:self didFinishEditItem:itemToEdit];
    }
    //[self  dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)switchChanged:(UISwitch *)sender {
    
    shouldRemind = sender.on;
}

- (void) cancel
{
    //[self  dismissViewControllerAnimated:YES completion:nil];
    [delegate DetailItemViewControllerDidCancel:self];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"DatePicker"])
    {
        DatePickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
        controller.date = dueDate;
    }
}
- (void)datePicker:(DatePickerViewController *)controller didPickDate:(NSDate *)date
{
    dueDate = date;
    [self updateDueDateLabel];
    [self dismissViewControllerAnimated:YES completion:nil];    
}
- (void)datePickerDidCancel:(DatePickerViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
