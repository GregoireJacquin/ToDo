//
//  DataModel.h
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject

@property (strong, nonatomic)NSMutableArray *lists;
- (void) saveCheckList;
- (int) indexOfSelectedCheckList;
- (void) setIndexOfSelectedCheckList:(int)index;
- (void) sortCheckList;
@end
