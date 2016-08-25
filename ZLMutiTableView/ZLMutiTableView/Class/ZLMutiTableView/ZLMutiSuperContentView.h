//
//  ZLMutiSuperContentView.h
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ZLSinglePageView.h"
#import "ZLMutiSuperContentViewProtocol.h"
/**
 *  可滑动TableView的抽象类
 */
@interface ZLMutiSuperContentView : ZLSinglePageView<ZLListenerProtocol, ZLMutiSuperContentViewProtocol>

@property UIView *contentTopView;
@property UITableView *contentTableView;

@property UIView *leftTopView;
@property UITableView *leftTableView;

@property UIScrollView *contentScrollView;

@property NSMutableArray *contentArray;

@property CGFloat topBarHeight;
@property CGFloat cellHeight;

- (UITableViewCell *)getContentTableViewCell;
- (UITableViewCell *)getLeftTableViewCell;

- (NSIndexPath *)getIndexPathOfGesture:(UIGestureRecognizer *)gesture;

- (void)updateSelectIndex;

- (void)initData;

- (void)selectNewIndex:(NSArray *)indexArray;


@end
