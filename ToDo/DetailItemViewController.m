//
//  AddItemViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 11/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "DetailItemViewController.h"

@interface DetailItemViewController ()

@end

@implementation DetailItemViewController
@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;
@synthesize itemToEdit;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    if(itemToEdit != NULL)
    {
        self.title = @"Edit item";
        self.textField.text = itemToEdit.name;
        self.doneBarButton.enabled = YES;
    }
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setTextField:nil];
    [self setDoneBarButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return 0;
}

#pragma mark ToDo AddItem
- (void) done
{
    if(itemToEdit == NULL)
    {
        CheckListItem *item = [[CheckListItem alloc] init];
        item.name = textField.text;
        [delegate DetailItemViewController:self didFinishAddingItem:item];
    }
    else {
        itemToEdit.name = textField.text;
        [delegate DetailItemViewController:self didFinishEditItem:itemToEdit];
    }
    //[self  dismissViewControllerAnimated:YES completion:nil];
}
- (void) cancel
{
    //[self  dismissViewControllerAnimated:YES completion:nil];
    [delegate DetailItemViewControllerDidCancel:self];
}
@end
