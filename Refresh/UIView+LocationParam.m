//
//  UIView+LocationParam.m
//  Refresh
//
//  Created by Merlin on 2017/5/3.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "UIView+LocationParam.h"

@implementation UIView (LocationParam)

//h
- (void)setH:(float)h
{
    CGRect frame = self.frame;
    frame.size.height = h ;
    self.frame = frame;
}
- (float)h
{
    return self.frame.size.height;
}

//w
- (void)setW:(float)w
{
    CGRect frame = self.frame;
    frame.size.width = w ;
    self.frame = frame;
}
- (float)w
{
    return self.frame.size.width;
}

//x
- (void)setX:(float)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (float)x
{
    return self.frame.origin.x;
}

//y
- (void)setY:(float)y
{
    CGRect frame = self.frame;
    frame.origin.y = y ;
    self.frame = frame;
}
- (float)y
{
    return self.frame.origin.y;
}

//centerx
- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)centerX
{
    return self.center.x;
}

//centery
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center ;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)centerY
{
    return self.center.y;
}
@end
