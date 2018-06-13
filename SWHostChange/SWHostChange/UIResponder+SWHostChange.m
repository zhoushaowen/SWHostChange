//
//  UIResponder+SWHostChange.m
//  SWHostChange
//
//  Created by zhoushaowen on 2018/6/12.
//  Copyright © 2018年 zhoushaowen. All rights reserved.
//

#import "UIResponder+SWHostChange.h"
#import <objc/runtime.h>
#import <SWCustomPresentation.h>
#import "SWHostChangeViewController.h"
#import "SWHostChangeManager.h"

@implementation UIResponder (SWHostChange)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], @selector(motionBegan:withEvent:));
    Method method2 = class_getInstanceMethod([self class], @selector(sw_motionBegan:withEvent:));
    method_exchangeImplementations(method1, method2);
}

- (void)sw_motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    [self sw_motionBegan:motion withEvent:event];
    if(![SWHostChangeManager sharedInstance].enable) return;
    [[[UIApplication sharedApplication].delegate window].rootViewController dismissViewControllerAnimated:NO completion:nil];
    [[[UIApplication sharedApplication].delegate window].rootViewController sw_presentCustomModalPresentationWithViewController:[SWHostChangeViewController new] containerViewWillLayoutSubViewsBlock:^(SWPresentationController * _Nonnull presentationController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        presentationController.presentedView.bounds = CGRectMake(0, 0, width-40, 300);
        presentationController.presentedView.center = CGPointMake(width/2.0f, height/2.0f);
        presentationController.presentedView.layer.cornerRadius = 5.0f;
        presentationController.presentedView.clipsToBounds = YES;
    } animatedTransitioningModel:[SWAnimtedTransitioningModel new] completion:nil];
    if (@available(iOS 10.0, *)) {
        UIImpactFeedbackGenerator *feedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleMedium];
        [feedback prepare];
        [feedback impactOccurred];
    }
}

@end
