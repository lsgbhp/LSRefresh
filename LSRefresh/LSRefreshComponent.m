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
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.clipsToBounds = YES;
}

- (void)layoutSubviews {
    [self locateSubviews];
    [super layoutSubviews];
}

- (void)setupSubviews {}
- (void)locateSubviews {}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (newSuperview && ![newSuperview isKindOfClass:[UIScrollView class]]) return;
    
    [self removeObserver];
    
    if (newSuperview) {
        self.scrollView = (UIScrollView *)newSuperview;
        self.scrollView.alwaysBounceVertical = YES;
                            
        self.ls_width = newSuperview.ls_width;
        self.ls_left = 0.f;
        
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
    
    NSLog(@"inset: %@", NSStringFromUIEdgeInsets(self.scrollView.contentInset));
    NSLog(@"offset: %@", NSStringFromCGPoint(self.scrollView.contentOffset));
    NSLog(@"height: %@", @(self.ls_height));
    
    if (self.scrollView.ls_offsetY <= -self.scrollView.ls_insetTop) {
        self.ls_top = self.scrollView.ls_offsetY + self.scrollView.ls_insetTop;
        self.ls_height = fabs(self.scrollView.ls_insetTop + self.scrollView.ls_offsetY);
    }
    
    if (self.state != LSRefreshStateRefreshing){
        if (self.ls_height < kLSRefreshIdleToPullingHeight) {
            self.state = LSRefreshStateIdel;
        } else if (self.ls_height < kLSRefreshPullingToWillRefreshHeight) {
            self.state = LSRefreshStatePulling;
        } else if (self.ls_height >= kLSRefreshPullingToWillRefreshHeight) {
            self.state = LSRefreshStateWillRefresh;
            if (!self.scrollView.isDragging) {
                [self beginRefreshing];
            }
        }
    }
}

- (void)setState:(LSRefreshState)state {
    
    if (state == _state) return;
    _state = state;
    
    if (state == LSRefreshStateRefreshing) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -(self.scrollView.ls_insetTop + kLSRefreshHeaderHeight)) animated:YES];
        self.scrollView.scrollEnabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self endRefreshing];
        });
    
    } else if (state == LSRefreshStateIdel) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -self.scrollView.ls_insetTop) animated:YES];
        self.scrollView.scrollEnabled = YES;
    }
}

- (void)beginRefreshing {
    if (self.state != LSRefreshStateRefreshing) {
        self.state = LSRefreshStateRefreshing;
    }
}

- (void)endRefreshing {
    self.state = LSRefreshStateIdel;
}

#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kLSRefreshKeyContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
}

@end
