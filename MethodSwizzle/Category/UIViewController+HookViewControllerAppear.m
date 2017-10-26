//
//  UIViewController+HookViewControllerAppear.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "UIViewController+HookViewControllerAppear.h"
#import "HookUtility.h"

@implementation UIViewController (HookViewControllerAppear)

+ (void)hook_ViewcontrollerOpen{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkj_ExchangeMethod([self class], @selector(viewDidAppear:),@selector(mkj_viewDidAppear));
    });
}


- (void)mkj_viewDidAppear{
    NSLog(@"hook Viewcontroller viewdidAppear---- class:%@",NSStringFromClass([self class]));
    [self mkj_viewDidAppear];
}

@end
