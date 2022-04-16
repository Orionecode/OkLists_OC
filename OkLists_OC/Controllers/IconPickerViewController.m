//
//  IconPickerViewController.m
//  OkLists_OC
//
//  Created by 曾一笑 on 2022/4/14.
//

#import "IconPickerViewController.h"

@interface IconPickerViewController ()

@end

@implementation IconPickerViewController
{
    NSArray *_icons;
    NSArray *_iconsName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _icons = @[
        @"globe.asia.australia",
        @"bolt.fill",
        @"pencil",
        @"wand.and.rays",
        @"list.number",
        @"alarm",
        @"photo",
        @"plus.rectangle.on.folder.fill"];
    _iconsName = @[
        @"Global",
        @"Lightning",
        @"Pencil",
        @"Rays",
        @"List",
        @"Alarm",
        @"Photo",
        @"Folder"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_icons count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IconCell"];
    
    cell.textLabel.text = _iconsName[indexPath.row];
    cell.imageView.image = [UIImage systemImageNamed:_icons[indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *iconName = _icons[indexPath.row];
    [self.delegate iconPicker:self didPickIcon:iconName];
}

@end
