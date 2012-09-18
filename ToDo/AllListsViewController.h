//
//  AllListsViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailListViewController.h"
#import "DataModel.h"

@interface AllListsViewController : UITableViewController <DetailListViewControllerDelegate , UINavigationControllerDelegate>

@property (strong, nonatomic) DataModel *dataModel;

@end
