//
//  LSRefreshComponent.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 ShawnLin. All rights reserved.
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

- (void)dealloc {
    [self removeObserver];
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
    [self.scrollView addObserver:self forKeyPath:kLSRefreshKeyContentSize options:options context:nil];
}

- (void)removeObserver {
    [self.superview removeObserver:self forKeyPath:kLSRefreshKeyContentOffset];
    [self.superview removeObserver:self forKeyPath:kLSRefreshKeyContentSize];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {}
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {}

- (void)setState:(LSRefreshState)state {
    if (state == self.state) return;
    _state = state;
    if (_state == LSRefreshStateRefreshing) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.actionBlock ? self.actionBlock() : nil;
        });
    }
}

- (void)beginRefreshing {
    if (self.state != LSRefreshStateRefreshing) {
        self.state = LSRefreshStateRefreshing;
    }
}

- (void)endRefreshing {
    self.state = LSRefreshStateFinish;
}

#pragma mark - KVO Methods

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:kLSRefreshKeyContentOffset]) {
        [self scrollViewContentOffsetDidChange:change];
    }
    if ([keyPath isEqualToString:kLSRefreshKeyContentSize]) {
        [self scrollViewContentSizeDidChange:change];
    }
}

@end
