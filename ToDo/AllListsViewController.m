#import "AllListsViewController.h"
#import "Checklist.h"
#import "ChecklistViewController.h"
#import "ChecklistItem.h"

@implementation AllListsViewController

@synthesize dataModel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if ((self = [super initWithCoder:aDecoder])) {
		self.dataModel = [[DataModel alloc] init];
	}
	return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
	[self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
    self.navigationController.delegate = self;
    if(index >= 0 && index < [self.dataModel.lists count])
    if(index >= 0 && index < [self.dataModel.lists count])
    {
        CheckList *checklist = [self.dataModel.lists objectAtIndex:index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"ShowChecklist"])
    {
		CheckListViewController *controller = segue.destinationViewController;
		controller.checkList = sender;
	} else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
		UINavigationController *navigationController = segue.destinationViewController;
		DetailListViewController *controller = (DetailListViewController *)navigationController.topViewController;
		controller.delegate = self;
		controller.checkListToEdit = nil;
	}
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [self.dataModel.lists count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
    
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
	CheckList *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
    
	cell.textLabel.text = checklist.name;
	cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    if([checklist.items count] == 0)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"No items"];
    else if([checklist countUncheckedItems] == 0)
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Done !"];
    else
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining",[checklist countUncheckedItems]];
    
	return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [dataModel setIndexOfSelectedCheckList:indexPath.row];
	CheckList *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
	[self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	[self.dataModel.lists removeObjectAtIndex:indexPath.row];
    
	NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
	[tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListNavigationController"];
    
	DetailListViewController *controller = (DetailListViewController *)navigationController.topViewController;
	controller.delegate = self;
    
	CheckList *checklist = [self.dataModel.lists objectAtIndex:indexPath.row];
	controller.checkListToEdit = checklist;
    
	[self presentViewController:navigationController animated:YES completion:nil];
}

- (void)DetailListViewControllerDidCancel:(DetailListViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)DetailListViewController:(DetailListViewController *)controller didFinishAddingItem:(CheckList *)checkList
{
    int newIndex = [dataModel.lists count];
    [dataModel.lists addObject:checkList];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    //[self saveCheckListItems];
    [self dismissViewControllerAnimated:YES completion:Nil];
}
- (void)DetailListViewController:(DetailListViewController *)controller didFinishEditItem:(CheckList *)checkList
{
    int index = [dataModel.lists indexOfObject:checkList];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    cell.textLabel.text = checkList.name;
    //[self saveCheckListItems];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if(self == viewController)
    {
        [self.dataModel setIndexOfSelectedCheckList:-1];
    }
}

@end
