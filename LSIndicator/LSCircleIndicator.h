//
//  LSCircleIndicator.h
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/14.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCircleIndicator : UIView

+ (instancetype)indicator;

- (void)startAnimation;
- (void)stopAnimation;

@end
