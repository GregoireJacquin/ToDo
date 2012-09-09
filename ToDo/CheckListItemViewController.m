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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog([NSString stringWithFormat:@"%d", [items count]]);
    return [items count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckListItem *item = [items objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Checklistitem"];
    UILabel *label = (UILabel *)[tableView viewWithTag:1000];
    NSLog([NSString stringWithFormat:@"%@", item.name]);
    label.text = item.name;
    
    return cell;
     
}


@end
