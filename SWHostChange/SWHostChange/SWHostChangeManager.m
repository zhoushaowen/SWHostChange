//
//  SWHostChangeManager.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWHostChangeManager.h"
#import "SWHost.h"

static SWHostChangeManager *SharedManager = nil;

@implementation SWHostChangeManager

@synthesize currentHost = _currentHost;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!SharedManager){
            SharedManager = [[self alloc] init];
        }
    });
    return SharedManager;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(!SharedManager){
            SharedManager = [super allocWithZone:zone];
        }
    });
    return SharedManager;
}

- (SWHost *)currentHost {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __block BOOL flag = NO;
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"SWHOST"];
        self->_currentHost = [NSKeyedUnarchiver unarchiveObjectWithData:data?:NSData.new];
        if(self->_currentHost){
            [self.hostGroup enumerateObjectsUsingBlock:^(SWHost * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if([self->_currentHost isEqual:obj]){
                    flag = YES;
                    *stop = YES;
                }
            }];
            if(flag){
                NSLog(@"本地的host和设置的Host相匹配");
            }else{
                NSLog(@"本地的host和设置的Host不匹配,将选择默认第一个Host");
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SWHOST"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                self->_currentHost = [self.hostGroup firstObject];
            }
        }
    });
    if(_currentHost == nil){
        _currentHost = [_hostGroup firstObject];
    }
    return _currentHost;
}

- (void)setCurrentHost:(SWHost *)currentHost {
    _currentHost = currentHost;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_currentHost];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"SWHOST"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    abort();
}

- (NSArray<SWHost *> *)hostGroup {
    if(_enable){
        NSAssert(_hostGroup.count > 0, @"hostGroup为空,请先配置hostGroup!");
    }
    return _hostGroup;
}





















@end
















