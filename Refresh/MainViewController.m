//
//  MainViewController.m
//  Refresh
//
//  Created by Merlin on 2017/5/10.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "MainViewController.h"
#import "HeadTestView.h"
#import "MJViewController.h"

@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self ;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 80;
    _tableView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_tableView];
    
    
    HeadTestView *headView = [[HeadTestView alloc]initWithFrame:CGRectMake(0, -100, 100, 100)];
    headView.backgroundColor = [UIColor orangeColor];
    [_tableView insertSubview:headView atIndex:0];

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor orangeColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MJViewController *mjVc = [[MJViewController alloc]init];
    [self.navigationController pushViewController:mjVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
