//
//  DetailListViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "DetailListViewController.h"
#import "CheckList.h"

@interface DetailListViewController ()

@end

@implementation DetailListViewController
{
    NSString *iconName;
}
@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize checkListToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        iconName = @"No Icon";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    if(checkListToEdit != NULL)
    {
        self.title = @"Edit checklist";
        self.textField.text = checkListToEdit.name;
        self.doneBarButton.enabled = YES;
        iconName = checkListToEdit.iconName;
    }
    self.picker.image = [UIImage imageNamed:iconName];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [self setPicker:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"iconPicker"])
    {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

#pragma mark - TextField delegate

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newTextField = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    self.doneBarButton.enabled = ([newTextField length] > 0);
    
    return YES;
}

#pragma mark - Table view delegate

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1)
        return indexPath;
    else
        return 0;
}

#pragma mark ToDo AddItem
- (void) done
{
    if(checkListToEdit == NULL)
    {
        CheckList *checkList = [[CheckList alloc] init];
        checkList.name = textField.text;
        checkList.iconName = iconName;
        [delegate DetailListViewController:self didFinishAddingItem:checkList];
    }
    else
    {
        checkListToEdit.name = textField.text;
        checkListToEdit.iconName = iconName;
        [delegate DetailListViewController:self didFinishEditItem:checkListToEdit];
    }
    //[self  dismissViewControllerAnimated:YES completion:nil];
}
- (void) cancel
{
    //[self  dismissViewControllerAnimated:YES completion:nil];
    [delegate DetailListViewControllerDidCancel:self];
}
- (void)iconPicker:(IconPickerViewController *)controller didPickerIcon:(NSString *)theIconName
{
    iconName = theIconName;
    self.picker.image = [UIImage imageNamed:iconName];
    [self.navigationController popViewControllerAnimated:YES];
}
@end