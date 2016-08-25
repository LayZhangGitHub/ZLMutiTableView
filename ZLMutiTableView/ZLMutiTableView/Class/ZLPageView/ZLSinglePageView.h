//
//  ZLSinglePageView.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLListenerProtocol.h"
#import "ZLPageTitleButton.h"

/**
 *  ZLPageView 的单个页面的抽象类
 */

@interface ZLSinglePageView : UIView<ZLListenerProtocol>

//@property (nonatomic) NSString *title;
@property NSUInteger pageIndex;

@property ZLPageTitleButton *titleButton;

- (void)setPageTitle:(NSString *)title;

#pragma abstractFunc
//- (void)addListener;
//- (void)removeListener;

- (void)updateView;

- (void)reloadPageData;
- (void)pageUnSelect;
- (void)pageSelect;

@end
