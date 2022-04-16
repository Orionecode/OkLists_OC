//
//  ListDetailViewController.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "ListDetailViewController.h"
#import "Checklist.h"

@interface ListDetailViewController ()

@end

@implementation ListDetailViewController
{
    NSString *_iconName;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if ((self = [super initWithCoder:coder])) {
      _iconName = @"folder";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.checklistToEdit != nil) {
        self.title = @"Edit Checklist";
        self.UITextField.text = self.checklistToEdit.name;
        self.doneBarButton.enabled = YES;
        _iconName = self.checklistToEdit.iconName;
    }
    
    self.iconImageView.image = [UIImage systemImageNamed:_iconName];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.UITextField becomeFirstResponder];
}

- (IBAction)cancel {
    [self.delegate listDetailViewControllerDidCancel:self];
}

- (IBAction)done {
    if (self.checklistToEdit == nil) {
        // 添加新项目
        Checklist *checklist = [[Checklist alloc] init];
        checklist.name = self.UITextField.text;
        checklist.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishAddingChecklist:checklist];
    } else {
        // 编辑现有项目
        self.checklistToEdit.name = self.UITextField.text;
        self.checklistToEdit.iconName = _iconName;
        
        [self.delegate listDetailViewController:self didFinishEditingChecklist:self.checklistToEdit];
    }
}

#pragma mark - Table view data source

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return indexPath;
    } else {
        return nil;
    }
}

// 是否开启Done Button
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

// icon Picker
- (void)iconPicker:(IconPickerViewController *)picker didPickIcon:(NSString *)iconName {
    _iconName = iconName;
    self.iconImageView.image = [UIImage systemImageNamed:_iconName];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Prepare (Navigation)
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PickIcon"]) {
        IconPickerViewController *controller = segue.destinationViewController;
        controller.delegate = self;
    }
}

@end
