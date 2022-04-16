//
//  DataModel.h
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataModel : NSObject

@property (nonatomic, strong) NSMutableArray *lists;

- (void)saveChecklists;
- (void)sortChecklists;

- (NSInteger)indexOfSelectedChecklist;
- (void)setIndexOfSelectedChecklist:(NSInteger)index;
+ (NSInteger)nextChecklistItemID;

@end

NS_ASSUME_NONNULL_END
