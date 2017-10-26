//
//  FirstViewController.m
//  Hook
//
//  Created by mintou on 2017/10/23.
//  Copyright © 2017年 mintou. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
#import "FourthViewController.h"
#import "FiveViewController.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *items;

@end

static NSString  * const reuseID = @"CELLID";

@implementation FirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.rowHeight = 45;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:reuseID];
}

- (NSMutableArray *)items{
    if (!_items) {
        _items = [[NSMutableArray alloc] initWithArray:@[@"防止数组越界Crash",@"页面路径",@"用户点击事件监控",@"ScrollView监听",@"22222"]];
    }
    return _items;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID forIndexPath:indexPath];
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
            // 数组防越界
        case 0:{
            SecondViewController *sencondVC = [[SecondViewController alloc] init];
            [self.navigationController pushViewController:sencondVC animated:YES];
        }
            break;
            // 页面hook监听
        case 1:{
//            MethodSwizzle[12267:654142] hook Viewcontroller viewdidAppear---- class:ThirdViewController
//            MethodSwizzle[12267:654142] hook Viewcontroller viewdidAppear---- class:FirstViewController
            ThirdViewController *sencondVC = [[ThirdViewController alloc] init];
            [self.navigationController pushViewController:sencondVC animated:YES];
        }
            break;
            // 用户事件收集
        case 2:{
            FourthViewController *sencondVC = [[FourthViewController alloc] init];
            [self.navigationController pushViewController:sencondVC animated:YES];
        }
            break;
            // ScrollView监听
        case 3:{
            FiveViewController *sencondVC = [[FiveViewController alloc] init];
            [self.navigationController pushViewController:sencondVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
