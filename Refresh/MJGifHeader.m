//
//  MJGifHeader.m
//  Refresh
//
//  Created by Merlin on 2017/5/11.
//  Copyright © 2017年 Merlin. All rights reserved.
//

#import "MJGifHeader.h"

@implementation MJGifHeader


- (void)prepare
{
    [super prepare];
    self.backgroundColor = [UIColor blueColor];
    self.gifView.backgroundColor = [UIColor redColor];
    [self setTitle:@"title" forState:MJRefreshStatePulling];
    self.lastUpdatedTimeLabel.hidden = YES;
}
@end
