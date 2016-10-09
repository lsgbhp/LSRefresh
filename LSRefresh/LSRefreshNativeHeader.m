//
//  LSRefreshNativeHeader.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/10/8.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "LSRefreshNativeHeader.h"

static const CGFloat kLSRefreshNativeHeaderHeight = 60.f;

@interface LSRefreshNativeHeader ()

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation LSRefreshNativeHeader

+ (instancetype)nativeHeaderWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshNativeHeader *header = [LSRefreshNativeHeader new];
    header.actionBlock = actionBlock;
    return header;
}

- (void)setupSubviews {
    [super setupSubviews];
    self.refreshControl = [UIRefreshControl new];
    [self.refreshControl addTarget:self action:@selector(beginRefreshing) forControlEvents:UIControlEventValueChanged];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (self.scrollView) {
        [self.scrollView addSubview:self.refreshControl];
    }
}

- (void)removeFromSuperview {
    [self.refreshControl removeFromSuperview];
    [super removeFromSuperview];
}

- (void)setState:(LSRefreshState)state {
    
    if (state == self.state) return;
    
    if (state == LSRefreshStateRefreshing) {
        [self.scrollView setContentOffset:CGPointMake(0, -(self.scrollView.ls_insetTop+kLSRefreshNativeHeaderHeight)) animated:YES];
        [self.refreshControl beginRefreshing];
    }
    
    [super setState:state];
}

- (void)beginRefreshing {
    [super beginRefreshing];
}

- (void)endRefreshing {
    [super endRefreshing];
    [self.refreshControl endRefreshing];
}

@end
