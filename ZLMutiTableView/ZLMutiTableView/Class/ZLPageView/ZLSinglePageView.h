//
//  ZLSinglePageView.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLListenerProtocol.h"

/**
 *  ZLPageView 的单个页面的抽象类
 */

@interface ZLSinglePageView : UIView<ZLListenerProtocol>

@property (nonatomic, assign) NSUInteger pageIndex;

#pragma abstract Func
//- (void)addListener;
//- (void)removeListener;

- (void)updateView;

- (void)reloadPageData;
- (void)pageUnSelect;
- (void)pageSelect;

@end
