//
//  NSArray+HookObjectAtIndex.h
//  MethodSwizzle
//
//  Created by mintou on 2017/10/24.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (HookObjectAtIndex)

+ (void)avoidCrash_Open;

- (id)mkj_ObjectAtIndex:(NSUInteger)index;

@end
