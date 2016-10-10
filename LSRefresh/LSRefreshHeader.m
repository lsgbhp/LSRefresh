//
//  LSRefreshHeader.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "LSRefreshHeader.h"
#import "LSCircleIndicator.h"

static const CGFloat kLSRefreshHeaderHeight = 60.f;
static const CGFloat kLSRefreshHeaderIdleToPullingHeight = 30.f;
static const CGFloat kLSRefreshHeaderPullingToWillRefreshHeight = 100.f;

@interface LSRefreshHeader ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) LSCircleIndicator *indicator;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation LSRefreshHeader

+ (instancetype)headerWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshHeader *header = [LSRefreshHeader new];
    header.actionBlock = actionBlock;
    return header;
}

- (void)setupSubviews {
    [super setupSubviews];
    
    self.contentView = [UIView new];
    
    self.indicator = [LSCircleIndicator indicator];
    [self.contentView addSubview:self.indicator];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.text = @"下拉刷新";
    self.infoLabel.textColor = [UIColor lightGrayColor];
    self.infoLabel.font = [UIFont systemFontOfSize:14.f];
    [self.infoLabel sizeToFit];
    [self.contentView addSubview:self.infoLabel];
    
    [self addSubview:self.contentView];
}

- (void)locateSubviews {
    [super locateSubviews];
    
    [self.infoLabel sizeToFit];
    self.infoLabel.ls_left = self.indicator.ls_right + 15.f;
    self.infoLabel.ls_centerY = self.indicator.ls_centerY;
    
    self.contentView.ls_height = (self.infoLabel.ls_height > self.indicator.ls_height) ? self.infoLabel.ls_height : self.indicator.ls_height;
    self.contentView.ls_width = self.infoLabel.ls_right;
    self.contentView.center = CGPointMake(self.ls_width*0.5, self.ls_height*0.5);
}

- (void)setState:(LSRefreshState)state {
    
    if (state == self.state) return;
    
    if (state == LSRefreshStateRefreshing) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -(self.scrollView.ls_insetTop + kLSRefreshHeaderHeight)) animated:YES];
        self.scrollView.scrollEnabled = NO;
        
    } else if (state == LSRefreshStateFinish) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -self.scrollView.ls_insetTop) animated:YES];
        self.scrollView.scrollEnabled = YES;
    }
    
    if (state == LSRefreshStateIdel) {
        self.infoLabel.text = @"下拉刷新";
    } else if (state == LSRefreshStatePulling) {
        self.infoLabel.text = @"下拉刷新";
    } else if (state == LSRefreshStateWillRefresh) {
        self.infoLabel.text = @"释放刷新";
    } else if (state == LSRefreshStateRefreshing) {
        self.infoLabel.text = @"刷新中..";
    } else if (state == LSRefreshStateFinish) {
        self.infoLabel.text = @"刷新完毕";
    }
    
    [super setState:state];
}

- (void)beginRefreshing {
    [super beginRefreshing];
    [self.indicator startAnimation];
}

- (void)endRefreshing {
    [super endRefreshing];
    [self.indicator stopAnimation];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 调整header高度和位置
    if (self.scrollView.ls_offsetY < -self.scrollView.ls_insetTop) {
        self.ls_top = self.scrollView.ls_offsetY + self.scrollView.ls_insetTop;
        self.ls_height = fabs(self.scrollView.ls_insetTop + self.scrollView.ls_offsetY);
    } else {
        self.ls_top = self.ls_height = 0.f;
    }
    
    // 根据高度修改控件状态
    if (self.state != LSRefreshStateRefreshing){
        if (self.scrollView.isDragging) {
            if (self.ls_height < kLSRefreshHeaderIdleToPullingHeight) {
                self.state = LSRefreshStateIdel;
                
            } else if (self.ls_height >= kLSRefreshHeaderIdleToPullingHeight && self.ls_height < kLSRefreshHeaderPullingToWillRefreshHeight) {
                self.state = LSRefreshStatePulling;
                
            } else if (self.ls_height >= kLSRefreshHeaderPullingToWillRefreshHeight) {
                self.state = LSRefreshStateWillRefresh;
            }
        } else  {
            if (self.state == LSRefreshStateWillRefresh) {
                [self beginRefreshing];
            }
        }
    }
    
    // 根据高度调整Indicator UI
    if (self.state != LSRefreshStateRefreshing) {
        if (self.ls_height <= kLSRefreshHeaderPullingToWillRefreshHeight) {
            CGFloat progress = self.ls_height/kLSRefreshHeaderPullingToWillRefreshHeight;
            self.indicator.progress = self.contentView.alpha = progress;
        } else {
            self.indicator.progress = self.contentView.alpha = 1.f;
        }
    } else {
        self.contentView.alpha = 1.f;
    }
}

@end
