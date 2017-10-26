//
//  UITableView+HookTableViewDelegate.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/25.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "UITableView+HookTableViewDelegate.h"
#import <objc/runtime.h>
#import "HookUtility.h"
#define CUSTOM_CLASS_SEL(class,sel) NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])

@implementation UITableView (HookTableViewDelegate)

- (void)swizzle_tableViewDidSelectedAtIndexpath:(id<UITableViewDelegate>)delegate{
    class_addMethod([delegate class],
                    CUSTOM_CLASS_SEL([delegate class],
                                     @selector(tableView:didSelectRowAtIndexPath:)),
                    class_getMethodImplementation([self class], @selector(mkj_tableView:didSelectRowAtIndexPath:)),
                    "v@:@@");
    
    if ([HookUtility isContainSel:@selector(tableView:didSelectRowAtIndexPath:) inClass:[delegate class]]) {
        mkj_ExchangeMethod([delegate class], @selector(tableView:didSelectRowAtIndexPath:), CUSTOM_CLASS_SEL([delegate class], @selector(tableView:didSelectRowAtIndexPath:)));
    }
}


- (void)mkj_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"hook----%@---tableViewDidSelected----%@",[self class],indexPath);
    SEL sel = CUSTOM_CLASS_SEL([self class], @selector(tableView:didSelectRowAtIndexPath:));
    if ([HookUtility isContainSel:sel inClass:[self class]]) {
        IMP imp = [self methodForSelector:sel];
        ((void(*)(id,SEL,id,id))imp)(self,sel,tableView,indexPath);
    }
}



@end
