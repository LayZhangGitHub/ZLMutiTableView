//
//  ZLPageView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 Allone. All rights reserved.
//

#import "ZLPageView.h"
#import "ZLSinglePageView.h"

const CGFloat defaultTopTapHeight = 40.0f;

@interface ZLPageView()<UIScrollViewDelegate>

// const value
@property CGFloat topTapHeight;

// views
@property UIScrollView *mainScrollView;
@property NSMutableArray *topTabButtonArray;

// values
@property NSUInteger currentPageIndex;

@end

@implementation ZLPageView

// const value
@synthesize topTapHeight = _topTapHeight;

// views
@synthesize mainScrollView = _mainScrollView;
@synthesize topTabButtonArray = _topTabButtonArray;

// values
@synthesize currentPageIndex = _currentPageIndex;

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
    }
    return self;
}

- (id)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    [self setBackgroundColor:[UIColor blackColor]];
    _currentPageIndex = UINT8_MAX;
    self.topTapHeight = defaultTopTapHeight;
    [self initScrollView];
}

- (void)initScrollView {
    self.mainScrollView = [[UIScrollView alloc] init];
    [self.mainScrollView setDelegate:self];
    [self.mainScrollView setBounces:NO];
    [self.mainScrollView setShowsHorizontalScrollIndicator:NO];
    [self.mainScrollView setPagingEnabled:YES];
    [self.mainScrollView setBackgroundColor:[UIColor grayColor]];
    [self addSubview:self.mainScrollView];
}

#pragma layout subviews
- (void)layoutTopTabButtons {
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    CGFloat tabWidth = scrollViewWidth / self.pageViewArray.count;
    for (int i = 0; i < self.pageViewArray.count; i++) {
        //        UIButton *button = [_topTabButtonArray objectAtIndex:i];
        UIButton *titleButton = [(ZLSinglePageView *)[self.pageViewArray objectAtIndex:i] titleButton];
        CGRect buttonFrame = titleButton.bounds;
        buttonFrame.size.width = tabWidth;
        CGFloat x = i * tabWidth;
        buttonFrame.origin.x = x;
        buttonFrame.size.height = _topTapHeight;
        
        [titleButton setFrame:buttonFrame];
    }
}

- (void)layoutPageViews {
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    CGFloat scrollViewHeight = CGRectGetHeight(self.frame) - self.topTapHeight;
    for (int i = 0; i < self.pageViewArray.count; i++) {
        UIView *tempView = [self.pageViewArray objectAtIndex:i];
        [tempView setFrame:CGRectMake(i * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
        //        NSLog(@"%f...%@", ScrollViewHeight, [tempView class]);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    NSUInteger index = scrollView.contentOffset.x / scrollViewWidth;
    [self setCurrentPage:index];
}

- (void)topTabButtonClick:(id)sender {
    if ([sender isKindOfClass:[UIButton class]]) {
        [self setCurrentPage:[_topTabButtonArray indexOfObject:sender]];
    }
}

- (void)reclickCurrentPage {
    [[self.pageViewArray objectAtIndex:_currentPageIndex] reloadPageData];
}

- (void)setCurrentPage:(NSUInteger)currentPage {
    
    if (currentPage >= self.pageViewArray.count) {
        NSLog(@"cross array");
        return;
    }
    
    if (self.currentPageIndex == currentPage) {
        [[self.pageViewArray objectAtIndex:currentPage] reloadPageData];
        return;
    }
    
    if (self.currentPageIndex == UINT8_MAX) {
        self.currentPageIndex = 0;
    }
    
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    
    [[_topTabButtonArray objectAtIndex:self.currentPageIndex] setBackgroundColor:[UIColor grayColor]];
    [[_topTabButtonArray objectAtIndex:currentPage] setBackgroundColor:[UIColor blackColor]];
    [[[_topTabButtonArray objectAtIndex:self.currentPageIndex] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    [[[_topTabButtonArray objectAtIndex:currentPage] titleLabel] setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_mainScrollView setContentOffset:CGPointMake(currentPage * scrollViewWidth, 0) animated:NO];
    
    [[self.pageViewArray objectAtIndex:self.currentPageIndex] pageUnSelect];
    [[self.pageViewArray objectAtIndex:currentPage] reloadPageData];
    [[self.pageViewArray objectAtIndex:currentPage] pageSelect];
    
    self.currentPageIndex = currentPage;
    
    if (_actionDelegate != nil && [_actionDelegate respondsToSelector:@selector(pageView:didChangePageAtIndex:)]) {
        [_actionDelegate pageView:self didChangePageAtIndex:currentPage];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutPageViews];
    [self layoutTopTabButtons];
}


#pragma setDelegate
- (void)setSourceDelegate:(id<ZLPageViewDataSourceProtocol>)sourceDelegate {
    if (sourceDelegate == nil) {
        _sourceDelegate = nil;
    }
    
    if (_sourceDelegate != sourceDelegate) {
        _sourceDelegate = sourceDelegate;
        
        [self resetComponent];
        [self setScrollEnable];
    }
}

- (void)setActionDelegate:(id<ZLPageViewActionProtocol>)actionDelegate {
    if (actionDelegate == nil) {
        _actionDelegate = nil;
    }
    
    if (_actionDelegate != actionDelegate) {
        _actionDelegate = actionDelegate;
    }
}

- (void)resetComponent {
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(topTapTitleHeightAtPageView:)]) {
        _topTapHeight = [_sourceDelegate topTapTitleHeightAtPageView:self];
    }
    
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(arrayOfCustomPageViewAtPageView:)]) {
        self.pageViewArray = [_sourceDelegate arrayOfCustomPageViewAtPageView:self];
    }
}

- (void)setScrollEnable {
    if (_sourceDelegate != nil && [_sourceDelegate respondsToSelector:@selector(scrollEnable)]) {
        [_mainScrollView setScrollEnabled:[_sourceDelegate scrollEnable]];
    }
}

#pragma publicFunc
- (void)setPageViewArray:(NSArray *)pageViewArray {
    _pageViewArray = pageViewArray;
    _topTabButtonArray = [[NSMutableArray alloc] init];
    for (int index = 0; index < pageViewArray.count; index ++) {
        UIView *view = [pageViewArray objectAtIndex:index];
        if ([view isKindOfClass:[ZLSinglePageView class]]) {
            ZLSinglePageView *singleView = (ZLSinglePageView *)view;
            [singleView setPageIndex:index];
//            [self buildTopTapButton:[singleView titleButton]];
            [_topTabButtonArray addObject:[singleView titleButton]];
            [[singleView titleButton] addTarget:self
                                         action:@selector(topTabButtonClick:)
                               forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:[singleView titleButton]];
            [_mainScrollView addSubview:singleView];
        }
    }
    
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    CGFloat scrollViewHeight = CGRectGetHeight(self.frame);
    
    [_mainScrollView setFrame:CGRectMake(0, _topTapHeight, scrollViewWidth, scrollViewHeight - _topTapHeight)];
    [_mainScrollView setContentSize:CGSizeMake(scrollViewWidth * self.pageViewArray.count, scrollViewHeight - _topTapHeight)];
}

- (void)removeAllListener {
    for (ZLSinglePageView *view in self.pageViewArray) {
        [view pageUnSelect];
    }
    [[_topTabButtonArray objectAtIndex:self.currentPageIndex] setBackgroundColor:[UIColor grayColor]];
    [[[_topTabButtonArray objectAtIndex:self.currentPageIndex] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    self.currentPageIndex = UINT8_MAX;
}

- (void)dealloc {
    
}


@end
