//
//  SWHostChangeViewController.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWHostChangeViewController.h"
#import "SWHostChangeManager.h"
#import "SWHost.h"

@interface SWHostChangeViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation SWHostChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [SWHostChangeManager sharedInstance].hostGroup.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Cell = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell];
    }
    NSArray *array = [SWHostChangeManager sharedInstance].hostGroup;
    SWHost *host = array[indexPath.row];
    cell.textLabel.text = host.name;
    NSMutableString *str = [[NSMutableString alloc] initWithString:@""];
    [[host.info allKeys] enumerateObjectsUsingBlock:^(NSString*  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *value = host.info[key];
        [str appendFormat:@"%@:%@",key,value];
        [str appendString:@","];
    }];
    if([str hasSuffix:@","]){
        str = [[str substringToIndex:str.length - 1] mutableCopy];
    }
    cell.detailTextLabel.text = str;
    [host setValue:@(indexPath.row) forKey:@"ID"];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if([[host valueForKey:@"ID"] integerValue] == [[[SWHostChangeManager sharedInstance].currentHost valueForKey:@"ID"] integerValue]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *Header = @"header";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:Header];
    if(header == nil){
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:Header];
    }
    header.textLabel.text = [NSString stringWithFormat:@"当前选择的Host:%@",[SWHostChangeManager sharedInstance].currentHost.name];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否修改当前Host?" message:@"修改当前Host之后app会自动退出,请重新启动app!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        SWHost *host = [SWHostChangeManager sharedInstance].hostGroup[indexPath.row];
        [[SWHostChangeManager sharedInstance] setCurrentHost:host];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}



@end
