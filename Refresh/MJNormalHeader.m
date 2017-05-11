//
//  MJNormalHeader.m
//  Refresh
//
//  Created by Merlin on 2017/5/11.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "MJNormalHeader.h"

@interface MJNormalHeader()

{
    UILabel *_customLabel;
}

@end

@implementation MJNormalHeader


/**
 初始化
 */
- (void)prepare
{
    [super prepare];
//    self.arrowView.image = [UIImage imageNamed:@""];
//    self.stateLabel.hidden = YES;
//    self.lastUpdatedTimeLabel.hidden = YES;
    self.backgroundColor = [UIColor whiteColor];
}
/**
 布局
 */
- (void)placeSubviews
{
    [super placeSubviews];
    
}
/**
 下拉状态改变

 @param state 状态
 */
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
//    self.arrowView.hidden = YES;
    NSLog(@"---state change = %ld",(long)state);
}
/**
 父视图偏移量改变kvo

 @param chang 参数
 */
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)chang
{
    [super scrollViewContentOffsetDidChange:chang];
    NSValue *value = [chang objectForKey:@"new"];
    CGPoint point = [value CGPointValue];
    NSLog(@"---content offset %@-%f",chang,point.y);
}

/**
 父视图contentSize改变kvo

 @param change 参数
 */
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
{
    [super scrollViewContentSizeDidChange:change];
//    NSLog(@"---content size %@",change);
    
}
/**
 父视图拖动手势变化

 @param change change
 */
- (void)scrollViewPanStateDidChange:(NSDictionary *)change NS_REQUIRES_SUPER;
{
    [super scrollViewPanStateDidChange:change];
    NSLog(@"---pan state %@",change);
}


@end
