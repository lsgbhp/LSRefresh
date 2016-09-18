//
//  LSCircleIndicator.h
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/14.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCircleIndicator : UIView

@property (nonatomic, assign) CGFloat progress;

+ (instancetype)indicator;

- (void)startAnimation;
- (void)stopAnimation;

@end
