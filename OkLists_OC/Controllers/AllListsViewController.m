//
//  AllListsViewController.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "AllListsViewController.h"
#import "Checklist.h"
#import "CheckListViewController.h"
#import "ChecklistItem.h"
#import "DataModel.h"

@interface AllListsViewController ()

@end

@implementation AllListsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    self.navigationController.delegate = self;
    NSInteger index = [self.dataModel indexOfSelectedChecklist];
  
    if (index >= 0 && index < [self.dataModel.lists count]) {
        Checklist *checklist = self.dataModel.lists[index];
        [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
    }
}

#pragma mark - Table view data source
// 渲染行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu", [self.dataModel.lists count]);
    return [self.dataModel.lists count];
}

// 渲染Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ChecklistCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    cell.textLabel.text = checklist.name;
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    int count = [checklist countUncheckedItems];
    if ([checklist.items count] == 0) {
      cell.detailTextLabel.text = @"No Items";
    } else if (count == 0) {
      cell.detailTextLabel.text = @"All Done";
    } else {
      cell.detailTextLabel.text = [NSString stringWithFormat:@"%d Remaining", count];
    }
    
    cell.imageView.image = [UIImage systemImageNamed:checklist.iconName];
    
    return cell;
}

// 点击特定行导航到Checklist
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataModel setIndexOfSelectedChecklist:indexPath.row];
    
    Checklist *checklist = self.dataModel.lists[indexPath.row];
    
    [self performSegueWithIdentifier:@"ShowChecklist" sender:checklist];
}

// 删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.dataModel.lists removeObjectAtIndex:indexPath.row];
    
    NSArray *indexPaths = @[indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

// 修改
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
  UINavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"ListDetailViewController"];

  ListDetailViewController *controller = (ListDetailViewController *)navigationController;
  controller.delegate = self;

  Checklist *checklist = self.dataModel.lists[indexPath.row];
  controller.checklistToEdit = checklist;
    
  [self.navigationController pushViewController:navigationController animated:YES];
}

#pragma mark - Delegates

// 添加
- (void)listDetailViewController:(nonnull ListDetailViewController *)controller didFinishAddingChecklist:(nonnull Checklist *)checklist {
    [self.dataModel.lists addObject:checklist];
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    
    [self.navigationController popViewControllerAnimated:YES];
}

// 修改
- (void)listDetailViewController:(nonnull ListDetailViewController *)controller didFinishEditingChecklist:(nonnull Checklist *)checklist {
    [self.dataModel sortChecklists];
    [self.tableView reloadData];
    [self.navigationController popViewControllerAnimated:YES];
}

// 取消
- (void)listDetailViewControllerDidCancel:(nonnull ListDetailViewController *)controller {
    // dismiss 是给modal用的，popViewController才是返回上一页
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
  if (viewController == self) {
    [self.dataModel setIndexOfSelectedChecklist:-1];
  }
}


#pragma mark - Prepare
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  if ([segue.identifier isEqualToString:@"ShowChecklist"]) {
      CheckListViewController *controller = segue.destinationViewController;
      controller.checklist = sender;
  } else if ([segue.identifier isEqualToString:@"AddChecklist"]) {
      UINavigationController *navigationController = segue.destinationViewController;
      ListDetailViewController *controller = (ListDetailViewController *)navigationController;
      controller.delegate = self;
      controller.checklistToEdit = nil;
  }
}

@end
