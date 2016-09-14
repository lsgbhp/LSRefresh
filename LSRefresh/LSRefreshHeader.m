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
}

- (void)locateSubviews {
    [super locateSubviews];
    self.indicator.center = CGPointMake(self.ls_width*0.5, self.ls_height*0.5);
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

@end
