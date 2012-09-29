//
//  IconPickerViewController.m
//  ToDo
//
//  Created by Grégoire Jacquin on 26/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController {
    NSArray *icons;
}
@synthesize delegate;

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
    icons = [NSArray arrayWithObjects:@"No Icon",@"Appointments",@"Birthday",@"Chores",@"Drink",@"Folder",@"Groceries",@"Inbox",@"Photos",@"Trips",nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    icons = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"iconCell"];
    NSString *icon = [icons objectAtIndex:indexPath.row];
    cell.textLabel.text = icon;
    cell.imageView.image = [UIImage imageNamed:icon];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *iconName = [icons objectAtIndex:indexPath.row];
    [delegate iconPicker:self didPickerIcon:iconName];
}

@end
