//
//  HeadTestView.m
//  Refresh
//
//  Created by Merlin on 2017/5/10.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "HeadTestView.h"
#import "UIView+LocationParam.h"

@interface HeadTestView()



@end
@implementation HeadTestView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        label.text = @"my life";
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
    }
    return self;
}

@end
