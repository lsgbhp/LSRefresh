//
//  LSRefreshHeader.m
//  remix
//
//  Created by ShawnLin on 16/9/9.
//  Copyright © 2016年 fongtinyik. All rights reserved.
//

#import "LSRefreshHeader.h"

@interface LSRefreshHeader ()

@end

@implementation LSRefreshHeader

+ (instancetype)headerWithActionBlock:(LSRefreshActionBlock)actionBlock {
    LSRefreshHeader *header = [[LSRefreshHeader alloc] init];
    header.actionBlock = actionBlock;
    return header;
}

- (void)configuration {
    [super configuration];
}

- (void)setupSubviews {
    [super setupSubviews];
}

@end
