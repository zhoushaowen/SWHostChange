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
#import <MarqueeLabel.h>

@interface SWHostChangeTableViewCell : UITableViewCell

@property (nonatomic,strong) MarqueeLabel *animationLabel;

@end

@implementation SWHostChangeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        MarqueeLabel *label = [[MarqueeLabel alloc] initWithFrame:self.detailTextLabel.frame];
        label.rate = 25;
        [self.contentView addSubview:label];
        self.animationLabel = label;
        self.animationLabel.font = self.detailTextLabel.font;
        self.animationLabel.textColor = self.detailTextLabel.textColor;
        self.detailTextLabel.hidden = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.animationLabel.frame = self.detailTextLabel.frame;
}

@end

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
    SWHostChangeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cell];
    if(cell == nil){
        cell = [[SWHostChangeTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cell];
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
    cell.animationLabel.text = cell.detailTextLabel.text;
    cell.accessoryType = UITableViewCellAccessoryNone;
    if([host isEqual:[SWHostChangeManager sharedInstance].currentHost]){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(SWHostChangeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.animationLabel restartLabel];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(SWHostChangeTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell.animationLabel shutdownLabel];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *Header = @"header";
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:Header];
    if(header == nil){
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:Header];
    }
    header.textLabel.text = [NSString stringWithFormat:@"当前选择的是:%@",[SWHostChangeManager sharedInstance].currentHost.name];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否修改当前Host?" message:@"修改当前Host之后app会自动退出,请重新启动app!" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        SWHost *host = [SWHostChangeManager sharedInstance].hostGroup[indexPath.row];
        [[SWHostChangeManager sharedInstance] setCurrentHost:host];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [[[UIApplication sharedApplication].delegate window].rootViewController presentViewController:alert animated:YES completion:nil];
}



@end
