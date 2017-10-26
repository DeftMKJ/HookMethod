//
//  NSArray+HookObjectAtIndex.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "NSArray+HookObjectAtIndex.h"
#import "HookUtility.h"

@implementation NSArray (HookObjectAtIndex)

// 函数在你动态加载或者静态引用了这个类的时候，该函数就会被执行，它并不需要你显示的去创建一个类后才会执行，同时它只会执行一次
// 也可以写在里面，但是我感觉会找不到
//+ (void)load{
//
//}


+ (void)avoidCrash_Open{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class __NSPlaceholderArray = NSClassFromString(@"__NSPlaceholderArray");
        Class __NSArrayI = NSClassFromString(@"__NSArrayI");
        Class __NSSingleObjectArrayI = NSClassFromString(@"__NSSingleObjectArrayI");
        Class __NSArray0 = NSClassFromString(@"__NSArray0");
        
        // 初始化方法
        mkj_ExchangeMethod(__NSPlaceholderArray,
                           @selector(initWithObjects:count:),
                           @selector(avoidCrash_initWithObjects:count:));
        // 多个元素
        mkj_ExchangeMethod(__NSArrayI,
                           @selector(objectAtIndex:),
                           @selector(avoidCrash_arrayI_objectAtIndex:));
        
        // 单个元素
        mkj_ExchangeMethod(__NSSingleObjectArrayI,
                           @selector(objectAtIndex:),
                           @selector(avoidCrash_singleObjectArray_objectAtIndex:));
        // 空元素
        mkj_ExchangeMethod(__NSArray0,
                           @selector(objectAtIndex:),
                           @selector(avoidCrash_array0_objectAtIndex:));
        
        
    });
}
//
//- (void)textLog{
//    // 空的
//    NSArray *arr = [[NSArray alloc] init];
//    //    arr[0];
//    // 还没初始化的
//    id arr1 = [NSArray alloc];
//    // 单个元素
//    NSArray *arr3 = [[NSArray alloc] initWithArray:@[@"1"]];
//    // 多个元素
//    NSArray *arr4 = [[NSArray alloc] initWithArray:@[@"1",@"2"]];
//    NSLog(@"还没init----%@",[arr1 class]);
//    NSLog(@"空数组------%@",[arr class]);
//    NSLog(@"单个元素------%@",[arr3 class]);
//    NSLog(@"多个元素-------%@",[arr4 class]);
//    /*
//    2017-10-23 17:55:00.190937+0800 Hook[14153:915303] 手势触发
//    2017-10-23 17:55:00.191134+0800 Hook[14153:915303] 还没init----__NSPlaceholderArray
//    2017-10-23 17:55:00.191241+0800 Hook[14153:915303] 空数组------__NSArray0
//    2017-10-23 17:55:00.191338+0800 Hook[14153:915303] 单个元素------__NSSingleObjectArrayI
//    2017-10-23 17:55:00.191479+0800 Hook[14153:915303] 多个元素-------__NSArrayI
//     */
//}

// 这里的四个方法都是替换掉之前系统的访问方法，因此如果你加上log，会不断的打印
- (instancetype)avoidCrash_initWithObjects:(const id  _Nonnull __unsafe_unretained *)objects count:(NSUInteger)count {
    //    NSLog(@"__NSPlaceholderArray-----------------------------");
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrash_initWithObjects:objects count:count];
    } @catch (NSException *exception) {
        mkj_SendErrorWithException(exception, @"数组初始化异常");
    } @finally {
        return returnArray;
    }
    
}

- (instancetype)avoidCrash_arrayI_objectAtIndex:(NSInteger)index {
    //    NSLog(@"__NSArrayI-----------------------------");
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrash_arrayI_objectAtIndex:index];
    } @catch (NSException *exception) {
        mkj_SendErrorWithException(exception, @"数组越界");
    } @finally {
        return returnArray;
    }
    
}

- (instancetype)avoidCrash_singleObjectArray_objectAtIndex:(NSInteger)index {
    //    NSLog(@"__NSSingleObjectArrayI-----------------------------");
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrash_singleObjectArray_objectAtIndex:index];
    } @catch (NSException *exception) {
        mkj_SendErrorWithException(exception, @"单个数组越界");
    } @finally {
        return returnArray;
    }
    
}

- (instancetype)avoidCrash_array0_objectAtIndex:(NSInteger)index {
    //    NSLog(@"__NSArray0-----------------------------");
    NSArray *returnArray = nil;
    @try {
        returnArray = [self avoidCrash_array0_objectAtIndex:index];
    } @catch (NSException *exception) {
        mkj_SendErrorWithException(exception, @"空数组越界");
    } @finally {
        return returnArray;
    }
    
}

// 这种写法其实更使用一点，容易理解
- (id)mkj_ObjectAtIndex:(NSUInteger)index{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    NSLog(@"thread:%@",[NSThread callStackSymbols]);
    return nil;
}




@end

