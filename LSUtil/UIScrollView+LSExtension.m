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

@end
