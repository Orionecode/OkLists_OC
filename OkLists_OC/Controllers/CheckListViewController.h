//
//  CheckListViewController.h
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import "ItemDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class Checklist;

@interface CheckListViewController : UITableViewController <ItemDetailViewControllerDelegate>

@property (nonatomic, strong) Checklist *checklist;

@end

NS_ASSUME_NONNULL_END
