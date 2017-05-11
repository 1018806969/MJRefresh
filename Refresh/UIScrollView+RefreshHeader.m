//
//  UIScrollView+RefreshHeader.m
//  Refresh
//
//  Created by Merlin on 2017/5/2.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "UIScrollView+RefreshHeader.h"
#import <objc/runtime.h>

@implementation UIScrollView (RefreshHeader)

- (void)addRefreshHeaderWithHandle:(void(^)())handle
{
    RefreshHeader *header = [[RefreshHeader alloc]init];
    header.handle = handle;
    self.header = header;
    [self insertSubview:header atIndex:0];
}


- (void)setHeader:(RefreshHeader *)header
{
    objc_setAssociatedObject(self, @selector(header), header, OBJC_ASSOCIATION_ASSIGN);
}

- (RefreshHeader *)header
{
    return objc_getAssociatedObject(self, @selector(setHeader:));
}


+ (void)load
{
    Method originalDealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method swizzleDealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"tang_dealloc"));
    method_exchangeImplementations(originalDealloc, swizzleDealloc);
}
- (void)tang_dealloc
{
    self.header = nil ;
    [self tang_dealloc];
}
@end
