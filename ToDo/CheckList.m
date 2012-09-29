//
//  CheckList.m
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "CheckList.h"
#import "CheckListItem.h"

@implementation CheckList
@synthesize name;
@synthesize items;
@synthesize iconName;

- (id)init
{
    if(self = [super init])
    {
        items = [[NSMutableArray alloc]initWithCapacity:20];
        iconName = @"No Icon";
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.name = [aDecoder decodeObjectForKey:@"Name"];
        self.items = [aDecoder decodeObjectForKey:@"Items"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.items forKey:@"Items"];
    [aCoder encodeObject:self.name forKey:@"Name"];
}
- (int)countUncheckedItems
{
    int count = 0;
    for (CheckListItem *item in items) {
        if(!item.checked)
            count += 1;
    }
    return count;
}
- (NSComparisonResult)comparer:(CheckList *)otherCheckList
{
    return [self.name localizedCaseInsensitiveCompare:otherCheckList.name];
}
@end
