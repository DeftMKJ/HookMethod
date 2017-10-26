//
//  HookUtility.m
//  Hook
//
//  Created by mintou on 2017/10/23.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "HookUtility.h"


void mkj_ExchangeMethod(Class aClass, SEL oldSEL, SEL newSEL)
{
    Method oldMethod = class_getInstanceMethod(aClass, oldSEL);
    assert(oldMethod);
    Method newMethod = class_getInstanceMethod(aClass, newSEL);
    assert(newMethod);
    method_exchangeImplementations(oldMethod, newMethod);
}

void mkj_SendErrorWithException(NSException *exception,NSString *descriptions){
    // 打印堆栈信息
    NSLog(@"%@",exception);
    NSLog(@"%@",[exception callStackSymbols]);
}

@implementation HookUtility

+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class{
    unsigned int count;
    Method *methodLists = class_copyMethodList(class, &count);
    
    for (int i = 0; i < count; i++) {
        Method method = methodLists[i];
        NSString *selName = [NSString stringWithUTF8String:sel_getName(method_getName(method))];
        
        if ([NSStringFromSelector(sel) isEqualToString:selName]) {
            return YES;
        }
    }
    return NO;
}

@end
