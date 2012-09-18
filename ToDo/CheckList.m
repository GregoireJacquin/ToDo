//
//  CheckList.m
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "CheckList.h"

@implementation CheckList
@synthesize name;
@synthesize items;

- (id)init
{
    if(self = [super init])
    {
        items = [[NSMutableArray alloc]initWithCapacity:20];
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
@end
