//
//  UIView+LocationParam.h
//  Refresh
//
//  Created by Merlin on 2017/5/3.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LocationParam)

/*
 设置或返回View的 x y h w
 */
@property (nonatomic, assign) float h;
@property (nonatomic, assign) float w;
@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
