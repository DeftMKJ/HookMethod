//
//  UIViewController+HookViewControllerAppear.h
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HookViewControllerAppear)

+ (void)hook_ViewcontrollerOpen;

@end
