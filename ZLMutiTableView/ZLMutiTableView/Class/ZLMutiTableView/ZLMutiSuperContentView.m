//
//  ZLMutiSuperContentView.m
//  ZLMutiTableView
//
//  Created by ZhangLei on 16/8/23.
//  Copyright © 2016年 LayZhang. All rights reserved.
//

#import "ZLMutiSuperContentView.h"

#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )

static const CGFloat   defaultTopBarHeight     = 38.0f;
static const CGFloat   defaultCellHeight       = 28.0f;

@interface ZLMutiSuperContentView()<UITableViewDelegate, UITableViewDataSource> {
    CGFloat _topBarHeight;
    CGFloat _cellHeight;
}

@end

@implementation ZLMutiSuperContentView

@synthesize contentTopView;
@synthesize contentTableView;

@synthesize leftTopView;
@synthesize leftTableView;

@synthesize contentScrollView;

@synthesize contentArray;

@synthesize cellHeight = _cellHeight;
@synthesize topBarHeight = _topBarHeight;

- (id)init {
    if (self = [super init]) {
        [self initComponent];
        //        _currentIndex = -1;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initComponent];
        //        _currentIndex = -1;
    }
    return self;
}

- (void)initComponent {
    [self setDefault];
    [self initContentScrollView];
    [self initContentTableView];
    [self initContentTopView];
    [self initLeftTableView];
    [self initLeftTopView];
}

#pragma init

- (void)initData {
    NSLog(@"this is TradeContentView initData");
}

- (void)updateSelectIndex {
}

- (void)setDefault {
    _topBarHeight  = defaultTopBarHeight;
    _cellHeight     = defaultCellHeight;
    self.contentArray = [[NSMutableArray alloc] init];
}

- (void)initContentScrollView {
    self.contentScrollView = [[UIScrollView alloc] init];
    [self.contentScrollView setDelegate:self];
    [self.contentScrollView setBounces:NO];
    [self.contentScrollView setShowsHorizontalScrollIndicator:NO];
    [self.contentScrollView setBackgroundColor:[UIColor redColor]];
    [self addSubview:self.contentScrollView];
}

- (void)initContentTableView {
    self.contentTableView = [[UITableView alloc] init];
    self.contentTableView.bounces = NO;
    self.contentTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (IOS9_OR_LATER) {
        self.contentTableView.cellLayoutMarginsFollowReadableWidth = NO;
    }
    self.contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.contentTableView.allowsSelection = NO;
    self.contentTableView.showsVerticalScrollIndicator = NO;
    [self.contentTableView setDelegate:self];
    [self.contentTableView setDataSource:self];
    [self.contentTableView setBackgroundColor:[UIColor blackColor]];
    [self.contentScrollView addSubview:self.contentTableView];
}

- (void)initLeftTableView {
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.bounces = NO;
    self.leftTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    if (IOS9_OR_LATER) {
        self.contentTableView.cellLayoutMarginsFollowReadableWidth = YES;
    }
    self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.leftTableView.allowsSelection = NO;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    [self.leftTableView setDelegate:self];
    [self.leftTableView setDataSource:self];
    [self.leftTableView setBackgroundColor:[UIColor blackColor]];
    [self addSubview:self.leftTableView];
}

- (void)initContentTopView {
    self.contentTopView = [[UIView alloc] init];
    [self.contentTopView setBackgroundColor:[UIColor blackColor]];
    [self initContentColumNames];
    [self.contentScrollView addSubview:self.contentTopView];
}

- (void)initLeftTopView {
    self.leftTopView = [[UIView alloc] init];
    [self.leftTopView setBackgroundColor:[UIColor blackColor]];
    [self initLeftColumNames];
    [self addSubview:self.leftTopView];
}

#pragma tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    if (tableView == self.contentTableView) {
        cell = [self updateContentTableViewCellWithIndex:indexPath];
    }
    
    if (tableView == self.leftTableView) {
        cell = [self updateLeftTableViewCellWithIndex:indexPath];
    }
    
    if (!tableView) {
        NSLog(@"*** get unknown err tableview !!! ***");
    }
    
    return cell;
    
    //    NSLog(@"*** get unknown err tableview !!! ***");
    //    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma layout
- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect superFrame = self.bounds;
    
    [self.contentTopView    setFrame:CGRectMake(0, 0, [self getScrollContentWidth], _topBarHeight)];
    [self.leftTopView       setFrame:CGRectMake(0, 0, [self getLeftColumWidth], _topBarHeight)];
    
    if ([[self.contentTopView subviews] count] > 0) {
        [[[self.contentTopView subviews] objectAtIndex:0] setFrame:self.contentTopView.bounds];
    }
    
    if ([[self.leftTopView subviews] count] > 0) {
        [[[self.leftTopView subviews] objectAtIndex:0] setFrame:self.leftTopView.bounds];
    }
    
    [self.leftTableView     setFrame:CGRectMake(0,                          _topBarHeight,  [self getLeftColumWidth],       superFrame.size.height - _topBarHeight)];
    [self.contentTableView  setFrame:CGRectMake(0,                          _topBarHeight,  [self getScrollContentWidth],   superFrame.size.height - _topBarHeight)];
    [self.contentScrollView setFrame:CGRectMake([self getLeftColumWidth],   0,              [self getContentColumWidth],    superFrame.size.height)];
    //    [self.contentTableView  setFrame:self.contentScrollView.bounds];
    [self.contentScrollView setContentSize:CGSizeMake([self getScrollContentWidth], superFrame.size.height)];
}

- (UITableViewCell *)getContentTableViewCell {
    // 根据类名来获取 所以有一定的 类名定义规范
    NSString *className = NSStringFromClass([self class]);
    NSString *tableViewContentCellName          = [NSString stringWithFormat:@"%@ContentCell", className];
    NSString *tableViewContentIdentifierName    = [NSString stringWithFormat:@"%@ContentIdentifier", className];
    return [self getTableViewCell:tableViewContentIdentifierName andNibName:tableViewContentCellName];
}

- (UITableViewCell *)getLeftTableViewCell {
    // 根据类名来获取 所以有一定的 类名定义规范
    NSString *className = NSStringFromClass([self class]);
    NSString *tableViewContentCellName          = [NSString stringWithFormat:@"%@LeftCell", className];
    NSString *tableViewContentIdentifierName    = [NSString stringWithFormat:@"%@LeftIdentifier", className];
    return [self getTableViewCell:tableViewContentIdentifierName andNibName:tableViewContentCellName];
}

- (UITableViewCell *)getTableViewCell:(NSString *)cellIndentifier andNibName:(NSString *)nibName {
    UITableViewCell *cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    
    if(cell == nil){
        UINib *nib = [UINib nibWithNibName:nibName bundle:nil];
        [self.contentTableView registerNib:nib forCellReuseIdentifier:cellIndentifier];
        cell = [self.contentTableView dequeueReusableCellWithIdentifier:cellIndentifier];
    }
//    [cell addBottomLineWithWidth:1.0f bgColor:[UIColor whiteColor]];
    
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
    return cell;
}

#pragma scrollview delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIScrollView *target = nil;
    if (scrollView == self.contentTableView) {
        target = self.leftTableView;
    }else if (scrollView == self.leftTableView) {
        target = self.contentTableView;
    }
    
    //    CGFloat move = scrollView.contentOffset.y - target.contentOffset.y;
    target.contentOffset = scrollView.contentOffset;
}

#pragma TradeViewProtocol abstract
// 子类实现
- (void)initContentColumNames {}
- (void)initLeftColumNames {}
- (UITableViewCell *) updateContentTableViewCellWithIndex:(NSIndexPath *)indexPath {return nil;}
- (UITableViewCell *) updateLeftTableViewCellWithIndex:(NSIndexPath *)indexPath {return nil;}

- (CGFloat)getLeftColumWidth {return 0.0f;}
- (CGFloat)getContentColumWidth {return 0.0f;}
- (CGFloat)getScrollContentWidth {return 0.0f;}

#pragma publicFunc
- (void)selectNewIndex:(NSArray *)indexArray {
    
//    for (id cell in self.contentArray) {
//        if ([cell respondsToSelector:@selector(setIsSelected:)]) {
//            [cell setIsSelected:false];
//        }
//    }
//    
//    for (NSNumber *index in indexArray) {
//        id cell = [self.contentArray objectAtIndex:[index intValue]];
//        if ([cell respondsToSelector:@selector(setIsSelected:)]) {
//            [cell setIsSelected:true];
//        }
//    }
//    
//    for (int i = 0; i < [contentArray count]; i++) {
//        UITableViewCell *oldContentCell    = [self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        UITableViewCell *oldLeftCell       = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
//        if (oldContentCell != nil) {
//            [oldContentCell.contentView setBackgroundColor:[UIColor blackColor]];
//            [oldLeftCell.contentView setBackgroundColor:[UIColor blackColor]];
//        }
//    }
//    
//    for (NSNumber *numer in indexArray) {
//        NSInteger index = [numer intValue];
//        UITableViewCell *newContentCell    = [self.contentTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        UITableViewCell *newLeftCell       = [self.leftTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
//        [newContentCell.contentView setBackgroundColor:[UIColor grayColor]];
//        [newLeftCell.contentView setBackgroundColor:[UIColor grayColor]];
//    }
}

- (NSIndexPath *)getIndexPathOfGesture:(UIGestureRecognizer *)gesture {
    CGPoint contentPoint = [gesture locationInView:self.contentTableView];
    NSIndexPath * contentIndexPath = [self.contentTableView indexPathForRowAtPoint:contentPoint];
    CGPoint leftPoint = [gesture locationInView:self.leftTableView];
    NSIndexPath * leftIndexPath = [self.leftTableView indexPathForRowAtPoint:leftPoint];
    if (contentIndexPath != nil) {
        return contentIndexPath;
    }
    
    if (leftIndexPath != nil) {
        return leftIndexPath;
    }
    
    return nil;
}

- (void)reloadPageData {
    [super reloadPageData];
//    [[ShowAlertManager getInstance] showAlertWaitViewWithMessage:[[LangCaptain getInstance] getLangByCode:@"IsLoading"] onView:self];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self initData];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [[ShowAlertManager getInstance] hidenAlertWaitView];
            [self.contentTableView reloadData];
            [self.leftTableView reloadData];
            [self addListener];
            [self updateSelectIndex];
        });
    });
}

- (void)pageUnSelect {
    [super pageUnSelect];
    [self removeListener];
}

- (void)pageSelect {
    [super pageSelect];
    //    [self addListener];
}

- (void)dealloc {
    [self removeListener];
}


@end
