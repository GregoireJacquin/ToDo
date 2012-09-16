//
//  CheckListItem.h
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckListItem : NSObject <NSCoding>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL checked;

- (void)toggleChecked;
@end
