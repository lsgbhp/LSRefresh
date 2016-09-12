//
//  LSRefreshComponent.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 fongtinyik. All rights reserved.
//

#import "LSRefreshComponent.h"

@interface LSRefreshComponent ()

@end

@implementation LSRefreshComponent

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configuration];
        [self setupSubviews];
    }
    return self;
}

- (void)configuration {
    self.state = LSRefreshStateIdel;
}

- (void)layoutSubviews {
    [self setupSubviews];
    [super layoutSubviews];
}

- (void)setupSubviews {
    
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    [self removeObserver];
    
    if (newSuperview) {
        self.frame = CGRectMake(0.f, -kLSRefreshHeaderHeight,
                                newSuperview.bounds.size.width, kLSRefreshHeaderHeight);
        
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
        
        [self addObserver];
    }
}

- (void)addObserver {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.scrollView addObserver:self forKeyPath:kLSRefreshKeyContentOffset options:options context:nil];
}

- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:kLSRefreshKeyContentOffset];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    if (self.scrollView.ls_offsetY <= 0) {
        self.ls_top = self.scrollView.ls_offsetY;
        self.ls_height = fabs(self.scrollView.ls_offsetY);
    }
    if (self.scrollView.ls_offsetY <= -kLSRefreshTriggerHeight) {
        self.backgroundColor = [UIColor greenColor];
    } else {
        self.backgroundColor = [UIColor yellowColor];
    }
}

- (void)setState:(LSRefreshState)state {
    _state = state;
}

#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kLSRefreshKeyContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

@end
