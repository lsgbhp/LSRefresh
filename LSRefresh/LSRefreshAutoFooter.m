//
//  LSRefreshAutoFooter.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/10/8.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "LSRefreshAutoFooter.h"

static const CGFloat kLSRefreshAutoFooterTriggerDistance = 100.f;

@interface LSRefreshAutoFooter ()

@end

@implementation LSRefreshAutoFooter

+ (instancetype)autoFooterWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshAutoFooter *footer = [LSRefreshAutoFooter new];
    footer.actionBlock = actionBlock;
    return footer;
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 隐藏控件
    if (self.hidden) return;
    
    // 只有scrollView滑动时才响应事件，若是autolayout导致contentOffset变化，不响应。
    if (!(self.scrollView.isDragging || self.scrollView.isDecelerating)) return;
    
    // 当前不是初始状态不响应事件
    if (self.state != LSRefreshStateIdel) return;
    
    // 避免下拉刷新触发上拉刷新
    if (self.scrollView.ls_offsetY <= 0) return;
    
    if ((self.scrollView.ls_offsetY+self.scrollView.ls_height) > (self.ls_bottom-kLSRefreshAutoFooterTriggerDistance)) {
        [self beginRefreshing];
    }
}

- (void)endRefreshing {}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
    
    if (self.scrollView.ls_contentH > self.scrollView.ls_height) {
        self.ls_top = self.scrollView.ls_contentH;
    } else {
        self.ls_top = self.scrollView.ls_height;
    }
    self.state = LSRefreshStateIdel;
}

- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    if (!hidden) {
        self.ls_top = self.scrollView.ls_contentH;
    }
}

@end
