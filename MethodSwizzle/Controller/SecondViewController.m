//
//  SecondViewController.m
//  Hook
//
//  Created by mintou on 2017/10/23.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 200, 30);
    [button setTitle:@"数组越界防止崩溃" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0f;
    button.layer.borderColor = [UIColor redColor].CGColor;
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)click{
    NSArray *array = @[@"111",@"222",@"333"];
    // 必定越界
    [array objectAtIndex:9];
    
//    id obj = @"111";
//    [obj objectAtIndex:1];
    
//    NSMutableArray *arr = [[NSMutableArray alloc] initWithArray:@[@"1",@"2"]];
//    arr[10];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"enter------>%@",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
