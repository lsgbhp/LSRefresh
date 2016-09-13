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
    LSRefreshStateFinishing
};

typedef void (^LSRefreshActionBlock)();

static const CGFloat kLSRefreshHeaderHeight = 44.f;
static const CGFloat kLSRefreshTriggerHeight = 50.f;

static NSString * const kLSRefreshKeyContentOffset = @"contentOffset";

@interface LSRefreshComponent : UIView

@property (nonatomic, assign) LSRefreshState state;
@property (nonatomic, copy) LSRefreshActionBlock actionBlock;

@property (nonatomic, weak) UIScrollView *scrollView;

- (void)configuration;
- (void)setupSubviews;
- (void)placeSubviews;

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;

@end
