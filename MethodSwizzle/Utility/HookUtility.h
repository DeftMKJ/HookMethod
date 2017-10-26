//
//  HookUtility.h
//  Hook
//
//  Created by mintou on 2017/10/23.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


FOUNDATION_EXPORT void mkj_ExchangeMethod(Class aClass,SEL oldSel,SEL newSel);
FOUNDATION_EXPORT void mkj_SendErrorWithException(NSException *exception,NSString *descriptions);
@interface HookUtility : NSObject

// 检测class里面是否有对应的sel方法
+ (BOOL)isContainSel:(SEL)sel inClass:(Class)class;

@end
