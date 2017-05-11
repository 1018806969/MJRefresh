//
//  UIScrollView+RefreshHeader.h
//  Refresh
//
//  Created by Merlin on 2017/5/2.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeader.h"

@interface UIScrollView (RefreshHeader)

@property (nonatomic, strong) RefreshHeader *header;


- (void)addRefreshHeaderWithHandle:(void(^)())handle;
@end
