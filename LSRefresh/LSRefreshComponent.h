//
//  LSRefreshComponent.h
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UIView+LSExtension.h"
#import "UIScrollView+LSExtension.h"

typedef NS_ENUM(NSUInteger, LSRefreshState) {
    LSRefreshStateIdel = 1,
    LSRefreshStatePulling,
    LSRefreshStateRefreshing,
    LSRefreshStateWillRefresh,
    LSRefreshStateFinish
};

typedef void (^LSRefreshActionBlock)();

static NSString * const kLSRefreshKeyContentOffset = @"contentOffset";
static NSString * const kLSRefreshKeyContentSize = @"contentSize";

@interface LSRefreshComponent : UIView

@property (nonatomic, assign) LSRefreshState state;
@property (nonatomic, copy) LSRefreshActionBlock actionBlock;

@property (nonatomic, weak) UIScrollView *scrollView;

- (void)configuration;
- (void)setupSubviews;
- (void)locateSubviews;

- (void)beginRefreshing;
- (void)endRefreshing;

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change;
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change;

@end
