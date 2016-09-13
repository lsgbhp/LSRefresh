//
//  LSRefreshHeader.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 fongtinyik. All rights reserved.
//

#import "LSRefreshHeader.h"

static const CGFloat kLSIndicatorRadius = 12.f;

@interface LSRefreshHeader ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation LSRefreshHeader

+ (instancetype)headerWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshHeader *header = [[LSRefreshHeader alloc] init];
    header.actionBlock = actionBlock;
    return header;
}

- (void)configuration {
    [super configuration];
}

- (void)setupSubviews {
    [super setupSubviews];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(kLSIndicatorRadius, kLSIndicatorRadius)
                          radius:kLSIndicatorRadius
                      startAngle:0*M_PI
                        endAngle:2*M_PI
                       clockwise:YES];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0.f, 0.f, kLSIndicatorRadius*2, kLSIndicatorRadius*2);
    circleLayer.path = circlePath.CGPath;
    circleLayer.lineWidth = 1;
    circleLayer.lineCap = kCALineCapRound;
    circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer = circleLayer;
    [self.layer addSublayer:self.circleLayer];
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0*M_PI);
    rotateAnimation.toValue = @(2*M_PI);
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.autoreverses = NO;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.duration = 2.f;
    [circleLayer addAnimation:rotateAnimation forKey:@"rotate"];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.f);
    strokeEndAnimation.toValue = @(1.f);
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    strokeEndAnimation.autoreverses = NO;
    strokeEndAnimation.repeatCount = HUGE_VALF;
    strokeEndAnimation.duration = 3.f;
    [circleLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
}

- (void)placeSubviews {
    [super placeSubviews];
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circleLayer.position = CGPointMake(self.ls_width*0.5, self.ls_height*0.5);
    [CATransaction commit];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    NSLog(@"%@", NSStringFromCGPoint(self.scrollView.contentOffset));
    if (self.scrollView.ls_offsetY <= -100) {
        [self.circleLayer removeAllAnimations];
    }
}

@end
