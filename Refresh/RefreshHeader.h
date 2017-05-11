//
//  RefreshHeader.h
//  Refresh
//
//  Created by Merlin on 2017/5/2.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RefreshHeader : UIView


@property (nonatomic, copy) void(^handle)();

- (void)endRefresh;

@end
