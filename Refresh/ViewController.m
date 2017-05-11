//
//  ViewController.m
//  Refresh
//
//  Created by Merlin on 2017/5/2.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "ViewController.h"
#import "UIScrollView+RefreshHeader.h"
#import "MainViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"refresh";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView.delegate = self;
    _tableView.dataSource = self ;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    _tableView.rowHeight = 80;
    _tableView.backgroundColor = [UIColor grayColor];
    
    
    [_tableView addRefreshHeaderWithHandle:^{
        [self performSelector:@selector(refreshScc) withObject:nil afterDelay:3];
    }];
    CGFloat table_x = _tableView.center.x;
    CGPoint point = _tableView.header.center;
    point.x = table_x;
    _tableView.header.center = point;
    
}
- (void)refreshScc
{
    [_tableView.header endRefresh];
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
    MainViewController *mainVc = [[MainViewController alloc]init];
    [self.navigationController pushViewController:mainVc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
