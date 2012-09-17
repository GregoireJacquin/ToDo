//
//  AllListsViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "AllListsViewController.h"
#import "CheckList.h"
#import "CheckListViewController.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController
{
    NSMutableArray *lists;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        lists = [[NSMutableArray alloc]initWithCapacity:20];
        CheckList *list = [[CheckList alloc] init];
        list.name = @"Todo 1";
        [lists addObject:list];
        
        CheckList *list1 = [[CheckList alloc] init];
        list1.name = @"Todo 2";
        [lists addObject:list1];
        
        CheckList *list2 = [[CheckList alloc] init];
        list2.name = @"Todo 2";
        [lists addObject:list2];
    }
    
    
    return self;
}

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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowCheckList"])
    {
        CheckListViewController *controller = segue.destinationViewController;
        controller.checkList = sender;
        
    }
    else if([segue.identifier isEqualToString:@"AddCheckList"])
    {
        UINavigationController *navigation = segue.destinationViewController;
        DetailListViewController *controller = (DetailListViewController *)navigation.topViewController;
        controller.delegate = self;
        controller.checkListToEdit = nil;
        
    }
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    UINavigationController *navigation = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    DetailListViewController *controller = (DetailListViewController *)navigation.topViewController;
    controller.delegate = self;
    CheckList *checkList = [lists objectAtIndex:indexPath.row];
    controller.checkListToEdit = checkList;
    
    [self presentViewController:navigation animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    CheckList *list = [lists objectAtIndex:indexPath.row];
    
    cell.textLabel.text = list.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [lists removeObjectAtIndex:indexPath.row];
    
    NSArray * indexPaths = [NSArray arrayWithObject: indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckList *checkList = [lists objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ShowCheckList" sender:checkList];
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}
#pragma mark - DetailListViewController Delegate
- (void)DetailListViewController:(DetailListViewController *)controller didFinishAddingItem:(CheckList *)checkList
{
    int newIndex = [lists count];
    [lists addObject:checkList];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)DetailListViewControllerDidCancel:(DetailListViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)DetailListViewController:(DetailListViewController *)controller didFinishEditItem:(CheckList *)checkList
{
    int index = [lists indexOfObject:checkList];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.text = checkList.name;
    //[self configureTextForCell:cell whitAtItem:checkList];
    //[self saveCheckListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
