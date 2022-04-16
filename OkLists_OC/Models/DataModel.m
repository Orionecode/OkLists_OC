//
//  DataModel.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "DataModel.h"
#import "Checklist.h"

@implementation DataModel

- (id)init
{
    self = [super init];
    if (self) {
        [self loadChecklists];
        [self registerDefaults];
        [self handleFirstTime];
    }
    return self;
}

- (NSString *)documentDirectory {
    //Get documents directory
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [directoryPaths objectAtIndex:0];
    return documentsDirectoryPath;
}

- (NSString *)dataFilePath {
    return [[self documentDirectory] stringByAppendingPathComponent:@"Checklists.plist"];
}

- (void)saveChecklists {
    NSMutableData *data = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    [archiver encodeObject:self.lists forKey:@"Checklists"];
    [archiver finishEncoding];
    [data writeToFile:[self dataFilePath] atomically:YES];
}

- (void)loadChecklists {
    NSString *path = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
      NSData *data = [[NSData alloc] initWithContentsOfFile:path];
      NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
      self.lists = [unarchiver decodeObjectForKey:@"Checklists"];
      [unarchiver finishDecoding];
    } else {
      self.lists = [[NSMutableArray alloc] initWithCapacity:20];
    }
}

- (void)registerDefaults {
    NSDictionary *dictionary = @{
      @"ChecklistIndex" : @-1,
      @"FirstTime" : @YES,
      @"ChecklistItemId" : @0,
      };

    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
}

- (void)handleFirstTime {
    BOOL firstTime = [[NSUserDefaults standardUserDefaults] boolForKey:@"FirstTime"];
    if (firstTime) {
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = @"List";
        checklist.iconName = @"folder";
        [self.lists addObject:checklist];
        [self setIndexOfSelectedChecklist:0];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"FirstTime"];
    }
}

- (NSInteger)indexOfSelectedChecklist {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"ChecklistIndex"];
}

- (void)setIndexOfSelectedChecklist:(NSInteger)index {
    [[NSUserDefaults standardUserDefaults] setInteger:index forKey:@"ChecklistIndex"];
}

- (void)sortChecklists {
    [self.lists sortUsingSelector:@selector(compare:)];
}

+ (NSInteger)nextChecklistItemID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger itemID = [userDefaults integerForKey:@"ChecklistItemId"];
    [userDefaults setInteger:itemID + 1 forKey:@"ChecklistItemId"];
    [userDefaults synchronize];
    return itemID;
}
@end
