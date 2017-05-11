//
//  MJAutoNormalFooter.m
//  Refresh
//
//  Created by Merlin on 2017/5/11.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "MJAutoNormalFooter.h"

@implementation MJAutoNormalFooter


- (void)placeSubviews
{
    [super placeSubviews];
    if (self.state == MJRefreshStateNoMoreData) {
        self.backgroundColor = [UIColor redColor];
        self.mj_h = 100;
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetB += 56;
        }];
        CGPoint point = self.scrollView.contentOffset;
        point.y += 46;
        self.scrollView.contentOffset = point;
    }else
    {
        self.backgroundColor = [UIColor clearColor];
        self.mj_h = 44;
        [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
            self.scrollView.mj_insetB = 44;
        }];
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    CGPoint point = [[change objectForKey:@"new"] CGPointValue];
    NSLog(@"偏移量====%f",point.y);
}
@end
