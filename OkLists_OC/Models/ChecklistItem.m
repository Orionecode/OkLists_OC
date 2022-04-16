//
//  ChecklistItem.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "ChecklistItem.h"
#import "DataModel.h"

@implementation ChecklistItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.itemId = [DataModel nextChecklistItemID];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super init]) {
        self.dueDate = [coder decodeObjectForKey:@"DueDate"];
        self.shouldRemind = [coder decodeBoolForKey:@"ShouldRemind"];
        self.itemId = [coder decodeIntegerForKey:@"ItemID"];
        
        self.text = [coder decodeObjectForKey:@"Text"];
        self.checked = [coder decodeBoolForKey:@"Checked"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.dueDate forKey:@"DueDate"];
    [coder encodeBool:self.shouldRemind forKey:@"ShouldRemind"];
    [coder encodeInteger:self.itemId forKey:@"ItemID"];
    
    [coder encodeObject:self.text forKey:@"Text"];
    [coder encodeBool:self.checked forKey:@"Checked"];
}

- (void)toggleChecked {
    self.checked = !self.checked;
}

@end
