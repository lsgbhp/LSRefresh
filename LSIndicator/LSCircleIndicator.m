//
//  LSCircleIndicator.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/14.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "LSCircleIndicator.h"

static const CGFloat kLSIndicatorRadius = 12.f;

@interface LSCircleIndicator ()

@property (nonatomic, strong) CAShapeLayer *circleLayer;

@end

@implementation LSCircleIndicator

+ (instancetype)indicator {
    LSCircleIndicator *indicator = [[LSCircleIndicator alloc] initWithFrame:CGRectMake(0, 0, kLSIndicatorRadius*2, kLSIndicatorRadius*2)];
    return indicator;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    [circlePath addArcWithCenter:CGPointMake(kLSIndicatorRadius, kLSIndicatorRadius)
                          radius:kLSIndicatorRadius
                      startAngle:0*M_PI
                        endAngle:2*M_PI
                       clockwise:YES];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.frame = CGRectMake(0.f, 0.f, kLSIndicatorRadius*2, kLSIndicatorRadius*2);
    circleLayer.path = circlePath.CGPath;
    circleLayer.lineWidth = 1.f;
    circleLayer.lineCap = kCALineCapRound;
    circleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    self.circleLayer = circleLayer;
    [self.layer addSublayer:self.circleLayer];
}

- (void)layoutSubviews {
    
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circleLayer.position = CGPointMake(self.bounds.size.width*0.5, self.bounds.size.height*0.5);
    [CATransaction commit];

    [super layoutSubviews];
}

- (void)setProgress:(CGFloat)progress {
    _progress = progress;
    self.circleLayer.strokeEnd = progress;
}

- (void)startAnimation {
    
    CABasicAnimation *rotateAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotateAnimation.fromValue = @(0*M_PI);
    rotateAnimation.toValue = @(2*M_PI);
    rotateAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    rotateAnimation.autoreverses = NO;
    rotateAnimation.repeatCount = HUGE_VALF;
    rotateAnimation.duration = 1.f;
    [self.circleLayer addAnimation:rotateAnimation forKey:@"rotate"];
    
    CABasicAnimation *strokeEndAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEndAnimation.fromValue = @(0.f);
    strokeEndAnimation.toValue = @(1.f);
    strokeEndAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    strokeEndAnimation.autoreverses = YES;
    strokeEndAnimation.repeatCount = HUGE_VALF;
    strokeEndAnimation.duration = 2.f;
    [self.circleLayer addAnimation:strokeEndAnimation forKey:@"strokeEnd"];
}

- (void)stopAnimation {
    [self.circleLayer removeAllAnimations];
}

@end
