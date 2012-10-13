//
//  CheckListItem.m
//  ToDo
//
//  Created by Grégoire Jacquin on 09/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//
//

#import "CheckListItem.h"
#import "DataModel.h"

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
        self.dueDate = [aDecoder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [aDecoder decodeBoolForKey:@"shouldRemind"];
        self.itemId = [aDecoder decodeIntForKey:@"itemId"];
    }
    return self;
    
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"Name"];
    [aCoder encodeBool:self.checked forKey:@"Checked"];
    [aCoder encodeObject:self.dueDate forKey:@"DueDate"];
    [aCoder encodeBool:self.shouldRemind forKey:@"shouldRemind"];
    [aCoder encodeInt:self.itemId forKey:@"itemId"];
}

- (id)init
{
    if(self = [super init])
    {
        self.itemId = [DataModel nextCheckListItem];
    }
    return self;
}

- (void) scheduleNotification
{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    if(self.shouldRemind && [self.dueDate compare:[NSDate date]] == NSOrderedAscending)
    {
        UILocalNotification *localNotification = [[UILocalNotification alloc] init];
        localNotification.fireDate = self.dueDate;
        localNotification.timeZone = [NSTimeZone defaultTimeZone];
        localNotification.alertBody = self.name;
        localNotification.soundName = UILocalNotificationDefaultSoundName;
        localNotification.userInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:self.itemId] forKey:@"itemdId"];
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
        NSLog(@"Notification doit est planifié %@ %d", localNotification, self.itemId);
    }
}
- (UILocalNotification *)notificationForThisItem
{
    NSArray *allNotification = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *notification in allNotification) {
        NSNumber *nomber =[notification.userInfo objectForKey:@"itemId"];
        if(nomber != nil && [nomber intValue] == self.itemId)
        {
            return notification;
        }
    }
    return 0;
}
- (void)dealloc
{
    UILocalNotification *existingNotification = [self notificationForThisItem];
    if (existingNotification != nil) {
        [[UIApplication sharedApplication] cancelLocalNotification:existingNotification];
    }
    
}

@end
