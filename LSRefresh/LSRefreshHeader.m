//
//  LSRefreshHeader.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 fongtinyik. All rights reserved.
//

#import "LSRefreshHeader.h"
#import "LSCircleIndicator.h"

@interface LSRefreshHeader ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) LSCircleIndicator *indicator;
@property (nonatomic, strong) UILabel *infoLabel;

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
    self.contentView.ls_width = self.infoLabel.ls_width + self.indicator.ls_width + 15.f;
    self.contentView.ls_left = self.ls_width * 0.38;
    self.contentView.ls_centerY = self.ls_height * 0.5;
}

- (void)setState:(LSRefreshState)state {
    
    if (state == self.state) return;
    
    if (state == LSRefreshStateRefreshing && self.state == LSRefreshStateWillRefresh) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -(self.scrollView.ls_insetTop + kLSRefreshHeaderHeight)) animated:YES];
        self.scrollView.scrollEnabled = NO;
        
    } else if (state == LSRefreshStateFinish && self.state == LSRefreshStateRefreshing) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.ls_offsetX, -self.scrollView.ls_insetTop) animated:YES];
        self.scrollView.scrollEnabled = YES;
    }
    
    if (state == LSRefreshStateIdel) {
        self.infoLabel.text = @"下拉刷新";
    } else if (state == LSRefreshStatePulling) {
        self.infoLabel.text = @"用力下拉";
    } else if (state == LSRefreshStateWillRefresh) {
        self.infoLabel.text = @"释放刷新";
    } else if (state == LSRefreshStateRefreshing) {
        self.infoLabel.text = @"加载中";
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
        self.state = LSRefreshStateIdel;
    }
    
    // 根据高度修改控件状态
    if (self.state != LSRefreshStateRefreshing && self.state != LSRefreshStateFinish){
        
        if (self.ls_height < kLSRefreshIdleToPullingHeight) {
            self.state = LSRefreshStateIdel;
            
        } else if (self.ls_height >= kLSRefreshIdleToPullingHeight && self.ls_height < kLSRefreshPullingToWillRefreshHeight) {
            self.state = LSRefreshStatePulling;
            
        } else if (self.ls_height >= kLSRefreshPullingToWillRefreshHeight) {
            self.state = LSRefreshStateWillRefresh;
            if (!self.scrollView.isDragging) {
                [self beginRefreshing];
            }
        }
    }
    
    // 根据高度调整Indicator UI
    if (self.state != LSRefreshStateRefreshing) {
        if (self.ls_height <= kLSRefreshPullingToWillRefreshHeight) {
            if (self.state != LSRefreshStateFinish) {
                CGFloat progress = self.ls_height/kLSRefreshPullingToWillRefreshHeight;
                self.indicator.progress = progress;
            } else {
                self.indicator.progress = 1.f;
            }
        } else {
            self.indicator.progress = 1.f;
        }
    }
}

@end
