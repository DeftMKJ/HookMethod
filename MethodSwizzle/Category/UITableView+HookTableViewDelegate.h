//
//  UITableView+HookTableViewDelegate.h
//  MethodSwizzle
//
//  Created by mintou on 2017/10/25.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (HookTableViewDelegate)

- (void)swizzle_tableViewDidSelectedAtIndexpath:(id)delegate;

@end
