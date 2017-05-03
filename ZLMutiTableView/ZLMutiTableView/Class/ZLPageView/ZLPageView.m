//
//  ZLPageView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/22.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import "ZLPageView.h"
#import "ZLSinglePageView.h"

//const CGFloat defaultTopTapHeight = 40.0f;
const CGFloat defaultSliderHeight = 3.0f;

typedef NS_OPTIONS(NSUInteger, ZLMainScrollViewDragDirect) {
    ZLMainScrollViewDragDirectMiddle    = 1 << 0,
    ZLMainScrollViewDragDirectLeft      = 1 << 1,
    ZLMainScrollViewDragDirectRight     = 1 << 2
};

@interface ZLPageView()<UIScrollViewDelegate> {
    CGFloat _lastScrollOffset;
    ZLMainScrollViewDragDirect _dragDirect;
}

// views
@property (nonatomic, strong) UIScrollView *mainScrollView;
@property (nonatomic, strong) NSArray *topTabButtonArray;
@property (nonatomic, strong) NSArray *pageViewArray;
@property (nonatomic, strong) UIView *sliderView;

// values
@property (nonatomic, assign) CGFloat topTapHeight;
@property (nonatomic, assign) NSUInteger currentPageIndex;

@end

@implementation ZLPageView

- (instancetype)init {
    if (self = [super init]) {
        [self initComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initComponent];
    }
    return self;
}

- (void)initComponent {
    [self setBackgroundColor:[UIColor blackColor]];
    _currentPageIndex = UINT8_MAX;
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

#pragma mark - layout subviews
- (void)layoutSubviews {
    [super layoutSubviews];
    [self loadData];
    [self layoutPageViews];
    [self layoutTopTabButtons];
}

- (void)loadData {
    
    if (self.pageViewArray) {
        return;
    }
    
    // delegate 不可为空
    if (!self.sourceDelegate) {
        return;
    }
//    if (!self.actionDelegate) {
//        return;
//    }
    
    if ([self.sourceDelegate respondsToSelector:@selector(topTapTitleHeight)]) {
        self.topTapHeight = [self.sourceDelegate topTapTitleHeight];
    }
    
    if ([self.sourceDelegate respondsToSelector:@selector(arrayOfPageView)]) {
        self.pageViewArray = [self.sourceDelegate arrayOfPageView];
        for (UIView *pageView in self.pageViewArray) {
            [self.mainScrollView addSubview:pageView];
        }
    }
    
    if ([self.sourceDelegate respondsToSelector:@selector(arrayOfTitleButton)]) {
        self.topTabButtonArray = [self.sourceDelegate arrayOfTitleButton];
        for (UIButton *pageBtn in self.topTabButtonArray) {
            [pageBtn addTarget:self action:@selector(topTabButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [pageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self addSubview:pageBtn];
        }
    }
    
    if ([self.sourceDelegate respondsToSelector:@selector(scrollEnable)]) {
        self.mainScrollView.scrollEnabled = [self.sourceDelegate scrollEnable];
    }
    
    if (!self.sliderView) {
        self.sliderView = [[UIView alloc] init];
        self.sliderView.backgroundColor = [UIColor redColor];
        self.sliderView.alpha = 0.8;
        [self addSubview:self.sliderView];
    }
    
}

- (void)layoutTopTabButtons {
    CGFloat scrollViewWidth = CGRectGetWidth(self.frame);
    CGFloat tabWidth = scrollViewWidth / self.pageViewArray.count;
    for (int i = 0; i < self.pageViewArray.count; i++) {
        UIButton *button = [_topTabButtonArray objectAtIndex:i];
        
        CGFloat x = i * tabWidth;
        CGFloat y = 2.0f;
        CGFloat height = _topTapHeight - y;
        CGFloat width = tabWidth;
        
        [button setFrame:CGRectMake(x, y, width, height)];
    }
    [self.sliderView setFrame:CGRectMake(0, _topTapHeight - defaultSliderHeight, tabWidth, defaultSliderHeight)];
}

- (void)layoutPageViews {
    CGFloat scrollViewWidth     = CGRectGetWidth(self.frame);
    CGFloat scrollViewHeight    = CGRectGetHeight(self.frame) - self.topTapHeight;
    for (int i = 0; i < self.pageViewArray.count; i++) {
        UIView *tempView = [self.pageViewArray objectAtIndex:i];
        [tempView setFrame:CGRectMake(i * scrollViewWidth, 0, scrollViewWidth, scrollViewHeight)];
        //        NSLog(@"%f...%@", ScrollViewHeight, [tempView class]);
    }
    
    [_mainScrollView setFrame:CGRectMake(0, _topTapHeight, scrollViewWidth, scrollViewHeight - _topTapHeight)];
    [_mainScrollView setContentSize:CGSizeMake(scrollViewWidth * self.pageViewArray.count, scrollViewHeight - _topTapHeight)];
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
    
    [[_topTabButtonArray objectAtIndex:self.currentPageIndex] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[_topTabButtonArray objectAtIndex:currentPage] setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[[_topTabButtonArray objectAtIndex:self.currentPageIndex] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    [[[_topTabButtonArray objectAtIndex:currentPage] titleLabel] setFont:[UIFont boldSystemFontOfSize:20.0f]];
    [_mainScrollView setContentOffset:CGPointMake(currentPage * scrollViewWidth, 0) animated:YES];
    
    [[self.pageViewArray objectAtIndex:self.currentPageIndex] pageUnSelect];
    [[self.pageViewArray objectAtIndex:currentPage] reloadPageData];
    [[self.pageViewArray objectAtIndex:currentPage] pageSelect];
    
    self.currentPageIndex = currentPage;
    
    if (_actionDelegate != nil && [_actionDelegate respondsToSelector:@selector(pageView:didChangePageAtIndex:)]) {
        [_actionDelegate pageView:self didChangePageAtIndex:currentPage];
    }
}


#pragma mark - scrollview delegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _lastScrollOffset = scrollView.contentOffset.x;
    _dragDirect = ZLMainScrollViewDragDirectMiddle;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // pageview 预加载
    if (scrollView.contentOffset.x - _lastScrollOffset >= 0.0001) {
        if (!(_dragDirect & ZLMainScrollViewDragDirectRight)) {
            _dragDirect |= ZLMainScrollViewDragDirectRight;
            [[self.pageViewArray objectAtIndex:self.currentPageIndex + 1] reloadPageData];
        }
    } else if (scrollView.contentOffset.x - _lastScrollOffset <= -0.0001) {
        if (!(_dragDirect & ZLMainScrollViewDragDirectLeft)) {
            _dragDirect |= ZLMainScrollViewDragDirectLeft;
            [[self.pageViewArray objectAtIndex:self.currentPageIndex -1] reloadPageData];
        }
    }
    
    CGFloat rate = self.sliderView.frame.size.width / scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x * rate;
    CGRect frame = self.sliderView.frame;
    frame.origin.x = x;
    self.sliderView.frame = frame;
}

#pragma publicFunc

- (void)removeAllListener {
    for (ZLSinglePageView *view in self.pageViewArray) {
        [view pageUnSelect];
    }
    [[_topTabButtonArray objectAtIndex:self.currentPageIndex] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[[_topTabButtonArray objectAtIndex:self.currentPageIndex] titleLabel] setFont:[UIFont systemFontOfSize:18.0f]];
    self.currentPageIndex = UINT8_MAX;
}

- (void)dealloc {
    
}


@end
