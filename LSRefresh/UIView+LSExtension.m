//
//  UIView+LSRefresh.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/12.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "UIView+LSExtension.h"

@implementation UIView (LSExtension)

- (CGFloat)ls_top {
    return self.frame.origin.y;
}

- (void)setLs_top:(CGFloat)ls_top {
    CGPoint newOrigin = CGPointMake(self.frame.origin.x, ls_top);
    self.ls_origin = newOrigin;
}

- (CGFloat)ls_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setLs_bottom:(CGFloat)ls_bottom {
    CGPoint newOrigin = CGPointMake(self.frame.origin.x, ls_bottom - self.frame.size.height);
    self.ls_origin = newOrigin;
}

- (CGFloat)ls_left {
    return self.frame.origin.x;
}

- (void)setLs_left:(CGFloat)ls_left {
    CGPoint newOrigin = CGPointMake(ls_left, self.frame.origin.y);
    self.ls_origin = newOrigin;
}

- (CGFloat)ls_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setLs_right:(CGFloat)ls_right {
    CGPoint newOrigin = CGPointMake(ls_right - self.frame.origin.x, self.frame.origin.y);
    self.ls_origin = newOrigin;
}

- (CGFloat)ls_width {
    return self.frame.size.width;
}

- (void)setLs_width:(CGFloat)ls_width {
    CGSize newSize = CGSizeMake(ls_width, self.frame.size.height);
    self.ls_size = newSize;
}

- (CGFloat)ls_height {
    return self.frame.size.height;
}

- (void)setLs_height:(CGFloat)ls_height {
    CGSize newSize = CGSizeMake(self.frame.size.width, ls_height);
    self.ls_size = newSize;
}

- (CGFloat)ls_centerX {
    return self.center.x;
}

- (void)setLs_centerX:(CGFloat)ls_centerX {
    CGPoint center = self.center;
    center.x = ls_centerX;
    self.center = center;
}

- (CGFloat)ls_centerY {
    return self.center.y;
}

- (void)setLs_centerY:(CGFloat)ls_centerY {
    CGPoint center = self.center;
    center.y = ls_centerY;
    self.center = center;
}

- (CGPoint)ls_origin {
    return self.frame.origin;
}

- (void)setLs_origin:(CGPoint)ls_origin {
    CGRect newFrame = CGRectMake(ls_origin.x, ls_origin.y, self.frame.size.width, self.frame.size.height);
    self.frame = newFrame;
}

- (CGSize)ls_size {
    return self.frame.size;
}

- (void)setLs_size:(CGSize)ls_size {
    CGRect newFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, ls_size.width, ls_size.height);
    self.frame = newFrame;
}

@end
