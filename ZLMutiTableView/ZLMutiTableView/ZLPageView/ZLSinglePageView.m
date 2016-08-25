//
//  ZLSinglePageView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ZLSinglePageView.h"

@implementation ZLSinglePageView

@synthesize pageIndex = _pageIndex;

@synthesize titleButton = _titleButton;

- (id)init {
    if (self = [super init]) {
        [self initZLComponent];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initZLComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initZLComponent];
    }
    return self;
}

- (void)initZLComponent {
    self.titleButton = [[ZLPageTitleButton alloc] initWithStyle:ZLTitleButtonStyleGray];
}

/**
 *  和resetView 不同 并不是 每个View 都需要update 所以自己实现
 */
- (void)updateView {
    NSLog(@"SinglePageView updateView");
}

/**
 *  关于 titleButton的style, 可在ZLPageTitleButton 自定义
 */
- (void)setPageTitle:(NSString *)title {
    [self.titleButton setTitle:title forState:UIControlStateNormal];
}

/**
 *  用于重新载入数据
 *  需要 载入 报表数据的地方重写， 一般 可以不重写
 */
- (void)reloadPageData {
    NSLog(@"this is SinglePageView reloadData");
}

- (void)pageSelect {
    NSLog(@"this is SinglePageView pageSelect");
}

- (void)pageUnSelect {
    NSLog(@"this is SinglePageView pageUnSelect");
}

- (void)addListener {
    NSLog(@"this is SinglePageView addListener");
}

- (void)removeListener {
    NSLog(@"this is SinglePageView removeListener");
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

/**
 *  子类不要实现
 */
- (void)dealloc {
    [self removeListener];
}


@end
