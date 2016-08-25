//
//  ZLPageViewProtocol.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZLPageView;

/**
 *  ZLPageView 的 datasource和action
 */

@protocol ZLPageViewDataSourceProtocol <NSObject>

//- (NSUInteger)countOfPageViews;
- (CGFloat)topTapTitleHeightAtPageView:(ZLPageView *)pageView;
- (NSArray *)arrayOfCustomPageViewAtPageView:(ZLPageView *)pageView;

- (Boolean)scrollEnable;

@end

@protocol ZLPageViewActionProtocol <NSObject>

- (void)pageView:(ZLPageView *)pageView didChangePageAtIndex:(NSUInteger)index;

@end
