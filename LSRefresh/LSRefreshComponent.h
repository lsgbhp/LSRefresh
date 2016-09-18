//
//  LSRefreshComponent.h
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 fongtinyik. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+LSExtension.h"
#import "UIScrollView+LSExtension.h"

typedef NS_ENUM(NSUInteger, LSRefreshState) {
    LSRefreshStateIdel = 1,
    LSRefreshStatePulling,
    LSRefreshStateRefreshing,
    LSRefreshStateWillRefresh
};

typedef void (^LSRefreshActionBlock)();

static const CGFloat kLSRefreshHeaderHeight = 50.f;
static const CGFloat kLSRefreshIdleToPullingHeight = 30.f;
static const CGFloat kLSRefreshPullingToWillRefreshHeight = 90.f;

static NSString * const kLSRefreshKeyContentOffset = @"contentOffset";

@interface LSRefreshComponent : UIView

@property (nonatomic, assign) LSRefreshState state;
@property (nonatomic, copy) LSRefreshActionBlock actionBlock;

@property (nonatomic, weak) UIScrollView *scrollView;

- (void)configuration;
- (void)setupSubviews;
- (void)locateSubviews;

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;

@end
