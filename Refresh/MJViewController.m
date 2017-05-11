//
//  MJViewController.m
//  Refresh
//
//  Created by Merlin on 2017/5/11.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "MJViewController.h"
//#import "MJNormalHeader.h"
#import "MJGifHeader.h"
//#import "MJBackNormalFooter.h"
#import "MJAutoNormalFooter.h"

@interface MJViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation MJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"mjrefresh";
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, self.view.bounds.size.height-150) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self ;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 80;
    _tableView.backgroundColor = [UIColor grayColor];
    
    [self.view addSubview:_tableView];
    
    
    _tableView.mj_header = [MJGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    _tableView.mj_footer = [MJAutoNormalFooter footerWithRefreshingBlock:^{
        [self performSelector:@selector(stopFooter) withObject:nil afterDelay:3];
    }];
}

- (void)refresh
{
    [self performSelector:@selector(stopRefresh) withObject:nil afterDelay:3];
}

- (void)stopFooter
{
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}
- (void)stopRefresh
{
    _tableView.mj_footer.state = MJRefreshStateIdle;
    [_tableView.mj_header endRefreshing];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (indexPath.row == 0) {
        cell.backgroundColor = [UIColor orangeColor];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MJViewController *mjVc = [[MJViewController alloc]init];
//    [self.navigationController pushViewController:mjVc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
