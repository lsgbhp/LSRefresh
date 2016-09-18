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
    
    self.indicator = [LSCircleIndicator indicator];
    [self addSubview:self.indicator];
    [self.indicator startAnimation];
    
    self.infoLabel = [UILabel new];
    self.infoLabel.text = @"下拉刷新";
    self.infoLabel.textColor = [UIColor lightGrayColor];
    self.infoLabel.font = [UIFont systemFontOfSize:14.f];
    [self.infoLabel sizeToFit];
    [self addSubview:self.infoLabel];
}

- (void)locateSubviews {
    [super locateSubviews];
    
//    if (self.state != LSRefreshStateIdel) {
        self.indicator.center = CGPointMake(self.ls_width*0.4, self.ls_height*0.5);
        [self.infoLabel sizeToFit];
        self.infoLabel.ls_left = self.indicator.ls_right + 10.f;
        self.infoLabel.ls_centerY = self.indicator.ls_centerY;
//    }
}

- (void)setState:(LSRefreshState)state {
    [super setState:state];
    
    if (state == LSRefreshStateIdel) {
        self.infoLabel.text = @"下拉刷新";
    } else if (state == LSRefreshStatePulling) {
        self.infoLabel.text = @"用力下拉";
    } else if (state == LSRefreshStateWillRefresh) {
        self.infoLabel.text = @"释放开始刷新";
    } else if (state == LSRefreshStateRefreshing) {
        self.infoLabel.text = @"努力加载中";
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

@end
