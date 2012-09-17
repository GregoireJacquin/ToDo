//
//  ViewController.h
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailItemViewController.h"
@class CheckList;

@interface CheckListViewController : UITableViewController <DetailItemViewControllerDelegate>
@property (strong, nonatomic) CheckList *checkList;
@end
