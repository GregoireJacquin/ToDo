//
//  ViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "CheckListItemViewController.h"
#import "CheckListItem.h"

@interface CheckListItemViewController ()

@end

@implementation CheckListItemViewController
{
    NSMutableArray *items;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    items = [[NSMutableArray alloc] initWithCapacity:20];
    
    CheckListItem *items1 =[[CheckListItem alloc] init];
    items1.name = @"Sortir le chien";
    items1.checked = NO;
    [items addObject:items1];
    
    CheckListItem *items2 =[[CheckListItem alloc] init];
    items2.name = @"Sortir le chat";
    items2.checked = YES;
    [items addObject:items2];
    
    CheckListItem *items3 =[[CheckListItem alloc] init];
    items3.name = @"Sortir le lapin";
    items3.checked = NO;
    [items addObject:items3];
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
    label.text = item.name;
    
}

#pragma mark UITableViewControllerDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Checklistitem"];
    
    CheckListItem *item = [items objectAtIndex:indexPath.row];
    
    [self configureTextForCell:cell whitAtItem:item];
    [self configureCheckmarkForCell:cell whithAtItem:item];
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckListItem *item = [items objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    item.checked = !item.checked;
    
    [self configureCheckmarkForCell:cell whithAtItem:item];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}


@end
