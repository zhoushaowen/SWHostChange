//
//  AppDelegate.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "AppDelegate.h"
#import <SWHostChange.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SWHostChangeManager sharedInstance] setEnable:YES];
    SWHost *host1 = [[SWHost alloc] initWithName:@"开发地址" info:@{@"host":@"http://www.develop.com",@"imageUrl":@"http://www.develop.com"}];
    SWHost *host2 = [[SWHost alloc] initWithName:@"测试地址" info:@{@"host":@"http://www.test.com",@"imageUrl":@"http://www.test.com"}];
    SWHost *host3 = [[SWHost alloc] initWithName:@"正式地址" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    SWHost *host4 = [[SWHost alloc] initWithName:@"正式地址2" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    SWHost *host5 = [[SWHost alloc] initWithName:@"正式地址3" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    SWHost *host6 = [[SWHost alloc] initWithName:@"正式地址4" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    SWHost *host7 = [[SWHost alloc] initWithName:@"正式地址5" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    SWHost *host8 = [[SWHost alloc] initWithName:@"正式地址6" info:@{@"host":@"http://www.production.com",@"imageUrl":@"http://www.production.com"}];
    [[SWHostChangeManager sharedInstance] setHostGroup:@[host1,host2,host3,host4,host5,host6,host7,host8]];
    
    NSLog(@"name:%@-------host:%@",[SWHostChangeManager sharedInstance].currentHost.name,[SWHostChangeManager sharedInstance].currentHost.info[@"host"]);
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
