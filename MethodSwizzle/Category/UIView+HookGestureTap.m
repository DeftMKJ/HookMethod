//
//  UIView+HookGestureTap.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "UIView+HookGestureTap.h"
#import "HookUtility.h"

@implementation UIView (HookGestureTap)

+ (void)mkjHook_GestureOpen{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkj_ExchangeMethod([self class], @selector(pointInside:withEvent:), @selector(mkj_pointInside:withEvent:));
    });
}

- (BOOL)mkj_pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    NSLog(@"手势点击事件拦截，但是连tableView的cell点击都拦截了");
    return [self mkj_pointInside:point withEvent:event];
}

@end
