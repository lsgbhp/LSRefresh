//
//  UIScrollView+LSExtension.h
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/12.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (LSExtension)

@property (nonatomic, assign) CGFloat ls_offsetX;
@property (nonatomic, assign) CGFloat ls_offsetY;

@property (nonatomic, assign) CGFloat ls_contentW;
@property (nonatomic, assign) CGFloat ls_contentH;

@end
