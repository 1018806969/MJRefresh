//
//  RefreshHeader.m
//  Refresh
//
//  Created by Merlin on 2017/5/2.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "RefreshHeader.h"
#import "UIView+LocationParam.h"

const CGFloat kRefreshHeaderHeight = 35.0f;
const CGFloat kRefreshHeaderRadius = 5.0f;

const CGFloat kRefreshHeight       = 55.0f;
const CGFloat kPointAnimateLen     = 5.0f;

#define topPointColor    [UIColor colorWithRed:90 / 255.0 green:200 / 255.0 blue:200 / 255.0 alpha:1.0].CGColor
#define leftPointColor   [UIColor colorWithRed:250 / 255.0 green:85 / 255.0 blue:78 / 255.0 alpha:1.0].CGColor
#define bottomPointColor [UIColor colorWithRed:92 / 255.0 green:201 / 255.0 blue:105 / 255.0 alpha:1.0].CGColor
#define rightPointColor  [UIColor colorWithRed:253 / 255.0 green:175 / 255.0 blue:75 / 255.0 alpha:1.0].CGColor


@interface RefreshHeader()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *TopPointLayer;
@property (nonatomic, strong) CAShapeLayer *BottomPointLayer;
@property (nonatomic, strong) CAShapeLayer *LeftPointLayer;
@property (nonatomic, strong) CAShapeLayer *rightPointLayer;

@property (nonatomic, assign) CGFloat       offsetY;
@property (nonatomic, assign) BOOL          isAnimating;


@end
@implementation RefreshHeader

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, 135, 135)];
    if (self) {
        [self initLayer];
    }
    return self;
}
#pragma mark -------1.初始化view
- (void)initLayer
{
    CGFloat centerLine = kRefreshHeaderHeight / 2 ;
    CGFloat radius     = kRefreshHeaderRadius;
    
    CGPoint topPoint = CGPointMake(centerLine, radius);
    self.TopPointLayer = [self layerWithCenter:topPoint color:topPointColor];
    self.TopPointLayer.hidden = NO;
    self.TopPointLayer.opacity = 0.f;
    [self.layer addSublayer:self.TopPointLayer];
    
    CGPoint leftPoint = CGPointMake(radius, centerLine);
    self.LeftPointLayer = [self layerWithCenter:leftPoint color:leftPointColor];
    [self.layer addSublayer:self.LeftPointLayer];
    
    CGPoint bottomPoint = CGPointMake(centerLine, kRefreshHeaderHeight - radius);
    self.BottomPointLayer = [self layerWithCenter:bottomPoint color:bottomPointColor];
    [self.layer addSublayer:self.BottomPointLayer];
    
    CGPoint rightPoint = CGPointMake(kRefreshHeaderHeight - radius, centerLine);
    self.rightPointLayer = [self layerWithCenter:rightPoint color:rightPointColor];
    [self.layer addSublayer:self.rightPointLayer];
    
    
    self.lineLayer = [CAShapeLayer layer];
    self.lineLayer.frame = self.bounds;
    self.lineLayer.lineWidth = kRefreshHeaderRadius * 2;
    self.lineLayer.lineCap = kCALineCapRound;
    self.lineLayer.lineJoin = kCALineJoinRound;
    self.lineLayer.fillColor = topPointColor;
    self.lineLayer.strokeColor = topPointColor;
    UIBezierPath * path = [UIBezierPath bezierPath];
    [path moveToPoint:topPoint];
    [path addLineToPoint:leftPoint];
    [path moveToPoint:leftPoint];
    [path addLineToPoint:bottomPoint];
    [path moveToPoint:bottomPoint];
    [path addLineToPoint:rightPoint];
    [path moveToPoint:rightPoint];
    [path addLineToPoint:topPoint];
    self.lineLayer.path = path.CGPath;
    self.lineLayer.strokeStart = 0.f;
    self.lineLayer.strokeEnd = 0.f;
    [self.layer insertSublayer:self.lineLayer above:self.TopPointLayer];
}
- (CAShapeLayer *)layerWithCenter:(CGPoint)center color:(CGColorRef)color
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(center.x - kRefreshHeaderRadius, center.y - kRefreshHeaderRadius, kRefreshHeaderRadius * 2, kRefreshHeaderRadius * 2);
    layer.fillColor = color ;
    layer.path = [self pointPath];
    layer.hidden = YES;
    return layer;
}
- (CGPathRef)pointPath
{
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(kRefreshHeaderRadius, kRefreshHeaderRadius) radius:kRefreshHeaderRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
}
#pragma mark ------2.重写方法，添加到父视图时调用，获取父视图，并kvo观察偏移量
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.center = self.scrollView.center;
        [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    }else
    {
        [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        self.offsetY = - self.scrollView.contentOffset.y;
    }
}
#pragma mark -------3.重写属性offsetY的方法，根据偏移量的不同处理不同的情况：（1）在下拉过程且没有加载动画时，处理简便渐变动画效果 （2）下拉超过一定距离kRefreshHeight且没有进行加载动画且手指没有拖动时，处理加载动画
- (void)setOffsetY:(CGFloat)offsetY
{
    _offsetY = offsetY;
    
    if (!self.isAnimating) {
        if (offsetY >= kRefreshHeight) {
            self.y = - (kRefreshHeight - (kRefreshHeight- kRefreshHeaderHeight)/2);
            NSLog(@"self.y=%f",self.y);
        }else
        {
            self.y = offsetY <= self.h ? - offsetY : -(self.h + (offsetY - self.h)/2);
        }
        [self gradualAnimateWithOffsetY:offsetY];
    }
//    NSLog(@"offsetY=%f,isAnimating=%d,dragging=%d",offsetY,self.isAnimating,self.scrollView.dragging);
    NSLog(@"%f-=---%d",offsetY,self.scrollView.dragging);
    if (offsetY >= kRefreshHeight && !self.isAnimating && !self.scrollView.dragging) {
        [self animate];
        if (self.handle) {
            self.handle();
        }
    }
}
//加载动画
- (void)animate
{
    self.isAnimating = YES;
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = kRefreshHeight;
        self.scrollView.contentInset = inset;
    }];
    
    [self addAnimateLayer:self.TopPointLayer toX:0 toY:kPointAnimateLen];
    [self addAnimateLayer:self.LeftPointLayer toX:kPointAnimateLen toY:0];
    [self addAnimateLayer:self.rightPointLayer toX:-kPointAnimateLen toY:0];
    [self addAnimateLayer:self.BottomPointLayer toX:0 toY:-kPointAnimateLen];
    
    [self addRotationAnimateLayer:self.layer];

}
- (void)addAnimateLayer:(CALayer *)layer toX:(CGFloat)x toY:(CGFloat)y
{
    CAKeyframeAnimation *frameAnimate = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    frameAnimate.duration = 1 ;
    frameAnimate.repeatCount = MAXFLOAT;
    frameAnimate.removedOnCompletion = NO;
    frameAnimate.fillMode = kCAFillModeForwards;
    frameAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    NSValue *fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(0, 0, 0.f)];
    NSValue *toValue = [NSValue valueWithCATransform3D:CATransform3DMakeTranslation(x, y, 0.f)];
    frameAnimate.values = @[fromValue,toValue,fromValue,toValue,fromValue];
    [layer addAnimation:frameAnimate forKey:@"translationKeyFrameAni"];
}
- (void)addRotationAnimateLayer:(CALayer *)layer
{
    CABasicAnimation *rotationAnimate = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimate.fromValue = @(0);
    rotationAnimate.toValue = @(M_PI * 2);
    rotationAnimate.duration = 1.0f;
    rotationAnimate.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotationAnimate.repeatCount = MAXFLOAT;
    rotationAnimate.fillMode = kCAFillModeForwards;
    rotationAnimate.removedOnCompletion = NO;
    [layer addAnimation:rotationAnimate forKey:@"rotationAnimation"];
}
//渐变动画
- (void)gradualAnimateWithOffsetY:(CGFloat)offsetY
{
    float startOffsetY = 0.f;
    float endOffsetY = 0.f;
    //up slip hidden
    if (offsetY < 0) {
        self.TopPointLayer.opacity = 0.f;
        [self pointLayerHiddenStateWithIndex:0];
    }else if (offsetY >= 0 && offsetY < (kRefreshHeight - 40))
    {
        self.TopPointLayer.opacity = offsetY / 20 ;
        [self pointLayerHiddenStateWithIndex:0];
    }else if (offsetY >= (kRefreshHeight - 40) && offsetY < kRefreshHeight)
    {
        self.TopPointLayer.opacity = 1.0f;
        //大阶段 0 ～ 3
        NSInteger stage = (offsetY - (kRefreshHeight - 40)) /10;
        //大阶段的前半段
        CGFloat subProgress = (offsetY - (kRefreshHeight - 40)) - (stage * 10);
        if (subProgress >= 0 && subProgress <= 5) {
            [self pointLayerHiddenStateWithIndex:stage * 2];
            startOffsetY = stage / 4.0;
            endOffsetY = stage / 4.0 + subProgress / 40.0 * 2;
        }
        //大阶段的后半段
        if (subProgress > 5 && subProgress < 10) {
            [self pointLayerHiddenStateWithIndex:stage * 2 + 1];
            startOffsetY = stage / 4.0 + (subProgress - 5) / 40.0 * 2;
            if (startOffsetY < (stage + 1) / 4.0 - 0.1) {
                startOffsetY = (stage + 1) / 4.0 - 0.1;
            }
            endOffsetY = (stage + 1) / 4.0;
        }

    }else
    {
        self.TopPointLayer.opacity = 1.0;
        [self pointLayerHiddenStateWithIndex:NSIntegerMax];
        startOffsetY = 1.0;
        endOffsetY = 1.0;
    }
    self.lineLayer.strokeStart = startOffsetY;
    self.lineLayer.strokeEnd = endOffsetY;
}
- (void)pointLayerHiddenStateWithIndex:(NSInteger)index
{
    self.LeftPointLayer.hidden = index > 1 ? NO : YES;
    self.BottomPointLayer.hidden = index > 3 ? NO : YES;
    self.rightPointLayer.hidden = index > 5 ? NO : YES;
    self.lineLayer.strokeColor = index > 5 ? rightPointColor : index > 3 ? bottomPointColor : index > 1 ? leftPointColor : topPointColor;
}

#pragma mark --------4.加载完成之后的回调方法
- (void)endRefresh
{
    [self removeAnimation];
}
- (void)removeAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = 0.0f;
        self.scrollView.contentInset = inset;
    } completion:^(BOOL finished) {
        [self.TopPointLayer removeAllAnimations];
        [self.LeftPointLayer removeAllAnimations];
        [self.BottomPointLayer removeAllAnimations];
        [self.rightPointLayer removeAllAnimations];
        [self.layer removeAllAnimations];
        [self pointLayerHiddenStateWithIndex:0];
        self.isAnimating = NO;
    }];
}
@end
