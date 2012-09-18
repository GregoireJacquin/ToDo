//
//  DataModel.m
//  ToDo
//
//  Created by Grégoire Jacquin on 17/09/12.
//  Copyright (c) 2012 Grégoire Jacquin. All rights reserved.
//

#import "DataModel.h"
#import "CheckList.h"

@implementation DataModel
@synthesize lists;
- (id)init
{
    if (self = [super init]) {
        [self loadCheckList];
        [self registerDefaults];
    }
    return self;
}
#pragma mak - Save and load Items
- (NSString *)documentDirectory
{
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    return documentDirectory;
}
- (NSString *)DataFilePath
{
    return [[self documentDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}
- (void)saveCheckList
{
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:lists forKey:@"CheckList"];
    [archiver finishEncoding];
    [data writeToFile:[self DataFilePath] atomically:YES];
}
- (void)loadCheckList
{
    NSString *path = [self DataFilePath];
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        NSData *data = [[NSData alloc]initWithContentsOfFile:path];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
        lists = [unarchiver decodeObjectForKey:@"CheckList"];
        [unarchiver finishDecoding];
    }
    else
    {
        lists = [[NSMutableArray alloc]initWithCapacity:20];
    }
}
- (void)registerDefaults
{
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:-1],@"Checklistindex",[NSNumber numberWithBool:YES], @"Firsttime",nil];
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}
- (int)indexOfSelectedCheckList
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"Checklistindex"];
}
- (void) setIndexOfSelectedCheckList:(int)index
{
    [[NSUserDefaults standardUserDefaults]setInteger:index forKey:@"Checklistindex"];
}- (void)handleFirstime
{
    BOOL firsttime = [[NSUserDefaults standardUserDefaults] integerForKey:@"Firsttime"];
    if (firsttime) {
        CheckList *checklist = [[CheckList alloc]init];
    }
        
}
@end
