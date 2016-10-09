//
//  LSRefreshFooter.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/28.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "LSRefreshFooter.h"
#import "LSCircleIndicator.h"

static const CGFloat kLSRefreshFooterHeight = 50.f;

@interface LSRefreshFooter ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) LSCircleIndicator *indicator;
@property (nonatomic, strong) UILabel *infoLabel;

@end

@implementation LSRefreshFooter

+ (instancetype)footerWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshFooter *footer = [LSRefreshFooter new];
    footer.actionBlock = actionBlock;
    return footer;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    
    if (newSuperview) {
        self.scrollView.ls_insetBottom += self.ls_height;
    } else {
        self.scrollView.ls_insetBottom -= self.ls_height;
    }
}

- (void)setupSubviews {
    [super setupSubviews];
    
    self.ls_height = kLSRefreshFooterHeight;
    
    self.contentView = [UIView new];
    
    self.indicator = [LSCircleIndicator indicator];
    [self.contentView addSubview:self.indicator];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.text = @"上拉刷新";
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
    
    if (state ==  LSRefreshStateRefreshing) {
        CGFloat offsetY = self.scrollView.ls_contentH+self.scrollView.ls_insetBottom-self.scrollView.ls_height;
        if (self.scrollView.ls_contentH < self.scrollView.ls_height) {
            offsetY = self.ls_bottom - self.scrollView.ls_height;
        }
        [self.scrollView setContentOffset:CGPointMake(0.f, offsetY) animated:YES];
    
        self.scrollView.scrollEnabled = NO;
    
    } else if (state == LSRefreshStateFinish) {
        self.scrollView.scrollEnabled = YES;
    }
    
    if (state == LSRefreshStateIdel) {
        self.infoLabel.text = @"上拉加载";
    } else if (state == LSRefreshStatePulling) {
        self.infoLabel.text = @"上拉加载";
    } else if (state == LSRefreshStateWillRefresh) {
        self.infoLabel.text = @"释放加载";
    } else if (state == LSRefreshStateRefreshing) {
        self.infoLabel.text = @"加载中..";
    } else if (state == LSRefreshStateFinish) {
        self.infoLabel.text = @"加载完毕";
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

    if (!self.hidden) {
        if (self.scrollView.ls_offsetY + self.scrollView.ls_height > self.ls_bottom) {
            self.state = LSRefreshStateWillRefresh;
        } else {
            if (self.scrollView.isDragging) {
                self.state = LSRefreshStateIdel;
            } else if (self.state == LSRefreshStateWillRefresh) {
                [self beginRefreshing];
            }
        }
    }
}

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
    if (hidden) {
        self.scrollView.ls_insetBottom -= self.ls_height;
    } else {
        self.scrollView.ls_insetBottom += self.ls_height;
        self.ls_top = self.scrollView.ls_contentH;
    }
}

@end
