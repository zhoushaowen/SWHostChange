//
//  SWHost.h
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWHost : NSObject<NSCoding>

- (instancetype)initWithName:(NSString *)name info:(NSDictionary *)info;

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSDictionary *info;

@end
