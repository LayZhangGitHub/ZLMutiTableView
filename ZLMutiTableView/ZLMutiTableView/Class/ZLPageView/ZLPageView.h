//
//  ZLPageView.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLPageViewProtocol.h"

/**
 *  ZLSinglePage容器
 */

@interface ZLPageView : UIView

@property (nonatomic, weak) id<ZLPageViewDataSourceProtocol> sourceDelegate;
@property (nonatomic, weak) id<ZLPageViewActionProtocol> actionDelegate;

@property (nonatomic) NSArray *pageViewArray;

- (void)setCurrentPage:(NSUInteger)index;
- (void)reclickCurrentPage;

- (void)removeAllListener;

@end
