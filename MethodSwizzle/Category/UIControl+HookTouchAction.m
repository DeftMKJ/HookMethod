//
//  UIControl+HookTouchAction.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "UIControl+HookTouchAction.h"
#import "HookUtility.h"

@implementation UIControl (HookTouchAction)

+(void)mkjhood_touchActionOpen{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkj_ExchangeMethod([self class], @selector(sendAction:to:forEvent:), @selector(mkj_SendAction:to:forEvent:));
    });
}

- (void)mkj_SendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event{
    NSLog(@"control--%@,action---%@,target---%@,Point---%@",
          NSStringFromClass([self class]),
          NSStringFromSelector(action),
          NSStringFromClass([target class]),
          NSStringFromCGRect(self.frame));
    [self mkj_SendAction:action to:target forEvent:event];
}

// send the action. the first method is called for the event and is a point at which you can observe or override behavior. it is called repeately by the second.
//- (void)sendAction:(SEL)action to:(nullable id)target forEvent:(nullable UIEvent *)event;

@end
