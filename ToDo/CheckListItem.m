//
//  CheckListItem.m
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//
//

#import "CheckListItem.h"

@implementation CheckListItem

- (void)toggleChecked
{
    self.checked = !self.checked;
}
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.checked = [aDecoder decodeBoolForKey:@"Checked"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
}

@end
