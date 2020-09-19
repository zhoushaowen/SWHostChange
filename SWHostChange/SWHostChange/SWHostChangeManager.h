//
//  SWHostChangeManager.h
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SWHost;

@interface SWHostChangeManager : NSObject

+ (instancetype)sharedInstance;

/**
 是否开启Host切换
 */
@property (nonatomic) BOOL enable;

@property (nonatomic,copy) NSArray<SWHost *> *hostGroup;

/**
 当前选中的Host,默认没有选中
 */
@property (nonatomic,strong) SWHost *currentHost;



@end

