//
//  UIScrollView+LSExtension.m
//  LSRefreshExample
//
//  Created by ShawnLin on 16/9/12.
//  Copyright © 2016年 ShawnLin. All rights reserved.
//

#import "UIScrollView+LSExtension.h"

@implementation UIScrollView (LSExtension)

- (CGFloat)ls_offsetX {
    return self.contentOffset.x;
}

- (void)setLs_offsetX:(CGFloat)ls_offsetX {
    CGPoint offset = self.contentOffset;
    offset.x = ls_offsetX;
    self.contentOffset = offset;
}

- (CGFloat)ls_offsetY {
    return self.contentOffset.y;
}

- (void)setLs_offsetY:(CGFloat)ls_offsetY {
    CGPoint offset = self.contentOffset;
    offset.y = ls_offsetY;
    self.contentOffset = offset;
}

- (CGFloat)ls_contentW {
    return self.contentSize.width;
}

- (void)setLs_contentW:(CGFloat)ls_contentW {
    CGSize contentSize = self.contentSize;
    contentSize.width = ls_contentW;
    self.contentSize = contentSize;
}

- (CGFloat)ls_contentH {
    return self.contentSize.height;
}

- (void)setLs_contentH:(CGFloat)ls_contentH {
    CGSize contentSize = self.contentSize;
    contentSize.height = ls_contentH;
    self.contentSize = contentSize;
}

- (CGFloat)ls_insetTop {
    return self.contentInset.top;
}

- (void)setLs_insetTop:(CGFloat)ls_insetTop {
    UIEdgeInsets contentInset = self.contentInset;
    contentInset.top = ls_insetTop;
    self.contentInset = contentInset;
}

- (CGFloat)ls_insetBottom {
    return self.contentInset.bottom;
}

- (void)setLs_insetBottom:(CGFloat)ls_insetBottom {
    UIEdgeInsets contentInset = self.contentInset;
    contentInset.bottom = ls_insetBottom;
    self.contentInset = contentInset;
}

- (CGFloat)ls_insetLeft {
    return self.contentInset.left;
}

- (void)setLs_insetLeft:(CGFloat)ls_insetLeft {
    UIEdgeInsets contentInset = self.contentInset;
    contentInset.left = ls_insetLeft;
    self.contentInset = contentInset;
}

- (CGFloat)ls_insetRight {
    return self.contentInset.right;
}

- (void)setLs_insetRight:(CGFloat)ls_insetRight {
    UIEdgeInsets contentInset = self.contentInset;
    contentInset.right = ls_insetRight;
    self.contentInset = contentInset;
}

@end
