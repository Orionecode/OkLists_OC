//
//  AllListsViewController.h
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import "ListDetailViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class DataModel;

@interface AllListsViewController : UITableViewController <ListDetailViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) DataModel *dataModel;

@end

NS_ASSUME_NONNULL_END
