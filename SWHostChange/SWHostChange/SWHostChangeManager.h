//
//  SWHostChangeManager.h
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const SWHostDidChangeNotification;

@class SWHost;

@interface SWHostChangeManager : NSObject

+ (instancetype)sharedInstance;

/**
 是否开启Host切换 默认为NO
 */
@property (nonatomic) BOOL enable;
/// 如果app启动之后currentHost为空,是否自动弹出SWHostChangeViewController 默认是YES
@property (nonatomic) BOOL automaticShowHostChangeVCAfterAppLaunchIfCurrentHostIsNil;

@property (nonatomic,copy) NSArray<SWHost *> *hostGroup;

/**
 当前选中的Host,默认没有选中
 */
@property (nonatomic,strong) SWHost *currentHost;



@end

