//
//  ListDetailViewController.h
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import <UIKit/UIKit.h>
#import "IconPickerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class ListDetailViewController;
@class Checklist;

#pragma mark - protocol
@protocol ListDetailViewControllerDelegate <NSObject>
- (void)listDetailViewControllerDidCancel:(ListDetailViewController *)controller;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishAddingChecklist:(Checklist *)checklist;
- (void)listDetailViewController:(ListDetailViewController *)controller didFinishEditingChecklist:(Checklist *)checklist;
@end

#pragma mark - interface
@interface ListDetailViewController : UITableViewController <UITextFieldDelegate, IconPickerViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *UITextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

- (IBAction)done;
- (IBAction)cancel;

@property (nonatomic, weak) id <ListDetailViewControllerDelegate> delegate;
@property (nonatomic, strong) Checklist *checklistToEdit;

@end

NS_ASSUME_NONNULL_END
