//
//  Checklist.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "Checklist.h"
#import "ChecklistItem.h"

@implementation Checklist

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.items = [[NSMutableArray alloc] initWithCapacity:20];
        self.iconName = @"No Icon";
    }
    return self;
}

- (instancetype)initWithCoder:(nonnull NSCoder *)coder {
    self = [super init];
    if (self) {
        self.name = [coder decodeObjectForKey:@"Name"];
        self.items = [coder decodeObjectForKey:@"Items"];
        self.iconName = [coder decodeObjectForKey:@"IconName"];
    }
    return self;
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder { 
    [coder encodeObject:self.name forKey:@"Name"];
    [coder encodeObject:self.items forKey:@"Items"];
    [coder encodeObject:self.iconName forKey:@"IconName"];
}

- (int)countUncheckedItems {
    int count = 0;
    for (ChecklistItem *item in self.items) {
        if (!item.checked) {
            count += 1;
        }
    }
    return count;
}

- (NSComparisonResult)compare:(Checklist *)other
{
    return [self.name localizedStandardCompare:other.name];
}

@end
