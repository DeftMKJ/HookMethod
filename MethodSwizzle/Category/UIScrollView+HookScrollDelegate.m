//
//  UIScrollView+HookScrollDelegate.m
//  MethodSwizzle
//
//  Created by mintou on 2017/10/25.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "UIScrollView+HookScrollDelegate.h"
#import "HookUtility.h"
#import "UITableView+HookTableViewDelegate.h"

#define CUSTOM_CLASS_SEL(class,sel) NSSelectorFromString([NSString stringWithFormat:@"%@_%@",NSStringFromClass(class),NSStringFromSelector(sel)])

@implementation UIScrollView (HookScrollDelegate)
+ (void)mkjHook_ScrollViewDelegateOpen{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkj_ExchangeMethod([self class],
                           @selector(setDelegate:),
                           @selector(mkj_setDelegate:));
    });
}
// hook delegate方法
- (void)mkj_setDelegate:(id<UIScrollViewDelegate>)delegate{
    
    // 判断delegate例如控制器类是否有添加代理方法
    if (![HookUtility isContainSel:CUSTOM_CLASS_SEL([delegate class],@selector(scrollViewWillBeginDragging:)) inClass:[delegate class]]) {
        
        // 未添加 手动添加
        class_addMethod([delegate class],
                        CUSTOM_CLASS_SEL([delegate class], @selector(scrollViewWillBeginDragging:)),
                        method_getImplementation(class_getInstanceMethod([self class], @selector(mkj_scrollViewWillBeginDragging:))),
                        "v@:@");
        
        // 判断是否有实现原生的方法
        if ([HookUtility isContainSel:@selector(scrollViewWillBeginDragging:) inClass:[delegate class]]) {
            // 实现才交换
            mkj_ExchangeMethod([delegate class], @selector(scrollViewWillBeginDragging:), CUSTOM_CLASS_SEL([delegate class], @selector(scrollViewWillBeginDragging:)));
        }
    }
    
    // 判断是否是TableView  给tableView添加
    if ([NSStringFromClass([self class]) isEqualToString:@"UITableView"]) {
        if ([HookUtility isContainSel:CUSTOM_CLASS_SEL([delegate class], @selector(tableView:didSelectRowAtIndexPath:)) inClass:[delegate class]]) {
            [(UITableView *)self swizzle_tableViewDidSelectedAtIndexpath:delegate];
        }
    }
    
    
    [self mkj_setDelegate:delegate];
}


- (void)mkj_scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    NSLog(@"scrollView--->%@--WillBeginDragging--->hook",[self class]);
    SEL sel = CUSTOM_CLASS_SEL([self class], @selector(scrollViewWillBeginDragging:));
    // 判断控制器是否有实现  imp函数指针，返回值根据具体的方法而定，这里没有就返回void，参数前两个是固定的id和sel，后面参数根据实际为准
    if ([HookUtility isContainSel:sel inClass:[self class]]) {
        IMP imp = [self methodForSelector:sel];
        ((void(*)(id,SEL,id))imp)(self,sel,scrollView);
    }
    
}




/*
 这种hook针对Delegate无法进行 网上找了另一个方法
+ (void)mkjHook_ScrollViewDelegateOpen{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mkj_ExchangeMethod([self class], @selector(scrollViewWillBeginDragging:), @selector(mkj_scrollViewWillBeginDragging:));
    });
}

- (void)mkj_scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"测试");
}
*/

@end
