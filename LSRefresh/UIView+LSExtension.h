//
//  UIView+LSRefresh.h
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/12.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LSExtension)

@property (nonatomic, assign) CGFloat ls_top;
@property (nonatomic, assign) CGFloat ls_bottom;
@property (nonatomic, assign) CGFloat ls_left;
@property (nonatomic, assign) CGFloat ls_right;

@property (nonatomic, assign) CGFloat ls_width;
@property (nonatomic, assign) CGFloat ls_height;

@property (nonatomic, assign) CGFloat ls_centerX;
@property (nonatomic, assign) CGFloat ls_centerY;

@property (nonatomic, assign) CGPoint ls_origin;
@property (nonatomic, assign) CGSize ls_size;

@end
