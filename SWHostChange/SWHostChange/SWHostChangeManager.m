//
//  SWHostChangeManager.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "SWHostChangeManager.h"
#import "SWHost.h"
//#import <SAMKeychain.h>
#import "SWHostChangeViewController.h"

NSString *const SWHostDidChangeNotification = @"SWHostDidChangeNotification";

static SWHostChangeManager *SharedManager = nil;

@implementation SWHostChangeManager
{
    NSString *_bundleId;
    __weak id _observer;
}

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

- (instancetype)init
{
    self = [super init];
    if (self) {
        _bundleId = [[NSBundle mainBundle].infoDictionary objectForKey:@"CFBundleIdentifier"];
        __weak typeof(self) weakSelf = self;
        _observer = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(strongSelf.currentHost == nil && self.enable){
                [SWHostChangeViewController showWithDismissGestureEnable:NO];
            }
        }];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_observer];
}

- (SWHost *)currentHost {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __block BOOL flag = NO;
//        NSData *data = [SAMKeychain passwordDataForService:self->_bundleId account:@"SWHOST"];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:self->_bundleId];
        if(data){
            self->_currentHost = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
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
                NSLog(@"本地的host和设置的Host不匹配,将删除之前旧的Host");
//                [SAMKeychain deletePasswordForService:self->_bundleId account:@"SWHOST"];
//                self->_currentHost = [self.hostGroup firstObject];
                self->_currentHost = nil;
            }
        }
    });
//    if(_currentHost == nil){
//        _currentHost = [_hostGroup firstObject];
//    }
    return self.enable?_currentHost:nil;
}

- (void)setCurrentHost:(SWHost *)currentHost {
    _currentHost = currentHost;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_currentHost];
//    [SAMKeychain setPasswordData:data forService:_bundleId account:@"SWHOST"];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:_bundleId];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:SWHostDidChangeNotification object:self userInfo:currentHost?@{@"currentHost":currentHost}:nil];
    abort();
}

- (NSArray<SWHost *> *)hostGroup {
    if(_enable){
        NSAssert(_hostGroup.count > 0, @"hostGroup为空,请先配置hostGroup!");
    }
    return _hostGroup;
}





















@end
















