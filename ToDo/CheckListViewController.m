//
//  ViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "CheckListViewController.h"
#import "CheckListItem.h"
#import "CheckList.h"

@interface CheckListViewController ()

@end

@implementation CheckListViewController
@synthesize checkList;
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        //[self loadCheckListItems];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = checkList.name;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark ToDo

- (void)configureCheckmarkForCell:(UITableViewCell *)cell whithAtItem:(CheckListItem *)item
{
        UILabel *label = (UILabel *)[cell viewWithTag:1001];
        
        if(item.checked)
            label.text = @"√";
        else
            label.text = @"";
}
- (void)configureTextForCell:(UITableViewCell *)cell whitAtItem:(CheckListItem *)item
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    //label.text = item.name;
    label.text = [NSString stringWithFormat:@"%@",item.name];
    
}

#pragma mark UITableViewControllerDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [checkList.items removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    //[self saveCheckListItems];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [checkList.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Checklistitem"];
    
    CheckListItem *item = [checkList.items objectAtIndex:indexPath.row];
    
    [self configureTextForCell:cell whitAtItem:item];
    [self configureCheckmarkForCell:cell whithAtItem:item];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CheckListItem *item = [checkList.items objectAtIndex:indexPath.row];
    [item toggleChecked];
    
    [self configureCheckmarkForCell:cell whithAtItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailItemViewController *controller = (DetailItemViewController *)navigationController.topViewController;
        controller.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"EditItem"])
    {
        UINavigationController *navigationController = segue.destinationViewController;
        DetailItemViewController *controller = (DetailItemViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.itemToEdit = sender;
    }

}

#pragma mark - AddItemViewController Delegate
- (void)DetailItemViewController:(DetailItemViewController *)controller didFinishAddingItem:(CheckListItem *)item
{
    int newIndex = [checkList.items count];
    [checkList.items addObject:item];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)DetailItemViewControllerDidCancel:(DetailItemViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    CheckListItem *item = [checkList.items objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"EditItem" sender:item];
}
- (void)DetailItemViewController:(DetailItemViewController *)controller didFinishEditItem:(CheckListItem *)item
{
    int index = [checkList.items indexOfObject:item];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    [self configureTextForCell:cell whitAtItem:item];
    //[self saveCheckListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
