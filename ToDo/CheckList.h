//
//  CheckList.h
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckList : NSObject <NSCoding>

@property (copy, nonatomic)NSString *name;
@property (strong, nonatomic)NSMutableArray *items;
@property (copy, nonatomic)NSString *iconName;
- (int) countUncheckedItems;
@end
