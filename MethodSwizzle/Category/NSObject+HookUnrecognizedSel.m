//
//  NSObject+HookUnrecognizedSel.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "NSObject+HookUnrecognizedSel.h"


@implementation NSObject (HookUnrecognizedSel)
// A Selector for a method that the receiver does not implement.
// 当category重写类已有的方法时会出现此警告。
// Category is implementing a method which will also be implemented by its primary class
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-protocol-method-implementation"
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"unrecognized selector : classe:%@ sel:%@",NSStringFromClass([self class]),NSStringFromSelector(aSelector));
    
    // 元类 meta class 创建 重新指定Selector 防止崩溃  http://ios.jobbole.com/81657/
//    1、为”class pair”分配内存 (使用objc_allocateClassPair).
//    2、添加方法或成员变量到有需要的类里 (我已经使用class_addMethod添加了一个方法).
//    3、创建出来
    
    // 用objc_allocateClassPair创建一个自定义名字的元类
    Class class = objc_allocateClassPair(NSClassFromString(@"NSObject"), "UnrecognizedSel", 0);

    // 类添加方法 Sel 和 Imp
    class_addMethod(class, aSelector, class_getMethodImplementation([self class], @selector(customMethod)), "v@:");
//    class_addIvar(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>, <#size_t size#>, <#uint8_t alignment#>, <#const char * _Nullable types#>)
//    objc_registerClassPair(class)
    // 创建
    id tempObject = [[class alloc] init];
    return tempObject;
}
#pragma clang diagnostic pop


- (void)customMethod{
    NSLog(@"呵呵");
}
@end
